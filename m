From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] git submodule update: Move branch calculation to where it's needed
Date: Fri, 16 Oct 2015 13:54:52 -0700
Message-ID: <xmqq37xaedpf.fsf@gitster.mtv.corp.google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnC1i-0008Jg-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbbJPUyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:54:55 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33588 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbJPUyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:54:54 -0400
Received: by pabrc13 with SMTP id rc13so130110766pab.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8ZmoSzdg2WQNbqFa7ZzUYUtPFDqq7n0J+0OeyLz9eyQ=;
        b=vHsP8YN9jVJ0JUo6ig8X1KVeX5LFaYQl8XtUaaARF2ZlCaXeLWsxdJGVN3TJTnbYFG
         iQOKPL1U/gtRNW/dnNJUCmekFfejrSWEBQ+8krCvY8JcCe+OyXSTqfUQwjw3C0pFXFQV
         VhpCiq8nKugDH2E1XzCRiq+t3MEahHVu7/on6WhsPjYHi+GR3osAlwVKa7Nrdnt08KzI
         WRjZAJswJxQtF3quGkFhrKneF5hZTB2fNjEXtVpokAyfAuFxpzCWs3Y9bnF+CcmMcvR0
         A1x8z5UF0gxt8CSQZH/KuSBXjEw9b4NNj+d+H3qctnQjNmEQII7/jYqizeP5IxfeVWLn
         Kzhw==
X-Received: by 10.68.68.197 with SMTP id y5mr18667007pbt.88.1445028894241;
        Fri, 16 Oct 2015 13:54:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id si10sm22973654pab.15.2015.10.16.13.54.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:54:53 -0700 (PDT)
In-Reply-To: <1444960333-16003-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Oct 2015 18:52:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279769>

Stefan Beller <sbeller@google.com> writes:

> The branch variable is used only once so calculate it only when needed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Makes sense.

>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index eea27f8..56a0524 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -668,7 +668,6 @@ cmd_update()
>  		fi
>  		name=$(git submodule--helper name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
> -		branch=$(get_submodule_config "$name" branch master)
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> @@ -718,6 +717,7 @@ Maybe you want to use 'update --init'?")"
>  				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
>  			fi
>  			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
> +			branch=$(get_submodule_config "$name" branch master)
>  			sha1=$(clear_local_git_env; cd "$sm_path" &&
>  				git rev-parse --verify "${remote_name}/${branch}") ||
>  			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
