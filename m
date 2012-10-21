From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/6] New remote-hg helper
Date: Sun, 21 Oct 2012 19:48:58 +0200
Message-ID: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:49:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzeR-0002dM-I2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab2JURtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58451 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JURtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:15 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1631487wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=y4zevPB4Rz0bBAJxoW7gTkfpSHNSUAxKn/SutI+wfqU=;
        b=mTWFTSiDaFGwytu/oYPWeIn+k3byHnSw99BkLF9iwaIRjfTGL3BIGV7fYPQ3rR3rXS
         5MpUe+AYXod/REHIexrdgVMc7ZZDBc0wrk4B4W7UG64W4RrjjGzR8JVfrSULcnOCwIXS
         VEgJjfyxGe0NW5Q1bS3Ewk7BuRu7zaqy4vFhdLb2tlT6ChSKWrMexoFdPjiWoysF5axo
         27De3RBeA3CEPW4f9TPVmRmS9mq3BOJy58CerpPnshvG/ulF30JNI5Zcl60dwNhi3IzQ
         VLMVcohCm/apyvf5U/vVj9OdAlfD9CgsHqiLcm/1xOjENbK4KinjtzxQ2w1lOLRiBXyX
         Flnw==
Received: by 10.216.136.158 with SMTP id w30mr3838440wei.30.1350841754307;
        Sun, 21 Oct 2012 10:49:14 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id bn7sm17152477wib.8.2012.10.21.10.49.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208128>

I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
slow, or to difficult to setup, etc.

The only one I've liked so far is hg-fast-export[1], which is indeed fast,
relatively simple, and relatively easy to use. But it's not properly maintained
any more.

So, I decided to write my own from scratch, using hg-fast-export as
inspiration, and voila.

This one doesn't have any dependencies, just put it into your $PATH, and you
can clone and fetch hg repositories. More importantly to me; the code is
simple, and easy to maintain.

One important remote-hg alternative is the one written by Sverre Rabbelier that
is now maintained and distributed in msysgit, however, in my opinion the code
is bloated, and there isn't even a standalone branch to take a look at the
patches, and give them a try.

This version has some features that Sverre's version doesn't:

 * Support for tags
 * Support to specify branches to pull

Sverre's version has some features this one doesn't:

 * Support for octopus merges

[1] http://repo.or.cz/w/fast-export.git

Changes since v2:

 * Added support for pushing
 * Tests copied from original remote-hg
 * Custom default -> master renames removed
 * Code reorganized

Changes since v1:

 * Improved documentation
 * Use more common 'python' binary
 * Warn, don't barf when a branch has multiple heads
 * Fixed marks to fetch after cloned
 * Support for cloning/pulling remote repositories
 * Use a more appropriate internal directory (e.g. .git/hg/origin)
 * Fixes for python3

Felipe Contreras (6):
  Add new remote-hg transport helper
  remote-hg: add support for pushing
  remote-hg: add support for remote pushing
  remote-hg: add support for trivial features
  tests: add remote-hg tests
  tests: fix remote-hg warnings for modern git

 contrib/remote-hg/git-remote-hg | 489 ++++++++++++++++++++++++++++++++++++++++
 t/t5801-remote-hg.sh            | 143 ++++++++++++
 2 files changed, 632 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg
 create mode 100755 t/t5801-remote-hg.sh

-- 
1.8.0.rc2.7.g0961fdf.dirty
