From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 00/19] remote-helper improvements
Date: Wed,  8 Jun 2011 20:48:31 +0200
Message-ID: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNot-0007wm-5H
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab1FHSta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:30 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab1FHSt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:28 -0400
Received: by eyx24 with SMTP id 24so279690eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=kORjd2COuPfHocmJkBCWPsEmPfKbJ/KddmAEHuyT65w=;
        b=UdFxvaMw0QT6zKWvtwtmUC8hyFcBi+MLQIZWXvet37K92PUax/y2UTMy3S7/BUhuPd
         sU1ps+ePK3cznpLy6MU99ADplKghW0C8jxlR3RIGSqkRN/BpMak7cSapMNoP7uhb8WX/
         ZesAE1JrqNNaoahyBz68FHcVZeflo8JbXNbLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=YZSP41PhiorQ0jIlKgFRJoHqqXIrDUL5WJlKDz5/nNskBvdQW/A3ytK6Q4RJc8IAE0
         nShf6X9Vphn1gS89HSHSiqW7YsnSjqcnBHmSHVqOPKy/lgqmOihwm6ULBSvQyhYqEG8i
         zYhW1nBkCdStoHxcF8HeufFo/oecSaYaeeEfU=
Received: by 10.14.2.27 with SMTP id 27mr3111836eee.9.1307558966260;
        Wed, 08 Jun 2011 11:49:26 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175421>

This is a re-roll of Peff's recent series [0] and the series [1] I sent out
well over half a year ago. My series replaces two from Peff's.

[0] http://thread.gmane.org/gmane.comp.version-control.git/174904
[1] http://thread.gmane.org/gmane.comp.version-control.git/154669

Jeff King (6):
      transport-helper: fix minor leak in push_refs_with_export
      t5800: factor out some ref tests
      t5800: document some non-functional parts of remote helpers
      teach remote-testgit to import non-HEAD refs
      transport-helper: don't feed bogus refs to export push
      git_remote_helpers: push all refs during a non-local export

Sverre Rabbelier (13):
      remote-curl: accept empty line as terminator
      git-remote-testgit: only push for non-local repositories
      git-remote-testgit: fix error handling
      fast-import: introduce 'done' command
      fast-export: support done feature
      transport-helper: factor out push_update_refs_status
      transport-helper: check status code of finish_command
      transport-helper: use the new done feature where possible
      transport-helper: update ref status after push with export
      transport-helper: change import semantics
      transport-helper: export is no longer always the last command
      transport-helper: Use capname for gitdir capability too
      transport-helper: implement marks location as capability

 Documentation/git-fast-export.txt   |    4 +
 Documentation/git-fast-import.txt   |   25 ++++
 builtin/fast-export.c               |    9 ++
 fast-import.c                       |    8 ++
 git-remote-testgit.py               |   54 ++++++---
 git_remote_helpers/git/exporter.py  |    8 +-
 git_remote_helpers/git/importer.py  |    5 +-
 git_remote_helpers/git/non_local.py |    2 +-
 remote-curl.c                       |    3 +
 t/t5800-remote-helpers.sh           |   59 ++++++++-
 t/t9300-fast-import.sh              |   42 ++++++
 transport-helper.c                  |  238 ++++++++++++++++++----------------
 12 files changed, 320 insertions(+), 137 deletions(-)
