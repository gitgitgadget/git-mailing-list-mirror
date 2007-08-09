From: Pavel Roskin <proski@gnu.org>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 09 Aug 2007 09:24:43 -0400
Message-ID: <1186665883.28228.31.camel@dv>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
	 <1186549433.2112.34.camel@dv>
	 <20070808092027.GB7860@diana.vm.bytemark.co.uk>
	 <20070808213917.GA22521@diana.vm.bytemark.co.uk>
	 <1186611514.7383.4.camel@dv>
	 <20070808232349.GA23172@diana.vm.bytemark.co.uk>
	 <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
	 <20070809073801.GA31482@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ80u-0005vE-6E
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 15:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938930AbXHINYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 09:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937510AbXHINYs
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 09:24:48 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:59352 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765571AbXHINYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 09:24:46 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IJ83I-00040x-DY
	for git@vger.kernel.org; Thu, 09 Aug 2007 09:27:48 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IJ80J-00083X-5r; Thu, 09 Aug 2007 09:24:43 -0400
In-Reply-To: <20070809073801.GA31482@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55447>

On Thu, 2007-08-09 at 09:38 +0200, Karl Hasselstr=F6m wrote:

> I take it this all means you're actually using my branch? What's your
> opinion on its usefulness?

Well, I tried it, and then ran a script to update all local
repositories.  It converted everything to "version 3", so I'm sort of
stuck with it.  If the "version 3" code is not committed to the mainlin=
e
StGIT, I'll have to convert my repositories back or even re-fetch them.

I have noticed two problems so far, but I cannot tell is they are
specific to the "pu" branch.

1) Undead patches.

StGIT finds a patch I deleted long ago and shows it as unapplied.  It
cannot be deleted by "stg delete" because some files are missing.

$ stg delete at76_usb
Traceback (most recent call last):
  File "/home/proski/bin/stg", line 43, in <module>
    main()
  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 28=
4, in main
  File "home/proski/lib/python2.5/site-packages/stgit/commands/delete.p=
y", line 76, in func
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 1=
227, in delete_patch
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 1=
209, in delete_patch_data
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 1=
60, in delete
OSError: [Errno 2] No such file or directory: '.git/patches/wireless-de=
v/patches/at76_usb'

That's Linux repository, and I'm on wireless-dev branch.  There is a
file .git/patches/wireless-dev/trash/at76_usb containing "None".  There
are two other files in that directory, but they have some SHA1 hashes.

There is also a file .git/patches/wireless-dev/patchorder, which
contains "at76_usb".

I was updating the repository by "stg pull", there were two patches,
"at76_usb" being first.  It couldn't be merged, so I deleted it.  I
deleted the other patch as well, since I new it was applied upstream.
After another "stg pull" at76_usb became "undead".

I cannot reproduce it on another repository.

2) Invisible branches.

StGIT stopped showing other branches.  It's always showing the same
branch, although it can switch to other branches:

[proski@dv linux-2.6]$ stg branch --list
Available branches:
> s     wireless-dev  |=20
[proski@dv linux-2.6]$ stg branch wireless-2.6
Checking for changes in the working directory ... done
Switching to branch "wireless-2.6" ... done
[proski@dv linux-2.6]$ stg branch --list
Available branches:
  s     wireless-dev  |=20
[proski@dv linux-2.6]$ stg branch linus      =20
Checking for changes in the working directory ... done
Switching to branch "linus" ... done
[proski@dv linux-2.6]$ stg branch --list
Available branches:
  s     wireless-dev  |=20
[proski@dv linux-2.6]$ stg init
stg init: linus already initialized
[proski@dv linux-2.6]$

--=20
Regards,
Pavel Roskin
