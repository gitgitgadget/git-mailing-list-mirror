Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095CFC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjBCRHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjBCRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:07:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F427A8A28
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:07:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x7so5862119edr.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wRC5KCCH786rIyVdVXLh7LimJghKVVL6RyE6bfZ5dg=;
        b=eSXy5d/cP3RCSfSrdOpw/7mfJYsZpThOFvI3DQ88p/lNiU2d9MYc++BVGLvWtlZ3aP
         Md2uXxc+LM0AWQJzn0xky7+cOX+gXeC1jrvcQ5KA8ralxIXa/FjAUomJl1tyzreudXad
         5BXb0FfRLNnSHxi11PtTurHPQU/vjCkmuxFF3vXIgQuql8eP42YPlA277WUli2ZSDca3
         QYxh7sOycWm40SwAYcPP9AM8/iH8XWY9zpB2kTd0FMI2xiMXSjuCpQ7R6RpNv3OCAjNB
         yZw2N2PeH6od3HC3+Ou+XZjzY2HNJRUSay/EwKR7yxX6H9Xk5Or1FQ8bcZc+SsfC9EKQ
         vinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wRC5KCCH786rIyVdVXLh7LimJghKVVL6RyE6bfZ5dg=;
        b=DQNqgR1Urm+3sQ7cUt5MBtf919CuOH5jVzoZgP9KUbKw9LdELpKzqGRZzC1HJeoktx
         Z67Zd/Aor1cicNA33CQE+nIuSChYkivHHd5wgrTssfiXd6FNOUiGb+Jc+RflM1+hZrXD
         Qaw9FJkLiTLiUJtATEXzjXfyruRaO5mkn8Ep2XQ5YSd2rqOzYCMbllSxCMSnvURr6dTV
         jtMF5gaaPMjdB77GSymZvDHb3OFNkq6Jt4CyW45CC7GmQZyJY4OB7dzcb/nArCLECWXQ
         ylr2U3U6/qJdJU/qQ4ilm0JBIdIudJ2PQ+6ZKXV51tqrVm50M2SAX9UQ72RTp4o0liYy
         4Sbw==
X-Gm-Message-State: AO0yUKVqIxUDu607+Q6ZXmaBoMBn4mLxftgyj4KMIoEM/j8j5+7qyoTa
        JyrAOZ1hHdOHZS0AuT6OuIzxdn0EDq+uL+46TWc=
X-Google-Smtp-Source: AK7set/tq5b/ORvwgTWf67aDm1bHvklxWkh3UsCaAFU7D2uqX03qfGadTHbhkt0SGZQJZPOvC4i/DhiJW4E1IT7B/NQ=
X-Received: by 2002:a05:6402:294f:b0:499:b60f:5741 with SMTP id
 ed15-20020a056402294f00b00499b60f5741mr3380214edb.80.1675444026705; Fri, 03
 Feb 2023 09:07:06 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net> <CALnO6CA3LL2TbMyvVsgeNgGHr9tGq4-FYR0-RMyJJiMvV3P91w@mail.gmail.com>
 <Y908f2qaxKeljtj+@coredump.intra.peff.net>
In-Reply-To: <Y908f2qaxKeljtj+@coredump.intra.peff.net>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Fri, 3 Feb 2023 12:06:55 -0500
Message-ID: <CALnO6CAfKA2atXwHXGJxnBGJ46EMbjGmFU54mb4FJL2O8ceXyQ@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2023 at 11:55 AM Jeff King <peff@peff.net> wrote:
> Just a guess, but does calling:
>
>   setlocale(LC_CTYPE, "");
>
> at the start of the program change things (you'll probably need to also
> include locale.h)?

Indeed, the new output is

    illegal byte sequence

For the following program

    #include <regex.h>
    #include <assert.h>
    #include <stddef.h>
    #include <stdio.h>
    #include <locale.h>

    int main(int argc, char **argv) {
        char *loc = setlocale(LC_CTYPE, "");
        assert (loc != NULL);
        regex_t re;
        int ret = regcomp(&re, "[\xc0-\xff][\x80-\xbf]+", REG_EXTENDED
| REG_NEWLINE);
        /* assert(ret != 0); */
        size_t errbuf_size = regerror(ret, &re, NULL, 0);
        char errbuf[errbuf_size];
        regerror(ret, &re, errbuf, errbuf_size);
        printf("%s\n", errbuf);
    }

My own locale output, for completion's sake:

    LANG="fr_FR.UTF-8"
    LC_COLLATE="fr_FR.UTF-8"
    LC_CTYPE="fr_FR.UTF-8"
    LC_MESSAGES="fr_FR.UTF-8"
    LC_MONETARY="fr_FR.UTF-8"
    LC_NUMERIC="fr_FR.UTF-8"
    LC_TIME="fr_FR.UTF-8"
    LC_ALL="fr_FR.UTF-8"


-- 
D. Ben Knoble
