Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E832C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCFWyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCFWyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:54:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32233580
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:54:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso14709497pjr.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678143241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlRHJhwkoiEu0mIO6yNZgkvBKhPSfTEFudRMEoLY8Ak=;
        b=gzN4CY9A5bWQDqbmaLxb+fLTcDouf+eJMJFDHp9fvPp1N/YpBz8r34ULUwfHmPLgRO
         TyqszZy5jWW9vDHm9xn6HcUacjP1xIV07LGfKVZcrulIvUFkdNL8gd3xv1QCWe20BmX7
         MdmMHTfW86a2aGgHuGjkuEqEiFz3VPBQoBU7FSZ+p2viaEB0gNQOj9AJ49KlICpHtxlf
         c/HOPBecz1SUuSFOqaWKlEFBBVLrT2OLRPh9GeAs2s8Y9ew2E7RJBsJTJU40jRjW8zIG
         ZvgC6F3Rl8fHbjWbmgjHPrWaVGGo1kJJVEdm6dynb7XWHnzERpHr+XUeNRx+deIB15Dy
         fmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlRHJhwkoiEu0mIO6yNZgkvBKhPSfTEFudRMEoLY8Ak=;
        b=38f8cLZ9NkARFDkxhql5f/55PjZ/gTsw566KRnrKtdrMJM/0959uK8j9eO9McShwgV
         BRluQep6UCHucgCL+VIxwBvT7/rmofVuXHHvoXMho3i+G9I9K5YLJMRH9ioB0Ee1yo8C
         /Iu5rQMi+7TTZ0tD/hNsByMaRYHgSHzjpO/eN3noXAxmo1q97KPPLO9P4eHbszYWPE7V
         0x0OHOzfc/d8wup9m7AL4tWE32YZavwpQ9nyuxo5bA/x6N6i1NAo9Bg2XNGQ3aBfdek9
         poFch3dxHeP7UPDK1PwVGCdK8E8y1FVM9mfnEhrIiQavgcklpyPVxuv6pI8h3wP4VSDi
         Hs7g==
X-Gm-Message-State: AO0yUKVsQs5HGkNHWwzogS01+VfjtCOppuCPvpqbBjB412Bv/vPadBs2
        MntNAohHmnhKvJRfv7LhiCA=
X-Google-Smtp-Source: AK7set99ESOlvo0yn7QEr6BtPZcN+QDa1Jjj+SwpUILKE/cJtcIPqG1/V/7dm7J5VHRBylR65X5+Kw==
X-Received: by 2002:a17:902:d2c7:b0:19e:8bfe:7d70 with SMTP id n7-20020a170902d2c700b0019e8bfe7d70mr16617607plc.52.1678143241064;
        Mon, 06 Mar 2023 14:54:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b0019d397b0effsm7164724plg.270.2023.03.06.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:54:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:54:00 -0800
In-Reply-To: <pull.1490.git.1678136369387.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 06 Mar 2023 20:59:29
        +0000")
Message-ID: <xmqqy1o97apj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
>  	struct object_directory *odb;
>  
>  	obj_read_lock();
> +	reprepare_alt_odb(r);
>  	for (odb = r->objects->odb; odb; odb = odb->next)
>  		odb_clear_loose_cache(odb);

Hmph, if there was an old alternate ODB from which we took some
loose object from and cached, and if that ODB no longer is on the
updated alternate list, would we now fail to clear the loose objects
cache for the ODB?  Or are we only prepared for seeing "more"
alternates and assume no existing alternates go away?

Other than that, looking quite well reasoned.

