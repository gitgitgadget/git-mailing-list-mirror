Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9A91F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935428AbeFMScb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:32:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50246 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935400AbeFMScb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:32:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so6386961wmd.0
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZrpC3rF0zU1c3RT965TBlpA1DPETmTGMmqjfdAeZhuw=;
        b=P+LAxDth8WtTlVS9yy4QD86paV3ItoHGcBiyiWPxOTmEKT7ZIjgNYm5PsOuZbKczQR
         SeNVKy8evVJu6AUTL4cQiXSb+ThhJ5V4KPgoQJKGgqL9E7+7TU2jOouwbAsPa6E9GhIK
         aY7XI8JMi5QiZENxkyMuM/jOqXkzwmpe1mA3HoS2OHSB9h/iUDLv9oq92cawiOH/mqrE
         MKcUNFC5EhcGrilFvkrylgB8GemtV4PppsoeezQ37dE1V/gOLz7CwqxDo/96VTvQ0H2m
         jAK8nRBMKlSHexGLEE+JFvXUc2TFl3C3ObA+QB1cq1KAiBm4X+eoqwVceJHiIwZqCcJd
         BWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZrpC3rF0zU1c3RT965TBlpA1DPETmTGMmqjfdAeZhuw=;
        b=RJ7IWUAwzMaYdBiqAW96TQm2O89FbAEHuzTJ+Dr9Qlcq6Ww8LooO4Lx2QW9YS7LaJ/
         +x4uZHjBGu27u6ml92UgtvGsZHdCqvCJjwt39aKEdYoY8O7cCJiNeQqwrMpL8iYSvwqd
         B/IZAXy+/Wmkwmq4Xd5bZPBWs/WL862IKWrJ8BeJa4+vgUvTd7iVsHoYcEgWPYVpgder
         wKM2bgjQb1CbSy5ESVAq/HY7jIDyznQthyhdRG1gRGQzzkSdmU5oQ1ikr9PtDMNct9oX
         b83EaFG75ts+5IeXvlg/4ipimm7j8mbYlTZBY4l5WUq9kxMkrMNhdlBdiEkZQT2XHmVL
         NKyQ==
X-Gm-Message-State: APt69E1n/UzQ5PDsgVpMHCZacrVt+P0wAjeKwLWWcPn+1wx1q0B4ysTR
        CDUFxM8Xv9uxFGYyCv12xtCW8EUH
X-Google-Smtp-Source: ADUXVKJFLdcRlf9XFVuCSFbCzP5aIBCr6svUtEzjiY+ydrUMFjQO98hmAVBFrn29cFzhlWhqKRG0NA==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr4076226wme.22.1528914749824;
        Wed, 13 Jun 2018 11:32:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a8-v6sm4840443wrc.18.2018.06.13.11.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 11:32:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
        <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
Date:   Wed, 13 Jun 2018 11:32:28 -0700
In-Reply-To: <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 13 Jun 2018 13:21:03 -0400")
Message-ID: <xmqqy3fi5ygz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A couple comments if you happen to re-roll...
>
> On Wed, Jun 13, 2018 at 10:22 AM Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>> The buffer being passed to zlib includes a null terminator that
>
> On this project, the character mnemonic "NUL" is typically used, not
> "null" or "NULL" (which is typically reserved for pointers), so:
> s/null/NUL/g

Correct but I did not think it is a per-project preference; rather,
"NUL is the name of the byte" is universal ;-)

>> diff --git a/packfile.c b/packfile.c
>> @@ -1433,6 +1433,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
>> +       buffer[size] = 0; /* assure that the buffer is still terminated */
>
> I think we normally use '\0' for NUL on this project rather than simply 0.
>
> The comment is also effectively pure noise since it merely repeats
> what the code already states clearly (especially when the code says
> "buffer[size] = '\0';"), so dropping the comment altogether would be
> reasonable.

Both are sensible suggestions.  Thanks for making them.

