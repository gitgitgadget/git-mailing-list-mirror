Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A8C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbjDZPOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjDZPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:13:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25D49EE
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:13:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b4960b015so5780736b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682522037; x=1685114037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb5eV3WO33v3pELe7ZHrUlNygahJSzg7hBkFHUa5dfY=;
        b=sx3oZfvBMycrPoiZS2EhFPntbCnv13h0YiIkSmjAgrd0kny91txeeHYTWL3MWz7x3s
         4TK5ow9w73Ii8glcb/aR8opQLRg1PMfBKdOQo45W+j0NWiiPMXZMy0a/D8RIRK+qFHwF
         VfvOb2Zzuq65IQNSvnoRmzPe5ofRNhwajj3Wp0OLPlljCCtJgIsHkw6lde1xidcxKRjL
         byaFen76v+0iLGJE2nGCsIere7AHhBKknYwgK5Xv7hCO14Cg4IQydApPCwwd12pDSV8v
         7dhOWiwN3cjUCqHgyEeDbB+F6w5VI2oG/jKbFM6WqtCQL84YpssbAoB4QgdvQVbGDW95
         GpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682522037; x=1685114037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eb5eV3WO33v3pELe7ZHrUlNygahJSzg7hBkFHUa5dfY=;
        b=QxYLH/Nevx1uu92EXHvtt6XQFpPhEIdcVhq4uy4h2PfoWdOp8xM8LNe1FNn65sYtuJ
         piqSFjKxvHJlWR8/ViK/G2ACOfWZnaWlMEWa5ZxtgFTuWojuTS4nVupzmc+b1p3smBs/
         4B4d463FngfUzdQUU2fMoEg/WyjIXzaxQlI+4KroLrQ83TvOWPcX/8kyA8mTWr8ZuLoV
         c7yaWnjFjn/kytZ0wcQM8FieC5RozhvrOlm3fW4fzO72Bwykqx1kfK0X8J1787MTupMM
         yvaUyXm0i2HkxgVIAPG2jF60l2eVCy+RLkeiE8tQbwRCl9XzU9R8E/785NPzR0xST+IZ
         tFuw==
X-Gm-Message-State: AAQBX9ciKc8kvw4weTUu9yIJV2y+pa0O9lcfUTaOPQH1tBwX7hcgN9Pt
        f+8CrIYMtaLOZzO2NnokdqbikFNNHq4=
X-Google-Smtp-Source: AKy350b74VNWYwxdZJI6AqxjVOPhOrGSrvqebuJav9W00BU6XK2H5zNDr83rHget236PJf4SE7zFFg==
X-Received: by 2002:a05:6a00:1348:b0:63d:5cb7:2dff with SMTP id k8-20020a056a00134800b0063d5cb72dffmr33023629pfu.33.1682522036544;
        Wed, 26 Apr 2023 08:13:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h9-20020a056a00218900b0063b89300347sm11799178pfi.142.2023.04.26.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:13:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>
Subject: [PATCH] doc: GIT_DEFAULT_HASH is and will be ignored during "clone"
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
        <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
        <xmqqcz3ry2sw.fsf@gitster.g>
        <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
        <20230426112508.GB130148@coredump.intra.peff.net>
        <xmqqcz3qwuj7.fsf@gitster.g>
Date:   Wed, 26 Apr 2023 08:13:55 -0700
In-Reply-To: <xmqqcz3qwuj7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        26 Apr 2023 08:08:28 -0700")
Message-ID: <xmqqzg6uvfpo.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The phrasing "is currently ignored" was prone to be misinterpreted
as if we were wishing if it were honored.  Rephrase it to make it
clear that the experimental variable will be ignored.

In the longer term, after/when we allow incremental/over-the-wire
migration of the object-format, i.e. cloning from an SHA-1
repository to create an SHA-256 repository (or vice versa) and
fetching and pushing between them would bidirectionally convert the
object format on the fly, it is likely that we would teach a new
option "--object-format" to "git clone" to say "you would use
whatever object format the origin uses by default, but this time, I
am telling you to use this format on our side, doing on-the-fly
object format conversion as needed".  So it is perfectly OK to
ignore the settings of this experimental variable, even after such
an extension happens that makes it necessary for us to have a way to
create a new repository that uses different object format from the
origin repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * An obvious follow-up to the previous discussion.

 Documentation/git.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index 74973d3cc4..54b043899f 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -546,9 +546,9 @@ double-quotes and respecting backslash escapes. E.g., the value
 
 `GIT_DEFAULT_HASH`::
 	If this variable is set, the default hash algorithm for new
-	repositories will be set to this value. This value is currently
-	ignored when cloning; the setting of the remote repository
-	is used instead. The default is "sha1". THIS VARIABLE IS
+	repositories will be set to this value. This value is
+	ignored when cloning and the setting of the remote repository
+	is always used. The default is "sha1". THIS VARIABLE IS
 	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
 
 Git Commits
