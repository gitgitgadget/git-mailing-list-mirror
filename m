From: =?utf-8?Q?Damien_G=C3=A9rard?= <damien@iwi.me>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Thu, 16 Jan 2014 14:46:58 +0100
Message-ID: <4FE5D5E6-60F6-4111-B538-5CA01092A2F0@iwi.me>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me> <20140114001820.GA12058@padd.com> <20140114232432.GA31465@padd.com> <843E4B24-5EDD-4451-8849-425160576A99@iwi.me> <20140116130833.GA15613@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 14:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3nHp-0000WT-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 14:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbaAPNrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 08:47:04 -0500
Received: from catkin.iwi.me ([91.121.49.159]:40748 "EHLO catkin.iwi.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbaAPNrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 08:47:03 -0500
Received: from imac-de-admin.private.4d.fr (unknown [194.98.194.79])
	(Authenticated sender: damien@iwi.me)
	by catkin.iwi.me (Postfix) with ESMTPSA id 5518EA25E9;
	Thu, 16 Jan 2014 14:47:00 +0100 (CET)
In-Reply-To: <20140116130833.GA15613@padd.com>
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240513>


On 16 Jan 2014, at 14:08, Pete Wyckoff <pw@padd.com> wrote:

> damien@iwi.me wrote on Wed, 15 Jan 2014 09:56 +0100:
>> p4 fstat  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h@59702=20
>> ... depotFile //depot/openssl/0.9.8j/openssl/include/openssl/bn.h
>> ... headAction edit
>> ... headType symlink
>> ... headTime 1237906419
>> ... headRev 2
>> ... headChange 59702
>> ... headModTime 1231329423
>>=20
>> p4 print -q //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 | =
od -c
>> 0000000
>>=20
>> p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1     =
  =20
>> //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1 - add change 5=
9574 (text)
>> p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2
>> //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 - edit change =
59702 (symlink)
>=20
> That's interesting.  When I do the equivalent "p4 print" commands
> it shows something like this.
>=20
> arf-git-test$ p4 fstat //depot/bn.h
> ... depotFile //depot/bn.h
> ... clientFile /dev/shm/trash directory.t9802-git-p4-filetype/cli/bn.=
h
> ... isMapped=20
> ... headAction edit
> ... headType symlink
> ... headTime 1389876870
> ... headRev 2
> ... headChange 8
> ... headModTime 1389876870
> ... haveRev 2
>=20
> arf-git-test$ p4 print //depot/bn.h#1
> //depot/bn.h#1 - add change 7 (text)
> file-text
>=20
> arf-git-test$ p4 print //depot/bn.h#2
> //depot/bn.h#2 - edit change 8 (symlink)
> /elsewhere/bn.h
>=20
> I don't know how you manage to get a symlink with an empty
> destination like that.
>=20
> I'll work on a way to hack around this failure.  In the mean time,
> if you're game, it might be fun to see what p4 does with such a
> repository.  You could make a client for just that little subdir,
> check out at 59702 and see what is there:
>=20
> mkdir testmess
> cd testmess
> cat <<EOF | p4 client -i
> Client: testmess
> Description: testmess
> Root: $(pwd)
> View: //depot/openssl/0.9.8j/openssl/include/openssl/... //testmess/.=
=2E.
> EOF
>=20
> then take a look at how p4 represents the "empty" symlink
> in the filesystem:
>=20
> p4 sync @59702
> ls -la bn.h

I=E2=80=99ve tried exactly your commands, and I=E2=80=99ve got an empty=
 folder..

{14:38}~/p4/testmess =E2=9E=AD p4 sync @59702
//depot/openssl/0.9.8j/openssl/include/openssl/aes.h#2 - refreshing /ho=
me/dgerard/p4/testmess/aes.h
//depot/openssl/0.9.8j/openssl/include/openssl/asn1.h#2 - refreshing /h=
ome/dgerard/p4/testmess/asn1.h
//depot/openssl/0.9.8j/openssl/include/openssl/asn1_mac.h#2 - refreshin=
g /home/dgerard/p4/testmess/asn1_mac.h
//depot/openssl/0.9.8j/openssl/include/openssl/asn1t.h#2 - refreshing /=
home/dgerard/p4/testmess/asn1t.h
//depot/openssl/0.9.8j/openssl/include/openssl/bio.h#2 - refreshing /ho=
me/dgerard/p4/testmess/bio.h
//depot/openssl/0.9.8j/openssl/include/openssl/blowfish.h#2 - refreshin=
g /home/dgerard/p4/testmess/blowfish.h
//depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 - refreshing /hom=
e/dgerard/p4/testmess/bn.h
//depot/openssl/0.9.8j/openssl/include/openssl/buffer.h#2 - refreshing =
/home/dgerard/p4/testmess/buffer.h
[=E2=80=A6]


{14:39}~/p4/testmess =E2=9E=AD ls -la
total 12
drwxr-xr-x 2 dgerard dgerard 4096 janv. 16 14:37 .
drwxr-xr-x 4 dgerard dgerard 4096 janv. 16 14:34 ..
-rw-r--r-- 1 dgerard dgerard   93 janv. 16 14:37 .perforce=09


Then I tried to sync the previous changeset, which is ok :

{14:44}~/p4/testmess =E2=9E=AD p4 sync -f @59701
//depot/openssl/0.9.8j/openssl/include/openssl/aes.h#1 - updating /home=
/dgerard/p4/testmess/aes.h
[=E2=80=A6]

{14:44}~/p4/testmess =E2=9E=AD l
total 0
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 aes.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 asn1.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 asn1_mac.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 asn1t.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 bio.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 blowfish.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 bn.h
-r--r--r-- 1 dgerard dgerard 0 janv. 16 14:44 buffer.h
[=E2=80=A6]



However, when trying to sync to the appropriate changeset :

{14:44}~/p4/testmess =E2=9E=AD p4 sync -f @59702
//depot/openssl/0.9.8j/openssl/include/openssl/aes.h#2 - updating /home=
/dgerard/p4/testmess/aes.h
rename: /home/dgerard/p4/testmess/aes.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/asn1.h#2 - updating /hom=
e/dgerard/p4/testmess/asn1.h
rename: /home/dgerard/p4/testmess/asn1.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/asn1_mac.h#2 - updating =
/home/dgerard/p4/testmess/asn1_mac.h
rename: /home/dgerard/p4/testmess/asn1_mac.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/asn1t.h#2 - updating /ho=
me/dgerard/p4/testmess/asn1t.h
rename: /home/dgerard/p4/testmess/asn1t.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/bio.h#2 - updating /home=
/dgerard/p4/testmess/bio.h
rename: /home/dgerard/p4/testmess/bio.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/blowfish.h#2 - updating =
/home/dgerard/p4/testmess/blowfish.h
rename: /home/dgerard/p4/testmess/blowfish.h: No such file or directory
//depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 - updating /home/=
dgerard/p4/testmess/bn.h
rename: /home/dgerard/p4/testmess/bn.h: No such file or directory

And the folder remains untouched.
Quite strange for me...
