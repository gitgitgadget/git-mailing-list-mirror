From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 10:49:39 +0200
Organization: Digium, Inc.
Message-ID: <4C4BFAA3.3050700@digium.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com> <AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lynn.Lin@emc.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:49:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocwu7-0000E3-MV
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab0GYItq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:49:46 -0400
Received: from mail.digium.com ([216.207.245.2]:35904 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab0GYItp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 04:49:45 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Ocwty-0004N4-PJ; Sun, 25 Jul 2010 03:49:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id B6CCBD8025;
	Sun, 25 Jul 2010 03:49:42 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fp5CVthAb2z3; Sun, 25 Jul 2010 03:49:42 -0500 (CDT)
Received: from [192.168.1.43] (195-175.76-83.cust.bluewin.ch [83.76.175.195])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 3AC15D8023;
	Sun, 25 Jul 2010 03:49:41 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151714>

On 07/24/2010 02:36 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sat, Jul 24, 2010 at 03:53,  <Lynn.Lin@emc.com> wrote:
>> From: Lynn Lin <Lynn.Lin@emc.com>
>>
>> ---
>>  Makefile         |    4 +++-
>>  git-gui/Makefile |    4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index bc3c570..eb28b98 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -238,7 +238,9 @@ all::
>>
>>  GIT-VERSION-FILE: FORCE
>>        @$(SHELL_PATH) ./GIT-VERSION-GEN
>> --include GIT-VERSION-FILE
>> +ifneq "$(MAKECMDGOALS)" "clean"
>> +  -include GIT-VERSION-FILE
>> +endif
>>
>>  uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
>>  uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo not')
>> diff --git a/git-gui/Makefile b/git-gui/Makefile
>> index 197b55e..91e1ea5 100644
>> --- a/git-gui/Makefile
>> +++ b/git-gui/Makefile
>> @@ -9,7 +9,9 @@ all::
>>
>>  GIT-VERSION-FILE: FORCE
>>        @$(SHELL_PATH) ./GIT-VERSION-GEN
>> --include GIT-VERSION-FILE
>> +ifneq "$(MAKECMDGOALS)" "clean"
>> +  -include GIT-VERSION-FILE
>> +endif
>>
>>  uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
>>  uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not')
>> --
>> 1.7.1
>=20
> This patch needs a rationale, why was it needed? The "-include"
> directive will simply ignore files that don't exist (as opposed to
> "include"), so including GIT-VERSION-FILE during "make clean'
> shouldn't be an issue.

Just guessing here, but since GIT-VERSION-FILE has a 'FORCE'
prerequisite, that means that the operations to generate it will be run
even for 'make clean', which is not useful for the cleaning operation.
It's probably not harmful either... but maybe the OP has some more
significant reason for this patch.

--=20
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
