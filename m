From: Kevin Coleman <kevin.coleman@sparkstart.io>
Subject: Re: folder naming bug?
Date: Tue, 3 Feb 2015 01:23:19 -0500
Message-ID: <26FB4384-1027-436F-84C5-91C6CC4D27EA@sparkstart.io>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io> <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com> <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io> <20150203052317.GA1262@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIWtR-0006Ik-T5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 07:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbbBCGXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 01:23:21 -0500
Received: from imap10-3.ox.privateemail.com ([192.64.116.216]:50584 "EHLO
	imap10-3.ox.privateemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbbBCGXU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Feb 2015 01:23:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.privateemail.com (Postfix) with ESMTP id B371F2400C3;
	Tue,  3 Feb 2015 01:23:19 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap10.ox.privateemail.com
Received: from mail.privateemail.com ([127.0.0.1])
	by localhost (imap10.ox.privateemail.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tAasloQIbGdA; Tue,  3 Feb 2015 01:23:19 -0500 (EST)
Received: from [192.168.49.81] (unknown [72.16.218.22])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 62FF12400A9;
	Tue,  3 Feb 2015 01:23:19 -0500 (EST)
In-Reply-To: <20150203052317.GA1262@peff.net>
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263309>

Awesome reply! That makes sense.  So basically if I accidentally capita=
lize a folder name and commit it, I need to be very careful when I corr=
ect it.  Definitely ran into this problem with my repo and =E2=80=98los=
t=E2=80=99 a few commits before I noticed something was off.

-Kevin Coleman

> On Feb 3, 2015, at 12:23 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Feb 02, 2015 at 11:52:21PM -0500, Kevin Coleman wrote:
>=20
>> Yes, I am on a Mac.  I just tried that, but I don=E2=80=99t think th=
at
>> completely fixed it.  As you can see it tracks =E2=80=9Cfoo/bar.md=E2=
=80=9D and then
>> it tracks =E2=80=9CFoo/bar.md=E2=80=9D.  It still tracks both =E2=80=
=9Cfoo=E2=80=9D and =E2=80=9CFoo=E2=80=9D even tho
>> only =E2=80=9CFoo=E2=80=9D exists in my dir after the rename.
>=20
> Yes, because your filesystem _is_ case insensitive, but now you have
> told git that it is not. In your example:
>=20
>> 11:41:57 ~/test $ git init
>> Initialized empty Git repository in /Users/kcoleman/test/.git/
>> 11:42:03 ~/test (master #) $ git config core.ignorecase false
>> 11:42:06 ~/test (master #) $ mkdir foo
>> 11:42:13 ~/test (master #) $ cd foo
>> 11:42:26 ~/test/foo (master #) $ touch bar.md
>> 11:42:30 ~/test/foo (master #) $ cd ..
>> 11:42:32 ~/test (master #) $ git add .
>=20
> Now git has "foo" (lowercase) in the index. And that's what your
> filesystem has, too.
>=20
>> 11:42:35 ~/test (master #) $ git commit -m "first"
>> [master (root-commit) 6125a1d] first
>> 1 file changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 foo/bar.md
>> 11:42:39 ~/test (master) $ mv foo Foo
>> 11:42:44 ~/test (master) $ ls
>> Foo
>=20
> Now we still have "foo" in the index, but "Foo" in the filesystem.
>=20
>> 11:42:46 ~/test (master) $ git status
>> On branch master
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>=20
>> 	Foo/
>=20
> When git asks the filesystem lstat("foo") to find out if we still hav=
e
> it, the filesystem returns the entry for "Foo" (because it is
> case-insensitive).
>=20
> But when git asks the filesystem to iterate over all of the files, so=
 it
> can check which ones are not tracked, it will get "Foo", which of cou=
rse
> is not in the index.
>=20
> So you do not see a deletion of "foo", but you do see "Foo" as
> untracked.
>=20
>> 11:42:48 ~/test (master) $ git add .
>> 11:43:18 ~/test (master +) $ git commit -m "second"
>> [master f78d025] second
>> 1 file changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 Foo/bar.md
>=20
> And this tells git to look through the filesystem for untracked files
> and add them to the index. So it adds "Foo".
>=20
> Now that you have both "foo" and "Foo" in the index, but the filesyst=
em
> treats them the same, you can create more mayhem. If you were to upda=
te
> one entry but not the other (e.g., by writing to bar.md before doing =
the
> second commit), then git would be perpetually confused. _One_ of the
> files would always look like needed to be updated, because the
> filesystem cannot represent the situation that is in the index.
>=20
> And that is why git sets core.ignorecase in the first place. :)
>=20
> As to your original problem:
>=20
>>>> git isn=E2=80=99t tracking folder renames when the case of the let=
ters
>>>> change, but it will track it if the folder changes names.  Is this
>>>> intentional?
>=20
> Yes, this is intentional. Your filesystem treats them as the same fil=
e,
> so git has to, as well.
>=20
> If your goal is to change the case that git records, then you should =
be
> able to do it with "git mv". But git will never pick up a case change
> that you made separately in the filesystem, because it's
> indistinguishable from the filesystem simply picking a different case=
 to
> store the file.
>=20
> And that does happen. For instance, if you switch between two branche=
s
> with "Foo" and "foo", most case-preserving filesystems will leave you
> with whichever version you had first (i.e., git asks the filesystem t=
o
> open "foo", and the filesystem says "ah, I already have Foo; that mus=
t
> have been what you meant").
>=20
> -Peff
