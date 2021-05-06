Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93FC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F65B61040
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhEFUtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhEFUt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 16:49:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934FC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 13:48:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o16so8825386ljp.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eN9OBKMPhUvQBuSGi0kEN5DUt/w5lXTP+AHamoNxp6M=;
        b=Js6VVcqeKSvcbrXukME1OBkuG7eXPPAmhZKXPFl1xkAXLnKV2aniRy5QpQvmuuJmZa
         PAmrgFavw1PBZozJfnvbnar/1pCn7Ch/1vCiKliDk3J3FXgYg7NE8X6g8leUqbl1KRk/
         SAY44rNXMkdm7thqIqHa2h8lv6xb682rZXarj5+uq4VyInGHKSON9L+ihPEF0hJPIxMz
         dndcz8tb3hJtNEyXIrVUMv2wIKrUnwnABwaMhGFX0u5LfFos3/ghtnWBSaUbhqsTKfZl
         /LUwLxcwQ38SHcvYk99Xy6h/d3HzAJNELF+KIjjc1fnA+5W7h2Gm4pc1cn+XjNxWEFnx
         VjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=eN9OBKMPhUvQBuSGi0kEN5DUt/w5lXTP+AHamoNxp6M=;
        b=je+ZZE3vWnfhsSNK5z58czxaazSdBMyhWPgbSmLspCTKAU4kvDVfkWYII6ANfloY+4
         e7XkrYXec621t2y6muM+fHwxfAMvl/RAfB5aTgRYbxo8GYuFSs8m1PZCDTj4oWlLyT6B
         cySTuZdihrHG5o++dNHGUTrdlMRPfayyvCxZZALg2MLP80JQUeRwT92p9mM3e0b0TUiy
         eN+mehruGKheMQJ+BbUtPbPOqScVpMdTB8ymxV0ubrjW6JVC2boNU0kavek9N4BAIAjk
         tZaw9stZdXdvcAxDtHjq0moS10uI1y1ptPxE1keacD02P4fyeFoe8+iV5UHrZtqmaASp
         mC6A==
X-Gm-Message-State: AOAM533OZ69iG+QmM4Mfl74AuLc9dE6c7M2ZphkaWUD7U1q0vfWNNqLO
        TyN0I3y/Vz3v6O8BODHT5/UMbL4DT18=
X-Google-Smtp-Source: ABdhPJw1+jqN6O1+FgDh18VTHBzkHoeGlg60Yh8nsUexPQPNZ2OgsaLzmpQRnBplSOm1TqMGvz587A==
X-Received: by 2002:a2e:9707:: with SMTP id r7mr5192576lji.181.1620334108735;
        Thu, 06 May 2021 13:48:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u16sm1261379lja.48.2021.05.06.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:48:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
        <87r1imbmzz.fsf@osv.gnss.ru> <xmqqy2cu58vo.fsf@gitster.g>
        <87tunh9tye.fsf@osv.gnss.ru> <xmqqim3w3dvx.fsf@gitster.g>
        <87wnscuif9.fsf@osv.gnss.ru> <xmqqpmy3y5ar.fsf@gitster.g>
Date:   Thu, 06 May 2021 23:48:27 +0300
In-Reply-To: <xmqqpmy3y5ar.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        07 May 2021 05:29:32 +0900")
Message-ID: <87sg2zr3l0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

F> Sergey Organov <sorganov@gmail.com> writes:
>
>> It's nice we've reached mutual understanding!
>
> Yes, and thanks for correcting me.
>
>> The only remaining issue then is if we just go and do the change of -m
>> semantics, or do we need to take some backward compatibility measures?
>> Looks like we are rather safe to just go, as it's unlikely there will be
>> any real breakage. What do you think?
>
> I still wish I could come up with the usual backward compatibility
> transition dance for this case, but I do not think there is one.

Fine, thanks, so I'll prepare and submit a patch.

>
> However.
>
> If "-m" were doing a more useful thing than "compare with each
> parent separately", people may have aliased "log -m" to something so
> that their "git aliased-log" and "git aliased-log -p" would work
> better for them than "git log" and "git log -p", but quite honestly,
> I do not think "git log -m -p" output is readable by humans (after
> all, that is why we invented -c and --cc), so the population that
> get hit by this incompatible change may be very tiny minority in
> relative terms.

Well, honestly, I can't even come up with an alias that would break by
this change, but it's likely I'm just not creative enough :)

Thanks,
-- Sergey Organov
