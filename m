From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH] builtin/log.c: fixup format-patch --base segfault
Date: Sat, 9 Apr 2016 14:41:03 +0800
Message-ID: <20160409064103.GA15167@yexl-desktop>
References: <57006FB9.4080904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 08:42:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aomao-0000Tn-8w
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 08:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcDIGl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 02:41:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:7541 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbcDIGlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 02:41:55 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 08 Apr 2016 23:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,454,1455004800"; 
   d="scan'208";a="81994737"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2016 23:41:53 -0700
Mail-Followup-To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57006FB9.4080904@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291085>

On Sun, Apr 03, 2016 at 02:19:53AM +0100, Ramsay Jones wrote:
>
>Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>---
>
>Hi Xiaolong,
>
>When you next re-roll your 'xy/format-patch-base' branch could you
>please squash this (or something like it) into the relevant patch.
>(commit 50ff6afd, "format-patch: add '--base' option to record base
>tree info", 31-03-2016).
>
>The pu branch, for me, fails a shed load of tests in the following:
>
>    t3301-notes.sh
>    t3901-i18n-patch.sh
>    t4014-format-patch.sh
>    t4021-format-patch-numbered.sh
>    t4028-format-patch-mime-headers.sh
>    t4030-diff-textconv.sh
>    t4036-format-patch-signer-mime.sh
>    t4052-stat-output.sh
>    t4122-apply-symlink-inside.sh
>    t4150-am.sh
>    t4151-am-abort.sh
>    t4152-am-subjects.sh
>    t4255-am-submodule.sh
>    t7400-submodule-basic.sh
>    t7512-status-help.sh
>    t9001-send-email.sh
>
>Looking at the first failure, the cause was a segfault while running
>git-format-patch. A quick trip to the debugger showed that the segfault
>was in print_bases(). Furthermore, the contents of the bases structure
>passed in looked very dodgy (bases->nr_patch_id was 32767 and bases->patch_id[0]
>was 0xc). Indeed, it looked like it had not been initialized ...
>
>[NOTE: t6038-merge-text-auto.sh also fails for me, but it has nothing
>to do with your patch series. ;-)]
>
>This patch was just a quick fix, you may chose a different approach to
>fix the problem (eg don't call print_bases() unconditionally ...).

Thanks for the report, I will squash this to avoid segfault.

Best Regards,
Xiaolong.
>
>ATB,
>Ramsay Jones
>
> builtin/log.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/builtin/log.c b/builtin/log.c
>index 48c74f5..fed0f99 100644
>--- a/builtin/log.c
>+++ b/builtin/log.c
>@@ -1625,8 +1625,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> 		signature = strbuf_detach(&buf, NULL);
> 	}
> 
>+	memset(&bases, 0, sizeof(bases));
> 	if (base_commit || config_base_commit) {
>-		memset(&bases, 0, sizeof(bases));
> 		reset_revision_walk();
> 		prepare_bases(&bases, base_commit, list, nr);
> 	}
>-- 
>2.8.0
