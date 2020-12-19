Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC76C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AA923AC6
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLSMK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 07:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSMK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 07:10:59 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7CC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:10:18 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id o5so1203391oop.12
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9eKSTAV1p5pvXsXrUAktvmUA2zTTzE7CB8MAAAPMEz4=;
        b=NBBksC+6A5HUaJgUTrKFhG00XBoEJB36U881509oeSKvAwtf6UzPo7AYFmUjmA9oZU
         cLe4Fa3uvTW6getHJTsq9erkjr/X4nwy+/126okd+QzHuNKNqVzAlknoRgFQ7n9hgXb4
         jJEH8dkLbCy9d2MCE1lV3EfcnmYOZSsdyX4uQlF5KZc9fUz29kfuMzksWYPi+G4dtpFq
         ZgYMNShAAy+q0uml3Hnf1pKpzjqWKaakG1BTSxgKBbFhBR7X9F4FPa0WcRLMiNSi8d+X
         eKduCPiMySDnvAMuV0vd2Bc03QBucGhdM646rsbITsDB0iJ2IJN2swsCvbVwRQEc12JA
         kaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9eKSTAV1p5pvXsXrUAktvmUA2zTTzE7CB8MAAAPMEz4=;
        b=Rht37U8gnk2315GsPDboSYWaAZjbibytQsj1RXbhw6ynIyiomWwTkOgR/n9JVY3/KE
         i7qONoZgTk7Zx/VCJEHrSu6JK65ZgDaKtwVGGMyvsT2muHgfLHKj1iOciOS9U1dPQnim
         Lih5nEnSCV/9PUp3vjwFRVvhsFRCuMeq5GvVh4cxdMrhs7X8VDhXiEnks71PhUVGo6gq
         bwt7SQNqdYjNugrDpkMx/ICAPeSty0AgWdV432dSek6fCps71JtoDA1kXt2leHa1SLE7
         JBSQ7U+lqyKR4qQYFAfkEgt+rIZT2KbN9i/a78RZzc40G4vnHrNKaDgsmqt7qox1GXbQ
         PzWg==
X-Gm-Message-State: AOAM530Ft3ky1y40Nn+BrCXux524eNINVfIK0UvaIuTvrpmSKGmTnmBK
        /TqrLX5ND+j40W9l4QAGmZU=
X-Google-Smtp-Source: ABdhPJxcrTcorwCrdxjSqqLJcjxQzkfNau9WFhUMyCnmD6bW1KyZJDLBBRnyRT5jf52IRfh+yc3moQ==
X-Received: by 2002:a4a:c293:: with SMTP id b19mr6043024ooq.74.1608379818292;
        Sat, 19 Dec 2020 04:10:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a15sm2378367oii.50.2020.12.19.04.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:10:17 -0800 (PST)
Date:   Sat, 19 Dec 2020 06:10:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>
Message-ID: <5fddeda8a5a92_1de0de2088a@natae.notmuch>
In-Reply-To: <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
 <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
 <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > How about this?
> >
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -46,7 +46,7 @@ show_tool_names () {
> >                 while read scriptname
> >                 do
> >                         setup_tool "$scriptname" 2>/dev/null
> > -                       variants="$variants$(list_tool_variants)\n"
> > +                       variants="$variants$(list_tool_variants)"$'\n'
> >                 done
> >                 variants="$(echo "$variants" | sort | uniq)"
> 
> Ah, I didn't see your variant before sending mine.  $'\n' would work
> with bash but we prefer not to rely on bashisms here.

Yeah, but it's not even an RFC/PATCH. It's not proposed as a solution.

It's just to focus the eyes of the relevant parties on the likely issue.

-- 
Felipe Contreras
