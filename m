Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECEC35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E8F20726
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 11:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoErP2An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBILN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 06:13:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52905 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBILN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 06:13:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so2913772pjb.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElqYs9Ms2NMkg39LUoaEFSGQnKbEghmM5C5Oza9xeLA=;
        b=UoErP2AnvcblUXnUB8FfMgljJ92vkb0Lu1aIZdsQk5fG+yTYcMprZK7mIlVIRJ5QxK
         acVCAXUS+aLKFO3q5LCpjm45ARrE4puF20YB68Bvdl0+2PL34JqoWphdtXBSiKL7oX2E
         38GagWvUgLKB2R+h6nNBF/YVw/NaMYSpjHpOfng22Iq+xoFnAaT1Wiuz1CNOmjooWUl5
         LlAgfdfy32qFGOBdZba0ILJwah5spSMrDMCwALTGqUA4jRtoaUg1EtNPtckTWQlUTeAw
         Uh5xDApChZpnE3kLeZUHuIAAv8DbIZ5z4imHf2ndI96lnETumynRjXoGOZqBpQvZXo8O
         KZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElqYs9Ms2NMkg39LUoaEFSGQnKbEghmM5C5Oza9xeLA=;
        b=Q3G9sfJtz/cnhvfjlbeje7pIjlbV4n9bhlhbOQi90TIufMBaYg0CAb4CslCBAWhPYT
         /W9w/q7MPY5Mle9RwXjgBYqSL3dX+4yAxy09BlqPZxRKHfwdzyXDs8D/k+cSnboLWrDg
         jNwcbgIMo0nyp7lGQWjBs+xq9KK5YEsTFvYJe78jaJnuNu1AaGpLq1/69BTWtnikKegR
         e5XAmkvJllLmOv2XP3LnacYcBo07ajzO2qYCUtMzBUcMmaZQt1Hr2DzaAZrkqHI7pzhw
         g3f6a8M6yL22/Uv2z8D6oJjEZwJibs9JtDyUF58l10BZE3BntfN9W9ditx54XImSL/iW
         ijgg==
X-Gm-Message-State: APjAAAWtuLnOayUvWhWxO80QG9rjkSvIaSTeNaTuUNF0S87omR03Nk8f
        KfsKu2+9NwvZ6fN8cF2rEa7v530iOFGvfA==
X-Google-Smtp-Source: APXvYqzCO3Q+qpH5e98ronDgpSL2o2LmT1Nr1GI9QAi3s4HJ2dOGywy37183YhogMoGhm/nTFwDIBA==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr8150141plo.36.1581246835011;
        Sun, 09 Feb 2020 03:13:55 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id v8sm8391412pff.151.2020.02.09.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 03:13:54 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com
Subject: Conversion of 'git submodule' to C: need some help
Date:   Sun,  9 Feb 2020 16:43:49 +0530
Message-Id: <20200209111349.20472-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I was trying to understand the code of 'git submodule'[1]. This is
also in reference to this conversation I had before[2].

I read the code and stumbled across a function with a 'TODO' tag[3].
Here we want to change the aforementioned function into a 'repo_submodule_init'
function I suppose.

I am facing some problems and would love some insight on them:
	
	1. What exactly are we aiming in [3]? To replace the function completely
	   or to just add some 'repo_submodule_init' functionality?

	2. Something I inferred was that functions with names of the pattern 'strbuf_git_*'
	   are trying to 'create a path'(are they physically creating the path or just
	   instructing git about them?) while functions of the pattern 'git_*' are trying
	   to check some conditions denoted by their function names(for instance
	   'git_config_rename_section_in_file')? Is this inference correct to some extent?

	3. How does one check which all parts of a command have been completed? Is it checked
	   by looking at the file history or by comparing with the shell script of the command
	   or are there any other means?
	
	4. Is it fine if I am not able to understand the purpose of certain functions right now(such as
	   'add_submodule_odb')? I am able to get a rough idea of what the functions are doing but I am
	   not able to decode certain functions line-by-line.

Currently, I am studying in depth about 'git objects' and the submodule command on the git Documentation.
What else do would you advise me to strengthen my understanding of the code and git in general?

Regards,
Shourya Shukla

[1]: https://github.com/periperidip/git/blob/v2.25.0/submodule.c
[2]: https://lore.kernel.org/git/20200201173841.13760-1-shouryashukla.oo@gmail.com/
[3]: https://github.com/periperidip/git/blob/v2.25.0/submodule.c#L168

