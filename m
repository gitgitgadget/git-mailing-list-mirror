Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C9C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2943C207F7
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpTB3fOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgEURtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgEURt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:49:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226BC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:49:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so6192369otv.2
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L+5jXwk8hHU5QPrjMddT/xwRVoIZ3cKPgzxOCTpCQ7Q=;
        b=UpTB3fOOAecdsRcxVK5fjIQnw08lb51BiwKCI6/+dCDQlhOLL5qKRNXOy9ZEOewqK2
         rikOkVkI1Alh5TW0uovHC6WbwFND6k9X2eSDFpizggbh+0B6SgtacEzBHNlZ542KJy8N
         6OjuYwlN3GJJ5IZZRyudvj4AYtzhlZmw6KfRm+2wZWm4z04TQ/DbxWL8OTTVVXlH0Q5I
         TLTkNm0ZLRJIbiKR9au40lLIowhZvktpCvQyFte9tOZhRM9DXE55tmFHfXiIWogUzqxu
         yjsD3hIVJIjRekXSs3U7eYH8dCWA/0d9HsL8PdNV5w5WU7ej3w9kKTyNIAcfe0+DXDFQ
         c56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L+5jXwk8hHU5QPrjMddT/xwRVoIZ3cKPgzxOCTpCQ7Q=;
        b=LvB1CeFOFJm8XK8T7RyqAVAX88zak3XglXTGYAexe1rXQwT0Y0ydoeabdKzPNIrCZT
         VBEs0bw0xWNgW4FVKXhOTn4ZCuQQlhuGdMlVzRccR4wQdSbrcFwx7uu/4IkVB9EmJUAK
         yx7HnxkbsWE4F7gOAqXOsLYDACXu5FMqfl3tCklSRk6eukbjDSXP/+OrI8brYb8Zkbsz
         x65wj6iSP2JEnbUXO3VFFDPrpoV+YzANRbW87TqpqiEeo4yB+SBihXPO16fGx58e1Jll
         U4fK+Jz901/FYOxxqhq1zWMjZDA2+fxJrnyTw85K1FiZSG+fW8JUPAv1ngWpMPFnvOdE
         ee2A==
X-Gm-Message-State: AOAM530fmVOuAKyNzkGNT2ItR7bHZ/Xjx68nj3vw5G/p5Aw/fyBZHBq8
        jvfOFoVe+y4VggFaJY9hprmBm9131u1FCSbdmL3fJL3v3v4=
X-Google-Smtp-Source: ABdhPJz4vfGc1x3qCtAWFJ1zuUGDw4+SZ6abBkRq4kNjPD40EE2FV7zL2pB375QHOA8tMRXFDOLqvw+nLFLWXqpBFq8=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr5135900otm.316.1590083368140;
 Thu, 21 May 2020 10:49:28 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 10:49:17 -0700
Message-ID: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
Subject: Anyone know what is creating commits with bogus dates?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wanted to report that we seem to have a number of repos in the wild
with bogus (as in "won't even parse") dates.

I first discovered such a repository in the wild a while ago with
rails.git.  It has a commit with a recorded timezone of "+051800" for
both author and committer.  Everything else about the commit looks
fine.  See https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734.

Some google searches at the time turned up a few other examples, all
with the same "+051800" issue.  I put a special workaround for it into
filter-repo because I figured it was slightly prominent but probably
limited to that special timezone.  The fact that it was six digits but
the last two were zeros made it seem not quite as bad as it could be.


Recently, I've gotten a few reports of commits existing in live repos
with other forms of breakage.  Dates that correspond to roughly a
hundred years in the future, and with timezone specifiers that are
either 7 or 8 digits long and no leading or trailing zeros.  See
https://github.com/newren/git-filter-repo/issues/88.

Is there rogue software somewhere creating some bad commit objects?
Does anyone have any idea what might be causing these?  Any
suggestions on the right course(s) of action?

Right now, I'm leaning towards saying fast-import is right to bail on
these, and maybe I'll investigate having filter-repo waste some cycles
to try to detect these and report more helpful errors (though I really
want to avoid full sanity checking as that's expensive).  If I go that
route, I'll probably make it link to the example command I provided in
that bug report showing users how they can use filter-repo to fix
those problems.  Does that sound sane?  Anything I'm missing?


Thanks,
Elijah
