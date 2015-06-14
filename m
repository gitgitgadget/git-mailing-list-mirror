From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Sun, 14 Jun 2015 15:08:10 -0700
Message-ID: <xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 00:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4G4g-0004pf-1k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 00:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbFNWIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 18:08:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34876 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbFNWIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 18:08:13 -0400
Received: by iesa3 with SMTP id a3so51711544ies.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=l1QgqAq3rTwxJSVE6cPleegBnVr665XGonvCgSN83EA=;
        b=n9umk2TloTbJ3zaL5iIufnORgXaZPE4frj8pFon4ZBasMyQY0GwKgn6HpiJ4djDmgT
         6f7vmtRASFE9ppx2T2IfSQEAUe1Sez9caW4JlNNFe8gT1JwvnEhetIYRujxojzqrhJ8Q
         PcN9aoa0lRVNQKpRNXjXtV8d4Bx14I1ovcPxNSpM5iTvVMSm6KFzJm3Ntf9s1Jpul9gL
         ZMSQTKCGK4Y5Frwn/vBBLW029HDUEEGxqSmpZnXSyGSp4icQs2Ec3uPw8LlyslSBW1tj
         rjnPXoRwqLB5yAQRRCW8pwC4mMktMaS5qyNHhf2DfoSu7ziMpQ/6k0JE2zJmV0RaY3yq
         tPXg==
X-Received: by 10.50.79.169 with SMTP id k9mr16913870igx.44.1434319692652;
        Sun, 14 Jun 2015 15:08:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id e10sm6239510igy.11.2015.06.14.15.08.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 15:08:11 -0700 (PDT)
In-Reply-To: <1434018125-31804-4-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 11 Jun 2015 18:21:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271653>

Paul Tan <pyokagan@gmail.com> writes:

> +int cmd_am(int argc, const char **argv, const char *prefix)
> +{
> +	if (!getenv("_GIT_USE_BUILTIN_AM")) {
> +		const char *path = mkpath("%s/git-am", git_exec_path());
> +
> +		if (sane_execvp(path, (char**) argv) < 0)

Style: 

		if (sane_execvp(path, (char**)argv) < 0)

> +			die_errno("could not exec %s", path);
> +	}
> +
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index 44374b1..42328ed 100644
> --- a/git.c
> +++ b/git.c
> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  static struct cmd_struct commands[] = {
>  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },

Would this, especially having RUN_SETUP, keep the same behaviour
when the command is run from a subdirectory of a working tree?
e.g.

	save messages to ./inbox
        $ cd sub/dir
        $ git am ../../inbox



>  	{ "annotate", cmd_annotate, RUN_SETUP },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
>  	{ "archive", cmd_archive },
