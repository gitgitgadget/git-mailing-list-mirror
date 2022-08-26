Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18417C0502A
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHZVcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiHZVcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 17:32:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF89080A
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v4so2461030pgi.10
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc;
        bh=XacwkKk0dK8hGgYR0KtjQxOYY3PmGw7qCiiw8w48xb0=;
        b=OcceCbghR1FxOOoAJ5ubhcTw5vXOmQHWwQ2vpwjJ/OFyWK4wzMFhXh6CjiEJoivKYM
         gD0mBJFx5X/Tk5VO9YPo7O/STYpARxBSOpJuNkxxpeBbZY0X8iMUoWEAegfXQkRZI+ZG
         tU2o0qP8VzCpIcAIWOWo7pihsU+XFUAeqRg9xdzIi0FwMaAMFhaEreEGh8rEQAFx53G1
         J4an2tcOhdqX2zMMSJSX5IenbWz0mvc1eANLN0wFyGV/18GLKHz6PEjzrAtkml9NlZ4E
         GuiP13e+PW3esiHvDClZfTpuNl6wY8rkQKDkXqm3kLw1A014gmFg3hOtJJJGGk7mFbtD
         lYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc;
        bh=XacwkKk0dK8hGgYR0KtjQxOYY3PmGw7qCiiw8w48xb0=;
        b=kGLdSQ1UurVyzUjT43aKMTu51LWrQsMAEdFp6PkA4iKbhgjFh49xGWYT5hc3i5EO5G
         uRMQSEu5ZRKg7HbLGJxe9LoP+/02JgRJ9NNaWifttdaRidFHXIHuYqW0P56OjOVqGYxB
         9sHo9EPIxv6zOIl9rp9MM6eSD4ySJHa2LIK6ClEJKTdvasjZvwpj/tXiOowDgC3tWZ7z
         dSa3KSXlfEKwW6712gccavsZnkTwlLr55hFSezlwByrqazFX1e/W+lWc/9sONwwQfBWK
         oF0qTLieCJK2Zb8BaJzov5s36TzJ8jkyXE57OFDjICmAlyUjHTXmGeJhzC0DuP8UpDRG
         gCmQ==
X-Gm-Message-State: ACgBeo1Xg27WNFLvIigVscuSt2lD6FaAsddP4nECB/Iqvv6mDco2sSWK
        4cKSvRnausdpftuKAK8vqkazDdHbsCE=
X-Google-Smtp-Source: AA6agR5MFNayv1T0u8HtcLvhUs6v4WlFA6FnyJ97zKNEuOjCFeMlas10HBy1Zfyg8xMvqzmEwpqOUw==
X-Received: by 2002:a65:6385:0:b0:429:f03c:d5e with SMTP id h5-20020a656385000000b00429f03c0d5emr4766251pgv.322.1661549526235;
        Fri, 26 Aug 2022 14:32:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b0016d3935eff0sm36487plh.176.2022.08.26.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:32:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] format-patch: allow forcing the use of in-body From: header
Date:   Fri, 26 Aug 2022 14:32:03 -0700
Message-Id: <20220826213203.3258022-3-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-587-g47adba97a9
In-Reply-To: <20220826213203.3258022-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users may be authoring and committing their commits under the same
e-mail address they use to send their patches from, in which case
they shouldn't need to use the in-body From: line in their outgoing
e-mails.  At the receiving end, "git am" will use the address on the
"From:" header of the incoming e-mail and all should be well.

Some mailing lists, however, mangle the From: address from what the
original sender had; in such an unfortunate situation, the user may
want to add the in-body "From:" header even for their own patch.

"git format-patch --[no-]force-inbody-from" was invented for such
users.

Note.  This is an uncooked early draft.  Things to think about
include (but not limited to, of course):

 * Should this rather be --use-inbody-from=yes,no,auto tristate,
   that defaults to "auto", which is the current behaviour i.e.
   "when --from is given, add it only when it does not match the
   payload".  "yes" would mean "always emit the --from address as
   in-body From:" and "no" would mean ... what?  "Ignore --from"?
   Then why is the user giving --from in the first place?

 * Should it be "inbody" or "in-body"?

 * Should it have a corresponding configuration variable?

 * Should this patch be scrapped and the feature should be done
   inside "git send-email" instead?

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           |  2 ++
 pretty.c                |  2 ++
 revision.h              |  1 +
 t/t4014-format-patch.sh | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 9b937d59b8..83b2d01b49 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1897,6 +1897,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			   N_("show changes against <refspec> in cover letter or single patch")),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
+		OPT_BOOL(0, "force-inbody-from", &rev.force_inbody_from,
+			 N_("Use in-body From: even for your own commit")),
 		OPT_END()
 	};
 
diff --git a/pretty.c b/pretty.c
index 51e3fa5736..e266208c0b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -483,6 +483,8 @@ static int use_inbody_from(const struct pretty_print_context *pp, const struct i
 		return 0;
 	if (ident_cmp(pp->from_ident, ident))
 		return 1;
+	if (pp->rev && pp->rev->force_inbody_from)
+		return 1;
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index bb91e7ed91..a2d3813a21 100644
--- a/revision.h
+++ b/revision.h
@@ -208,6 +208,7 @@ struct rev_info {
 
 	/* Format info */
 	int		show_notes;
+	unsigned int	force_inbody_from;
 	unsigned int	shown_one:1,
 			shown_dashes:1,
 			show_merge:1,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index fbec8ad2ef..a4ecd433e2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1400,6 +1400,19 @@ test_expect_success '--from omits redundant in-body header' '
 	test_cmp expect patch.head
 '
 
+test_expect_success 'with --force-inbody-from, --from keeps redundant in-body header' '
+	git format-patch --force-inbody-from \
+		-1 --stdout --from="A U Thor <author@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success 'in-body headers trigger content encoding' '
 	test_env GIT_AUTHOR_NAME="éxötìc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
-- 
2.37.2-587-g47adba97a9

