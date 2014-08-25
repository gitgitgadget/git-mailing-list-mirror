From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 13:45:16 -0700
Message-ID: <20140825204516.GT20185@google.com>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
 <20140825200042.GJ30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM18n-0005Cx-11
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498AbaHYUpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:45:20 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33350 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbaHYUpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:45:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so20351997pdj.26
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+KcWDbh6oml0IA/pVKw3/PVz2U4p58F3GZfHsP07sy8=;
        b=NCesQRc3LJxWziiB6nc9r99R+EDIwYwGevpaAQY0KPDr8QpptqEHwTeUKVuzKn+K9O
         kixpqatBxLedtFMjNxPN5Tkm09Vgqai1ZBjE9y9nD3Gh3P7gmnK/ftuMrqNf0Ot+uVWZ
         x9cCZqN0P1qGBNK4YXRi7DGJuk3/jdqI4MQUkuGbjABtNK1GLmkm9nfi7uIQCOtjBbBc
         OWHJeYWu1RmBUdO+O+oftLQbjCCWuGgFrU+Q+ww+lZM3oD6rLrXdqjIqlcDm9FB1DJDx
         igrhzwghRZXHQWlaHJs5jFFoZANNY2M1m8syEHNKnOGG0d6XEerK3RtLMHOMQK8/dws5
         Vv0Q==
X-Received: by 10.68.209.194 with SMTP id mo2mr31530838pbc.80.1408999519034;
        Mon, 25 Aug 2014 13:45:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5425:d689:6054:193])
        by mx.google.com with ESMTPSA id do6sm1155251pdb.39.2014.08.25.13.45.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 13:45:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140825200042.GJ30953@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255865>

Jeff King wrote:

> It is unfortunately easy for our static header list to grow
> stale, as none of the regular developers make use of it.
> Instead of trying to keep it up to date, let's invoke "find"
> to generate the list dynamically.

Yep, I like this.

It does mean that people who run "make pot" have to be a little more
vigilant about not keeping around extra .h files by mistake.  But I
trust them.

[...]
> +LIB_H = $(shell $(FIND) . \
> +	-name .git -prune -o \
> +	-name t -prune -o \
> +	-name Documentation -prune -o \
> +	-name '*.h' -print)

Tiny nit: I might use

	$(shell $(FIND) * \
		-name . -o
		-name '.*' -prune -o \
		-name t -prune -o \
		-name Documentation -prune -o \
		-name '*.h' -print)

or

	$(shell $(FIND) * \
		-name '.?*' -prune -o \
		-name t -prune -o \
		-name Documentation -prune -o \
		-name '*.h' -print)

to avoid spending time looking in other dot-directories like .svn,
.hg, or .snapshot.

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
