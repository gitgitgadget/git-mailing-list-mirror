From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 08/20] git-mergetool.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 00:37:05 -0700
Message-ID: <CAJDDKr5dvsChQDk+0qJS8qJq+jr6XggWFaveFkaUj0T2OiGSpA@mail.gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
	<1402066563-28519-9-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 09:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuGcL-0006Sa-TO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 09:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbaFJHhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 03:37:07 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36750 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaFJHhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 03:37:06 -0400
Received: by mail-qc0-f181.google.com with SMTP id x3so1818469qcv.12
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m5INlZunn3aWeulEki3sNz3AIKJUyT2WCCmgXQkdbt4=;
        b=hJuI9eqag3wzFc5oQA4r8shkCVwZCRywt4OWOLfQYTRXZKL2GbsQn9C8mDBpPhfwdm
         sXYlgeRqTiSWQOyHMIf0nPVrmdtOo20AIgA8ibCcW9RBDImdEDBJLrlJbGpqS+Vs+9o9
         mN4zragIum8YDjr0eTmy8B4Xi1SBuUYr3XqmUywHQl4TMLtp1b8kTsCr7i7aZo72NTlS
         vulbZeisTkBio72unE83z7sUuNCsRT0qcKF4NXI92hrHXZMglYTzL13xnaUh5Ux/RU3R
         S1dkvCSwAfs40BbrLj7NW2Tkndh0zO98QaYCfFABTdFmZm1kKOyl2k8hSmwfHYs6RDIA
         Q1Eg==
X-Received: by 10.140.108.4 with SMTP id i4mr37955477qgf.80.1402385825773;
 Tue, 10 Jun 2014 00:37:05 -0700 (PDT)
Received: by 10.229.123.198 with HTTP; Tue, 10 Jun 2014 00:37:05 -0700 (PDT)
In-Reply-To: <1402066563-28519-9-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251170>

On Fri, Jun 6, 2014 at 7:55 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---

This looks good to me.  Thanks Elia,

Acked-by: David Aguilar <davvid@gmail.com>

>  git-mergetool.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index d08dc92..9a046b7 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -205,7 +205,7 @@ checkout_staged_file () {
>                 "$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
>                 : '\([^ ]*\)    ')
>
> -       if test $? -eq 0 -a -n "$tmpfile"
> +       if test $? -eq 0 && test -n "$tmpfile"
>         then
>                 mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
>         else
> @@ -256,7 +256,7 @@ merge_file () {
>         checkout_staged_file 2 "$MERGED" "$LOCAL"
>         checkout_staged_file 3 "$MERGED" "$REMOTE"
>
> -       if test -z "$local_mode" -o -z "$remote_mode"
> +       if test -z "$local_mode" || test -z "$remote_mode"
>         then
>                 echo "Deleted merge conflict for '$MERGED':"
>                 describe_file "$local_mode" "local" "$LOCAL"
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
David
