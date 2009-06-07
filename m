From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] show-branch: don't use LASTARG_DEFAULT with OPTARG
Date: Sun,  7 Jun 2009 16:39:15 -0700
Message-ID: <1244417955-21226-1-git-send-email-bebarino@gmail.com>
References: <4A2ACE32.8080504@gmail.com>
Cc: git list <git@vger.kernel.org>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@madism.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 01:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDRxZ-0002TL-UX
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 01:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbZFGXjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZFGXjU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 19:39:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:23483 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZFGXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 19:39:19 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1823958ywb.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 16:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=kOco384OBHIbpjBLZaCQZdGaB1VPi5M6nOUu/aN3G+A=;
        b=Hd8SntaDHT5bS4L6pi9EaYioacIUI3xuZCYo4t2ePAAC1mW2fyKoPeAsDjd+oBwWK1
         gdJu/9kTlKtstHW6Wy+h89Xk2FqXOQ7UmQSOCExeVK9j4/b8g1TUoC79S5oeiXi+ez2/
         VJndlhtU2wEOhLxlM9FwlrjWM4GrqcfvIoT88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cMrsbXSiqCNg6DfuSJfVhGIkPk1I2V4ICN4GVkqFpUC9vDTRpKZ/R0jrLvsmXR4e5G
         Be2EkmW4ZNCBoH1AztWMJDtXPAziWkhiQg6r09zipLzrjzqCKQtJMY8vWB0sMnoXHmQK
         A4ajh89QCUl4KQU5FIHDFPxmBsnwsnb47sc8k=
Received: by 10.90.105.17 with SMTP id d17mr5282717agc.68.1244417961156;
        Sun, 07 Jun 2009 16:39:21 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 39sm6514115agb.31.2009.06.07.16.39.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 16:39:20 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 07 Jun 2009 16:39:16 -0700
X-Mailer: git-send-email 1.6.3.2.202.g26c11
In-Reply-To: <4A2ACE32.8080504@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121022>

5734365 (show-branch: migrate to parse-options API 2009-05-21)
incorrectly set the --more option's flags to be
PARSE_OPT_LASTARG_DEFAULT and PARSE_OPT_OPTARG. These two flags
shouldn't be used together. An option taking a default should just set
the default value desired and parse options will take care of the rest.

Update the header comment to better convey this information.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-show-branch.c |    3 +--
 parse-options.h       |    7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 9433811..01bea3b 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -657,8 +657,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    "color '*!+-' corresponding to the branch"),
 		{ OPTION_INTEGER, 0, "more", &extra, "n",
 			    "show <n> more commits after the common ancestor",
-			    PARSE_OPT_OPTARG | PARSE_OPT_LASTARG_DEFAULT,
-			    NULL, (intptr_t)1 },
+			    PARSE_OPT_OPTARG, NULL, (intptr_t)1 },
 		OPT_SET_INT(0, "list", &extra, "synonym to more=-1", -1),
 		OPT_BOOLEAN(0, "no-name", &no_name, "suppress naming strings"),
 		OPT_BOOLEAN(0, "current", &with_current_branch,
diff --git a/parse-options.h b/parse-options.h
index b374ade..5653dba 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -71,8 +71,11 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
  *                     shown only in the full usage.
- *   PARSE_OPT_LASTARG_DEFAULT: if no argument is given, the default value
- *                              is used.
+ *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default
+ *				value if no argument is given when the option
+ *				is last on the command line. If the option is
+ *				not last it will require an argument.
+ *				Should not be used with PARSE_OPT_OPTARG.
  *   PARSE_OPT_NODASH: this option doesn't start with a dash.
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
-- 
1.6.3.2.202.g26c11
