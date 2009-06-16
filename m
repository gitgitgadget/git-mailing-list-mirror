From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 0/5] Teach shell scripts to be quiet
Date: Tue, 16 Jun 2009 15:32:56 -0700
Message-ID: <1245191581-11127-1-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhEM-0001yF-KB
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768AbZFPWdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759772AbZFPWdE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:28763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758681AbZFPWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so969312wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=4W01QKyoDHR1Td1zqbmy30WqRE4ndf+FuWrCN45NpVk=;
        b=HNZKYuxFVxi85/sI0CIglgEjd2xVlMmCGROXyo/r2S1IlZPtTKxWmPkkhsxBpZpIaL
         DJ05DT/AakUDY+c8NODeSC7XoKJNZdrKHzHnaQDuVsrjsvfupzwZG8Jov3Gk5Z9O/5Eq
         M+LmjRRd/qPpdhNGcgDyOneV1zkwjiNC/vrBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X3goVWs+sShWWS5tElubLEQNxWSqmfa2elHlLRWyfOb6XT4SlS1Mv4pbPvw8fwKSvh
         Tig1Qtpz1obvpmXPnHV5XQLeikguq6/lNtMH8++TGHTJ871+AihHqZC/4Qp0f6ke6iC3
         JsJ0cp5tAbMsRanYtvHo+BsPJEl+T/EplSHQA=
Received: by 10.114.52.16 with SMTP id z16mr14317574waz.220.1245191584165;
        Tue, 16 Jun 2009 15:33:04 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id n6sm1791498wag.4.2009.06.16.15.33.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:03 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:01 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121718>

The main goal of this series is to teach git-am and git-rebase to be
quiet.

This series feels very improved. I'm pretty confident in the first
three patches. I've split off the suppressing errors from git-apply
in git-am into its own patch this time around. It felt more like
an independent change.

I've tried to make sure I maintained GIT_QUIET after failing to apply,
but I'd appreciate if others could look over that to make sure.

Changes since v3:
    - simplify say()
    - say "applying to an empty history" in am.sh
    - quiet merge in rebase.sh::call_merge()
    - drop >&2 in a couple places in rebase.sh
    - maintain GIT_QUIET when git-am or git-rebase fails
    - fixup style issues with repack.sh
    - add to git_am_opt instead of hijacking GIT_QUIET in rebase.sh

Changes since v2:
    - say uses printf instead of echo
    - suppressing errors from git-apply under am -3 -q
    - added a test for am -3 -q
    - added a test for am where subjects have a literal newline
    - am,rebase tests check both stdout and stderr
    - rebase.sh::continue_merge() suppress the output of git rev-list

Changes since v1:
    - introduction of say()
    - migration of submodule and repack

Stephen Boyd (5):
  t4150: test applying with a newline in subject
  am: suppress apply errors when using 3-way
  git-sh-setup: introduce say() for quiet options
  submodule, repack: migrate to git-sh-setup's say()
  am, rebase: teach quiet option

 Documentation/git-am.txt     |    6 ++++-
 Documentation/git-rebase.txt |    4 +++
 git-am.sh                    |   35 +++++++++++++++++++++++-------
 git-rebase.sh                |   48 +++++++++++++++++++++++++++++++++--------
 git-repack.sh                |   12 ++++------
 git-sh-setup.sh              |    9 +++++++
 git-submodule.sh             |   24 +++++---------------
 t/t3400-rebase.sh            |   19 +++++++++++-----
 t/t4150-am.sh                |   26 ++++++++++++++++++++++
 9 files changed, 133 insertions(+), 50 deletions(-)
