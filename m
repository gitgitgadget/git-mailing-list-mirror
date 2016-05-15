From: git.20.BrowserUk@xoxy.net
Subject: Automating git add & commit for every change individually?
Date: Sat, 14 May 2016 18:01:30 -0800
Message-ID: <C21C71EAD3C.0000026Agit.20.BrowserUk@xoxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 04:01:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1lNM-000615-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 04:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbcEOCBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 22:01:35 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:54295 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753994AbcEOCBe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 22:01:34 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <git.20.BrowserUk@xoxy.net>)
	id 1b1lN6-0008Vd-Qy
	for git@vger.kernel.org; Sun, 15 May 2016 02:01:32 +0000
Received: from wm50.inbox.com ([64.135.83.50])
	by gourmet7.spamgourmet.com with smtp (Exim 4.80)
	(envelope-from <git.20.BrowserUk@xoxy.net>)
	id 1b1lN6-0008UA-Df
	for ; Sun, 15 May 2016 02:01:32 +0000
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <1605141801043.WM50> for <> from <git.20.BrowserUk@xoxy.net>;
	Sat, 14 May 2016 18:01:30 -0800
DomainKey-Signature: q=dns; a=rsa-sha1; c=nofws;
 d=inbox.com; s=s1;
 h=mime-version:date:message-id:from:subject:to:content-type;
 b=yTPHvyixayXsd8FPUkoHcuBBOZKw1FwEQ35zYBJID/kU1qT0j3hk9+r8H/FOKCAdeQ5W
 9asdwJ90FXrGcHHxuJsLzaRG49raMNr1LAcZpfoF2YUp540RCYcQeqk7G2hpnU10Gs9uvC
 /6KSjR4mpvWtK5py0V6fAaCpSysh8b1EY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; q=dns/txt;
 d=inbox.com; s=s1;
 h=mime-version:date:message-id:subject:from:to:content-type;
 bh=dlfM6gKQml0b2Ty8kGULlt9oVCIj7r/vYgao57+yblk=;
 b=qIomBiHu9X/EFWm6QZMJOug9ESc/tQg57mcC9cT/uSVv9BlFtf/W8OANIRgMzvZKO6Gp
 UkLnGMk7WDEyI5SA7q1r/nbNf+GaSjVvK1xaVNkrWkQgmutTcagmYaNBAr5wBIXTF+4wbY
 plyT9gjC7ST9ZwqeBXw0QcCQi95ObRr+I=
X-Mailer: INBOX.COM
X-Originating-IP: 146.198.67.225
X-IWM-ACU: DRCrZLBMKik6aIam8SmsGDvQ7PPm1hjMreD5G9PXQobuihmf7yKTaTPFHt-g
  nHM-LorMZL5yPqpMWtcE-xZWXB4k6RqBOvCAzAb0jTLxm8ktsqEXWOt4qQtN
  6mDoAvFDIrcZx6Qb_QOpE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294633>

Hi,=20

Not sure this is the right place; I couldn't find a mailing list specif=
ically for git *users*?

Problem: Given two source trees, neither yet under source control. One =
(hereafter:MOD)containing extensive modifications of the other (hereaft=
er:ORIG), I want to bring these together under source control such that=
 I can, starting with the full MOD version, back out (and subsequently =
reinstate) changes individually.

And I mean individually at the 'group of lines' level; not the 'whole f=
ile' level.

Reason. The ORIG does not compile locally due to dependency on propriet=
ary libraries I do not have access to. The MOD compiles locally and run=
s; but I have introduced an error that means it produces the wrong resu=
lts.=C2=A0

None of the changes required to remove the dependence on the proprietar=
y libraries should have affected the functionality. Obviously, I must h=
ave touched something that wasn't required to achieve the local compile=
=2E

Some of those 'incidental' changes are obvious: the original source fil=
es contain some tabs; my editor is set to replace tabs with spaces. Thi=
s shouldn't affect anything, but shows up in diffs. Some changes are ha=
bitual: manually adjusting whitespace and comments when trying to under=
stand particular sections of code. Some are changes I made trying to ac=
hieve the compile -- addressing warnings like "Information may be lost.=
" -- that probably weren't ultimately required to achieve the compile. =
These *could* affect the results produced.

Suggested solution:: Put the ORIG into git (init/add ./commit -am "Orig=
inal"). Copy the modified subtree over the original. Add & Commit the c=
hanges in chunks.

Problem: It doesn't allow me to back out the changes individually; only=
 commit sized chunks.

Suggested solution:: use git add -p to stage individual changes; and th=
en commit it. Rinse & repeat.

Problem:This is extremely laborious and error prone.
Ie. If I do git -p; {spews 377 lines of diff}; Do you want to stage thi=
s hunk. I accept: 'Y'; now that hunk is staged; but not committed. So, =
I have to quit out of git -p; then git commit -m {make up some reason} =
repeat for the next 4000 changes.

Question 1:: Is there any way to automate the staging & committing of a=
ll existing changes as individual commits? Preferably with auto-generat=
ed commit messages.

Question 2:: Is there some other way get both versions into git such th=
at I am to be able to 'undo' individual changes to the MOD version, try=
 the build & test; and then redo the undone change if it wasn't the one=
 that screwed things up?

Thanks, Buk

____________________________________________________________
Can't remember your password? Do you need a strong and secure password?
Use Password manager! It stores your passwords & protects your account.
Check it out at http://mysecurelogon.com/manager
