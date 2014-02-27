From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Thu, 27 Feb 2014 14:52:39 +0100
Message-ID: <vpqvbw08xy0.fsf@anie.imag.fr>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 14:52:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ1OM-0007Dk-8b
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbaB0Nwp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 08:52:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42255 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaB0Nwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 08:52:44 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1RDqchB004325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Feb 2014 14:52:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1RDqdsJ003062;
	Thu, 27 Feb 2014 14:52:39 +0100
In-Reply-To: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 27
 Feb 2014 20:01:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 27 Feb 2014 14:52:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1RDqchB004325
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394113961.05319@RGgfr/u7NK7J3ntckTOz0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242824>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> I find myself often do "git rebase -i xxx" and replace one "pick" lin=
e
> with "edit" to amend just one commit when I see something I don't lik=
e
> in that commit. This happens often while cleaning up a series. This
> automates the "replace" step so it sends me straight to that commit.

Sounds a good idea to me.

>  git-rebase--interactive.sh | 17 ++++++++++++++---
>  git-rebase.sh              | 10 ++++++++++

(obviously, don't forget doc and test if this becomes a non-RFC)

>  has_action "$todo" ||
>  	die_abort "Nothing to do"
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 1cf8dba..98796cc 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -31,6 +31,7 @@ verify             allow pre-rebase hook to run
>  rerere-autoupdate  allow rerere to update index with resolved confli=
cts
>  root!              rebase all reachable commits up to the root(s)
>  autosquash         move commits that begin with squash!/fixup! under=
 -i
> +1,edit-one!        generate todo list to edit this commit
>  committer-date-is-author-date! passed to 'git am'
>  ignore-date!       passed to 'git am'
>  whitespace=3D!       passed to 'git apply'
> @@ -249,6 +250,10 @@ do
>  	-i)
>  		interactive_rebase=3Dexplicit
>  		;;
> +	-1)
> +		interactive_rebase=3Dexplicit
> +		edit_one=3Dt
> +		;;
>  	-k)
>  		keep_empty=3Dyes
>  		;;
> @@ -450,6 +455,11 @@ then
>  		;;
>  	*)	upstream_name=3D"$1"
>  		shift
> +		if test -n "$edit_one"
> +		then
> +			edit_one=3D"$upstream_name"
> +			upstream_name=3D"$upstream_name^"
> +		fi
>  		;;

I think you forgot the case where the user specified -1 but no extra
argument (i.e. use the default to upstream branch). Shouldn't the added
code be after the esac?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
