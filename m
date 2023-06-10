Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D4C7EE2F
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 13:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjFJNvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJNvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 09:51:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C904BC
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 06:51:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56ce6bbe274so5549487b3.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686405100; x=1688997100;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+l8XTqWr2G1BhaJ1uQndk6NhOok5jWAXyrjjRVHNai4=;
        b=ksgGIK85bCbQ1aWD2OXhiTDlWYTLrHt2JYQs24D5WBhUCpKG3IeoUeJPwauvPy/Nod
         xYVuUNxTI6Rv/1dcVSCOHf4D18siOALoZpqSLvI7Osqqz7Na1DVqWuz3RcNIrtT4WUgH
         1v0il4JDhRflnhsHoJMXj2t+HB9EzKOxTKfhht4NJ9kNuVUf57ET1Ven9gw+y5ZWHmX8
         4yakyamvfsF7ZnOjp6oFlnmPAE5J2uTmPz6bOsV9arrZ6ynuXCv+HwY2NTHbcfcUu9iK
         1AZQJuIusWkUd04jYCRCxPCHE84MFEpe5K8DenwXji4lQUxnnliJrEFgZ7amEbdJOaxm
         68uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686405100; x=1688997100;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l8XTqWr2G1BhaJ1uQndk6NhOok5jWAXyrjjRVHNai4=;
        b=KPm1xNYmnG8A39a+uf4fIQfm9kboBHBHhyMr5yPa2xckVEe5qeFUkFzjUsTijuAk/+
         F/CO2eoUxL0xSry9FsTMTwqd+tZzoWu1bYrxQxwxbz6p8+dMca0xdViRVv+HrCDjkTsx
         jIQB9UJPFYAPbiYxRrsMqYUDF78pRETN0+0I8kTQ0BkiYMKWRZ+8ugyP350PNdRAH+BD
         0kydkI3ZH2uiC3sMxEvLHRG54528aBIAESuySO2qeAK9UqXsygPndvFJZXTuva/QFhpS
         y1B4pVBIOdk1imiKP4tNmUZ2atCpAjbFe4IMpvGrKCUA8pv6VDtpqT02ytIIJx+PBdpI
         NyRA==
X-Gm-Message-State: AC+VfDwM0vSpJXOO1Nqj3MMmRBQ5H6IvbjLTcblIEoaqXeACOzENPc7f
        jS1pj/IgOlD+1W1mYcF6JPN1NWFulv3dbX8TFUDFrSIZf2/1Sweb
X-Google-Smtp-Source: ACHHUZ7mcxq6dZbgTYPVV0p8j80jWU2Ky/Dp73Jvg4s71KFiQIB6d+YjVFArBLIVv+MTfFaWTtkabL4qB+LPBVvOzEw=
X-Received: by 2002:a0d:ce45:0:b0:556:ceb2:c462 with SMTP id
 q66-20020a0dce45000000b00556ceb2c462mr4624280ywd.2.1686405099976; Sat, 10 Jun
 2023 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAF3Uz7_tMJ=02T91haQEoFOB5B+C4npAYxhk6WzCj6BJGU4p5A@mail.gmail.com>
In-Reply-To: <CAF3Uz7_tMJ=02T91haQEoFOB5B+C4npAYxhk6WzCj6BJGU4p5A@mail.gmail.com>
From:   Simon Priet <simon.priet@gmail.com>
Date:   Sat, 10 Jun 2023 15:51:29 +0200
Message-ID: <CAF3Uz7-wAiUCizrW5s1zR6GSt6VxPbtt1DkOGOgKvda9nTDLuA@mail.gmail.com>
Subject: Re: Questions regarding French Translation of Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello to the Git community,

I am contributing in translating software such as Gitea and Gitlab in
French, and I have a few questions regarding the french wording and
translations that were decided in Git itself. Is there someone I can
speak to?

Best.

PS: Resent mail as the first version was not PLAIN-TEXT and was
rejected by the postmaster.
