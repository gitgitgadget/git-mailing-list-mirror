Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA22C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41E5206F5
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNKn/fDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbgDANql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:46:41 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:43439 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDANqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 09:46:40 -0400
Received: by mail-qk1-f173.google.com with SMTP id o10so26964081qki.10
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0lcRJbeakAKpXfQlFCIeB3i55srvYPIxeuRepS6z3uk=;
        b=PNKn/fDlHYfrVDlMoJ0GHFn5gHngubbEIaUZLoUdqUDYR8cXYXmFvLQmObnS76RDWw
         zCPTtlbyVjf6zmfIDfFkffOYYtyy6TCK1b+w4+extL28KrSbiK4kUNcU1BTi/mhW/wiU
         93CzfCv9HWtUNdd6BqvnNtc4ajFjcrbRBQ/VaEqib1tLFWuJwJ6GyqqVOv1HUZSKEgC/
         RT3o/hckjBtdQjWSUgvqbc6oemMqm+RxBdT6yZMuV+UqdCfB1ZkbymWfbjfJi/zWybKb
         v/7vVpevuEFrL3rxY0Ii72kwW0buPiIlYkR+Egcj1sXv3d5tNzRQHz0VVruemgEQ4KCe
         /v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0lcRJbeakAKpXfQlFCIeB3i55srvYPIxeuRepS6z3uk=;
        b=OHPUyJoYUHaju8Vo/xsf43+Q356imXXbfS7mtptDtME7wzKAd2zRvDn6xAOAUnLEFe
         7PNK9IUYokp91HWZShB0iHh6tlJTErW9D1j978RVUqqBhNSZtrWQ6Ea7ZCtYFad8lnKb
         osiE+bpvuSkhn6rw+N0BxBp/YNTJNuZqVhseLyRDt92pKA5PjiHs/Wig8TWbq0r+GLQ6
         dW9mT4LU9dlbNUAiAIkXDTPxiNGS/wBUANWbwzvL6SdIrjUXiPIfVlVOphCrACBpkNnm
         UrfwF2vpS4t1XmcE8IeBW1TYiJQ+CFJbVL/Am/bXFR95MkaZJ1wBY3qsJMd933mttZkY
         ZQbA==
X-Gm-Message-State: ANhLgQ0GfQKt7WRKz8FYS/guqt9Tv/0X8nemtqhqNhtif7ALN63iT2gr
        4VDyShwkpk0XBGMrk7Y6MjNzdh+gBgAxSMeIDo++Jw0mfRY=
X-Google-Smtp-Source: ADFU+vszUnQhxNN33QJ03H5ffQIghaDGctZ36v3aYkyxY4tiGE6Jo50RXSA04VEQ0oXLoypuVAES51RDOMRtOxCx1iw=
X-Received: by 2002:a37:a353:: with SMTP id m80mr9968451qke.398.1585748799151;
 Wed, 01 Apr 2020 06:46:39 -0700 (PDT)
MIME-Version: 1.0
From:   Thomas Kitzinger <th.kitzinger@gmail.com>
Date:   Wed, 1 Apr 2020 15:46:27 +0200
Message-ID: <CALYpq68+fr9NeoJO7YcfTV3LBfDG9AHZqw8Apvt-dHYL3_D7qA@mail.gmail.com>
Subject: Why does submodule status prefer distant annotated tag to recent
 lightweight tag?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a git repo that is used as a submodule that has one early
commit tagged with an annotated tag (V1.5) and several later commits
tagged with lightweight tags (V2.0, V2.1, V2.2). I know, probably not
a good habit to mix the tagging styles like this, but nothing I can do
about it.

When I run 'git submodule status', the result displayed is
(V1.5-5-gb59dba3) while I would expect it to show (V2.2).

I assume this comes as git-describe by default only considers
annotated tags and a 'git describe --tags' probably is only called if
the bare 'git describe' returns no result, but is there a good reason
it is implemented in this way?
Wouldn't it be better to make git-submodule-status call 'git describe
--tags' right away, as git-describe already prefers annotated tags
over lightweight tags if they are equally distant?

Thanks,
Thomas
