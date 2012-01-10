From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/8] The move to sequencer.c
Date: Tue, 10 Jan 2012 21:43:51 +0530
Message-ID: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeMY-00059f-1E
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab2AJQPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:15:38 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab2AJQPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:15:36 -0500
Received: by ggdk6 with SMTP id k6so301248ggd.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7IJ6hOFOo9j9lUuAY8od5TABa2BcKynYHJPeIBtkNyI=;
        b=L8/GThFZLxpThRuAWzlJgDd3qbVpX+N4+7EuXEq6oSqvBkUhmrV3ITT/flVxiNnQG+
         0GmyMYwwcCY3hcBo/DboPsErEmITWMc6pREc1VVqVXikfmtcjjBBlwAYhsrX2XcYPmY4
         SwYEeyoSZ610J/xlI6QDkJRXWPDH6LuVHRwFg=
Received: by 10.50.156.138 with SMTP id we10mr2500182igb.10.1326212135259;
        Tue, 10 Jan 2012 08:15:35 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.15.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:15:25 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188256>

Hi,

The big changes in this round are:

1. Dropped "revert: don't let revert continue a cherry-pick" from the
   last round after a quick discussion with Jonathan.

2. Separated out "revert: separate out parse errors logically" from
   "revert: report fine-grained errors from insn parser".  Definitely
   looks clearer.

3. Improved "revert: report fine-grained errors from insn parser" by
   eliminating repetition.  20 is a bit arbitrary, but it looks pretty
   enough on my terminal.

4. Added "sha1_name: introduce getn_sha1() to take length" and
   "revert: use getn_sha1() to simplify insn parsing".  I'm happy with
   them.  Name is inspired from the strncmp() variant of strcmp().

5. Included minimal API documentation with "sequencer: factor code out
   of revert builtin".

Thanks for reading.  I think I'll work on fixing the memory leaks now.

Ramkumar Ramachandra (8):
  revert: prepare to move replay_action to header
  revert: decouple sequencer actions from builtin commands
  revert: allow mixing "pick" and "revert" actions
  revert: separate out parse errors logically
  revert: report fine-grained errors from insn parser
  sha1_name: introduce getn_sha1() to take length
  revert: use getn_sha1() to simplify insn parsing
  sequencer: factor code out of revert builtin

 Documentation/technical/api-sequencer.txt |   22 +
 builtin/revert.c                          |  958 +----------------------------
 cache.h                                   |    1 +
 sequencer.c                               |  925 ++++++++++++++++++++++++++++-
 sequencer.h                               |   48 ++
 sha1_name.c                               |   23 +-
 t/t3510-cherry-pick-sequence.sh           |   46 +-
 7 files changed, 1056 insertions(+), 967 deletions(-)
 create mode 100644 Documentation/technical/api-sequencer.txt

-- 
1.7.8.2
