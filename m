From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/5] Preparation for non-ff pulls by default
Date: Sun,  8 Sep 2013 20:23:11 -0500
Message-ID: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHL-00019s-5n
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab3IIB2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:22 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:47148 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3IIB2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:22 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so5892966oag.21
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zIxD4jZbcGUDdVbfuUwwiWAoLPtTEaQxtzJs5nN4ZuM=;
        b=B/LxweOi/QRubEunjyif1F9cu6IUPdUki45/dita8W9KdGTmtOn6kByNWAyWdEFgFw
         8df4wFhRXlOMGkVQmKHqFMa3uP/Vb0Z89booMII9SaUsqAh7JycE6qtUK1Yz7t5X9O+p
         1QMserCF6cbinYdCNwhgtIsLnbtRI1/9pk/pYB8VNDftthsRON7iN++226PAKtlZE5yj
         +mgNukrLovMYwZ+hJ49hvLS5T3bFd6OEGPsV1baDrL1BWXGlPlmYPHdP7r4PV0Z3GUGi
         upeoGcwq73Nd4vEr8cqUaHl863NksioG5ymqEQqd3fUdZrtVOo0P3a01ad2Nzg4wknE3
         Jh6A==
X-Received: by 10.182.233.137 with SMTP id tw9mr9531182obc.87.1378690101715;
        Sun, 08 Sep 2013 18:28:21 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm10979163oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234295>

It is very typical for Git newcomers to inadvertently create merges and worst:
inadvertently pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been suggested
that 'git pull' barfs by default if the merge is non-fast-forward, which
unfortunately would break backwards compatibility.

This patch series leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default (e.g. in v2.0).

To achieve that first some configurations are renamed: for example: pull.rebase
=> pull.mode = rebase, but the old ones remain functional, thus there are no
functional changes.

Then the new mode 'merge-ff-only' is added, but not enabled by default, and
finally, a warning is added so the users will know what to do when the new
mode is indeed enabled by default.

Felipe Contreras (5):
  pull: rename pull.rename to pull.mode
  pull: refactor $rebase variable into $mode
  pull: add --merge option
  pull: add merge-ff-only option
  pull: add warning on non-ff merges

 Documentation/config.txt   | 24 ++++++++++--------
 Documentation/git-pull.txt | 10 +++++---
 branch.c                   |  4 +--
 git-pull.sh                | 63 +++++++++++++++++++++++++++++++++++++---------
 t/t3200-branch.sh          | 40 ++++++++++++++---------------
 t/t5520-pull.sh            | 62 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh           |  4 +--
 7 files changed, 157 insertions(+), 50 deletions(-)

-- 
1.8.4-338-gefd7fa6
