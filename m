From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v4 12/10] git-remote-testgit: support the new 'force'
 option
Date: Tue, 29 Oct 2013 02:41:51 -0600
Message-ID: <526f74cf8307f_37cdfb1e7c31@nysa.notmuch>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
 <1382908589-7000-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: srabbelier@gmail.com, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 09:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb52P-0000i2-K3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 09:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab3J2Iw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 04:52:29 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:55463 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3J2Iw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 04:52:27 -0400
Received: by mail-oa0-f54.google.com with SMTP id o20so4900273oag.13
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=yj9r3yJe9GJwHlpDDj6zVSLsFiHiR00W9AX0u2z1Lrk=;
        b=RNrgzjPMY7e5dNs2SrqwdstqQ494RfN5i185wtvQR59ym44+xMFbMS9Pze449YIS5M
         xZ0Zbj34bJgCm1mjI22Ghanp18QQLvYgzfwUHLLfx1+RoPupK214o+TNeeweh3LJrXlX
         8Yv9bz5hx4ZvDAXD1kVY2AbcaktV2neGhSRHeZAQEO5sRIyy9QNKPl9dL0uhAd8ZgUSx
         4KzowsHsjVXa/LmYVyK7VQsvU1Tzhc6zSrShvgHzv40p/A5gKjOdz6HJkdasmKxP/sYT
         ciAT7vds3/XtZO0BUA8BsDsV+HZmlROlx+otOrtR/wgRBSuz7JPBpiiPfdEkUaVOK50K
         LTLg==
X-Received: by 10.182.229.163 with SMTP id sr3mr115687obc.79.1383036746455;
        Tue, 29 Oct 2013 01:52:26 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm33810205obc.10.2013.10.29.01.52.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2013 01:52:25 -0700 (PDT)
In-Reply-To: <1382908589-7000-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236916>

Richard Hansen wrote:
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  git-remote-testgit.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
> index 6d2f282..80546c1 100755
> --- a/git-remote-testgit.sh
> +++ b/git-remote-testgit.sh
> @@ -6,6 +6,7 @@ url=$2
>  
>  dir="$GIT_DIR/testgit/$alias"
>  prefix="refs/testgit/$alias"
> +forcearg=
>  
>  default_refspec="refs/heads/*:${prefix}/heads/*"
>  
> @@ -39,6 +40,7 @@ do
>  		fi
>  		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
>  		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
> +		echo 'option'
>  		echo
>  		;;
>  	list)
> @@ -93,6 +95,7 @@ do
>  		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
>  
>  		git fast-import \
> +			${forcearg} \
>  			${testgitmarks:+"--import-marks=$testgitmarks"} \
>  			${testgitmarks:+"--export-marks=$testgitmarks"} \
>  			--quiet
> @@ -115,6 +118,21 @@ do
>  
>  		echo
>  		;;
> +	option\ *)
> +		read cmd opt val <<EOF
> +${line}
> +EOF

We can do <<-EOF to align this properly.

Also, I don't see why all the variables are ${foo} instead of $foo.

> +		case ${opt} in
> +		    force)

I think the convention is to align these:

case $opt in
force)

> +			case ${val} in
> +			    true) forcearg=--force; echo 'ok';;
> +			    false) forcearg=; echo 'ok';;
> +			    *) printf %s\\n "error '${val}'\
> + is not a valid value for option ${opt}";;

I think this is packing a lot of stuff and it's not that readable.

Moreover, this is not for production purposes, it's for testing purposes and a
guideline, I think this suffices.


	option\ *)
		read cmd opt val <<-EOF
		$line
		EOF
		case $opt in
		force)
			test $val = "true" && force="true" || force=
			echo "ok"
			;;
		*)
			echo "unsupported"
			;;
		esac
		;;

But this is definetly good to have, will merge.

-- 
Felipe Contreras
