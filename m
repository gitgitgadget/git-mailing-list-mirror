From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Don't do status in submodules if status.SubmoduleSummary 
	unset
Date: Thu, 20 May 2010 16:12:31 +0200
Message-ID: <AANLkTil1QHA3G2VaITdm7DkDmN1IhZ_u2SWLrelyxkF2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c925885784600487072a55
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 16:12:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF6UJ-0008BM-8l
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 16:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab0ETOMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 10:12:34 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:46062 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0ETOMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 10:12:33 -0400
Received: by ywh10 with SMTP id 10so5116357ywh.1
        for <git@vger.kernel.org>; Thu, 20 May 2010 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=1uptbCFcH564DKl5njBaZ3nkZK2/fmI0VwNVQT8MKm0=;
        b=BK+Zp6tI6P4uBGCicGkEwV8Jg3GPhV1SdO1hDS5onZpYo0Ij/p0j1GfsAuZB2b8TJE
         W5ZIlMEJ8xsvByOy3OYdbDzmWLS9HKl830GB193BLUpkB/iG2hKkI9z3BhMzcFTyouTq
         fiVsnbrLHoUws5ewUoXI9n6XNE4DB5ZuTp8Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=s4z2+jgLaZSE+RtznQfOiE42nIkxxsF4isoMRqgrJJbkKcPhxGGjJp7O6FbU/6nT2v
         vz7394AQI4s3/l/XHep7zMKTS1ebgXOpEp0TvrG1RPNYB+ndS0fyb7AMngtn1+Swz1Tj
         cUTohALxkrn0ruay7h2J3OfvZPqmBU0Xi4XaA=
Received: by 10.101.105.22 with SMTP id h22mr178345anm.35.1274364751741; Thu, 
	20 May 2010 07:12:31 -0700 (PDT)
Received: by 10.100.154.8 with HTTP; Thu, 20 May 2010 07:12:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147389>

--001636c925885784600487072a55
Content-Type: text/plain; charset=UTF-8

Noticed-by: Andy Parkins
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

--

On Thu, May 20, 2010 at 15:28, Junio C Hamano <gitster@pobox.com> wrote:
> As to the not-working-configuration I don't remember the codepath well, so
> sorry but no answer from me right now.

Maybe because we do a (kind of) gentle status run on submodules
whether the status.SubmoduleSummary set or not. Usually a background
run of "git status" for every submodules goes unnoticed, just
sometimes a submodule is a little too big.

I tried this, but feels like a bit of overkill.

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..d5bcdf9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -303,7 +303,10 @@ static void
wt_status_collect_changes_worktree(struct wt_status *s)
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	if (s->submodule_summary)
+		DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	else
+		DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;

--001636c925885784600487072a55
Content-Type: application/octet-stream; name="ignore-submodules.patch"
Content-Disposition: attachment; filename="ignore-submodules.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9fntmqn0

RnJvbSA2YjdhNWUwYWM1NjBlMTE4N2Q4ZmYzNTliYWQ4YzA0OTI3ZDBiNTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDIwIE1heSAyMDEwIDE2OjA0OjExICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRG9uJ3Qg
ZG8gc3RhdHVzIGluIHN1Ym1vZHVsZXMgaWYgc3RhdHVzLlN1Ym1vZHVsZVN1bW1hcnkgdW5zZXQK
Ck5vdGljZWQtYnk6IEFuZHkgUGFya2lucwpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFh
LmxrbWxAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3d0LXN0YXR1cy5jIGIvd3Qtc3RhdHVzLmMK
aW5kZXggOGNhNTlhMi4uZDViY2RmOSAxMDA2NDQKLS0tIGEvd3Qtc3RhdHVzLmMKKysrIGIvd3Qt
c3RhdHVzLmMKQEAgLTMwMyw3ICszMDMsMTAgQEAgc3RhdGljIHZvaWQgd3Rfc3RhdHVzX2NvbGxl
Y3RfY2hhbmdlc193b3JrdHJlZShzdHJ1Y3Qgd3Rfc3RhdHVzICpzKQogCWluaXRfcmV2aXNpb25z
KCZyZXYsIE5VTEwpOwogCXNldHVwX3JldmlzaW9ucygwLCBOVUxMLCAmcmV2LCBOVUxMKTsKIAly
ZXYuZGlmZm9wdC5vdXRwdXRfZm9ybWF0IHw9IERJRkZfRk9STUFUX0NBTExCQUNLOwotCURJRkZf
T1BUX1NFVCgmcmV2LmRpZmZvcHQsIERJUlRZX1NVQk1PRFVMRVMpOworCWlmIChzLT5zdWJtb2R1
bGVfc3VtbWFyeSkKKwkJRElGRl9PUFRfU0VUKCZyZXYuZGlmZm9wdCwgRElSVFlfU1VCTU9EVUxF
Uyk7CisJZWxzZQorCQlESUZGX09QVF9TRVQoJnJldi5kaWZmb3B0LCBJR05PUkVfU1VCTU9EVUxF
Uyk7CiAJaWYgKCFzLT5zaG93X3VudHJhY2tlZF9maWxlcykKIAkJRElGRl9PUFRfU0VUKCZyZXYu
ZGlmZm9wdCwgSUdOT1JFX1VOVFJBQ0tFRF9JTl9TVUJNT0RVTEVTKTsKIAlyZXYuZGlmZm9wdC5m
b3JtYXRfY2FsbGJhY2sgPSB3dF9zdGF0dXNfY29sbGVjdF9jaGFuZ2VkX2NiOwo=
--001636c925885784600487072a55--
