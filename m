Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3684E7B60F
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbjJDNCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjJDNCn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:02:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3D98
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:02:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8198ca891fso2153712276.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424559; x=1697029359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtvRlzUGKCeBIRi6rumpIE4MgEt7E1JgFxqMfkXm80o=;
        b=N9Gq/IKdY7cuym/gXY1chg3nrQfTDXs6beUesbnZpLrh5vFEj1KCyNu0WSzhLQVXJI
         Nh1x01QcPj+aErZIMR6a8TQUvsXnPQMh9iMKmzqDiGZ8sqryxntsEEfwco4oYlhwSQg7
         sw/jktkIMYlVpnYmwECxFSWKVXXMccDLDZfboeSSEPIvqT5Rigf7nG+RrTjyFGcVIV/c
         8hYLOYz5lsmbwUIkE8O28R4+k35UsNzpN01NcWmcszBlKlz5YlvBqfaTtMpHEWS8sHPT
         3lVfFjcEhEsd4fen+BpyFy5lt3Hj73i40AGmZ3BtG1uDq69FXd1y+XrDqhHM6/eKjZ5Y
         4ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424559; x=1697029359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtvRlzUGKCeBIRi6rumpIE4MgEt7E1JgFxqMfkXm80o=;
        b=a/IQW+gPNhiugT1EgM6vWVxbhWtq98cyRYyQ8C7G4eZlVhNAKHxwCba4nGmQlQpQbt
         aPsk6QK5dCWnSqKh3/kqbbaTGgPDP9QMnChGBrkaxQBj5YPOJAAv6MyAavFzoXiK1OtN
         33kXjVaSYti84cBlu7jtIaJhYf4VlfLSXgO/oK1HUDDJf8kBTTGP3gRc5Q4ecVQAEg/E
         +vhHako5Sh7SyxX3/wDUt4xuOPDPv17XyvZEq/ivtKYlxcp1/HRUlpfHwtkNLhrLJ35m
         jLn8+H3lwo+FGfbTrIA5Fr3WAG0JE2M8cp3Y9pBQxU3/Hyky847F7xtQiP0RPdSbXZE+
         YKww==
X-Gm-Message-State: AOJu0Yxb9K831P+kVTg4fuTu/lUva3eFAw69SErx/uHP2cphVJqc9tzl
        Tu4528W2O8Jsy6ztoh4QbwwDYJ6UfFH1TDlE94E04lgN5yI=
X-Google-Smtp-Source: AGHT+IE+IpukUY4e0g+IEgJ4x+bOquHyQAl7nyWULaQ2My/r9ZeaETFJpS1APBGa7G9xNcAMMYFo1DasHVu0+cRq8XI=
X-Received: by 2002:a5b:285:0:b0:d7b:9d44:7574 with SMTP id
 x5-20020a5b0285000000b00d7b9d447574mr1756131ybl.64.1696424558701; Wed, 04 Oct
 2023 06:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
 <20230925154144.15213-3-worldhello.net@gmail.com> <xmqqa5t9rkft.fsf@gitster.g>
 <ZRKax7Me5uIHKHoC@ugly>
In-Reply-To: <ZRKax7Me5uIHKHoC@ugly>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 4 Oct 2023 21:02:25 +0800
Message-ID: <CANYiYbHp-3YuSPHnR8gjS40UJLrJV5FPzqd_BtjyR8TAALhfRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pkt-line: do not chomp newlines for sideband messages
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 4:48=E2=80=AFPM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
>
> >Jiang Xin <worldhello.net@gmail.com> writes:
> >
> >> +++ b/pkt-line.c
> >> @@ -462,8 +462,33 @@ enum packet_read_status packet_read_with_status(i=
nt fd, char **src_buffer,
> >>      }
> >> +                    case 2:
> >> +                            /* fallthrough */
> >> +                    case 3:
> >
> while not entirely unprecedented, it's unnecessary and even
> counter-productive to annotate directly adjacent cases with fallthrough.

I see in "blame.c" there are directly adjacent cases like below. I
will remove the fallthrough statement.

        case 'A':
        case 'T':
                /* Did not exist in parent, or type changed */
                break;

Thanks.
