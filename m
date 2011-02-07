From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: git-svn problems with cloning
Date: Mon, 7 Feb 2011 12:58:33 +0100
Message-ID: <AANLkTinHmE-_JFeZP1AQ9yKh0ZN3+oqug=+j+5JcFHcm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 12:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmPjs-0004C4-5e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 12:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1BGL6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 06:58:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55633 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1BGL6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 06:58:34 -0500
Received: by vws16 with SMTP id 16so2837553vws.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=lmj7ynyA+1PVWBJdchjHvvta9NqPOoiWZhOJh10CCFU=;
        b=grwAqwOB1h6r3lynAvTvDh7PpRqWWcvq9p/057dPza/rVNdC/lHlZWvAxFDjYLJHTO
         cZs0x0LBQ9tUTg3EinfQoCCSw3PjUBi3ljWneKiYjnl/uuj/N6fDpIU9axem+oqJBVX0
         2stZn5su3oqwIo8MUTwPIqxMiDeVy5JPxiVSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=QkfYjv3V/70Zkwx6ADi/Vnff80AXn4L5+vsWor4ECdT6QuXXPeVT7Ce1yGoeqk9Lhv
         YM3rxoigZH5ygwAwXLDDUND15lfMfjNhClts6DcQ9JeycWFa3rv43eSe5Nw3Nb6jzpak
         TnlClQMuM4ir0eMZx/WAZ/ujVmKqlNSZuVAcE=
Received: by 10.220.188.74 with SMTP id cz10mr4597636vcb.71.1297079913946;
 Mon, 07 Feb 2011 03:58:33 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Mon, 7 Feb 2011 03:58:33 -0800 (PST)
X-Google-Sender-Auth: Tc1oxSTMownZrh1CGFxT5kTZPSs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166255>

Hi,

I'm trying to git-svn clone repository. I have encountered two
problems. For the the first one I have a workaround, but I'm lost with
the second.


1. I have a problem with one commit which tries to create a file name
which is not acceptable by file system (fat32). I tried to ignore this
files by using --ignore-paths, but it does not work. Am I using
ignore-paths incorrectly or do I have to find a different workaround?
(I'm thinking about using specific revisions or using filter-branch).

Here's what's happening:

$ git svn clone -s -r164508 '--ignore-paths=.*https:.*' <url>
Initialized empty Git repository in <path>/.git/
Using higher level of URL: <url> => <url>
mkdir .git/svn/refs/remotes/tags/https:: Invalid argument at
/usr/local/stow/git-1.7.4/libexec/git-core/git-svn line 3856

$ svn log -v -r164508 <url>
[...]
   A /<project>/tags/https:/blahblah

$ mkdir https:
mkdir: cannot create directory `https:': Invalid argument


2. I have specified revision that do not have invalid file names in it
and it worker, but git reported error later on, I suppose due to
--ignore-paths:

$ git svn clone -s '--ignore-paths=^/branches/<list of branches>'
'--ignore-paths=^/tags/<list of tags>' -r164510:HEAD <url>
[...]
r166131 = 86085ee643d1b8ecb60f6ec3212904a24dd4d71a
(refs/remotes/<ignored branch 1>
)
[...]
r167889 = 1fdb8124d72e1bc417f7fe06051a5280675dc73b
(refs/remotes/<ignored branch 2>)

	M	[...]	
Found merge parent (svn:mergeinfo prop):
1fdb8124d72e1bc417f7fe06051a5280675dc73b

[...]
W: Cannot find common ancestor between
689e9a85f91eb71e37ccd79063e0a5aaa37d1b74 and
5d04d29ab3c76835facade1859aed30129abecf4. Ignoring merge info.

Found merge parent (svn:mergeinfo prop):
039125717428084cdf4d38b8a98f431a9b656f1c

Couldn't find revmap for <url>/<ignored branch 3>/path
fatal: ambiguous argument
'86085ee643d1b8ecb60f6ec3212904a24dd4d71a^..1fdb8124d72e1bc417f7fe06051a5280675dc73b':
unknown revision or path not in the working tree.

Use '--' to separate paths from revisions

rev-list 86085ee643d1b8ecb60f6ec3212904a24dd4d71a^..1fdb8124d72e1bc417f7fe06051a5280675dc73b:
command returned error: 128



I'm not sure how to deal with this...


-- 
Piotrek
