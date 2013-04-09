From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Fix git add with submodules
Date: Tue,  9 Apr 2013 14:51:35 +0530
Message-ID: <1365499297-8667-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 11:20:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPUj6-0003GW-5E
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 11:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179Ab3DIJUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 05:20:19 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34821 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935294Ab3DIJUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 05:20:17 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so3708791pab.24
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=VPC3YLd2zl06CM8Ho+izcwFHZHKHA/iRQWDi6Kqcljw=;
        b=X65nA5HcXFVOgB3XFAPgugz+oVMOqKiFh1onMHepIuDX8N4wlAyF1SaYQ/taNC5uQo
         fZJQIZwTDZiZH2+rXT++TihVtdBlX/QbHgUjz8a37nZqZ9t5EVWCHwo1oSHodRorZHRO
         JY33dyGIqT08IF5uS4Dg3ouHt8D8/h3VpwKO7uQInMjoP8oy1q0PuunsJFQ9QL2N4Uh9
         RA5KGOf8+dZksMKNkzfAYbKmrQUnwoBQysbdOCpBsMvR57fN5qMtouIxCc2eGZMlbA6v
         klTWve+yK+/yE//5b8JBEqp6DLn1KNYa+raiLy/bLauFe3dR2yEcQi0W1Xi4IF+2sj4W
         UWzQ==
X-Received: by 10.68.134.36 with SMTP id ph4mr1485892pbb.181.1365499216397;
        Tue, 09 Apr 2013 02:20:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id mm9sm1484714pbc.43.2013.04.09.02.20.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 02:20:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.347.gdd82260.dirty
In-Reply-To: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220556>

Hi,

git add has a bug when operating on submodules.  The following test
fails:

	mkdir submodule_dir &&
	(
		cd submodule_dir &&
		git init &&
		cat >foo <<-\EOF &&
		Some content
		EOF
		git add foo &&
		git commit -a -m "Add foo"
	) &&
	test_must_fail git add submodule_dir/foo

[1/2] adds this failing test along with a passing related test.
[2/2] fixes the failing test.

Ramkumar Ramachandra (2):
  t3700 (add): add two tests for testing add with submodules
  add: refuse to add paths beyond repository boundaries

 builtin/add.c  |  5 +++--
 cache.h        |  2 ++
 pathspec.c     | 12 ++++++++++++
 pathspec.h     |  1 +
 symlinks.c     | 43 +++++++++++++++++++++++++++++++++++++------
 t/t3700-add.sh | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 8 deletions(-)

-- 
1.8.2.1.347.gdd82260.dirty
