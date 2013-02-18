From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 11:10:40 -0800
Message-ID: <20130218191040.GB3234@elie.Belkin>
References: <1361204512.4758.10.camel@mas>
 <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	trsten@science-computing.de, Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7W7K-0001Ny-DY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab3BRTKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:10:46 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49773 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3BRTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:10:46 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1812314pbc.10
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gqWpkDfxZmD/Ge8DeS4q/toYySC42lVPUUeZi8LKpBM=;
        b=u1jfDMZLjMwoVCH2UrpGjEEGJcVJ/22NIo5wCxyYB2y2OVLeVZlSCHOOAyPx0BBt1+
         aMeWRviflyAtq1H4686EKrNc3afwJKmSNPAhCyRxpqinJ1l513KOAF/elamHTQDwxBWc
         5qR7VD/BYgfkTDzAuZ82U2HAjNZ7Q8DW7bx30xAIcEfBJxL9oKoiiZP0xExDoEXuMwjE
         l+6FRmQfGX+eKKUPjOuJtOe/4Jqqkch3t6bDqZtPQnABPDly5HBb04Pa5cU8N94G4LOX
         OGHlWol2ssezKL+18mJDJ4iOpKIyplhtPiGtU44tVlbdq2Bo5cxMQMnfjEOsyLAEGiD0
         Z5fw==
X-Received: by 10.68.143.197 with SMTP id sg5mr32881075pbb.101.1361214645637;
        Mon, 18 Feb 2013 11:10:45 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o5sm104599653pay.5.2013.02.18.11.10.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 11:10:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216497>

Hi Martin,

Martin Erik Werner wrote:

> Minor clean up of if-then nesting in checks for environment variables
> and config options. No functional changes.

Yeah, the nesting was getting a little deep.  Thanks for the cleanup.
May we have your sign-off?

Once this is signed off,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Patch left unsnipped for reference.

> ---
>  contrib/completion/git-prompt.sh |   27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9b2eec2..e29694d 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -320,26 +320,25 @@ __git_ps1 ()
>  				b="GIT_DIR!"
>  			fi
>  		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
> -			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
> -				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
> -					git diff --no-ext-diff --quiet --exit-code || w="*"
> -					if git rev-parse --quiet --verify HEAD >/dev/null; then
> -						git diff-index --cached --quiet HEAD -- || i="+"
> -					else
> -						i="#"
> -					fi
> +			if test -n "${GIT_PS1_SHOWDIRTYSTATE-}" &&
> +			   test "$(git config --bool bash.showDirtyState)" != "false"
> +			then
> +				git diff --no-ext-diff --quiet --exit-code || w="*"
> +				if git rev-parse --quiet --verify HEAD >/dev/null; then
> +					git diff-index --cached --quiet HEAD -- || i="+"
> +				else
> +					i="#"
>  				fi
>  			fi
>  			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
>  				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
>  			fi
>  
> -			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> -				if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
> -					if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> -						u="%"
> -					fi
> -				fi
> +			if test -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" &&
> +			   test "$(git config --bool bash.showUntrackedFiles)" != "false" &&
> +			   test -n "$(git ls-files --others --exclude-standard)"
> +			then
> +				u="%"
>  			fi
>  
>  			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
> -- 
