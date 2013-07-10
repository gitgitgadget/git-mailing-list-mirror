From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH 0/4] add git-check-mailmap command
Date: Wed, 10 Jul 2013 15:03:57 -0400
Message-ID: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 21:10:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwzmr-0004Cn-2O
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 21:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab3GJTKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 15:10:45 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:43969 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab3GJTKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 15:10:44 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2013 15:10:44 EDT
Received: by mail-yh0-f48.google.com with SMTP id z12so2877441yhz.21
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=MjBxhLwZgXx3XWivDwJ2fE/1kEkXPBuC0gTSb956ycU=;
        b=aA59wGnLQkOIJbEFI3ifeBDIQHCDhXtkOv0BoVCvl+Ij9SFzxDlRsPxhKtwA3CqBm5
         kFxXcXPR/mnILWHthRwpWY+AibC7sNdvkMQYOtdrcvu3EiF/PAA0ri4xFETGS9wze/IO
         bY1V/dnHXZCw4KO/vv4EoCyUiEGTO4vD8FjDzkUiEYBurXenKSg+7AXRX7x0Vphhvud4
         VSq55n5VLRufpKm9eul7GmjOCHkvfMbU5DoK3/FwbK8ZlaUea20ht+yTeFy6CQIRztsP
         DcE0DmCcJq6jLXAbIyq0trF6cIRequ59kTMqo6a9TQPvJ8WGwfKy2TPBoSY1s66myjAc
         0WiA==
X-Received: by 10.236.169.228 with SMTP id n64mr18685636yhl.51.1373483088241;
        Wed, 10 Jul 2013 12:04:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id 66sm54426527yhe.20.2013.07.10.12.04.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 12:04:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230068>

This patch series adds builtin command check-mailmap, similar to
check-attr and check-ignore, which allows direct testing of .mailmap
configuration.  More importantly, as plumbing accessible to scripts
and other porcelain, check-mailmap publishes the stable, well-tested
.mailmap functionality employed by built-in Git commands.

It is RFC because it lacks documentation; because its utility as a
check-foo command is minimal compared to check-attr and check-ignore
(although its utility as plumbing for scripts and porcelain is more
significant); and because I want to make sure that the project is
willing to accept yet another check-foo command.

The idea and motivation for git-check-mailmap arose from the effort to
implement .mailmap support for git-contacts [1] (presently at
es/contacts in 'pu').

Felipe's Ruby implementation of .mailmap support for his git-related
script is introduced in patch 9/15 [2] of v5, and is augmented in patch
10/15 [3] to support invocation from within a subdirectory. His version
supports configuration variable mailmap.file, but not mailmap.blob.

Rather than rewriting the functionality yet again, this time in Perl,
along with all the details and nuances of the C version employed by
Git builtins, I decided that it made more sense to expose the
well-tested and polished C implementation as plumbing, thus allowing
any script or porcelain to take advantage of it.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/229533/
[2]: http://article.gmane.org/gmane.comp.version-control.git/224782/
[3]: http://article.gmane.org/gmane.comp.version-control.git/224783/

Eric Sunshine (4):
  builtin: add git-check-mailmap command
  t4203: test check-mailmap command invocation
  t4203: test mailmap functionality directly rather than indirectly
  t4203: consolidate test-repository setup

 .gitignore                             |   1 +
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/check-mailmap.c                |  73 ++++++++++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git.c                                  |   1 +
 t/t4203-mailmap.sh                     | 246 +++++++++++++++++----------------
 8 files changed, 209 insertions(+), 116 deletions(-)
 create mode 100644 builtin/check-mailmap.c

-- 
1.8.3.2
