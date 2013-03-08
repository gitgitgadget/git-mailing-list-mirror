From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Fri, 08 Mar 2013 13:19:57 +0100
Message-ID: <5139D76D.80703@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 13:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDwPE-0007JZ-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 13:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab3CHM1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 07:27:46 -0500
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59318 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab3CHM1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 07:27:45 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2013 07:27:45 EST
Received: from [192.168.2.152] (p54926829.dip.t-dialin.net [84.146.104.41])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id DF67B41A04
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 13:20:22 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217663>

Hi im running arch linux and core/glibc 2.17-3

When i try to rebase with:

git clonehttps://github.com/owncloud/core.git
cd core/
git pull --rebasehttps://github.com/PatrickHeller/core.git  master

I'm getting:

$ git pull --rebasehttps://github.com/PatrickHeller/core.git  master
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 2), reused 3 (delta 2)
Unpacking objects: 100% (3/3), done.
  Fromhttps://github.com/PatrickHeller/core
   * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: distinguish between touch and write
Applying: remove debug output
*** Error in `git': malloc(): memory corruption: 0x0000000000be14e0 ***


Using valgrind gives me:

$ valgrind /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
==5995== Memcheck, a memory error detector
==5995== Copyright (C) 2002-2012, and GNU GPL'd, by Julian Seward et al.
==5995== Using Valgrind-3.8.1 and LibVEX; rerun with -h for copyright info
==5995== Command: /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
==5995==
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 2), reused 3 (delta 2)
Unpacking objects: 100% (3/3), done.
  Fromhttps://github.com/PatrickHeller/core
   * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: distinguish between touch and write
Applying: remove debug output
*** Error in `git': malloc(): memory corruption: 0x00000000027f14e0 ***

^C==5995==
==5995== HEAP SUMMARY:
==5995==     in use at exit: 1,076 bytes in 11 blocks
==5995==   total heap usage: 53 allocs, 42 frees, 11,038 bytes allocated
==5995==
==5995== LEAK SUMMARY:
==5995==    definitely lost: 0 bytes in 0 blocks
==5995==    indirectly lost: 0 bytes in 0 blocks
==5995==      possibly lost: 0 bytes in 0 blocks
