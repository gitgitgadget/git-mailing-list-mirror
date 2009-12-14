From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Can't handle renamed resources on case insensitive filesystems.
Date: Mon, 14 Dec 2009 16:42:53 +0100
Message-ID: <40aa078e0912140742y1e20c155w5f0d1707a4c2ef5e@mail.gmail.com>
References: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
	 <40aa078e0912140650t7e061da0nfc75955cb584f3ba@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Lhunath (Maarten B.)" <lhunath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:43:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKD4h-00078L-Go
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 16:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbZLNPm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbZLNPm5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 10:42:57 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55075 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZLNPmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 10:42:55 -0500
Received: by ewy19 with SMTP id 19so3512010ewy.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qtf0EqMZWdwlTzhcV/nCjSvjBBH3et7Xhz183r0odao=;
        b=geuk+H+I+dc77mv2eEGrv95Oe1kV0nPGPK4eAOzsC+Zfgo2mlBAkEgmEi1GeoiOkpU
         2tmJbWcSNOCOuwQhTzHFpT3xjC4I4uENBJ2cR6tgKUQQUIs2UZ9OJaCK04pnFLMPSwQ2
         pjPwS3jBk5XcG2WlT0jVUPtxQ/STpsBsWx10s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=MJDyaUS9+JohBpJpUoSOXjM8Y9zq54GSwiH6oUgkI3Po73J1Srf6uBezM9zPkjnWx1
         Jsts1vjBQG6pYPaOSN44CPfxOyKmDJQYDMcgc9Bf89Cjkc83ouiokhKCZS4r0juPNQFp
         6BGucrP8EFlF6WsKi6QBLBsTExJB/2cIWn3ts=
Received: by 10.216.91.10 with SMTP id g10mr847676wef.217.1260805373895; Mon, 
	14 Dec 2009 07:42:53 -0800 (PST)
In-Reply-To: <40aa078e0912140650t7e061da0nfc75955cb584f3ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135218>

On Mon, Dec 14, 2009 at 3:50 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Mon, Dec 14, 2009 at 3:27 PM, Lhunath (Maarten B.) <lhunath@gmail.=
com> wrote:
>> GIT has quite a few issues concerning renamed files on case insensit=
ive filesystems, such as Mac OS X's default HFS+.
>>
>> For instance:
>>
>> lhunath@Myst t $ git mv Foo foo
>> fatal: destination exists, source=3DFoo, destination=3Dfoo
>>
>> Moreover, when a repository contains Foo and foo in one commit and i=
n a subsequent commit, "foo" is removed; "Foo" will also disappear when=
 checking out the latter.
>>
>> Most of these issues are likely just a result of the underlying file=
 system's handling of GIT's commands; though considering that Mac OS X'=
s default fs is case insensitive by default, and the Mac and Windows us=
erbases combined are quite large; it might be very much appropriate to =
do a check for this (if needed) and handle renames (and other operation=
s?) in a way that they would not cause conflicts on these file systems =
(eg. rename to a temporary filename first and then rename to destinatio=
n).
>>
>> In particular; these issues make it awfully painful to refactor Java=
 class names from things like JndiUtils -> JNDIUtils. =A0Not only is it=
 hard to get the commit INTO the repository correctly; it is also hard =
to check the commit OUT for somebody who has no idea any of this is nee=
ded.--
>
> Actually, you have only discovered the tip of the iceberg that is git
> and case insensitivity. However, it is probably also the most annoyin=
g
> part of it. Changing git mv to skip moving (or moving in a way that
> works better) the file when core.ignorecase is enabled and the source
> and destination are the same when compared in a case insensitive
> fashion might make sense.
>

After doing a quick test, it seems no change are required for the git
mv case: use the -f flag when renaming to turn the error into a
warning. Of course, you should only do this when you know that you
really want to rename the file. The following worked for me:

$ git init
$ touch.exe test.txt
$ git add test.txt
$ git commit -m "initial commit"
[master (root-commit) 5acb06f] initial commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
$ git mv test.txt Test.txt
fatal: destination exists, source=3Dtest.txt, destination=3DTest.txt
$ git mv test.txt Test.txt -f
Warning: destination exists; will overwrite!
$ ls
Test.txt

I've only tested this on Windows, but I guess it should work on OSX as =
well.

--=20
Erik "kusma" Faye-Lund
