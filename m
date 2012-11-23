From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v5 0/7] push: update remote tags only with force
Date: Thu, 22 Nov 2012 22:21:48 -0600
Message-ID: <1353644515-17349-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 23 05:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbknc-0001OK-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 05:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab2KWEXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 23:23:12 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab2KWEXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 23:23:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2857476iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=hQ+Oc6bflwBk8vwkF2yMyilQMbnZDJa+U5XCJb5YjhM=;
        b=JWjrFlL2p/MtSad6/mZa8R80qT9pcKeOJ09gzuVll7dkIYM5mU6CK/59OzOjtHk075
         K6ef9ryHPc9JOTS7br/1tZIxUsFZa3J/81pQmlHkXFNB+3GLsliJ/trFfTfqnUp7YD9g
         zcdcdbpyPdqYpILPbDyiNPF2IOaHko1XYFMhLbEzKqHTDrmTL5xfi7T/tTGibN6OEgL8
         rSJ/bNi9YEbBlPj0Tbe27R9vyoF0TB5r9mkBNNShj6gW9loAVAz1RzNrIYk0zg/UGnGN
         QQrDYBnezaCvcqKSviZcA4twUFWVQirWJ+NaOft4XfCSDkZCftiOzD9azeFCjMZlZDkC
         TgIg==
Received: by 10.50.57.133 with SMTP id i5mr2361851igq.67.1353644590959;
        Thu, 22 Nov 2012 20:23:10 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id l8sm3909944igo.13.2012.11.22.20.23.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 20:23:09 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210231>

Incorporated Junio's feedback.  Also, I broke the last patch of the
previous series out into three to make the changes more clear.

This patch set can be divided into two sets:

  1. Provide useful advice for rejected tag references.

     push: return reject reasons via a mask
     push: add advice for rejected tag reference

     Recommending a merge to resolve a rejected tag update seems
     nonsensical since the tag does not come along for the ride.  These
     patches change the advice for rejected tags to suggest using
     "push -f".

  2. Require force when updating tag references, even on a fast-forward.

     push: flag updates
     push: flag updates that require force
     push: require force for refs under refs/tags/
     push: require force for annotated tags
     push: clarify rejection of update to non-commit-ish

     This is in response to the following thread:

       http://thread.gmane.org/gmane.comp.version-control.git/208354

     This series prevents fast-forwards if the reference is under the
     refs/tags/* hierarchy or if the old object is a tag.

Chris Rorvick (7):
  push: return reject reasons via a mask
  push: add advice for rejected tag reference
  push: flag updates
  push: flag updates that require force
  push: require force for refs under refs/tags/
  push: require force for annotated tags
  push: clarify rejection of update to non-commit-ish

 Documentation/git-push.txt |  9 ++++---
 builtin/push.c             | 24 ++++++++++-------
 builtin/send-pack.c        |  9 +++++--
 cache.h                    |  7 ++++-
 remote.c                   | 65 +++++++++++++++++++++++++++++++++++++---------
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 44 ++++++++++++++++++++++++++++++-
 transport-helper.c         |  6 +++++
 transport.c                | 25 +++++++++++-------
 transport.h                | 10 ++++---
 10 files changed, 157 insertions(+), 43 deletions(-)

-- 
1.8.0.209.gf3828dc
