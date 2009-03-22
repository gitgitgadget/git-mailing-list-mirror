From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 0/3] format-patch --attach/--inline use filename instead of SHA1
Date: Sat, 21 Mar 2009 21:32:40 -0700
Message-ID: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 05:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlFO6-00045r-BI
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbZCVEct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbZCVEcs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:32:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:16810 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZCVEcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:32:48 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2242279wff.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=J1Fz3u4gm7/RZppBEYfzOOy/cNKTUpyLFbjEGXtjq6Q=;
        b=Cz2nOoJPKlBlU3GBw8i3FTI6zRN6GSSQmHkqiNommX0dboofyXOAo0dXBA8/MICMsb
         4P+P+qtHTlT0wQIfB4yu2rkPhZeZqYu2ELJFkchv+HSW7AtL+oAzghU1QdeUtFkuKmPq
         lJggSCovYZflsnCtqY2cqp0g7KvkUVPOW+U5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P1iUejkp0SDatzGvsZA9+kFaXFU66AIruBWaglVnKxteNzqVs8ZAjIjb/3uHNBX07w
         JU08sFTPx7E/gSf4loisLW7iQx25Ep4fMu5oiT/mkVlIN+vhtS7jy3fVPkXtRFHEZJqY
         iA3rIAhMexaBXNmBthS1jqFXTJlP0QLaveYIw=
Received: by 10.142.44.11 with SMTP id r11mr2229022wfr.186.1237696366033;
        Sat, 21 Mar 2009 21:32:46 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 9sm8348516wfc.0.2009.03.21.21.32.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 21:32:45 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 21 Mar 2009 21:32:43 -0700
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114114>

I'm resending this series because it seems it wasn't picked up probably because
the patches were mangled by my mailer.

This patch series modifies the behavior of format-patch when used with the
--attach or --inline command line settings. Current behavior names the attached
or inlined patches with the SHA1 of the commit, which isn't very friendly or
easy for a human to use when downloading the attachments. This series replaces
the SHA1 values with the filename used by format-patch when it outputs the
patches to files.

Stephen Boyd (3):
  format-patch: create patch filename in one function
  format-patch: --attach/inline uses filename instead of SHA1
  format-patch: --numbered-files and --stdout aren't mutually exclusive

 Documentation/git-format-patch.txt                 |    1 -
 builtin-log.c                                      |   51 ++++++++--------
 log-tree.c                                         |    8 +-
 revision.h                                         |    1 +
 t/t4013-diff-various.sh                            |    1 +
 ..._--attach_--stdout_--suffix=.diff_initial..side |   61 ++++++++++++++++++++
 ....format-patch_--attach_--stdout_initial..master |   12 ++--
 ...format-patch_--attach_--stdout_initial..master^ |    8 +-
 ...ff.format-patch_--attach_--stdout_initial..side |    4 +-
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 ++--
 ....format-patch_--inline_--stdout_initial..master |   12 ++--
 ...format-patch_--inline_--stdout_initial..master^ |    8 +-
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    4 +-
 14 files changed, 124 insertions(+), 63 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
