From: "Philip Oakley" <philipoakley@iee.org>
Subject: Sparse checkout not working as expected (colons in filenames on Windows)
Date: Thu, 19 Mar 2015 23:07:17 -0000
Organization: OPDS
Message-ID: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Yue Lin Ho" <yuelinho777@gmail.com>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYjWZ-0003tg-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 00:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbbCSXGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 19:06:43 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:64309 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088AbbCSXGm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 19:06:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CFGQCuVQtVPFtDFlxcgwUBUogBr3CPCxGFbQQCgUBNAQEBAQEBBgEBAQE4O4QKFAEBLh4BASELAggCASQ5AQQaBgcDBgETGwIBAgMBiCIJqhaOV5VBHASQCIMegRYFil+FbWGDDYcajBuGcoQQPoJ0AQEB
X-IPAS-Result: A2CFGQCuVQtVPFtDFlxcgwUBUogBr3CPCxGFbQQCgUBNAQEBAQEBBgEBAQE4O4QKFAEBLh4BASELAggCASQ5AQQaBgcDBgETGwIBAgMBiCIJqhaOV5VBHASQCIMegRYFil+FbWGDDYcajBuGcoQQPoJ0AQEB
X-IronPort-AV: E=Sophos;i="5.11,433,1422921600"; 
   d="scan'208";a="28440922"
Received: from host-92-22-67-91.as13285.net (HELO PhilipOakley) ([92.22.67.91])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Mar 2015 23:06:40 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265851>

Hi, I was expecting that sparse checkout could be used to avoid the 
checking out, by git, of files which have colons in their name into the 
worktree when on Windows.

Yue Lin Ho reported on the Msygit list [1] that he had a repo where 
there was already committed a file with a colon in it's name, which was 
a needed file and had been committed by a Linux user. The problem was 
how to work with that repo on a Windows box where such a file is 
prohibited to exist on the FS (hence the expectation that a sparse 
checkout would suffice). Yue has created a short test repo [2]

Even after getting the pathspec escaping right, I still haven't been 
able to make this expected behaviour work [3].

Am I wrong to expect that sparse checkout (and the skip-worktree bit) 
can be used to avoid files with undesirable filenames hitting the OS's 
file system?

If it should be OK, what's the correct recipe?

--
Philip

[1] 
https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/D4HcHRpxPgU 
"How to play around with the filename with colon on Windows?"
[2] Test repo https://github.com/t-pascal/tortoisegit-colons

[3] test sequence::
$ mkdir colons && cd colons
$ git clone -n https://github.com/t-pascal/tortoisegit-colons
$ cd tortoisegit-colons/
$ git config core.sparseCheckout true
$ cat .git/info/sparse-checkout # external editor
/*
!ifcfg-eth0\:0
$ git update-index --skip-worktree -- ifcfg-eth0\:0
Ignoring path ifcfg-eth0:0
$ git checkout -b test 7f35d34bc6160cc # tip commit, we are still 
unborn!
error: Invalid path 'ifcfg-eth0:0
D       ifcfg-eth0:0
Switched to a new branch 'test'
