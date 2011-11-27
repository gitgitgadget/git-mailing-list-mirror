From: David Ripton <dripton@ripton.net>
Subject: [PATCH] diff and apply: fix singular/plural grammar nit.
Date: Sun, 27 Nov 2011 08:44:21 -0500
Message-ID: <4ED23EB5.1030208@ripton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 27 14:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUf2f-0008GH-2o
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 14:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1K0NpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 08:45:06 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:42339 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1K0NpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 08:45:05 -0500
Received: from homiemail-a48.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 429521784B0
	for <git@vger.kernel.org>; Sun, 27 Nov 2011 05:45:04 -0800 (PST)
Received: from homiemail-a48.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTP id 7242B4F8058;
	Sun, 27 Nov 2011 05:44:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:subject:content-type:
	content-transfer-encoding; q=dns; s=ripton.net; b=gWNU1ItTjFMBzm
	qtdEBf5SOaNr/O959RYNDbTF4HnRY2FN7oDX06svakgEGPGqRhwdm9Rv8YeY4JIj
	Eu9WZ7PnoF1RhGCu7wW1F8k0XDx3hdaLKaAx6AXl4Ov4E093ojHU2SlKSCJ2aoKr
	JrzFIwwHJuY6bDXfEaeTAe7JuVNko=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:subject:content-type:
	content-transfer-encoding; s=ripton.net; bh=5rnV41+3hoR8QA0uEPAo
	7cQr7Os=; b=uQTuKn2UglrAuMG2BQff2En8QCi7MjKWJD6lkGuiFjpugpmG6Uui
	PxorsK9NOR7hPL5XJRtUpanLyJKo85FPMldbOVtgAbWzzFzGvgxoKqqBfaQdGumV
	LbZHuuCQ6aKTY2cEdiCvVmRjGsT75Xuco77hVeYmY5e0rxbALiVwlgA=
Received: from [192.168.2.175] (pool-72-86-45-238.clppva.fios.verizon.net [72.86.45.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTPSA id 1B92C4F8057;
	Sun, 27 Nov 2011 05:44:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111118 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185985>

Remove the trailing 's' from "files", "insertions", and "deletions"
when there is only one of the item.

Signed-off-by: David Ripton <dripton@ripton.net>
---
  builtin/apply.c |    5 ++++-
  diff.c          |   13 +++++++++----
  2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..47bbc23 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3244,7 +3244,10 @@ static void stat_patch_list(struct patch *patch)
                 show_stats(patch);
         }

-       printf(" %d files changed, %d insertions(+), %d deletions(-)\n", 
files, adds, dels);
+       printf(" %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
+              files, (files == 1 ? "" : "s"),
+              adds, (adds == 1 ? "" : "s"),
+              dels, (dels == 1 ? "" : "s"));
  }

  static void numstat_patch_list(struct patch *patch)
diff --git a/diff.c b/diff.c
index 374ecf3..531dcb1 100644
--- a/diff.c
+++ b/diff.c
@@ -1467,8 +1467,10 @@ static void show_stats(struct diffstat_t *data, 
struct diff_options *options)
         }
         fprintf(options->file, "%s", line_prefix);
         fprintf(options->file,
-              " %d files changed, %d insertions(+), %d deletions(-)\n",
-              total_files, adds, dels);
+              " %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
+              total_files, (total_files == 1 ? "" : "s"),
+              adds, (adds == 1 ? "" : "s"),
+              dels, (dels == 1 ? "" : "s"));
  }

  static void show_shortstats(struct diffstat_t *data, struct 
diff_options *options)
@@ -1498,8 +1500,11 @@ static void show_shortstats(struct diffstat_t 
*data, struct diff_options *option
                                 options->output_prefix_data);
                 fprintf(options->file, "%s", msg->buf);
         }
-       fprintf(options->file, " %d files changed, %d insertions(+), %d 
deletions(-)\n",
-              total_files, adds, dels);
+       fprintf(options->file,
+               " %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
+               total_files, (total_files == 1 ? "" : "s"),
+               adds, (adds == 1 ? "" : "s"),
+               dels, (dels == 1 ? "" : "s"));
  }

  static void show_numstat(struct diffstat_t *data, struct diff_options 
*options)
-- 
1.7.8.rc3

-- 
David Ripton    dripton@ripton.net
