Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469BC0015E
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjHPAKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbjHPAJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 20:09:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AA1FFF
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 17:09:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso93453741fa.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692144580; x=1692749380;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iym3UL0opdYGlYgXkqZ44VRPwtvPEe+002M5treKdNU=;
        b=Pmwe2WRUNoJk79q1TdKA701PKw+M6hKbJNW2cZsM62AdVAqjG9P+gEX0B8LvgnG55V
         YEygvCIMPSKw+KU5HI+k7fjdOwpnz8Zi+MFklqME7ooJqrKZy8p8YAL9MBnOyPtJk/6y
         xi5kdtk1OyukfB8/fcwmcrTtfejcIDqo9LwvYDz28QGvs5EVBG+1dnHmsDQrOGiI7YoQ
         nlPSonk2ELXqeP4ftsvg9AyEUmZE6Ji1BstGjqjW0+NacIl1PkhcVNS6SeR0n8uQgYhv
         DzHdpHPSltQsGUEQh2AzXnL/nHOD7EE5T5wemSlPH/nDnA7PxYQ8K7HU/HLZnT1MMO3d
         Jirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692144580; x=1692749380;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iym3UL0opdYGlYgXkqZ44VRPwtvPEe+002M5treKdNU=;
        b=i/+eGdNyQVKVmXv0k2AxwYCLolfb6DFl67IVu+aLL43i/h+pWpDadfvmQFt/3p3kwN
         SajPF16o1aOcsou8uZFsEWNH22/vAbe+suX/z5KyemY78DOblCuvsA37KHeYS5i6yBeO
         /FpqMgEYLIG0OTv9WJC+tKNQppbMIZ/f0u++iSkfHov8ZUYBrO5vRS+egcba2ceOGOx9
         qdO+EGFCTVZ/qnWNa1Q68M++OA3a4ssirp/TOTJWBSYByGHTJv9pJudvqSnJ1e0u5Bgq
         Bx1Ap8hQWYVNIdMYWzaJ4GSwC4BFTN6VHIkHMdqzpMl2Fh3zElcrqsm9ELOssDaqgi+u
         EaRQ==
X-Gm-Message-State: AOJu0YwbWAevQoNE27KknV6Onj8F8hTeFGIzOfo2Tevp6ZisknJ3FRWc
        rA7Gp/mJaPbyJgYq3YCkQAe9kxdvE8M9M7HZzFTJcrflPzBzgA==
X-Google-Smtp-Source: AGHT+IGzwT7J4QNDCT7mY4MIdnBX7TqJuxguUuN3p4lvLiy7KALzXzWfyMHqr4oPmPqchOVQrI7UEkrdZyMIUzEtyPs=
X-Received: by 2002:a2e:9053:0:b0:2b9:af56:f4b8 with SMTP id
 n19-20020a2e9053000000b002b9af56f4b8mr219105ljg.10.1692144579827; Tue, 15 Aug
 2023 17:09:39 -0700 (PDT)
MIME-Version: 1.0
From:   Patrick <patrickf3139@gmail.com>
Date:   Tue, 15 Aug 2023 17:09:13 -0700
Message-ID: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
Subject: Force usage of pager for diff, show, etc when piping to non-TTY
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed there is no option I can pass to git to use the pager set in
my gitconfig even when piping to non-TTY. Is there a workaround? If
not, may I request this as a new feature?

Use case: integrate tools like Delta or diff-so-fancy when building
wrappers around git commands. See
https://github.com/dandavison/delta/discussions/840 and
https://github.com/PatrickF1/fzf.fish/discussions/202 for examples.

Thanks,
Patrick
