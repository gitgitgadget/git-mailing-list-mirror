Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B0C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3220825
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtcV8Tyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHWUD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWUDY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 16:03:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFDC061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 13:03:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so3203284plp.4
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hb0OdOHD5he+Zwa5R/cuOyTwjcnWD/oekOZjTwJlf9o=;
        b=XtcV8TyilWXWB0QvfILfowQTJ+6YZ3AOQBfWwXQ93hJ0Y7KH3SoZwv0h/UYxp79LD3
         nebnnQ5l8xbLnewSIxzHrXvXoEYIaLlWciGk6So4M3c67+ZxEBYjhYGsefwxa8+Mj3jb
         g3nt4hIGm6gji0SE1DF86tg8tN8fOVHXWdQqA/oWBstvErR+Oc1qWF5ryXbQ3Dwkz51n
         dvyJV5OaxxRX5r2VRw4C5lXKKttfNUT9hjMf2vA90BHJyIlJNbkS4g4pVniJ6yqw2D+2
         F5UR9S0yD943wFpAyHotc68e336KoR6F7WzGKvSjMohLzfmfV60rWbErTYeQRXI3eIg9
         zyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Hb0OdOHD5he+Zwa5R/cuOyTwjcnWD/oekOZjTwJlf9o=;
        b=i3m2ejU7hfRDggNWeaCywKq1VIX9Nt4lWi4kU8jUH93ZVhCJRnvA8iYfnWGuiN3oIx
         7Eg0y6nKCMT/50jXLUdJzTMJnZ4EeDF/4WdxLt9TU785Rdh4/h6+GphGnXX8iCAaWmSl
         L4fxdTkrlxWFlhsvSqU6DHZoKc/ij570JCGknxEqGiZ1WyNN31Q5ufDG4Pe0aWBU9e3g
         Tj59MDImA+94F79LHWVe64HK7TYpaHrYu/kqdxtyu4iHrtzR+k0Q9goiaiTLYoKgdBKJ
         e3tcxqJgNaSIEX7H88POGEW1D9ox/wsNln8UuSIEXLl0LVffoVZGHQ/M1y7gDYM/IL5G
         XTag==
X-Gm-Message-State: AOAM531rPgQyIPQFWI7KPUwQsaqejskCnr8gADKLztt7mBOirtr3cLt0
        VHHRqelFOOWOjtcAtPvDZPo=
X-Google-Smtp-Source: ABdhPJwk8inzWWJSWSsfCbsupxgpoU9I2M7cvglM6/LQDsc/o7pCtP3PQNmfc4ZTaU1WjDuvjwEECg==
X-Received: by 2002:a17:90a:fb4a:: with SMTP id iq10mr1932956pjb.90.1598213003625;
        Sun, 23 Aug 2020 13:03:23 -0700 (PDT)
Received: from lwitch-pc ([49.207.137.20])
        by smtp.gmail.com with ESMTPSA id p11sm8023087pgh.80.2020.08.23.13.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 13:03:23 -0700 (PDT)
Message-ID: <5b6ed82f3ab58a194bf51c0e2905214f64246ad8.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Date:   Mon, 24 Aug 2020 01:33:17 +0530
In-Reply-To: <xmqqa6yn93ll.fsf@gitster.c.googlers.com>
References: <20200821171705.GA16484@konoha>
         <xmqq5z9ban27.fsf@gitster.c.googlers.com>
         <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
         <xmqqa6yn93ll.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-08-21 at 12:54 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > Here's the error message with context of the trash directory of that
> > test:
> > 
> > -- 8< --
> > $ cd t
> > $ ./t7421-submodule-summary-add.sh  -d
> > $ cd trash\ directory.t7421-submodule-summary-add/
> > 
> > $ git submodule summary HEAD^^
> > fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
> > * my-subm 35b40f1...0000000:
> > 
> > * subm 0000000...dbd5fc8 (2):
> >   > add file2
> > 
> > -- >8 --
> > 
> > That 'fatal' is a consequence of spawning a process in
> > `verify_submodule_committish` of `builtin/submodule--helper.c` even for
> > non-existent submodules.
> 
> Oh, so doing something that would cause the error message to be
> emitted itself is a bug.
> 

Exactly.

> > I don't think that 'fatal: ' message is giving
> > any useful information here. The fact that submodule 'my-subm' doesn't
> > exist can easily be inferred just by looking at the destination mode
> > (0000000). If anything that 'fatal' message is just confusing and
> > unnecessary, IMO.
> 
> Yes, I 100% agree.
> 
> > So, we could easily suppress it by doing something like this (while
> > also fixing the test):
> 
> Yup.  That is a very good idea.  
> 
> Or the caller of verify_submodule_committish() should refrain from
> calling it for the path?  After all, it is checking sm_path is a
> path to where a submodule should be before calling the function
> (instead of calling it for every random path), iow its criteria to
> make the call currently may be "the path in the index says it is a
> submodule", but it should easily be updated to "the path in the
> index says it is a submodule, and the submodule actually is
> populated", right?
> 

Ah, this reminds me of the initial version of the patch which did
exactly that. Quoting it here for reference:

+	strbuf_addstr(&sm_git_dir_sb, p->sm_path);
+	if (is_nonbare_repository_dir(&sm_git_dir_sb))
+		is_sm_git_dir = 1;
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
+		missing_src = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_src));
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
+		missing_dst = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_dst));
+

Note: `verify_submodule_object_name` is now renamed to
`verify_submodule_committish`.

That does sound like a sane approach to me. There's not much point in
invoking `rev-parse` in a non-populated (a.k.a. de-initialized) or non-
existent submodule but we removed that check as we thought it was
unnecessary redundant because `capture_command` would fail anyway.
Looks like we failed to notice the additional `fatal` message fallout
then.

Also, I think it would be better to something like the following in
t7421 to ensure that `fatal` doesn't sneak up accidentally in the
future:

-- 8< --
diff --git t/t7421-submodule-summary-add.sh t/t7421-submodule-summary-add.sh
index 59a9b00467..b070f13714 100755
--- t/t7421-submodule-summary-add.sh
+++ t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
        git commit -m "change submodule path" &&
        rev=$(git -C sm rev-parse --short HEAD^) &&
        git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-       grep "fatal:.*my-subm" err &&
+       test_must_be_empty err &&
        cat >expected <<-EOF &&
        * my-subm ${rev}...0000000:
 
-- >8 --

-- 
Sivaraam


