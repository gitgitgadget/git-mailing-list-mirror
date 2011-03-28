From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 0/9] add long forms for format placeholders
Date: Tue, 29 Mar 2011 00:17:22 +0100
Message-ID: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lh9-0000kt-IP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab1C1XRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:17:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1C1XRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:17:53 -0400
Received: by wya21 with SMTP id 21so3294008wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=AT+jIdnAPUZtbL2FPyCx2Al48JdSr+b9tEHV07JRIoo=;
        b=A69ktiRWanRIieNcX0IpyySntvHO7EPds8Xm84/7qmZy9ZgqbwN+NToY3jis3JHTZr
         Flje0JkkogL6g35AV+hbiTrjP2MYzjWgBEL1EgGQlMRD/QhOoR0RCe+T+WSFcLlkTsiF
         inU8nNZhbSlVeZnCa0f7opaGYTEvqcC/GES7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MIvJRhBjxZtUKIet7GOmiN1FKQyR0Rmyz/tlFbiiolwhxUldJlhcbFBTWtKpUFy04M
         4IKwtB2WsLkqxJsiDYSL0qMqLclaNU28TXszkvD2OjZqNqcKxgEtNWSaSsrZ82jR4Cf1
         jjK7MgdjHvn7w66foYjhUN+eOiEO19QmPnwY8=
Received: by 10.216.69.15 with SMTP id m15mr4181187wed.70.1301354271958;
        Mon, 28 Mar 2011 16:17:51 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170198>

I've been kicking around this series for a while now as part of a larger
effort of refactoring the pretty formats. A recent discussion on the
list has lead me to believe that this smaller subset may be of use
sooner, rather than later.

This series attempts to add "long forms" for common format placeholders
in the "git log" family of commands, making the way for yet more
placeholders to be added without needing to worry too much about the
increasingly limited set of available one-letter mnemonics. It also
moves towards the possibility of eventual unification with the format
options in for-each-ref.

For example: after this series, in place of %ad, %at, etc you would be
able to use %(authordate), %(authordate:unix), etc.

There are some changes in this series which may not seem justified at
this point, most noticeably the splitting of user-defined format
processing into separate "parse" and "format" stages. This is done to
allow for more-complicated formats to be defined, especially conditional
formats. Examples of these are not yet included in this series, because
this series only includes those parts related to allowing for the
"long form" placeholders. If this series needs to go through a few
cycles before it's ready for inclusion, examples more-complicated
formats may find their way into the series.

The primary purpose of the series is to allow new placeholders to be
defined without worrying about the increasingly diminishing set of
available one-or-two-letter mnemonics.

Cc: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>

Will Palmer (9):
  mention --date=raw in rev-list and blame help
  add support for --date=unix to complement %at
  interpret %C(invalid) as we would %%C(invalid)
  add sanity length check to format_person_part
  refactor pretty.c into "parse" and "format" steps
  add long-form %(wrap:...) for %w(...)
  add long form %(color:...) for %C(...)
  add long forms %(authordate) and %(committerdate)
  add long forms for author and committer identity

 .gitignore                         |    1 +
 Documentation/blame-options.txt    |    4 +-
 Documentation/git-rev-list.txt     |    2 +-
 Documentation/pretty-formats.txt   |   51 ++-
 Documentation/rev-list-options.txt |    4 +-
 Makefile                           |    1 +
 builtin/blame.c                    |    3 +
 cache.h                            |    5 +-
 color.c                            |   17 +-
 color.h                            |    1 +
 commit.h                           |   84 ++++
 date.c                             |   61 ++-
 pretty.c                           |  947 +++++++++++++++++++++++++++---------
 test-pretty.c                      |  250 ++++++++++
 14 files changed, 1164 insertions(+), 267 deletions(-)
 create mode 100644 test-pretty.c

-- 
1.7.4.2
