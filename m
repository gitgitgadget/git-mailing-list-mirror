From: =?ISO-8859-1?Q?Anders_Hovm=F6ller?= <boxed@killingar.net>
Subject: Re: Mac OSX, git and mounted drives from linux
Date: Tue, 29 Mar 2011 09:19:30 +0200
Message-ID: <AANLkTikEA7Q2t7=6+j-ZK1-tAF0bZk26F=YS9MeN9sQ0@mail.gmail.com>
References: <AANLkTi=eErGTJ=ky98+2p19S15AzNx+bdQSc_4A+SWih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 09:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TDF-0003aH-UF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1C2HTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:19:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60147 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1C2HTb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:19:31 -0400
Received: by ewy4 with SMTP id 4so1403075ewy.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 00:19:30 -0700 (PDT)
Received: by 10.213.1.209 with SMTP id 17mr1781369ebg.104.1301383170162; Tue,
 29 Mar 2011 00:19:30 -0700 (PDT)
Received: by 10.213.98.79 with HTTP; Tue, 29 Mar 2011 00:19:30 -0700 (PDT)
In-Reply-To: <AANLkTi=eErGTJ=ky98+2p19S15AzNx+bdQSc_4A+SWih@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170239>

Hi,

I think I've found a bug with git. For me it reproduces 100% of the
time. Basically "git diff-index HEAD" seems to be broken in some
strange way in my situation.

Prerequisites:
- Running git from a mac, latest update of snow leopard
- mounted a volume that exists on a linux box
- perform "git diff-index HEAD" on a repository

Notice also that the output from diff-index changes once in a while
when running other git commands. I couldn't find any reasonable
pattern. If I run diff-index from the linux box itself just after
running it on the mac it outputs the same garbage. If I then pull and
then rerun diff-index everything is fine until I run diff-index from
the mac again.
The reason always running the tools from the linux box is not a
reasonable workaround is that GitX uses diff-index :P
I have the exact same git version on both machines. I also checked
that they are correctly time synched.
The full log of what I did to reproduce it (my prompts are prefixed
with ------ for readability):


------ andersh-ws:andersh andersh$ pwd
/Volumes/andersh
------ andersh-ws:andersh andersh$ git clone
git://github.com/boxed/gitx.git=A0test
Cloning into test...
remote: Counting objects: 8419, done.
remote: Compressing objects: 100% (3014/3014), done.
remote: Total 8419 (delta 5609), reused 7767 (delta 5142)
Receiving objects: 100% (8419/8419), 8.91 MiB | 1.57 MiB/s, done.
Resolving deltas: 100% (5609/5609), done.
------ andersh-ws:andersh andersh$ cd test
------ andersh-ws:test andersh$ git diff-index HEAD
:100644 100644 b14754a0580c4195b1b48840f33b095f01fa3bac
0000000000000000000000000000000000000000 M
Images/AddRemoteBranchFireworksTemplate.png
:100644 100644 1671ac95aab83479c7b7bfe5d4df26db08618341
0000000000000000000000000000000000000000 M PBGitHistoryView.xib
:100644 100644 8e95c567aebc1ca1fb5e5b2fc1f5824364f19f30
0000000000000000000000000000000000000000 M
html/lib/syntaxhighlighter/compass/shThemeDjango.scss
:100644 100644 58942dc8e1a48eeced0175d3b87b96bcf918c622
0000000000000000000000000000000000000000 M speed_test/array.m
------ andersh-ws:test andersh$ git status
# On branch master
nothing to commit (working directory clean)
------ andersh-ws:test andersh$ git diff-index HEAD
:100644 100644 b14754a0580c4195b1b48840f33b095f01fa3bac
0000000000000000000000000000000000000000 M
Images/AddRemoteBranchFireworksTemplate.png
:100644 100644 1671ac95aab83479c7b7bfe5d4df26db08618341
0000000000000000000000000000000000000000 M PBGitHistoryView.xib
------ andersh-ws:test andersh$ mount
/dev/disk0s2 on / (hfs, local, journaled)
devfs on /dev (devfs, local, nobrowse)
/dev/disk1s2 on /Volumes/Macintosh HD (hfs, local, journaled)
map -hosts on /net (autofs, nosuid, automounted, nobrowse)
map auto_home on /home (autofs, automounted, nobrowse)
/dev/disk2s2 on /Users/andersh (hfs, local, nodev, nosuid, journaled, n=
obrowse)
//andersh@somelinuxserver/andersh on /Volumes/andersh (smbfs, nodev,
nosuid, mounted by andersh)
------ andersh-ws:test andersh$ git diff
------ andersh-ws:test andersh$ git --version
git version 1.7.3.5

Hoping someone has an idea,
Anders
