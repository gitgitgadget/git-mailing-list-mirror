From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 09/20] git-rebase--interactive.sh: avoid "test <cond>
 -a/-o <cond>"
Date: Tue, 10 Jun 2014 11:43:47 -0700
Message-ID: <20140610184346.GC72751@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-10-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuR1d-0001h9-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbaFJSn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:43:58 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59193 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaFJSn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:43:57 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so6545786pbc.14
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NVnqiSuzY7SAtl9bced1dGruhwL4eIms0oBMrkyKF4U=;
        b=cdkq+TQo7r3+3fjZ6SAf+sBw3B++aw7CHPplXQ3cIwEhUlRdipYTRigZ6XUP4nVlk+
         c1SwBZR68HPEnqjHYTx+W/HsEHCzO2YPNeW2evz/x0DDGwunsyQ6DVZNDSfHcnXrgxnf
         mMcHQIP853/5O3wmEFRU15LWiKJURYfUBG6CHby203BEhytZJpubDaKjsKWvRs0ivG2W
         ttFDCKh49+U46lKhAk7jpZBasFXfB8xLA+lKC9E6RJ9qangLWLLblhqk3xNZd9CP9nHg
         pMOePL1wwY/wGHXbXhyt/qXJBJZrLNoeY16gMzqwL4d64JdpeNECbvGV6aJzh0ELwj9L
         1/Dg==
X-Received: by 10.66.163.98 with SMTP id yh2mr7509489pab.104.1402425837023;
        Tue, 10 Jun 2014 11:43:57 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id iv2sm70819661pbc.19.2014.06.10.11.43.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 11:43:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402066563-28519-10-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251210>

On Fri, Jun 06, 2014 at 07:55:52AM -0700, Elia Pinto wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  git-rebase--interactive.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6ec9d3c..797571f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1013,7 +1013,7 @@ then
>  	git rev-list $revisions |
>  	while read rev
>  	do
> -		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
> +		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
>  		then

This line is getting pretty long.
I wonder whether it should be wrapped at the && to keep it shorter?

Also, it looks like the last half of the expression can be simplified to,

	test -z "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)"

rather than comparing against "".
-- 
David
