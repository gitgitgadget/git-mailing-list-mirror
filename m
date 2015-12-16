From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH 0/2] git-svn: add support for prefixed globs in config
Date: Wed, 16 Dec 2015 16:01:07 +0300
Message-ID: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 14:01:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Bho-0001Ph-NP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 14:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbbLPNBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 08:01:16 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36347 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972AbbLPNBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 08:01:15 -0500
Received: by mail-lb0-f177.google.com with SMTP id yq9so5940568lbb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 05:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ksdUSALb7GnegEVfGJqZtyIcXBHCggWxPivtwPZHXyA=;
        b=eFC21TipreXP1BlF7AgyrlS7spE7Kfv0d4rIqqBVIp3F3XkrBH9Ddjk6vJIWBYIfCC
         L0KMQbeLhM3JeCZrAvv5Ki1+Sh36iutxsp/iUKj77d62h6pAH6S3kNwegVLYZ8v/4kFs
         AAkl4bYCCFXbpKFD/dBdnbKJvnsSqXgUdezN1QCxpxJYFtKaL1Z2Eu3GZdBg576w/uXQ
         q+gt4VUsWPbRAv1eXDGst9rPitK9Rz8BC3xFKp1X+XeEgY6aAw2P/LJhtbqQKrHaThcN
         YOAptxSR4RySYXUDR0wH6b9mvdfrG67FFgQGSIv5UKzbF4nEcwOt1Ry76/G5N8hz9X4q
         pRZg==
X-Received: by 10.112.199.105 with SMTP id jj9mr10665098lbc.131.1450270873736;
        Wed, 16 Dec 2015 05:01:13 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id ds5sm982032lbc.0.2015.12.16.05.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 05:01:12 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a9Bhf-0007lg-3X; Wed, 16 Dec 2015 16:01:11 +0300
X-Mailer: git-send-email 2.7.0.rc0.21.gb793f61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282558>

There are existing old SVN repos which use patterns in branch (and tag) names
to indicate some information. For example: branches/release_01, branches/release_02, etc,
however non-patterned branches co-exist with them (like branches/dev).

If someone maintains git mirror of such a repo it is reasonable to mirror only
several branches (for example those who match some pattern) and in current situation
it leads to messy and error-prone git config like:

branches = branches/{release_20,release_21,release_22,...

It would be useful to have an opportunity to write

branches = branches/release_*

instead of this.

Thus I suggest to add support for such 'prefixed' globs into git-svn.

Victor Leschuk (2):
  Introduce prefixed globs for branches and tags in git-svn.
  Add test for git-svn prefixed globs.

 Documentation/git-svn.txt        |   5 ++
 perl/Git/SVN/GlobSpec.pm         |   9 ++-
 t/t9168-git-svn-prefixed-glob.sh | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100755 t/t9168-git-svn-prefixed-glob.sh

-- 
2.7.0.rc0.21.gb793f61
