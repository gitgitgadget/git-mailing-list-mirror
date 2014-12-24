From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/3] Improve push performance with lots of refs
Date: Wed, 24 Dec 2014 23:05:37 +0000
Message-ID: <1419462340-769147-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 00:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3v0b-0006Er-AY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 00:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbaLXXGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 18:06:05 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55960 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584AbaLXXGC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 18:06:02 -0500
Received: from vauxhall.hsd1.tx.comcast.net. (unknown [98.201.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 27D1D2808F;
	Wed, 24 Dec 2014 23:05:54 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261816>

This series contains patches to address a significant push performance
regression in repositories with large amounts of refs.  It avoids
performing expensive edge marking unless the repository is shallow.

The first patch in the series is a fix for a minor typo I discovered
when editing the documentation.  The second patch implements git
rev-list --objects-edge-aggressive, and the third patch ensures it's
used for pushing to and fetching from shallow repos only.

The changes from v3 are to use --objects-edge-aggressive from the point
it's introduced (this preserves bisectability) and to make higher-level
commands pass --shallow for any shallow pushing and fetching instead of
trying to have pack-objects determine it.

The original fix was suggested by Duy Nguyen.

brian m. carlson (3):
  Documentation: add missing article in rev-list-options.txt
  rev-list: add an option to mark fewer edges as uninteresting
  pack-objects: use --objects-edge-aggressive for shallow repos

 Documentation/git-pack-objects.txt | 7 ++++++-
 Documentation/git-rev-list.txt     | 3 ++-
 Documentation/rev-list-options.txt | 7 ++++++-
 builtin/pack-objects.c             | 7 ++++++-
 list-objects.c                     | 4 ++--
 revision.c                         | 6 ++++++
 revision.h                         | 1 +
 send-pack.c                        | 3 +++
 upload-pack.c                      | 4 +++-
 9 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.2.1.209.g41e5f3a
