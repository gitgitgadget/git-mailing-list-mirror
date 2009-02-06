From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 06 Feb 2009 20:23:47 +0100
Message-ID: <498C8E43.8010108@kdbg.org>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net> <498C70C8.1080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:25:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWKE-0007cJ-8b
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZBFTXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbZBFTXv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:23:51 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:49172 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZBFTXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:23:51 -0500
Received: from [192.168.1.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 96EC51000B;
	Fri,  6 Feb 2009 20:23:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498C70C8.1080009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108775>

Ren=C3=A9 Scharfe schrieb:
> Johannes Sixt schrieb:
>> I also need this to complete this test:
>>
>> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
>> index 9c9c4c9..e377d48 100755
>> --- a/t/t1504-ceiling-dirs.sh
>> +++ b/t/t1504-ceiling-dirs.sh
>> @@ -93,13 +93,13 @@ GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/subdi"
>>  test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
>>
>>
>> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
>> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub"
>>  test_fail second_of_two
>>
>>  GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
>>  test_fail first_of_two
>>
>> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"
>> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub:/bar"
>>  test_fail second_of_three
>=20
> I don't, which makes me uneasy -- the tests shouldn't depend on detai=
ls
> in our setup. :-/

I updated my msysgit to the current master this moment, and I still nee=
d=20
these two changes. Do you use an older msysgit? With 31d5dfeb0=20
(2008-06-08) Steffen changed path mangling so that a text without a=20
leading / or . is not converted. That's exactly what we see here.

>> That said, I'm in the process of preparing a series that includes yo=
ur
>> patch and that does the proper cleanup and code moving that you agai=
n
>> didn't do :-/ But it turns out that this is non-trivial because of b=
ash's
>> (MSYS's) I-know-better-what-is-a-path-and-what-not behavior. It will=
 take
>> some time...
>=20
> Glad to hear the first part, but what code moving do you mean?  Somet=
hing
> like the following?
>=20
> -- snip! --
> Remove the unused function normalize_absolute_path() and its tests.

No, that's not enough. I mean something more like this (but I'll not=20
include the diff itself):

Johannes Sixt (4):
       Make test-path-utils more robust against incorrect use
       Move sanitary_path_copy to path.c (and rename to
         normalize_path_copy)
       Test and fix normalize_path_copy()
       Remove unused normalize_absolute_path()

Ren=C3=A9 Scharfe (1):
       Fix t1504 on Windows

  cache.h                 |    2 +-
  path.c                  |  124 +++++++++++++++++++++++++------------
  setup.c                 |   88 +--------------------------
  t/t0060-path-utils.sh   |   26 ++++----
  t/t1504-ceiling-dirs.sh |    2 +-
  test-path-utils.c       |   12 +++-
  6 files changed, 107 insertions(+), 147 deletions(-)

-- Hannes
