From: "epankala@cc.hut.fi" <epankala@cc.hut.fi>
Subject: GIT max file size.
Date: Thu, 08 May 2008 19:33:12 +0300
Message-ID: <48232B48.9010900@cc.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 19:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9ZP-0006NB-7G
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973AbYEHRFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 13:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbYEHRFW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:05:22 -0400
Received: from fsmail-out.f-secure.com ([193.110.109.20]:36261 "EHLO
	fsmail-out.f-secure.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbYEHRFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 13:05:20 -0400
X-Greylist: delayed 1923 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 13:05:20 EDT
Received: from fsav4im2 (fsav4im2.f-secure.com [193.110.108.82])
	by fsmail-out.f-secure.com (Postfix) with SMTP id 1F3631EA62D
	for <git@vger.kernel.org>; Thu,  8 May 2008 19:33:14 +0300 (EEST)
Received: from fsintra.f-secure.com (unknown [10.128.128.79])
 by fsav4im2 ([193.110.108.82]:25) (F-Secure Anti-Virus for Internet Mail 6.61.110 Release)
 with SMTP; Thu, 8 May 2008 16:33:10 -0000
 (envelope-from <epankala@cc.hut.fi>)
Received: from [10.128.128.218] (lnxstorage.f-secure.com [10.128.128.218])
	by fsintra.f-secure.com (Postfix) with ESMTP id 62BCA5BD22
	for <git@vger.kernel.org>; Thu,  8 May 2008 19:33:12 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071106)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81538>

Hello.

I received "fatal: Out of memory, malloc failed" error when I tried to
check in file of ~2.5G

It can be argued that binary file of that size (or binary file
altogether) has no place in version control anyways, but still I pursue=
d
it a bit more.

In #git@freenode channel I received some hints and in the end I started
running
"git-hash-object -w images/filesystem_ext2.img.bz2"

It would seem that sha1_file.c:write_sha1_file() has defined size
variable as integer.

This wraps around in "size =3D 8 + deflateBound(&stream, len+hdrlen);" =
and
gives big number for mmap()
mmap(NULL, 18446744071976239104, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D -1 ENOMEM (Cannot allocate memory=
)

size is used in "stream.avail_out =3D size;" and zstream.avail_out seem=
s
to be unsigned int
"uInt     avail_out; /* remaining free space at next_out */"

If size would be changed to unsigned would the max filesize be increase=
d
to ~4G or would it blow up elsewhere?

Is git going to support >2G files or is having "everything that is
needed to complete build process from beginning to bitter end" in
version control something that git is not meant for?

If latter is true then this would be pretty much pointless change. If
former then changing 'size' to integer won't be enough anyways...


Best Regards
Janne P=E4nk=E4l=E4

--=20
Janne P=E4nk=E4l=E4
