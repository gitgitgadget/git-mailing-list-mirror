From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 05/12] completion: add missing global options
Date: Sun, 8 Apr 2012 14:36:46 +0200
Message-ID: <20120408123646.GM2289@goldbirke>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 14:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGrSQ-00073F-P5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 14:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab2DHMm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 08:42:27 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:39684 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab2DHMm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 08:42:26 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Apr 2012 08:42:26 EDT
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 8 Apr
 2012 14:36:46 +0200
Received: from localhost6.localdomain6 (141.21.34.29) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 8 Apr
 2012 14:36:47 +0200
Content-Disposition: inline
In-Reply-To: <1333854479-23260-6-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194993>

Hi,


On Sun, Apr 08, 2012 at 06:07:52AM +0300, Felipe Contreras wrote:
> Otherwise 'git --foo bar<tab>' fails, also, other options are complet=
ely
> missing.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    9 +++++++--
>  t/t9902-completion.sh                  |   31 ++++++++++++++++++++++=
+++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 3bc8d85..c9672b2 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2621,7 +2621,10 @@ _git ()
>  		case "$i" in
>  		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
>  		--bare)      __git_dir=3D"." ;;
> -		--version|-p|--paginate) ;;
> +		--version) ;;
> +		-p|--paginate|--no-pager) ;;
> +		--exec-path=3D*|--html-path|--info-path) ;;
> +		--work-tree=3D*|--namespace=3D*|--no-replace-objects) ;;
>  		--help) command=3D"help"; break ;;
>  		*) command=3D"$i"; break ;;
>  		esac

This is not future proof, it will break again when we add yet another
global option.  This is also incomplete, because the '-c
<configvar=3Dvalue>' option is missing.

I send a patch to fix this issue a couple of months ago but it got
dropped on the floor.

  http://thread.gmane.org/gmane.comp.version-control.git/180650

My patch handles the -c global option and it won't break when we add
a new global option, so I think it should replace the above hunk.

Please feel free to copy the commit message, too, for the benefit of
other developers who might read the log message a year later.


> +test_expect_success 'general options plus command' '
> +	test_completion "git --version check" "checkout " &&
> +	test_completion "git --paginate check" "checkout " &&
> +	test_completion "git --git-dir=3Dfoo check" "checkout " &&
> +	test_completion "git --bare check" "checkout " &&
> +	test_completion "git --help des" "describe " &&
> +	test_completion "git --exec-path=3Dfoo check" "checkout " &&
> +	test_completion "git --html-path check" "checkout " &&
> +	test_completion "git --no-pager check" "checkout " &&
> +	test_completion "git --work-tree=3Dfoo check" "checkout " &&
> +	test_completion "git --namespace=3Dfoo check" "checkout " &&
> +	test_completion "git --paginate check" "checkout " &&
> +	test_completion "git --info-path check" "checkout " &&
> +	test_completion "git --no-replace-objects check" "checkout "
> +'

Then you could add a=20

	test_completion "git -c 'name=3Dvalue' check" "checkout "

test, too.


Best,
G=E1bor
