From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5561: get rid of racy appending to logfile
Date: Fri, 25 Sep 2015 08:50:07 -0700
Message-ID: <xmqqbncq5wi8.fsf@gitster.mtv.corp.google.com>
References: <20150924014541.GB6442@sigill.intra.peff.net>
	<1443118342-3856-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfVGJ-0001Df-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 17:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbbIYPuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 11:50:10 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34311 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbbIYPuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 11:50:09 -0400
Received: by padhy16 with SMTP id hy16so109255421pad.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lDCMI9CBvpcvn40Afjh2uZZHwKrdGUE26imCrw6EdVw=;
        b=KNZYlF6IBlgCLqVRVHkuF8bMrYdH60awxPrmD1sURrCO/kj5xXIyP+rsyfRxoGlKn4
         Uk6qDiGIHZYP3rhgj9jy+jZHnoYB+1Y2dqjpVY7aRe42xdJvgdyzWkhyngIjm7aHubBJ
         3+FULiK8pDwjb9uZzRLZmq8bfudHmUzL1yJdbCpcMG0eQMaxsZnXjYJvVNTM7ZuM/9Wp
         AFNGvf4VjwRO4R+u/QXrI14dco3Y1JMGsr0pDhGZ77cqaB2A1Er3r54MOAyDzEFsP4qU
         5z9LjLeyicWXO3GN9CDxdOa4G5LGFJqA5iBl0DXOXPi0v2Ie5d7J2SNkYALNt8xsMo2F
         +8vw==
X-Received: by 10.66.141.111 with SMTP id rn15mr8106435pab.118.1443196208770;
        Fri, 25 Sep 2015 08:50:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id ey17sm4640306pac.26.2015.09.25.08.50.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 08:50:08 -0700 (PDT)
In-Reply-To: <1443118342-3856-1-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Thu, 24 Sep 2015 20:12:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278663>

Stephan Beyer <s-beyer@gmx.net> writes:

> The definition of log_div() appended information to the web server's
> logfile to make the test more readable. However, log_div() was called
> right after a request is served (which is done by git-http-backend);
> the web server waits for the git-http-backend process to exit before
> it writes to the log file. When the duration between serving a request
> and exiting was long, the log_div() output was written before the last
> request's log, and the test failed. (This duration could become
> especially long for PROFILE=GEN builds.)
>
> To get rid of this behavior, we should not change the logfile at all.
> This commit removes log_div() and its calls. The additional information
> is kept in the test (for readability reasons) but filtered out before
> comparing it to the actual logfile.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  Okay Peff, I added the information to the commit message (in my own
>  words). Past tense for the situation before the patch, present tense
>  for the situation after (hope that's right but should not be too
>  important).
>
>  I also used your proposed grep line because it is probably more robust.

Thanks, both.  

I vaguely recall this test mysteriously failing a few times during
the past several years for me.  Thanks for digging to the bottom of
the problem.  Both the diagnosis and fix look very sensible.
