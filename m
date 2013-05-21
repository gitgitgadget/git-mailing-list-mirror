From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 00:41:19 +0200
Message-ID: <20130521224119.GF30969@goldbirke>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 00:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UevFL-0002ag-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab3EUWl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 18:41:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3EUWl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 18:41:26 -0400
Received: from localhost6.localdomain6 (f051105197.adsl.alicedsl.de [78.51.105.197])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LpUgc-1U1j8g1Kkg-00eipI; Wed, 22 May 2013 00:41:20 +0200
Content-Disposition: inline
In-Reply-To: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:PvRsifbSZQMql9lhLy5O3xD7XmGuyrbI4r9cU0sVTip
 kmVOkdrUP4MqekIlb549V5LMVthPNqDJTdeNUIkqWYo5wZw5cK
 +oxMOu3xBzLPi4bRSfkfePD5GhPw3i8F6YX7Vd4AUXWSfIQnuU
 W5ZuNH0DlE48ixec1JJAjuMJbFDgQjSKeKjA8wMJOYHBKEZO3K
 sVl14qmUse64eZPz6lZ7SKnDZRtpauBvuNo41K9xbPV+qAwIWc
 BmUr7zR6RNEZbc2CuDE8zR3yD0mnL2HJ++om5OwX83XTKwJkY8
 HysPSmE/v5bc8EaVIdDR8TNCPR7ADh+TDgQ8Fq7KI6kI+3DafB
 dwGROeJJHsawayluksTfLImxBbe9R5NTFgGqIYLUt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225090>

Hi,


On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
> Currently the __git_ps1 git prompt gives the following error with a
> repository converted by git-svn, when used with zsh:
>=20
> 	   __git_ps1_show_upstream:19: bad pattern: svn_remote[
>=20
> This was introduced by 6d158cba (bash completion: Support "divergence
> from upstream" messages in __git_ps1), when the script was for bash
> only.  Make it compatible with zsh.

What is the actual cause of this problem/incompatibility and how/why do
these changes fix it?

> -			svn_remote[ $((${#svn_remote[@]} + 1)) ]=3D"$value"
> +			svn_remote[$((${#svn_remote[@]} + 1))]=3D"$value"

I mean, did zsh really complained because of the space after the '[' ?!

> @@ -146,8 +146,8 @@ __git_ps1_show_upstream ()
>  	svn*)
>  		# get the upstream from the "git-svn-id: ..." in a commit message
>  		# (git-svn uses essentially the same procedure internally)
> -		local svn_upstream=3D($(git log --first-parent -1 \
> -					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
> +		set -a svn_upstream "$(git log --first-parent -1 \
> +					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null)"
>  		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
>  			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}

If so, then what about this one?


Best,
G=E1bor
