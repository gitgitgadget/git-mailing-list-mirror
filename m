From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 07/19] rebase -i: The replay of root commits is
 not shown with --verbose
Date: Fri, 11 Jul 2014 15:46:04 +0200
Message-ID: <53BFEA9C.6010203@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com> <b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 15:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5b9c-00060Y-BA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 15:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbaGKNqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 09:46:15 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41366 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbaGKNqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 09:46:13 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so1082513wgg.18
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=j7nRZjjsEC8V4k+hT/49TKiNpJ9gj7jlA7vKKYv5CIs=;
        b=FUU+qlhpxZMW+A5ll4jQx5NlbPyBEosVBto7qOPdO031Bz+QvfLhTYCs203EeV6CWr
         PRLcXhv3Mu/uNSav4/A/Rl13JHi5qbskGBPuUrqDyN3XvrzwM74YRbXzjdWYXf1c7AE0
         DcwwstfN+7J07o3S8nz9BYs2nAgO9w4fRHGQWyUr/XuQ4DZG0sfPqi3Zmjiu72FlbJO3
         o8TDsLLbNd+8eo3OdW9q/rUU79NZku2O3YsTok1yAKk5WKVjkzZzIVK2O9xN+9po+6An
         2Kw6ii+FEjFlnAGhS1TVf+WbtwIIZDRTBRv2QUyPnHJNHdK3F+nJtxJJLsmdglasqYoO
         qezg==
X-Received: by 10.194.158.164 with SMTP id wv4mr13301768wjb.124.1405086367968;
        Fri, 11 Jul 2014 06:46:07 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id gh16sm7692503wic.3.2014.07.11.06.46.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 06:46:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253275>

Hi Chris,

you're the original author of the code touched by this patch. Is the
second -q option really a simple copy-and-paste of the first or am I
overlooking something here? I'd like to confirm this as, in retrospect,
I feel a bit uncertain about the hasty claim in the log message.

Kind regards,
   Fabian

Fabian Ruch writes:
> The command line used to recreate root commits specifies the
> erroneous option `-q` which suppresses the commit summary message.
> However, git-rebase--interactive tends to tell the user about the
> commits it creates, if she wishes (cf. command line option
> `--verbose`). The code parts handling non-root commits or squash
> commits all output commit summary messages. Do not make the replay of
> root commits an exception. Remove the option.
> 
> It is OK to suppress the commit summary when git-commit is used to
> initialize the authorship of the sentinel commit because the
> existence of this additional commit is a detail of
> git-rebase--interactive's implementation. The option `-q` was
> probably introduced as a copy-and-paste error stemming from that part
> of the root commit handling code.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0af96f2..ff04d5d 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -511,7 +511,7 @@ do_pick () {
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
>  			git commit --allow-empty \
> -				   --amend --no-post-rewrite -n -q -C $1 \
> +				   --amend --no-post-rewrite -n -C $1 \
>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>  			die_with_patch $1 "Could not apply $1... $2"
>  	else
