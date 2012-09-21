From: Cristian Tibirna <tibirna@kde.org>
Subject: git diff-tree -r -C output inexact sometimes
Date: Thu, 20 Sep 2012 23:20:31 -0400
Organization: KDE
Message-ID: <2789023.yr3ihcVOhq@leto>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1364207.0sEsaBznuS"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 06:10:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEuZG-0000me-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 06:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab2IUEJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 00:09:25 -0400
Received: from walter.accountservergroup.com ([50.22.11.10]:51641 "EHLO
	walter.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925Ab2IUEJY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2012 00:09:24 -0400
X-Greylist: delayed 3050 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2012 00:09:24 EDT
Received: from modemcable066.126-58-74.mc.videotron.ca ([74.58.126.66] helo=leto.localnet)
	by walter.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <tibirna@kde.org>)
	id 1TEtlC-0002XX-05
	for git@vger.kernel.org; Thu, 20 Sep 2012 22:18:34 -0500
User-Agent: KMail/4.9.1 (Linux/3.4.6-2.10-desktop; KDE/4.9.1; x86_64; ; )
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - walter.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kde.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206102>

This is a multi-part message in MIME format.

--nextPart1364207.0sEsaBznuS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello

A colleague of mine discovered an inconsistency in the functioning of 

git diff-tree -r -C

in specific conditions. As tenuous as these conditions might seem (once you 
run the script in attachment and analyse its output), please rest assured that 
it comes from a real-life case.

Running the script in attachment produces a git repository in which were 
operated a large number of file renames, in which many of the renamed files 
(in this particular case all) have the same content but different names.

The commit data from the renaming operation (last commit in the script-
generated history) is inexactly rendered by the command 

git diff-tree -r -C master

The logical result is correctly produced by the more restricted command

git diff-tree -r -M master

IMO for this particular last commit both the above commands should return the 
same result.

Note that reducing i or j in the generator script attached below makes the bug 
dissapear.

Thanks a lot for your attention.

-- 
Cristian Tibirna
KDE developer .. tibirna@kde.org .. http://www.kde.org

--nextPart1364207.0sEsaBznuS
Content-Disposition: attachment; filename="generate_git_tree.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="generate_git_tree.sh"

#!/bin/bash
mkdir depot
cd depot
for i in {1..1}
do
   mkdir $i
   cd $i
   for j in {1..4}
   do
     mkdir $j
     cd $j
     for k in {1..15}
     do
       touch "my_filename${k}_-2.txt"
     done
     cd ..
   done
   cd ..
done
cd depot
git init
git add .
git commit -m "1st commit"
rename -- '_-2' '-2' */*/*_-2.txt
git add -A
git commit -m "BUG => some files deleted, other copied, but all should be renamed!"

--nextPart1364207.0sEsaBznuS--
