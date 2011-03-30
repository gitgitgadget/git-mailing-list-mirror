From: Maxin john <maxin@maxinbjohn.info>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Wed, 30 Mar 2011 09:52:23 +0100
Message-ID: <AANLkTim+0gxGKZT=vfmX7v0QZrApjRwAzW3PiLePL-iQ@mail.gmail.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
	<4D9103D3.5010403@zoho.com>
	<7vei5qtnc5.fsf@alter.siamese.dyndns.org>
	<4D9261AE.5070103@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
	Victor Engmark <victor.engmark@terreactive.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4r8g-0007Ib-TU
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab1C3IwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 04:52:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39640 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1C3IwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 04:52:25 -0400
Received: by ywj3 with SMTP id 3so426546ywj.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:52:24 -0700 (PDT)
Received: by 10.151.87.12 with SMTP id p12mr1320806ybl.169.1301475144013; Wed,
 30 Mar 2011 01:52:24 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Wed, 30 Mar 2011 01:52:23 -0700 (PDT)
X-Originating-IP: [192.100.120.41]
In-Reply-To: <4D9261AE.5070103@zoho.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170368>

Hi,

> Junio C Hamano wrote:
=2E.
>> Even though ancient shells I grew up with did not have $(), it is a =
way
>> backticks should have been written by Bourne from day one. =A0Histor=
ically,
>> handling nesting and interraction between double-quotes and backtick=
s
>> correctly was a nightmare to get right, and different implementation=
s of
>> shells got them always wrong. =A0If you use $(), the headaches go aw=
ay.
>> These days, we don't know of any POSIX shell that is widely used and=
 does
>> not understand $(). =A0As such, the above construct is perfectly saf=
e and
>> even preferred over ``. =A0Welcome to the 21st century ;-)
>>
>> The only major platform that didn't have a reasonable shell was Sola=
ris,
>> but we already have written its /bin/sh off as broken and unusable, =
and
>> suggest people to use xpg4 or xpg6 shell (see the Makefile).

Thank you very much for sharing this information. It was really really
informative.
Thanks to =C1ngel Gonz=E1lez and Victor Engmark for sharing their views=
=2E

Considering all the suggestions, I think, it is "not possible to
satisfy everyone" :)
So, I have modified the patch by incorporating most of the nice suggest=
ions.

Please let me know your comments.

Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
---
diff --git a/contrib/thunderbird-patch-inline/appp.sh
b/contrib/thunderbird-patch-inline/appp.sh
index cc518f3..20dac9f 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
 # Copyright 2008 Lukas Sandstr=F6m <luksan@gmail.com>
 #
 # AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include pathes inline i e-mails.
+# for Mozilla Thunderbird to properly include patches inline in e-mail=
s.

 # ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2

@@ -16,13 +16,12 @@ else
        cd > /dev/null
 fi

-PATCH=3D$(zenity --file-selection)
-
-if [ "$?" !=3D "0" ] ; then
-       #zenity --error --text "No patchfile given."
-       exit 1
+#check whether zenity is present
+if ! type zenity >/dev/null 2>&1 ; then
+       exit 1
 fi

+PATCH=3D$(zenity --file-selection) || exit 1
 cd - > /dev/null

 SUBJECT=3D`sed -n -e '/^Subject: /p' "${PATCH}"`
