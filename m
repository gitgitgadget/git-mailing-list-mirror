From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Tue, 24 Nov 2009 00:59:11 +0100
Message-ID: <4B0B21CF.5040504@lsrfire.ath.cx>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx> <20091123112221.GA7175@sajinet.com.pe> <7vtywlyu43.fsf@alter.siamese.dyndns.org> <4B0B185B.4090305@lsrfire.ath.cx> <7v4ooku7cv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 00:59:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCioV-0000TN-Md
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 00:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361AbZKWX7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 18:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757221AbZKWX7L
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 18:59:11 -0500
Received: from india601.server4you.de ([85.25.151.105]:33329 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbZKWX7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 18:59:10 -0500
Received: from [10.0.1.101] (p57B7BDDD.dip.t-dialin.net [87.183.189.221])
	by india601.server4you.de (Postfix) with ESMTPSA id 9BA3E2F8051;
	Tue, 24 Nov 2009 00:59:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v4ooku7cv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133545>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Yes, but what about git commands that are implemented as shell scrip=
ts
>> and use grep?  Something like the following patch?
>>
>> We'd need to run this from time to time to make sure no new grep cal=
ls
>> creep in:
>>
>>    git grep -L "unset GREP_OPTIONS" -- $(git grep -l "grep" git-*.sh=
)
>=20
> Hmm, but "bisect run" runs user's script and it may want to see
> GREP_OPTIONS from the environment, no?  Same for any of the hooks tha=
t am
> and rebase might want to run.
>=20
>=20
>=20
>  git-sh-setup.sh            |   14 ++++++++++++++
>  git-am.sh                  |    4 ++--
>  git-bisect.sh              |    4 ++--
>  git-filter-branch.sh       |    2 +-
>  git-instaweb.sh            |    8 ++++----
>  git-rebase--interactive.sh |   10 +++++-----
>  git-rebase.sh              |    2 +-
>  git-submodule.sh           |    6 +++---
>  8 files changed, 32 insertions(+), 18 deletions(-)
>=20
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index c41c2f7..2b2afa6 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -114,6 +114,20 @@ git_editor() {
>  	eval "${GIT_EDITOR:=3Dvi}" '"$@"'
>  }
> =20
> +sane_grep () {
> +	GREP_OPTIONS=3D \
> +	GREP_COLOR=3D \
> +	GREP_COLORS=3D \
> +	LC_ALL=3DC grep "$@"
> +}
> +
> +sane_egrep () {
> +	GREP_OPTIONS=3D \
> +	GREP_COLOR=3D \
> +	GREP_COLORS=3D \
> +	LC_ALL=3DC egrep "$@"
> +}
> +

Ah, yes, much nicer.

Ren=C3=A9
