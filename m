From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 29 Nov 2012 19:41:32 -0600
Message-ID: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdW-0006Qy-N6
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2K3BnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:11 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41967 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2K3BnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:09 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so11433874iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=3NMq9obfzp/ubgILKK2irTH8o186OZEg+aZqJcGBeks=;
        b=MCaC9HIU9K1VRbCN5omfx0COBaRm7dVMZYKxHKSwwpFiKAiWnKWgd0pjGUVHb4M52E
         RfK2jZ5hhSdUtQTmZ9/Zhf+wRk4I+MgboSCvwu/708z4Rdy6q9WSsPJoWwBvz0i2oqd9
         f91yzfGvEgQCmyYXwZNnKt44kh4GUfMnaUz4kmDLDJd45JVcu7KjP60IxGKf7vZ7CHA9
         SSpLxNjc3CNVuv2lOGNT+bylWCOTZDwACTVX7NUBYvXHrwChHlimgdMv2vh2yIKj8viY
         k8YfDqi5lvJZIO2sivBbKD5tTgBIaItuJ2sErYvYN/TebvjVNRnPrZp06b4E1jlWkoZM
         7meg==
Received: by 10.50.12.228 with SMTP id b4mr27577972igc.74.1354239789388;
        Thu, 29 Nov 2012 17:43:09 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:08 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210896>

This patch series originated in response to the following thread:

  http://thread.gmane.org/gmane.comp.version-control.git/208354

I made some adjustments based on Junio's last round of feedback
including a new patch reworking the "push rules" comment in remote.c.
Also refined some of the log messages--nothing major.  Finally, took a
stab at putting something together for the release notes, see below.

Chris

Release notes:

"git push" no longer updates tags (lightweight or annotated) by default.
Specifically, if the destination reference already exists and is under
refs/tags/ or it points to a tag object, it is not allowed to fast-
forward (unless forced using +A:B notation or by passing --force.)  This
is consistent with how a tag is normally thought of: a reference that
does not move once defined.  It also ensures a push will not
inadvertently clobber an already existing tag--something that can go
unnoticed if fast-forwarding is allowed.

Chris Rorvick (8):
  push: return reject reasons as a bitset
  push: add advice for rejected tag reference
  push: flag updates
  push: flag updates that require force
  push: require force for refs under refs/tags/
  push: require force for annotated tags
  push: clarify rejection of update to non-commit-ish
  push: cleanup push rules comment

 Documentation/git-push.txt |  9 ++---
 builtin/push.c             | 24 +++++++++-----
 builtin/send-pack.c        |  9 +++--
 cache.h                    |  7 +++-
 remote.c                   | 83 +++++++++++++++++++++++++++++++++++-----------
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 44 +++++++++++++++++++++++-
 transport-helper.c         |  6 ++++
 transport.c                | 25 ++++++++------
 transport.h                | 10 +++---
 10 files changed, 167 insertions(+), 51 deletions(-)

-- 
1.8.0.158.g0c4328c
