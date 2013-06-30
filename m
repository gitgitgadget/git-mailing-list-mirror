From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH 2/2] completion: learn about --man-path
Date: Sun, 30 Jun 2013 13:41:06 +0200
Message-ID: <20130630114106.GE2294@goldbirke>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
 <bc83f64cf17851022e0344b3eb693beda1bdd8b6.1371900318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:41:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtG0I-0001kE-Ql
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab3F3LlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 07:41:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:54374 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3F3LlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:41:10 -0400
Received: from localhost6.localdomain6 (f051032128.adsl.alicedsl.de [78.51.32.128])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MHcm8-1UwYKF1ato-003wu1; Sun, 30 Jun 2013 13:41:07 +0200
Content-Disposition: inline
In-Reply-To: <bc83f64cf17851022e0344b3eb693beda1bdd8b6.1371900318.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:BT/S7oJXeicqz6hii7pIPD0LI7WXAmS/TeT9MDy7iq7
 qEe6MJomyyONAdQ17AdrfYgCgg4r8k6jCJo3GHgr8ZSJBsoj02
 eAhP0tn+SdXOCk9NXf5GnD9LUp2g+epirqEJs1g6WgZNmdeBOm
 MbqlenXjT99dlfx2EO8LUPdvnco0shjt86xrC8WC4PSTc3Rmmz
 RAzWXo0lXRvmjcd05Tun2a7XzeD954SaMuCD56zmWLbPLFR9+e
 pdbGY8wMlRBQVappJeqwDAAQvGPW2q3N5u7yTwEaJnb7YbCSMB
 hIketJa0bOoGcRdJqFHR7xHS3cWewDVGuZ7mTVQBoRb9pbqB+y
 nQzqfOa/tzVUOZnXeLPI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229276>

Hi,

On Sat, Jun 22, 2013 at 12:25:18PM +0100, John Keeping wrote:
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 2 ++
>  t/t9902-completion.sh                  | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 8fbf941..c3290af 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2513,11 +2513,13 @@ __git_main ()
>  			--exec-path
>  			--exec-path=3D
>  			--html-path
> +			--man-path
>  			--info-path
>  			--work-tree=3D
>  			--namespace=3D
>  			--no-replace-objects
>  			--help
> +			-c

There are a couple of issues with this '-c' here:

- We normally offer only --long-options in the completion script.
- The log message doesn't mention it.
- And finally the most important: it will never be offered for
  completion.  This is the condition of this case branch:

                case "$cur" in
                --*)   __gitcomp "

  i.e. this case branch is executed only when the current word on the
  command line begins with '--', but then '-c' will never match.

Without the '-c' part it's "obviously correct" and together with patch
1/2 is

Acked-by: SZEDER G=E1bor <szeder@ira.uka.de>


>  			"
>  			;;
>  		*)     __git_compute_porcelain_commands
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 81a1657..14d605a 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -231,6 +231,7 @@ test_expect_success 'double dash "git" itself' '
>  	--exec-path Z
>  	--exec-path=3D
>  	--html-path Z
> +	--man-path Z
>  	--info-path Z
>  	--work-tree=3D
>  	--namespace=3D
> --=20
> 1.8.3.1.676.gaae6535
>=20
>=20
