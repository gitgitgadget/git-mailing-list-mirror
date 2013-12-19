From: Adam Spiers <git@adamspiers.org>
Subject: script for reproducing history example in git-log(1) man page
Date: Thu, 19 Dec 2013 18:36:45 +0000
Message-ID: <20131219183645.GD23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 19:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtiSq-0004fG-7c
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 19:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab3LSSgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 13:36:48 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45697 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab3LSSgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 13:36:47 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 270882E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 18:36:46 +0000 (GMT)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239529>

I wanted to be able to experiment with the TREESAME example given in
the git-log(1) man page, so I built this script which recreates it:

--------- 8< --------- 8< --------- 8< --------- 8< --------- 8< ---------
#!/bin/bash

mkdir git-log-example
cd git-log-example

git init

# I
echo asdf > foo; echo quux > quux
git add .
git commit -mI; git tag I

# A
echo foo > foo
git add .
git commit -mA; git tag A

# B
git checkout -b b I
echo foo > foo
git add .
git commit -mB; git tag B

# M
git checkout master
git merge --no-commit b
git commit -m"M: merge of A and B"; git tag M

# C
git checkout -b c I
git commit --allow-empty -mC; git tag C

# N
git checkout master
git merge --no-commit c
git commit -m"N: merge of M and C"; git tag N

# D
git checkout -b d I
echo baz > foo
git add .
git commit -mD; git tag D

# O
git checkout master
git merge --no-commit d
echo foobarbaz > foo
git add .
git commit -m"O: merge of N and D"; git tag O

# E
git checkout -b e I
echo xyzzy > quux
git add .
git commit -mE; git tag E

# P
git checkout master
git merge --no-commit e
echo "quux xyzzy" > quux
git add .
git commit -m"P: merge of O and E"; git tag P

# X
git checkout -b x I
rm foo quux; echo side > side
git add -A .
git commit --amend -m"X"; git tag X

# Y
git checkout -b y x
echo side2 > side
git add .
git commit -m"Y"; git tag Y

# Q
git checkout master
git merge --no-commit y
git commit -mQ; git tag Q

# cleanup unneeded branches
git branch -D b c d e x y
--------- 8< --------- 8< --------- 8< --------- 8< --------- 8< ---------

Would it be worth including this in (say) contrib/, and then referring
to it from the man page, in case anyone else feels a similar urge?
