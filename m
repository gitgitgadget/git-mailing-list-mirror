From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:57:21 +0000
Message-ID: <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFI8q-0001kb-IY
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbYAPX52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYAPX52
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:57:28 -0500
Received: from mail.sl.pt ([212.55.140.13]:52377 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751069AbYAPX51 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:57:27 -0500
Received: (qmail 17611 invoked from network); 16 Jan 2008 23:57:24 -0000
X-Virus-Status: Clean (0.01890 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.07313 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[85.240.106.162])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <kevin@sb.org>; 16 Jan 2008 23:57:24 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.162 as permitted sender)
In-Reply-To: <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70778>


On Jan 16, 2008, at 11:38 PM, Linus Torvalds wrote:
> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>> 	The only way to argue that normalization is wrong is by providing a
>> good reason to preserve the exact byte sequence, and so far the =20
>> only reason
>> I've seen is to help git.
>
> Git doesn't care. Just use the *same* sequence everywhere. Make sure
> something doesn't change it. Because if something changes it, git wil=
l
> track it.

The problem is that you don't control the sequence that everybody uses.

See this example:

melo@speed(~)$ uname -a
Linux speed.simplicidade.org 2.6.9-55.ELsmp #1 SMP Wed May 2 14:28:44 =20
EDT 2007 i686 i686 i386 GNU/Linux
melo@speed(~)$ set | grep LANG
LANG=3Den_US.UTF-8
melo@speed(~)$ mkdir t
melo@speed(~)$ cd t
melo@speed(~/t)$ git init
Initialized empty Git repository in .git/
melo@speed(~/t)$ touch =E1
melo@speed(~/t)$ git-add =E1
melo@speed(~/t)$ git-commit -m "added a in utf8"
Created initial commit 7a473a2: added a in utf8
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 "\303\241"
melo@speed(~/t)$ export LANG=3Den_US
melo@speed(~/t)$ touch =E1
melo@speed(~/t)$ ls -la
total 12
drwxrwxr-x   3 melo melo 4096 Jan 16 23:44 .
drwx--x--x  31 melo melo 4096 Jan 16 23:43 ..
-rw-rw-r--   1 melo melo    0 Jan 16 23:44 =E1
-rw-rw-r--   1 melo melo    0 Jan 16 23:43 =C3=A1
drwxrwxr-x   8 melo melo 4096 Jan 16 23:43 .git
melo@speed(~/t)$ git-add =E1
melo@speed(~/t)$ git-commit -m "added a in iso-latin-1"
Created commit 4282fca: Ol=C3=A1x!
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 "\341"

So two (simulated in this test) users who use different LANG settings =20
will be in trouble in no time.

What I take from this conversation is that I have to specify, for =20
each project I work on, which encoding we should use, across all =20
users, before they start using git with files with accented chars.

The difference I see between us is that if I tell my filesystem that =20
I want to name my file with a particular string encoded in X, users =20
using encoding Y will be able to read it correctly. I  like my =20
filesystem to make that work for me.

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
