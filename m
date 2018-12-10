Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDA320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 06:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLJGsd (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 01:48:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43373 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 01:48:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so9201660wrs.10
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 22:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YdiS1TpYWLyS0tcnH5e5JX2IRW9VPb73dQ9huN8R3Kg=;
        b=SYPf2H3cB6AJLdtSoKl9SttiS9RFBLizVyYxret7bqV8BFs+iylBSFjBdMxUYrEhvA
         J/eA/9SvmA/saMIjdkk8KRWqFqF2T/KqlboN8X8Y22wub8GwxbdQVb1J4oxQkyz6JnIt
         k/7BrhoYlcctU48uAGeFA6xczHdeQIYfqMME/wVDl7UWHi8C4AH31jN2ICBFk4ioLiwM
         imEp/BJrihl3WpnlSVRncgUw7X3HdrpngNLHbVLusTCG/+BHETOGEodD8053NtR4Gy8n
         LvlrGW/inx39DCCUu2Dn28/YBkUa/iT1ucX3mQRgTl+KopxWBl4G9Zkj8dQn4Z9RWhEu
         PzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YdiS1TpYWLyS0tcnH5e5JX2IRW9VPb73dQ9huN8R3Kg=;
        b=qGJPbgw8trfxlZdU3CztX+qh+xxjll8Drk6sTSRvsTnEMojy98kBkhLxWS5XXBu4VE
         meREd1Rh6KohB5gJvQeDsyTdfiRhwzJwiocGiG6l0+cYT2JYsaSzbcOC9MSYOE0kS8RV
         Woir71vVn0FKr91Kdhv1YQRhnwWRzaQeBB5Ka0k2lQv3AgiMrEo5udEL0KxBxy0Kuo8G
         csz3X8D9jlC+L2cbUTUhGB2IStx57Yn7vQtxyPhq69+9+xph098oKrBdHB9nxJFHlUwB
         0m/nHqMD+BvvGM4qpqemV5XBoeugp9GWki1ah5mGiZ+LLs9mqaCx9dG686vPBvZ2U0tD
         /Vnw==
X-Gm-Message-State: AA+aEWauoubn7dAz3LeL5WmDU8a3TCarkhBdwutx1P6KE7+8s5IgUbtg
        o0eZrLo3pMUtxyFTsUotPVY=
X-Google-Smtp-Source: AFSGD/Up3Y+2Y6didO/dvjqtCLAInzFJMF+R2l05yC8QW2cuBQ0c73N6R5rOz2wpNmoN9Q4MhlwL4Q==
X-Received: by 2002:adf:b649:: with SMTP id i9mr9117251wre.70.1544424509820;
        Sun, 09 Dec 2018 22:48:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h2sm7051942wrv.87.2018.12.09.22.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:48:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com>
        <20181209230024.43444-2-carenas@gmail.com>
Date:   Mon, 10 Dec 2018 15:48:28 +0900
In-Reply-To: <20181209230024.43444-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 9 Dec 2018 15:00:23 -0800")
Message-ID: <xmqqpnu9khc3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> JIT support was added to 8.20 but the interface we rely on is only
> enabled after 8.32 so try to make the message clearer.

Could you add some word before 8.20 and 8.32 (e.g. "pcre library
version 8.20", if that is what you are referring to, and if 8.32 is
also taken from the same context, adding such phrase to clarify the
context only to 8.20 is sufficient)?

> in systems where there are restrictions against creating executable
> pages programatically (like OpenBSD, NetBSD, macOS or seLinux) JIT
> will fail, resulting in a error message to the user.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---

The change to the code looked sensible.
