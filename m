Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23462036D
	for <e@80x24.org>; Tue, 21 Nov 2017 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdKUOTM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 09:19:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38109 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUOTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 09:19:11 -0500
Received: by mail-pg0-f67.google.com with SMTP id s11so10263014pgc.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sn4lkrM0o92W72Z1oqouEl8GW0xYW45pbM4M3S/H7/4=;
        b=PT+sKRNhVFEyJb/nuGO01UgcmYA/tSuLxNfRalJFn4qS4ONbJIHWiyBvhYwKfZ/ooM
         sH6zPLaztQX9/ZIoME4SRgKlKSiekZaTJokUiMeHgUvNeE+OGTk6HIw+7eLM2UQTyE9e
         e+UfOaCEwT5k1v7KS0A0IwQnYJ3qQEDV2sQobg0z22/dKvheFa82fv8KyCp4snBBjFDa
         ao0lI1z+iCXtqhjdP6nkX+XenLdTW3kf2XLcdUev5t/+If8i8+a91Ue1Iu/Y/UFeBExh
         iZXuOePJV7E9a4GxCwTWmdElGdjiXv6v3T8fOSREQ17L/cUPcNDrJxlG/DhbSzHOsV8I
         i0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sn4lkrM0o92W72Z1oqouEl8GW0xYW45pbM4M3S/H7/4=;
        b=I6YYBXvZH3DPHwo98bRd+mRNm56PYQovLZg7ngdEtrE2Nsld6isWxObaCkDA17MEF0
         TZFlVOAq+aW8/dJeHa30d1wej8qRdmZSsjgNVsvz1eMDWsf9fJ2qADGT9lUgZ6r4cA8w
         ndMPRp2Reep7yXPBQpppBEG/DPBtrrEXH2p67TllBGD6kJena8x4J0G3+Noovt8STudg
         NvmTubGAOyF3HGSVIrHR4ACD1Xrm7rXnE2Dk3axHAPgAFVpiCrYWf309FWiv9yKoiBhP
         EihwzeoF0yMdmf0voh5WDVjYr2tHO2euyaMub24jwnSzrYqMGWP2kL8AzY9pyuYzB6Fe
         lovA==
X-Gm-Message-State: AJaThX5/dki2Nh/90pR/uIJf+hrMJfHBNh3oCykeXFlLW74Leb18Jm3u
        lCJ4EoES5O/mDgmQZqPvDe4=
X-Google-Smtp-Source: AGs4zMYbGvuqiDZQRpQewVGUNtdNBM6HkiPYFo0byXmh1jSKUuWS42eOJXKtch3oQM7u9WHV/OUAdg==
X-Received: by 10.98.205.5 with SMTP id o5mr15266301pfg.39.1511273951279;
        Tue, 21 Nov 2017 06:19:11 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7280:849f:7a33:ea78:e714:400])
        by smtp.gmail.com with ESMTPSA id f12sm21895418pga.7.2017.11.21.06.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 06:19:09 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using skip_prefix
Date:   Tue, 21 Nov 2017 19:48:52 +0530
Message-Id: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the offset strlen("refs/heads/") to skip
the prefix "refs/heads/" use the skip_prefix() function which
is more communicative and verifies that the string actually
starts with that prefix.

Though we don't check for the result of verification here as
it's (almost) always the case that the string does start
with "refs/heads", it's just better to avoid hard-coding and
be more communicative.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---

Eric Sunshine <sunshine@sunshineco.com> writes:
> Perhaps call them 'oldref_bare' and 'newref_bare' or something.

Nice suggestion but I opted for the more communicative (atleast to
me) 'interpreted_*name'. Let me know if they have any issues.

>  It's probably not worth a re-roll,
> though...

It's definitely not worth a re-roll of the series but deserves a re-roll
of this patch. (I fixed a comment in this re-roll, thanks!)

Thanks,
Kaartic

 builtin/branch.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca9d8abd0..d3751ca70 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	const char *interpreted_oldname = NULL;
+	const char *interpreted_newname = NULL;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -493,13 +495,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
+	/* At this point it should be safe to believe that the refs have the
+	   prefix "refs/heads/" */
+	skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname);
+	skip_prefix(newref.buf, "refs/heads/", &interpreted_newname);
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
 	else
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
-
 	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
@@ -508,10 +514,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (recovery) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
-				oldref.buf + 11);
+				interpreted_oldname);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-				oldref.buf + 11);
+				interpreted_oldname);
 	}
 
 	if (!copy &&
@@ -520,9 +526,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_release(&oldref);
-	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-- 
2.15.0.345.gf926f18f3

