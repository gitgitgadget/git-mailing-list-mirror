From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: git svn --stdlayout 's little quirk.
Date: Sat, 20 Aug 2011 18:06:28 +0100 (BST)
Message-ID: <1313859988.60143.YahooMailClassic@web29518.mail.ird.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: madduck@madduck.net, normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 19:06:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qup0G-0005ZJ-BC
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 19:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab1HTRGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 13:06:30 -0400
Received: from nm19-vm0.bullet.mail.ird.yahoo.com ([77.238.189.92]:30701 "HELO
	nm19-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753394Ab1HTRGa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 13:06:30 -0400
Received: from [77.238.189.55] by nm19.bullet.mail.ird.yahoo.com with NNFMP; 20 Aug 2011 17:06:28 -0000
Received: from [212.82.108.238] by tm8.bullet.mail.ird.yahoo.com with NNFMP; 20 Aug 2011 17:06:28 -0000
Received: from [127.0.0.1] by omp1003.mail.ird.yahoo.com with NNFMP; 20 Aug 2011 17:06:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 751960.44190.bm@omp1003.mail.ird.yahoo.com
Received: (qmail 60499 invoked by uid 60001); 20 Aug 2011 17:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1313859988; bh=3be6gz//4CM4hsHNU6cjbz3s+8FHjHvpZQDIl8x11WA=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Avo0OGS5kRX5NclpP+hAYK8dntjX7EL13s9MnqqYl2Cc0U/K/bm9sS5tJRcEG6zuu6P8ABiEvHkTa4wWFMnl9ByY8aNGAMZjZs+2850BNSoxeebyB6udOQvwdM1erm/QU2w4mqsPEavohsIrJEVdLOWfhvBSP6xBeRQ+JCfSlC4=
X-YMail-OSG: 6xsczH4VM1kdF7ZSVnmwVoBmyf5oS1GA1bH9oMU6khCjAUC
 NQsZi9MfZOk1naQaFJJMEdE3iH83DZiMMDIARYJUqDrvaYidiJ90XxvssRv6
 kKEzxNHhCznI4jtAlDKMcpoadBj.LhVwcaEo_kBa1FKRiOg4xlaTscIqw83M
 PeEqd7YN5SXfGMlFilUU0GZLig34oLdUrbwcDUxZagvUUF37iXqg_W_KYNmV
 p6fvpjZPfuXoz3K7v8DiSOuoYxiFBDrY.rShCRPE1gr.YIjh.1r1BLKWwc.L
 T13poqltPBN18jux1qkDeTW3muH4sgdCdU3T.dXjyBmHeh8qqwsLe6L.evbu
 rj_xO6CG0U8JGCBTp.uPyIyVFRUsPTFejqUOlfAw4VahPCns_dA9GtTt8g_8
 W1g0U1OD1T1RSE_aBotGl_OwT5hbbbhfQ8X6mod7wt2apdF1sqOW.Ec3jg3z
 syEJyY4vzCse7UbhWDK52NeIvUppUqLt3n5Neu_w51HRA1soRxx5XJMTo
Received: from [81.101.129.153] by web29518.mail.ird.yahoo.com via HTTP; Sat, 20 Aug 2011 18:06:28 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.315625
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179764>

first of all, thanks for a great tool - use it daily!

I think I found a small bug in git 1.7.6. Having "trunk" at the end of the url in combination of --stdlayout is wrong, but it looks like that git-svn tries to cope, but doesn't go try far enough:

Doing this:
----------------
git svn clone --stdlayout http://quick-settings.googlecode.com/svn/trunk/ android-quick-settings
----------------

Gives this message and stops:
----------------
Initialized empty Git repository in /home/Hin-Tak/tmp-git/svn-imports/android-quick-settings/.git/
Using higher level of URL: http://quick-settings.googlecode.com/svn/trunk => http://quick-settings.googlecode.com/svn
----------------

When I saw the message I thought it is striping the ending 'trunk' for my convenience, but when I look at .git/config:

--------------------
$ more .git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = http://quick-settings.googlecode.com/svn
	fetch = trunk/trunk:refs/remotes/trunk
	branches = trunk/branches/*:refs/remotes/*
	tags = trunk/tags/*:refs/remotes/tags/*
------------------

It is doing 'trunk/trunk', etc, which is why it stopped.

Can it either clone correctly despite the wrong instruction, or fail with a better message than 'Using higher level...' which suggests it tried?
