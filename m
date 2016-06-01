From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Wed,  1 Jun 2016 17:45:15 +0700
Message-ID: <20160601104519.16563-1-pclouds@gmail.com>
References: <574D382A.8030809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	mhagger@alum.mit.edu, dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 12:45:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83eZ-0001dN-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcFAKpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 06:45:31 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35371 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbcFAKpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:45:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id g64so13093483pfb.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjXLDVhawZfkCZt48H0CPLD31sE3tk8Gq3baysGpMjw=;
        b=HxR223BUduJeOBZXx7Bl9WyPuif0StGOIEeovYPKlZstAY/7daCprPnXq6G23Yz+vz
         uGcovC4fqWoOfDgoURQ0SPImk1VDvRcPGXvwTbw0sVcmo0477XzuoxBp5pNkF9EPCR76
         HIw3Go+9HlAD41bjfbQUBdWbKswQTI7X8rnVXTfgHrbg2YOy9dnzTZ/JB03z9MAsTTV1
         3ntxo3WWQGYXwHzTko0KgEig9PflIh2j2Re7RvaHPKb+VwTla5MOQEZxejyXULvMI/GU
         o0TkRn27MpwNpbP5nTGT9IS3JqjR0U1llvlPm6rAXphdLqsmjDaJhWlHSrdMp4yaZ6rZ
         AS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjXLDVhawZfkCZt48H0CPLD31sE3tk8Gq3baysGpMjw=;
        b=c11tjTAIA2+Z9oMXzqftZGOyKJDqdAljemAgMnsgmnC/4MQ8xolZGFLcpKu93pUBlQ
         egkpURreakayOZycWwxoNP347k97pX2rAgKdwfI2LPmXumB9YjK1tpltLfJG5K0Y5PMx
         F/MLiwWCbepHpl1Q2/nbOOF5bpP5Tr1lmGJZbIomKGrUgLEEh7kjQo2eLuszxgJfBlfw
         DK11pUu+3hi6M3DaLr9tBL+2OLbhByGF+CtnUgrVRxX7qmeaZbkVboQrYrFzhAo6gd2g
         lwYH+cq80dHRV9lmOUwWDoYBNofzRR3cbGbzq11kt7BqPKjEYqNDdb4GFRABRBnrW5JX
         SQ4w==
X-Gm-Message-State: ALyK8tKoL8ZbuGsojPaGhUxXN9mobHHEkXKSV6OaCvztNi88dkjCKJLRDYKphJqPjbcoCg==
X-Received: by 10.98.27.215 with SMTP id b206mr7386549pfb.61.1464777929596;
        Wed, 01 Jun 2016 03:45:29 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id v1sm23426993pfa.93.2016.06.01.03.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 03:45:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:45:24 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <574D382A.8030809@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296076>

This series makes sure that objects referenced by all worktrees are
marked reachable so that we don't accidentally delete objects that are
being used. Previously per-worktree references in index, detached HEAD
or per-worktree reflogs come from current worktree only, not all
worktrees.

The series deals with git-prune and git-gc specifically. I left out
"git rev-list". It shares the same problem because it will only
consider current worktree's HEAD, index and per-worktree reflogs. The
problem is I am not sure if we simply just change, say
--indexed-objects, to cover all indexes, or should we only do that
with "--all-worktrees --indexed-objects". I guess this is up for
discussion.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  revision.c: move read_cache() out of add_index_objects_to_pending()
  reachable.c: mark reachable objects in index from all worktrees
  reachable.c: mark reachable detached HEAD from all worktrees
  reachable.c: make reachable reflogs for all per-worktree reflogs

 reachable.c      | 47 +++++++++++++++++++++++++++++++++++++++++------
 revision.c       | 34 +++++++++++++++++++++++++++-------
 revision.h       |  7 ++++++-
 t/t5304-prune.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 14 deletions(-)

--=20
2.8.2.524.g6ff3d78
