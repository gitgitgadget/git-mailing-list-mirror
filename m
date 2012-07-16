From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Mon, 16 Jul 2012 18:06:26 +0200
Message-ID: <899A52DB-E548-44CD-8624-A715DDB17032@web.de>
References: <5001644F.10901@web.de> <87y5mkm935.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:06:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqnoy-0004zA-Rf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab2GPQGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jul 2012 12:06:43 -0400
Received: from mout.web.de ([212.227.17.12]:64084 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab2GPQGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 12:06:37 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MZlMw-1TA6qx3Jfi-00L9qA; Mon, 16 Jul 2012 18:06:30
 +0200
In-Reply-To: <87y5mkm935.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:qQJ+P825qwB1jLEw2hFjZoi6y+xyClO47JvnxxBhcnd
 y73o+WJsVL36mDGAU281YrVmOU0HVu8UzWSQXrbsEI1VRt1/ng
 Hi61GMZCsDyo3zWMlxHi19QsAd1xte2AOtTXE7NPlOe7V9yeqY
 cY1AlobYmUNt4exAtYAzWq08N7hy0Cejsct9ncGurNciQRYFLf
 fAU3k62D0bda/8zFJhJxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201525>


Am 16.07.2012 um 09:57 schrieb Thomas Rast:

> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> Now it appeared on next as well, so it's time to look a little bit d=
eeper.
>>=20
>> This test case of t1450 fails:
>> test_expect_success 'tag pointing to something else than its type' '
>>=20
>> To debug more, I added an exit 0 here to inspect the file named out:
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 5b79c51..f1f45c9 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -179,6 +179,7 @@ test_expect_success 'tag pointing to something e=
lse than its type' '
>>        test_when_finished "git update-ref -d refs/tags/wrong" &&
>>        test_must_fail git fsck --tags 2>out &&
>>        cat out &&
>> +       exit 0
>>        grep "error in tag.*broken links" out
>> '
>>=20
>> Linux:
>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, no=
t a commit
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not loa=
d tagged object
>>=20
>> Mac OS X:
>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, =
not a blob
>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or m=
issing
>=20
> What OS X are you running?  I started a loop
>=20
>  while : ; do ./t1450-fsck.sh || break; done
>=20
> and it hasn't failed yet.  It is
>=20
>  $ uname -a
>  Darwin mackeller.inf.ethz.ch 11.4.0 Darwin Kernel Version 11.4.0: Mo=
n Apr  9 19:32:15 PDT 2012; root:xnu-1699.26.8~1/RELEASE_X86_64 x86_64
>=20
 uname -a
Darwin birne.lan 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:=
36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386
>=20
> You can run 'git ls-files --debug' which should give you all the data=
 in
> the index, and then perhaps run diff over that to determine the
> differences...
>=20

That lloks like this:

fileA
  ctime: 1342453768:0
  mtime: 1342453768:0
  dev: 234881026        ino: 92698027
  uid: 1500     gid: 20
  size: 4       flags: 5
fileB
  ctime: 1342453768:0
  mtime: 1342453768:0
  dev: 234881026        ino: 92698053
  uid: 1500     gid: 20
  size: 4       flags: 5

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
But what is interesting, is that=20
a) When I clone a fresh copy from git.git, it works OK. After some acti=
vity with the working dir,
  suddenly t1450 fails. Switching back to e.g. v1.7.11 makes t1450  pas=
s again.
  Switching to origin/next , running make brings back the problem, t145=
0 fails

b) The failure seems to be time critical. When I run the test yesterday=
 evening,
   being logged in via ssh makes the test pass.
   Sitting at the machine makes it fail.

c) It seems as if there is a problem when writing to disk.
   Could be the index file
   (git ls-files --debug does not dump the whole index, does it?)

d) As Peff pointed out, the fsck itself is not time critical.
 =20
Thanks for looking into it
