Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C59DC6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPQUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjCPQT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:19:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E30D3098
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:19:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j13so2158292pjd.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678983573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVj47gT390QT/2Dh3dP1lgI6G8nDspnUaKnOtmpEoWs=;
        b=pHMwx8kKhWBIaO89o6rIl3pWfU4K6pf/Q/70km+FjlQh+07nJccCc0OSJ6ZZnovzWi
         Cavoue6ZVXyF+teKQf8T6cbTRAJSryTgTfQ1cP7hWH46zesa9gyvu3/1Vrla2tjqBcjP
         ZAg56Rx2UAbWLNGO1d0o64GA7mqi40wOqptyyNlWiYC3oBKVDrDkUStHvTzJaljNO9DS
         +Hu13DDIYZ4xOelLrQyjghGLdnqzF4Xxyp76uMc1gBE4WCtdceA7XpLUPrNz7OhJNTOF
         KJtcVXsP4ivhJtVGSw6xJZKHi1Ix3P+g64bEfI23PlkO/ePEjP6UA8BIMr087g/eqVCQ
         Jewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVj47gT390QT/2Dh3dP1lgI6G8nDspnUaKnOtmpEoWs=;
        b=a3WK0b1+q/oE4TB1/YOdgjTjISAf/v8rb2LaVxcFzEMVpvvQiVBaqjg6NQX5FjiWVD
         0ucRT11uFcQAjn8B/sTkTFXJTdQSn4QzV+Gdis8504yI3zWmu5bBiL3E6WTSgfVA6XSB
         bNGf7/hBuJeNYyGKF0Zp47VDdcQt2msEtfghWQTZs0uN8idZoOxkYLuHtGY3P6gTi5++
         L+oq+bhQYRNF+hQRanacXKM3HjPb6evFHHaUT/zfsWHhYgWsCaPe853ga6CaPQmivdVp
         /N1+KbjxGDmF28zCcK41Bt4zY11lj7LgPVcJ1bqBkdEfsqghT5YPsvNd5qQZB4Eg2VzX
         CPPw==
X-Gm-Message-State: AO0yUKXsnrIsC0EJoiWEuLxpaO3Wa6ncf8FTfUD0oVHrkRP6jKtmLWKh
        4tvDjebXrLK/w6vyEWkae/CePoxkraY=
X-Google-Smtp-Source: AK7set+hXpRSiCDWMT0bNnlrJbJenMu9vX/3428RU9QCFQbyFLZvPuHliZ7k+0YOGIyBWg8ddY+yuw==
X-Received: by 2002:a17:902:d1d5:b0:19e:2631:7c01 with SMTP id g21-20020a170902d1d500b0019e26317c01mr3216287plb.37.1678983572873;
        Thu, 16 Mar 2023 09:19:32 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kz8-20020a170902f9c800b0019f3cc463absm5848233plb.0.2023.03.16.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:18:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
References: <cover.1678878623.git.ps@pks.im>
        <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
        <xmqqedppohno.fsf@gitster.g> <ZBMwUmBhqEd74YAx@ncase>
Date:   Thu, 16 Mar 2023 09:18:09 -0700
In-Reply-To: <ZBMwUmBhqEd74YAx@ncase> (Patrick Steinhardt's message of "Thu,
        16 Mar 2023 16:05:54 +0100")
Message-ID: <xmqqpm98mzzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Given that in the previous step, what used to be called display got
>> renamed to display_buffer (I think "buffer" ought to be sufficient
>> in this context, though), the variable of "struct display_state"
>> type should NOT be named "display", as it would be confusing when
>> two things are related to "display" and only one of them is called
>> as such.  Either "display_state" or "state" would be fine.
>
> Fair enough. In that case I may just as well drop the first patch.

If you plan to get rid of an independent "display_buffer" in the
endgame by moving it into the bigger struct as its .buffer member,
then I think the naming is fine as there will remain only one thing
that is "display".  The fact that I didn't see that plan through
when I read only the first two patches would probably mean that the
route this iteration of the series took was somewhat roundabout, and
there may be a more transparent and possibly a more direct way to
get to that goal?

I am not entirely sure if the buffer should go inside the
display_state structure in the endgame.  An alternative may be to
make it a on-stack variable of format_display() (which will later be
modified to do everything up to and including writing out the
result) and pass it through the callchain below to its helpers, just
like the current code already does.  And in such an approach, you'd
still need to name that variable passed to the helper functions
called by format_display()---"buffer" would be a good name for that.

Just thinking aloud.

Thanks.

