From: =?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
Subject: Re: [PATCH] Quick and dirty mergetool fix - take 2
Date: Fri, 30 Jan 2009 17:22:22 +0100
Message-ID: <4983293E.9070401@gmail.com>
References: <4983241B.6020208@gmail.com> <1233332166-14300-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:24:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwA7-0002Bs-HW
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbZA3QW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZA3QW2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:22:28 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:46518 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZA3QW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:22:27 -0500
Received: by ewy14 with SMTP id 14so855146ewy.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 08:22:25 -0800 (PST)
Received: by 10.210.10.8 with SMTP id 8mr980791ebj.158.1233332545257;
        Fri, 30 Jan 2009 08:22:25 -0800 (PST)
Received: from ?192.168.0.40? (c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se [85.225.165.16])
        by mx.google.com with ESMTPS id 5sm385119eyh.31.2009.01.30.08.22.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 08:22:24 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <1233332166-14300-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107841>

Charles Bailey wrote:
> ---
>  git-mergetool.sh |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index aefdca7..d495a6b 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -131,7 +131,7 @@ checkout_staged_file () {
>      tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
>  
>      if test $? -eq 0 -a -n "$tmpfile" ; then
> -	mv -- "$tmpfile" "$3"
> +	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
>      fi
>  }
>  
> @@ -161,9 +161,9 @@ merge_file () {
>      local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
>      remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
>  
> -    base_present   && checkout_staged_file 1 "$prefix$MERGED" "$BASE"
> -    local_present  && checkout_staged_file 2 "$prefix$MERGED" "$LOCAL"
> -    remote_present && checkout_staged_file 3 "$prefix$MERGED" "$REMOTE"
> +    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
> +    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
> +    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
>      if test -z "$local_mode" -o -z "$remote_mode"; then
>  	echo "Deleted merge conflict for '$MERGED':"

Yes, I was just about to propose a similar patch.

This solution works for me!

You might want to remove $prefix from the top of the
file since it's not used any more.

Thanks!

// Jonas
