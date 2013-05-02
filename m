From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 21:31:24 +0400
Message-ID: <12810110770.20130502213124@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 02 19:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxNZ-0003Ol-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500Ab3EBRdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:33:09 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:40987 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab3EBRdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:33:07 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so767713lab.2
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xoDyUgwnYY/2IESYVK+zbHVFri/XNEw6UJ9rp+Oj5hU=;
        b=cQtC3S0MWJkqqXsEc1Yyna8KDxhCYU9zo0FSV491aGV94Ako06Z2X1GBCeRsF/0yj9
         +JL6Z5EV3417JJ2xpKOXxPrWuAiuK9WDl8SX5/8gftW4DA/InCXUPmCdbVBufrL5BnY/
         uXpXBntmn5EAquxKYuXTKX1Xh2DYH5YLaxd1/eIEU0Yr10fP5NeJXPFkJWWEb7imeSzZ
         zIKtMBDO49FN3EdG4WJeNLIgSFBQgGsD9QMUFswIVPEfrBSOLVsSXJfhziIGj8d+NCoY
         bcggSsLgyWs5TPZlTjaAOQQnrmfTncJRVKSYw9cuUJTxD306ivnY/N3Pt5rZW8nA07Ex
         I0Rg==
X-Received: by 10.112.149.200 with SMTP id uc8mr3115735lbb.9.1367515985286;
        Thu, 02 May 2013 10:33:05 -0700 (PDT)
Received: from [192.168.0.78] (92-100-239-74.dynamic.avangarddsl.ru. [92.100.239.74])
        by mx.google.com with ESMTPSA id x9sm3022403lbi.15.2013.05.02.10.33.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 10:33:03 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130502024926.GA12172@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223236>

Hi. I won't send you updated patches until I import and test my huge
repo. Everything will be here:
https://github.com/basinilya/git/commits/v1.8.2.2-git-svn-fixes

At the moment I've decided not to implement the Junio's proposal:
> >> JCH> comment line "# added by git-svn only to keep the directory" and
> >> JCH> consider a directory that has nothing but .gitignore that consists
> >> JCH> of only that exact comment line an "added placeholder" directory to
> >> JCH> work it around.

But the config file is not an option too: I have 400 tags, each has
200 empty folders.

Instead I decided to store the paths in a text file (see
https://github.com/basinilya/git/commit/a961aedd81cb8676a52cfe71ccb6eba0f9e64b90 ).
I'm not planning to push this change to you.

The last error I encountered is:
r7009 = 39805bb078983e34f2fc8d2c8c02d695d00d11c0 (refs/remotes/DMC4_Basic)
Too many open files: Can't open file '/home/il/builds/sicap/gitsvn/prd_dmc4.svn/db/revs/0/786': Too many open files at /.snapshots/persist/builds/git/git-git/perl/blib/lib/Git/SVN/Ra.pm line 282.

I think It's unrelated to empty dirs.
