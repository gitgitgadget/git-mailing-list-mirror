From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] cache.h: avoid deprecation warnings on OS X 10.8
Date: Sun, 12 May 2013 13:20:30 -0400
Message-ID: <CAPig+cRsBay2tobNEMTujMR4q7xs-Fbq_3V=WQaw40KWAXwdLg@mail.gmail.com>
References: <1368239010-60894-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 19:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZx3-0002xn-Al
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab3ELRUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:20:33 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:49524 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab3ELRUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:20:33 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so5445064lab.16
        for <git@vger.kernel.org>; Sun, 12 May 2013 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Dm/KPUl1ghOMj/ChKsjh9kcJkcdu4G5r4p8RRT/xlVc=;
        b=LqsWLRynI70SXp5G7Wx6U6iuqBZQ7w+qrU45906oQE2p/uXJS7ArGshgGLFHwEDHc6
         KE2baIm/lNYw6a8dsIg1BGDCue10Xd3vKzxQCjsXZSt4L3SbrEYwo3HI++Np7+yP0J9Z
         PedqtQ+2kYSpXvTbvP3ODoeLMncjWL7UZjqWdbcSOLakYyBiuJjWktBZk5+YT9MZhbqV
         rxG1Fj4sWRNUDlGYFjCyFsTnvKyNcQ23qlEMn6N5Q/258/MCcIVa0jjgbnSm8Z4mSqTT
         gW53w72sZr5dhzCZRRSoPf6ktsgdSVrNomhVFa/3V0PsfstDEb4NUaqqjPN8x2RXZmmI
         swfw==
X-Received: by 10.112.125.232 with SMTP id mt8mr8439648lbb.55.1368379231084;
 Sun, 12 May 2013 10:20:31 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 12 May 2013 10:20:30 -0700 (PDT)
In-Reply-To: <1368239010-60894-1-git-send-email-davvid@gmail.com>
X-Google-Sender-Auth: i5xjgjt_V8L1SVuJdKfn_hILkZc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224057>

On Fri, May 10, 2013 at 10:23 PM, David Aguilar <davvid@gmail.com> wrote:
> Mac OS X Mountain Lion prints warnings when building git:
>
>         warning: 'SHA1_Init' is deprecated
>         (declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the Common Digest SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

On Lion, with this patch, I see diagnostics such as:

    warning: implicit declaration of function 'CC_SHA1_Init'

If I #include <CommonCrypto/CommonDigest.h>, the "implicit
declaration" warning is resolved, but a host of other warnings about
incompatible pointer types crop up.

(This is a bare Lion installation with latest XCode and "Command Line
Tools" package. No MacPorts, no Homebrew.)

> Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
> choosing this implementation and define it by default on Darwin.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This implements the suggestion from John Keeping instead
> of blindly setting NO_OPENSSL on Darwin.
