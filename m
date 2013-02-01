From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 14:38:51 -0800
Message-ID: <20130201223851.GH12368@google.com>
References: <27376267.797831359716377823.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 23:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1PGV-0007xT-Na
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960Ab3BAWi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 17:38:59 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33831 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757785Ab3BAWi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 17:38:57 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so1294140pad.20
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Wc1eGLAtZFny54CX8WlekTSOW3Y7t5u5RENlErQi4Ys=;
        b=ooNxMhnob/GkiQTvT8tqSBUv9VAKKNUS6GNIvpKghrELEbztKMsMS9zV8S9PbWv7nt
         qUYIKfsUuX52HUbMt2X/UC1+XPAH+D91GvZiHmDkL7IYSGR7+yk0dlBvxMWfHNpp+v1G
         TmkGe8vHZk7LXig3xc65EtI7WyE4nn4VDiAVJ8V3gYOxZ6ox6R1K43+I2MYwXAyri82S
         ue5DlOgHx94dZCdHLqpQoFWMUf0aJgCslqNiF3VwkJYJfmjgSo1ecWDwYCcRnt8zIpXW
         QEJ583IP9yVlo1bJrY+Dts/YWY3wQXjjnVhiEQTjzebNyqmdT8IiX7VpDA5s4GiocdXt
         foUg==
X-Received: by 10.68.193.199 with SMTP id hq7mr36361954pbc.3.1359758336704;
        Fri, 01 Feb 2013 14:38:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id nm2sm9636197pbc.43.2013.02.01.14.38.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 14:38:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <27376267.797831359716377823.JavaMail.weblogic@epml01>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215276>

Jongman Heo wrote:

>> But it doesn't stimulate any prerequisites in make, which is weird.
>> What's in builtin/.depend/fetch.o.d?
[...]
> please see below~.
>
> $ cat builtin/.depend/fetch.o.d            
> fetch.o: builtin/fetch.c cache.h git-compat-util.h compat/bswap.h \

That's the problem.  See the following thread:

  http://thread.gmane.org/gmane.comp.version-control.git/185625/focus=185680

Currently when COMPUTE_HEADER_DEPENDENCIES=auto git tests for
dependency generation support by checking the output and exit status
from the following command:

	$(CC) $(ALL_CFLAGS) -c -MF /dev/null -MMD -MP \
		-x c /dev/null -o /dev/null 2>&1

Perhaps this can be improved?  Even something as simple as a ccache
version test could presumably help a lot.

Hope that helps,
Jonathan
