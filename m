From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH 1/3] GIT-VERSION-GEN: make use of git describe --dirty
Date: Wed, 27 Oct 2010 09:50:34 +0200
Message-ID: <4CC7D9CA.1080609@debugon.org>
References: <cover.1287746107.git.misfire@debugon.org> <4CC1745C.70506@debugon.org> <20101022151140.GC9224@burratino> <4CC2D3B4.5030607@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 09:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB0mR-0000LB-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 09:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab0J0Hui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 03:50:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:52534 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0J0Huh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 03:50:37 -0400
Received: from [172.20.2.23] (p578D1A1A.dip.t-dialin.net [87.141.26.26])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MQcnt-1P2zt01T01-00UbEN; Wed, 27 Oct 2010 09:50:35 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <4CC2D3B4.5030607@debugon.org>
X-Provags-ID: V02:K0:DIsDnHptF2P8soSyO3/ef6BUD0Cr30eL9QvR7LCcIGY
 1stcP2V0K1K6Rw5G8YkvTVTeqtx7mgQwP4ZT6Hy55K2xrmLUvd
 D3wTdzdaISB6HYPcp2I4s0/gy6vOzivl6Hk/RO9I3v1syD38al
 7JgPdhXONwYL1WIUuv3//5JwXiAGIZJJ8lEalu2+hiAerfgz2i
 SoyAahRnZajoksh1OIfPkVqRRgLrasWPr7A4Y3UaV0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160025>

Mathias Lafeldt wrote:
> On 10/22/2010 05:11 PM, Jonathan Nieder wrote:
>> Mathias Lafeldt wrote:
>>
>>> Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
>>> "git diff-index" to determine if the working tree is dirty. It then appends
>>> "-dirty" to the version string returned by "git describe".
>>>
>>> However, as of Git v1.6.6, "git describe" can be told to do all that with the
>>> "--dirty" option, saving us the plumbing.
>> This has a minor downside, which is avoiding the nice version numbers when
>> building Git with git 1.5.6 installed.  What is the upside?
> 
> The upside is that the number of executed commands to get the version string
> is reduced from three to one.
> 
> I understand your point, though it would only be a "problem" once when
> doing the upgrade.
> 
> If backwards compatibility is more important here, I'd at least add a comment
> to GIT-VERSION-GEN. Something like:
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index d441d88..5c226f6 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -16,6 +16,10 @@ elif test -d .git -o -f .git &&
>         case "$VN" in
>         *$LF*) (exit 1) ;;
>         v[0-9]*)
> +               # As of Git v1.6.6, we can use "git describe --dirty" to
> +               # determine if the working tree is dirty. However, to still
> +               # have nice version numbers when building Git with older
> +               # versions of git installed, we keep using plumbing.
>                 git update-index -q --refresh
>                 test -z "$(git diff-index --name-only HEAD --)" ||
>                 VN="$VN-dirty" ;;
> 

Any feedback would be welcome.

-Mathias
