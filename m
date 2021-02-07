Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC1C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BC864E4E
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBGOnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 09:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBGOmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 09:42:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F0C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 06:42:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q131so8026897pfq.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rXo97p5MWfXoSqV91rTdZ9awsa+am/mazzqf7yg3+Dg=;
        b=umgmrgPF5E8wE4fOpcjvLlgwp7ejaSMs2lYZ+e7N4d+uq+YRDiGRj6jzHLMbhBIhQl
         POYfNorREKTR0gSlwC0Iw+yL0YZ1g079XJzg5DRFbGM1razYY8lEA4zzqE1Lyw0ZFUcd
         Zg0EfRvh7a7uKD0mHGuwy8fJJBLodzzt1Dnvqx4FhshsiBFnWGjtjQ2yxR4F4jVsBnGI
         G3LiDa4FGnfXllKChknPaXJCMpbrDIwejvdVHvY+EHHLK75q1OfSF0eaq0xTVlFgJBNx
         7JCzlR1820GI+q2I5YaXy5Ddp8DFG5H0uaQ7KIaN0RI/yAx94VOvSE0CQmsw3TM5Txec
         jypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rXo97p5MWfXoSqV91rTdZ9awsa+am/mazzqf7yg3+Dg=;
        b=gzRS3dZK4/8IVzfiP/qhRHh6z9H6RkqMfDyAebj4kv3EqHOFIJ8Ox1jWsfw1PxKQkZ
         QAkUEPifeLdrr1HNikNblTBvE+QTRjgW0xToIzXO42u+KKEqxvCOBfN71OHoj0A+pXEB
         xBqshwLE4qE/PX21GmBinMI3VOLmkpnbEa79p/wRX7u7xW7WELX5V4KNbTWBBsG/U4IY
         dH0f2jgTh+sn2QyoExeg0sDeQVKA2WY4xHn4zXi3SCy5PlQuE3cFlD9EKAYVnmUc55bh
         H9fHGYYbphnoKCwJ+0+cDleKxpXNwEJjqRqSmANh0ufPt62s5uIsjbbSRpzODmpEIcuE
         LuFA==
X-Gm-Message-State: AOAM530LuhG/DEh5vm8zRgcs5z7T+OU8fs4KcBN1Ob9u9HBEm0o9Haae
        AIU5K6XmjfjZ7yjKK5PsaVWhPsOEdGg=
X-Google-Smtp-Source: ABdhPJwQRC85Qfrc8UJqLFuXjupvUNJKQPvN/sxqeiQH4FE7ER11mgjF3QdAAEXg1/ktWnGf3LjWPw==
X-Received: by 2002:aa7:94b5:0:b029:1d7:f868:e48d with SMTP id a21-20020aa794b50000b02901d7f868e48dmr12100295pfl.9.1612708937165;
        Sun, 07 Feb 2021 06:42:17 -0800 (PST)
Received: from konoha ([182.64.196.99])
        by smtp.gmail.com with ESMTPSA id c188sm439798pfa.98.2021.02.07.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:42:16 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:11:44 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com
Subject: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules 
Message-ID: <20210207144144.GA42182@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I was lurking around 'gitgitgadget/git' when I saw this potential BUG
added by Phillipe Blaine (reported by Javier Mora):
https://github.com/gitgitgadget/git/issues/750

Link to the original mail by Javier:
https://lore.kernel.org/git/ea91c2ea29064079914f6a522db5115a@UUSALE0Z.utcmail.com/

In brief, 'git rm' does not stage the changed '.gitmodules' file when we
use the '--cached' option. Technically speaking, Git used to behave this
way only and hence this is not an unknown case. The test 45 of
't3600-rm.sh' already is prepared for this scenario and checks for
exactly the scenario as Javier describes.

So, my question is, do we need to fix this to make sure that the changed
'.gitmodules' is staged? I feel that we should because: since the SM
becomes irrelevant after executing 'git rm --cached', it's entry in
'.gitmodules' is a plain burden and is of no practical use.

The fault is in this section of 'builtin/rm.c':
https://github.com/git/git/blob/v2.30.0/builtin/rm.c#L378-L402

This part:

	const char *path = list.entry[i].name;
	if (list.entry[i].is_submodule) {
		strbuf_reset(&buf);
		strbuf_addstr(&buf, path);
		if (remove_dir_recursively(&buf, 0))
			die(_("could not remove '%s'"), path);

		removed = 1;
		if (!remove_path_from_gitmodules(path))
			gitmodules_modified = 1;
		continue;
	}

Needs to be executed irrespective of whether '--cached' is passed to the
command or not. In particular, the following if-statement is of utmost
importance:

	if (!remove_path_from_gitmodules(path))
		gitmodules_modified = 1;

Since the variable 'gitmodules_modified' is 0 when we pass 'cached', it
is not staged later here:

	if (gitmodules_modified)
		stage_updated_gitmodules(&the_index);

And its entry is not removed from the file. What should be done about
this? I would appreciate your opinions.

Regards,
Shourya Shukla

