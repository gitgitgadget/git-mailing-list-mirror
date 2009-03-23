From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 0/6] format-patch --attach/--inline uses filename not SHA1
Date: Sun, 22 Mar 2009 19:14:00 -0700
Message-ID: <cover.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhu-0000lE-DB
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZCWCON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbZCWCOM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:23531 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZCWCOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:11 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1537512rvb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=+7bBgJ3PPQhwiPfx57DN/gchVkjWjkbJCNgSPh4MGGM=;
        b=bNwBI7xhshjpS7k07HOPhBO55Q+Qo1pTHcRv0V3yB+qvJzKxvfCJBzaEmRSjjzffSh
         mBfANF00aPHV3FSpAu7oHnWSdfDlq3frz5a0+v9t7f7KBp3tWawVEeIYhgi4l5cqE79c
         Xjace2OS+7LkOUkWDQefH3THCRsz2gFBZ7WSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wpA/Ru2laAojhVLa2RtEuFS/66gXWCg+f0wlVEBlK2M97Kyq0A0TWlY60dQFzjjdkw
         pa9XP7QhlbT23XjeOTdB1N/CeNBRdAaOFRQR0ra8bYSZsyrcZiqTA0CmOFtTEKlBzwFN
         tVWvciIVSj/6UkJXYsQv4DIgLYtZvZFm6djMo=
Received: by 10.114.148.2 with SMTP id v2mr4430166wad.169.1237774449373;
        Sun, 22 Mar 2009 19:14:09 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm4935831waf.7.2009.03.22.19.14.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:08 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:06 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114227>

This patch series modifies the behavior of format-patch when used with the
--attach or --inline command line settings. Current behavior names the attached
or inlined patches with the SHA1 of the commit, which isn't very friendly or
easy for a human to use when downloading the attachments. This series replaces
the SHA1 values with the filename used by format-patch when it outputs the
patches to files.

New features in this version: 
    - %f format specifier exposing sanitized filenames to porcelain
    - get_patch_filename() moved to log-tree

Stephen Boyd (6):
  pretty.c: add %f format specifier to format_commit_message()
  format-patch: construct patch filename in one function
  format-patch: pass a commit to reopen_stdout()
  format-patch: move get_patch_filename() into log-tree
  format-patch: --attach/inline uses filename instead of SHA1
  format-patch: --numbered-files and --stdout aren't mutually exclusive

 Documentation/pretty-formats.txt                   |    1 +
 builtin-log.c                                      |  132 +++++----------
 log-tree.c                                         |   41 ++++-
 log-tree.h                                         |    6 +-
 pretty.c                                           |   38 +++++
 revision.h                                         |    2 +
 t/t4013-diff-various.sh                            |    3 +-
 ..._--attach_--stdout_--suffix=.diff_initial..side |   61 +++++++
 ....format-patch_--attach_--stdout_initial..master |   12 +-
 ...format-patch_--attach_--stdout_initial..master^ |    8 +-
 ...ff.format-patch_--attach_--stdout_initial..side |    4 +-
 ...nline_--stdout_--numbered-files_initial..master |  170 ++++++++++++++++++++
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 +-
 ....format-patch_--inline_--stdout_initial..master |   12 +-
 ...format-patch_--inline_--stdout_initial..master^ |    8 +-
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    4 +-
 17 files changed, 389 insertions(+), 129 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
 create mode 100644 t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
