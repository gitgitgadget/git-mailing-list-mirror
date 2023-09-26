Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCCE7F120
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjIZUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjIZUFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 16:05:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBBAD6
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 13:05:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50307acd445so15364978e87.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695758732; x=1696363532; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3ljssu3uahjkzzIB2X85IqA14funSRKbfkvyu5YI/o=;
        b=cv/50hSc9yBUm8pekcDYe6Q+RQjqo0hV4QqY17ixi3TPpmLS986fF5Z30QVxLf6lPu
         7BieHzOZOZUmXfnw+voGLith8P9XzVKh9/4pE9srBdDYrCNI/xjF5VKY1XNCCObJbHSz
         yRMgGZk82C9YrA6VB5A6dP8tHP6hJ4U4hyNw+Qhpj2PwspRuINHqGEN2cHf7JCGaiod1
         RdBENEfhHGbFMVDb2qR4bAaVnuySaJmUECeVEPpHjhjkKo3ay+pUJAVWcRP0wMpp1nqV
         YLoUwGSAqF6gWwp93n3YOAADq869gKqXPzYxw+BK+KIRIwHyJqRvvWpr5xqJoHgOF1WB
         qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758732; x=1696363532;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3ljssu3uahjkzzIB2X85IqA14funSRKbfkvyu5YI/o=;
        b=TV2ATh/HCy/HXiJpweIWpefErDUHqQpsVoeQDZXOIqZIk969v4jdC5EOdMROlz7/IX
         EQb99qXM2jbHD/oMLZOMbtBSKiimURxIU+HU9ojbeFtkf2VInMU++jMiqv2hUXf5Kcob
         n3B1NLTPCvKLwvGtsoT4fCovn3UxKJybo+M9O57/xsmM4QQdwG3cdJpizMcAabUZDtRL
         Ix0azfF8Bkky5c91FU8EJYj93S0PW5Bjo0UCI0GHnmUe07d4+tDiX7pgTTbdp0RPC+LF
         jmt+4SaBelyMWX9C1EjNCVFXc37wp+0clyX6Tajw4OBQUt+97i62EZv0lszvDqdSgfnx
         ZZ6Q==
X-Gm-Message-State: AOJu0YzrZtcbQndWlS7tVJGb7b1qXiGRL85bT4pnxkZeyMXX+wOv4FQZ
        HswMKrG7xjbLfEszwvZ+lLg3n3ZdM7c=
X-Google-Smtp-Source: AGHT+IFdLRZTSiiZDrgMFzphhKu+n/q+MlGe0rKPVrFOH1ESeHcgxRw87bEs1Aen0nj9jPfqkvgwbQ==
X-Received: by 2002:a05:6512:3d93:b0:500:94c5:6e06 with SMTP id k19-20020a0565123d9300b0050094c56e06mr11709814lfv.56.1695758731826;
        Tue, 26 Sep 2023 13:05:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d6-20020ac241c6000000b004ff8f448343sm2297017lfi.33.2023.09.26.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:05:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
        <xmqqzg1nfixw.fsf@gitster.g> <87ttrudkw9.fsf@osv.gnss.ru>
        <xmqqjzsdps0h.fsf@gitster.g> <87bkdpl2yx.fsf@osv.gnss.ru>
        <xmqqa5t8ooaj.fsf@gitster.g>
Date:   Tue, 26 Sep 2023 23:05:30 +0300
In-Reply-To: <xmqqa5t8ooaj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        26 Sep 2023 10:08:20 -0700")
Message-ID: <87o7hok8dx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> No need to ask for a new option, as the behavior you describe is already
>> there, and is spelled "git log --diff-merges=first-parent"
>> (--diff-merges=1 for short).
>
> Ah, that changes things.

Only a tiny bit, unfortunately, as I'm still struggling to finally
convince you (((

>
> Making "--diff-merges=<how>" only about the presentation of merge
> commits, requiring a separate "-p" for single-parent commits [*],
> does make the life for those in the "merges are the only interesting
> things" camp a lot easier, exactly because the lack of "-p" can be
> used to say "I am not interested in chanages by single-parent
> commits".
>
> 	Side note: I personally think it is a design mistake of
> 	--diff-merges=<how> (e.g., --cc and --diff-merges=cc do not
> 	behave the same way) but that is a different story, and it
> 	is way too late now anyway to "fix" or change.

        Side note: This has been considered and agreed upon when
        --diff-merges= options were introduced, and as far as I recall,
        at that time you explicitly agreed it might be useful to be able
        to get output only for merge commits.

        --cc is a simple alias for "--diff-merges=cc --patch" nowadays,
        so yes, they do behave differently, and that's by design. Dunno
        see any design mistake here, as we get all useful variations of
        behavior with a straightforward design, more frequent use-cases
        served by shorter options. Looks fine.

>
> So "-d" that stands for "--diff-merges=first-parent -p" makes the
> more useful (to those who think "merges are the only interesting
> things", which I do not belong to) "--diff-merges=first-parent"
> (without "-p") less useful.  And the combination is not useful for
> those of us who find individual patches plus tweaks by merges
> (either --cc or --remerge-diff) are the way to look at the history.

Yes, you have your --cc, -c, and --remerge-diff (that I'd call something
like --rd probably, but anyway). Could I please have my simple,
straightforward, mnemonic, and terribly useful "-d" as well?

In other words, will I finally be faced with "if you need it, do it
yourself" argument? ;)

> I still do not think that we want to give a short-and-sweet single
> letter option for such a combination.

I have very simple desire: convenient way to tell Git to show me diff to
the first parent for merge commits, as that's the thing I need 99% of
times when I do request diff output at all. That's exactly what I'd have
seen as changes when I was about to commit the merge as well, similar to
any other commit. It's so natural that I can't figure why it looks so
damn rare or unusual to you, and that it makes you argue so hard against
-d, especially when -p, -c, --cc, or even -m, are already there?

I do sympathize your desire to be careful about short options, but what
reservation for "-d" do you still have in mind? It seems that it was
just waiting for me to come and finally bring it to life with the best
meaning possible. How long should I wait for it to remain unused to
finally be able to make use of it?

Thanks,
-- Sergey Organov
