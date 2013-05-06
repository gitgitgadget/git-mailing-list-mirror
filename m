From: Ilya Basin <basinilya@gmail.com>
Subject: Re[4]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Mon, 6 May 2013 12:14:22 +0400
Message-ID: <916494719.20130506121422@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net> <12810110770.20130502213124@gmail.com> <20130502204017.GB26623@dcvr.yhbt.net> <77906182.20130503092642@gmail.com> <1379019858.20130503104248@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 06 10:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZGZ8-0003qO-9H
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 10:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab3EFIOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 04:14:30 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40649 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3EFIO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 04:14:29 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3159156lbv.27
        for <git@vger.kernel.org>; Mon, 06 May 2013 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=m4pxF2mw80iOnmRJMDmA+gVvn4UAQGS+YmRwEV+xDTk=;
        b=SakNS3gheWzQfazVdz4DEarmRnSKn54phyXaviXWCgNXmOmRPPoRQnrSs8yjg+wFbM
         o1/MZ6CD03vNT5fsdwCIDfabyloRqe1c10zQjyM7RY7dL1CYg6WedoZDGFdP9r74pfaT
         XpbkGHEwtTyqFowzDo1Eyb+uSx2EIvrNvB8JpKNpzupI7Qa6mxWUPZX95/knhN+VRMfx
         IFwPCAx7zK6p8nd2tTQPx4RCn6V1FMXRESQ1SyAkzVZittGuFFaIp1UD4RsTlan3SC9V
         SG+SZ7PlJgRp3+xYjl4ip+w0OA3KfueKAohHE5pA1E2/Oft/AYcGzaBmdB6MJEg5oeYG
         kujg==
X-Received: by 10.152.26.65 with SMTP id j1mr7225718lag.42.1367828066997;
        Mon, 06 May 2013 01:14:26 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:1842:ea3c:41c8:517a])
        by mx.google.com with ESMTPSA id lb9sm8561154lab.9.2013.05.06.01.14.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 01:14:25 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <1379019858.20130503104248@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223429>

>>>> The last error I encountered is:
>>>> r7009 = 39805bb078983e34f2fc8d2c8c02d695d00d11c0 (refs/remotes/DMC4_Basic)
>>>> Too many open files: Can't open file '/home/il/builds/sicap/gitsvn/prd_dmc4.svn/db/revs/0/786': Too many open files at /.snapshots/persist/builds/git/git-git/perl/blib/lib/Git/SVN/Ra.pm line 282.
>>>> 
>>>> I think It's unrelated to empty dirs.

EW>>> Can you get an lsof on the git-svn process right before this?
IB>>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/A4O_OTQxWc
IB>>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/LfpcENJduN
IB>>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/Dkk7pN4Mpz
IB>>     etc.

EW>>> What's your open files limit?
IB>> 1024

IB> Why no call to close() from temp_release() in Git.pm?

Found, fixed. It was related to empty dirs.



-- 
