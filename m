From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Wed, 07 May 2014 13:57:19 -0700
Organization: Twitter
Message-ID: <1399496239.11843.78.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <1399072451-15561-2-git-send-email-dturner@twopensource.com>
	 <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
	 <1399421211.11843.53.camel@stross>
	 <20140507030037.GB20726@sigill.intra.peff.net>
	 <1399433631.11843.57.camel@stross>
	 <xmqqlhudbi4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8uC-0001J3-VM
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaEGU53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:57:29 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:54670 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaEGU5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:57:25 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so1839500qcy.9
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=xZcEhujmJwdN+OK3nZpk9kBggAY57QR5HTnRYit8djU=;
        b=OWwM0ec0pl0XK0OHV9QlNtwJ0K+nkelbNrQwZOfvuctPkonY9nbQ++bg+Iw8avKH7g
         bE76QW5IBTaHBPYQ0lkfgUpyIyqffCfNdPQ7uT6QzPNHanHDlHyxspV2rQTgESJ5U9/u
         kk00kutj8DvaL3GDRWMx43//y8JZL00ssz5bgNpllVzejTkn+ssdBHK4uOeEOL4F6vQe
         i8zSuWXt9UqRDLde365qVmkfTd4OJR20sPwEWTdncG57YLdxF3/JaT28vvNZNuUJkgKp
         I9/So7nHXVwceFDx8pucUGVkOoBoMAQe1Khm5vdD7ceOqR/wWW27Oq/5i1IirEgd5LAM
         wF5g==
X-Gm-Message-State: ALoCoQldrXvdkrZQg4A0We7n1KKF52cpMfkEmErx4VBVEmJ1aC+CDP1ra7jZMnWlnZ8ExGjWP/ZY
X-Received: by 10.224.115.139 with SMTP id i11mr18057179qaq.1.1399496244291;
        Wed, 07 May 2014 13:57:24 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id v44sm14170045qge.13.2014.05.07.13.57.22
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 07 May 2014 13:57:23 -0700 (PDT)
In-Reply-To: <xmqqlhudbi4r.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248375>

On Wed, 2014-05-07 at 10:42 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > This causes my test to pass and generally seems correct to me.
> 
> Yes, this approach is very sensible, and I'll queue.
> 
> But watchman support _should_ be prepared for a program that does
> not do this.  Developing your support in on a codebase with this
> patch may be sweeping a bug in your code under the rug.

I agree that good defensive coding practice would be to not depend on
the cwd.  That's just what everything in environment.c presently does.
I don't want to change the rest of the get_*_file functions, because I
don't know what their callers expect of them.  Here is my patch to do
change just the fs_cache bit:

https://github.com/dturner-tw/git/commit/3fe93aeaee9719ee171a253c49af5126a057c513.patch

(I went ahead and made it part of 
the watchman branch on https://github.com/dturner-tw/git.git )

I wanted to just do the fixup where the path is used, but I couldn't see
a function for that.  If there's no function, that indicates to me that
it's probably a bad idea.  But maybe I'm just missing it.
