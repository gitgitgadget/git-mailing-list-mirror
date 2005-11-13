From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: Remove unneeded packs
Date: Sun, 13 Nov 2005 13:07:50 +0100
Organization: Chalmers
Message-ID: <43772C96.9030805@etek.chalmers.se>
References: <1131800663.29461.11.camel@blade>	<4375EA80.7070405@op5.se>	<1131802238.29461.18.camel@blade>	<43766687.2000007@etek.chalmers.se>	<7voe4pclwm.fsf@assigned-by-dhcp.cox.net>	<43771C43.7000104@etek.chalmers.se> <20051113150051.4a10365d.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 13 13:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbGdt-00011c-Fo
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 13:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVKMMH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 Nov 2005 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVKMMH0
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 07:07:26 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:48807 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932489AbVKMMHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 07:07:25 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 436F401B001B4DC7; Sun, 13 Nov 2005 13:07:24 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051113150051.4a10365d.vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11736>

Sergey Vlasov wrote:
> On Sun, 13 Nov 2005 11:58:11 +0100 Lukas Sandstr=F6m wrote:
>=20
>=20
>>Subject: [PATCH] Make sure all old packfiles are removed when doing a=
 full repack
>>
>>This is nessecary because unrachable objects in packfiles makes git-p=
ack-redundant
>>flag them as non-redundant.
>>
>>Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>
>>
>>---
>>
>> git-repack.sh |   16 +++++++++++++++-
>> 1 files changed, 15 insertions(+), 1 deletions(-)
>>
>>applies-to: 9a0f0c748316751fbf593a21f2b16bcdd975095a
>>08df1f641bd3f98a607a8413d647667adc18a633
>>diff --git a/git-repack.sh b/git-repack.sh
>>index f347207..293bb50 100755
>>--- a/git-repack.sh
>>+++ b/git-repack.sh
>>@@ -32,6 +32,8 @@ case ",$all_into_one," in
>> 	rev_list=3D
>> 	rev_parse=3D'--all'
>> 	pack_objects=3D
>>+	existing=3D`cd "$PACKDIR" && \
>>+	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
>> 	;;
>> esac
>> if [ "$local" ]; then
>>@@ -60,7 +62,19 @@ mv .tmp-pack-$name.pack "$PACKDIR/pack-$
>> mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
>> exit
>>=20
>>-if test "$remove_redandant" =3D t
>>+if test "$all_into_one" =3D t
>=20
>=20
> This should be
>=20
> if test "$all_into_one$remove_redandant" =3D tt
>=20
> (otherwise "git repack -a" becomes the same as "git repack -a -d").
>=20
>=20

This was the behaviour before git-pack-redundant, I just restored it.
Someone else gets to decide if git repack -a implies "remove all old pa=
cks".
