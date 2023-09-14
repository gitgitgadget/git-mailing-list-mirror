Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E9EEAA7A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 23:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjINX4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINX4n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 19:56:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5591FD6
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 16:56:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso25696211fa.2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694735797; x=1695340597; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFedS0zzIlnNIgLdsADYbWt1Lgy7WSZTAEuP9uBnNwo=;
        b=L9oajEZnPMnR+0AYKvaO5bazX1g/w9qXKyt8ZrSdNxWmNKGvpPcUXp6Ykk07UEih8l
         sk46uLr8Z6+VZMMlXSZEQ29GAPdoaR62rv5pslh86XSJiBsqyrwXUwvYeNCEg6nzvdzS
         axbTEd9XSsxX9SJbHMwsPcD2meyWtBTaExChzednwWk8yMedYCB8F05l/yOX7Mg2UK7Y
         Q5tdw3yqOqJetImz5zockaq92U/JK0YesLZVCdEPJ5e0lVceiCSlCMv27RlGi3/mIvf5
         ostvPfQYhWiXIp/hTkZ1XTGSBG2C2U441mmdktcEzd6IX+zUea7AtcS+se4Vyyu2uenA
         QCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735797; x=1695340597;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFedS0zzIlnNIgLdsADYbWt1Lgy7WSZTAEuP9uBnNwo=;
        b=hYpbdb9yBqhxBwVeV4+Ttu5ACK84QF45LIOPyCj6lmxPw3cGSWrw46biItKj2eEvps
         BfTFbwrHdFlZehIbZ+W7MKTzj/zNvklCwOcIaa01Dz0ec6Xr9qx5+QfpMz2uyiYc4hw0
         /wm2N7ZZQ7ib/0/pvfqCHeAbgGod4myIJgh9kynoQVCl3d6exsOGWZCYoaTtV5vHWAlK
         PJunXI15UFuOIz+ngyDdfhMogR+K3Sj26NNZdmJ7bCB1ODbcSpwQF7y/bdxoY+kVnqyg
         qy2/P1+M4AX5KXy2OP5TFQZHhij/sWEIGSVTW9FFbLSC5yk9WiiJHcUuod8u3THlhV42
         yFQA==
X-Gm-Message-State: AOJu0YysUnw5jtUEYpGkG8tvbtZwduB9X45tOy+KQ3oVseVbJyP13Y61
        utt+QaMAsxres5A4kkxGtyaOlBV6xJ0=
X-Google-Smtp-Source: AGHT+IHsykQZ2TSMjDtj3aqByR/tGdiRh9U0hWeC00SRQgNRxqkO3qGq4I28swyl6yDJyXLGQXQW/Q==
X-Received: by 2002:a2e:9546:0:b0:2bd:a85:899e with SMTP id t6-20020a2e9546000000b002bd0a85899emr187011ljh.3.1694735796645;
        Thu, 14 Sep 2023 16:56:36 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a26-20020a2e861a000000b002b6c92fa161sm469404lji.61.2023.09.14.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:56:36 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g>
Date:   Fri, 15 Sep 2023 02:56:35 +0300
In-Reply-To: <xmqqled8h01w.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        14 Sep 2023 15:17:31 -0700")
Message-ID: <87y1h8wbpo.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Sounds very straight-forward.
>>>
>>> Given that "--first-parent" in "git log --first-parent -p" already
>>> defeats "-m" and shows the diff against the first parent only,
>>> people may find it confusing if "git log -d" does not act as a
>>> shorthand for that.
>>
>> It doesn't, and I believe it's a good thing, as primary function of
>> --first-parent is to change history traversal rules, and if -d did that,
>> it would be extremely confusing.
>
> I am not sure about that.
>
>> Also, --first-parent is correctly documented as implying
>> --diff-merges=first-parent, not as defeating -m.
>
> Yes, exactly.  That makes me even more convinced that the intuitive
> behaviour, when we say "we have this great short-hand option that
> lets your 'git log' to do the first-parent thing with patch output",
> is to do the first-parent traversal _and_ show first-parent patches.
>
> "-d" is documented as a short-hand for "--diff-merges=first-parent
> --patch" and not for "--first-parent --patch", so the behaviour may
> correctly match documentation, but that does not make the documented
> behaviour an intuitive one.  And a behaviour that is not intuitive
> is confusing.

I think both behaviors make sense, provided they are correctly
documented. I just prefer the one that is more basic, yet allows to
achieve things that another one does not.

>
>> If we read resulting documentation with a fresh eye, -d is similar to
>> --cc, and -c, just producing yet another kind of output, so I think all
>> this fits together quite nicely and shouldn't cause confusion.
>
> Another thing is that showing first-parent patch for merges while
> letting the traversal also visit the second-parent chain is not as
> useful an option as it could be, even though it is not so bad as the
> original "-m -p" that also showed second-parent patch for merges as
> well.

I don't see why desire to look at diff-to-first-parent on "side"
branches is any different from desire to look at them on "primary"
branch, sorry, so I still don't want "-d" to affect traversal or other
commit filtering rules. We do have --first-parent as well as a few
others for that.

> People would have to say "log --first-parent -p" to get the
> first-parent traversal with first-parent patch output, and they
> would not behefit from having "-d".

Well, at least they can now say "log --first-parent -d" as well ;)

Honestly, the "log --first-parent -p" (without "-m") suddenly producing
diffs for merge commits is already unnatural, needs yet another
special-casing in documentation, and then, finally, this relatively new
behavior was introduced exactly because there were no "-d" at that time,
to save typing "-m". The latter is yet another example of why "-d" in
its current form is a good idea.

That said, if you feel like there is place for a short-cut for this
particular use-case, it'd be fine with me, say:

--fpd:
  short-cut for "--first-parent -d"

would fit quite nicely into the picture, I think.

Thanks,
-- Sergey Organov
