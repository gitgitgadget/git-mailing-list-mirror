Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4464C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7320716
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2Ww2aT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgA2TPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:15:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40999 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2TPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 14:15:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so566525ljc.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=30RN8W3bcZ5LMXNeHvizGJQ07uEPiQoE0wM31IF3dZA=;
        b=p2Ww2aT+RW86Xxy0X0SpPtpWQUV5SL86sL3+Ku0cbBbKvN15yLPWtPcmek3WwO+Yv4
         dG9EKaG9yEk+YIEqtx8Cqz3SnszaNjP7iapxp0mHqsMhoSNTIcoip5H1e44xyvW9cW+b
         ljxvtyx8Oq9efiKeykx0sfvEvrZ17b7eFEbHEAL/zRTvJt2qYRR7bzTTdbF0n7p9UJMH
         2iTMg2l51jZy5thED8k4vunS22SKfTht3KBK4gaDwJPs66NWdkaO/2EhofYJpWft9+np
         7LuQTkrnRmfO2oK18PeYCIEq6qA5+0XJgOPudKKGhBX8OV+2mxyBTQbep8WSebWvwQov
         Xt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=30RN8W3bcZ5LMXNeHvizGJQ07uEPiQoE0wM31IF3dZA=;
        b=S3fbrLi9yi1WY8rBnCJiD7PkNrwDZy+f34up0LiI2wx72NvFXu1h0KvybE8WsIyLLJ
         PNkQc9qemAvKY2u3S2FbfGoN/NZT0r4gI6m8yfwvJSraxyx2PPro0BjUU2uqWlTeIIRn
         thCHk2JfuSbAw6NMOGGZXefvhtJKAVchUzZrOvYbqZy4w7U1BKN2UP5XWvfY29Raxn1d
         LCCkJgQHj8IotQl6N1WuwrrLEzZs7XC78EgIKAgQsz7NsVpLSaUw3heWliifqVpMSTPJ
         KP0RJy49orAd5jx3JCCWuAVDs4qgXoF0L3w1PlWujhCue0vCAXc4jXT/PMHPhPgRO5If
         HSZw==
X-Gm-Message-State: APjAAAUEEsA5JuwqZcTsbODfAvfK7kE9tTfSRs3xNzjN3w3/UmVgjlRA
        BLp5HU7oQqJsoWiCGKEA2hI=
X-Google-Smtp-Source: APXvYqw/t2etuwERTRz2LHRgG2kVPVONPARVE0hWgQxZz/X1uqEdwQIG5ioWOHP1X1CUi+cLhmNhiA==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr367267ljz.273.1580325321309;
        Wed, 29 Jan 2020 11:15:21 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id k12sm1529983lfc.33.2020.01.29.11.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 11:15:20 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [GSoC] Exploring Previous year Projects
References: <20200129171248.6217-1-shouryashukla.oo@gmail.com>
Date:   Wed, 29 Jan 2020 20:15:18 +0100
In-Reply-To: <20200129171248.6217-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 29 Jan 2020 22:42:48 +0530")
Message-ID: <86k15ars55.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Hello,
>
> I was looking at the previous year projects[1] and a project intrigued me=
, namely:
> "Convert scripts to builtins".
>
> Following from Christian's advice[2], I have decided to focus on my proje=
ct proposal.
> I noticed that various commands such as "git bisect", "git web--browse"(i=
t particularly
> interests me) are still in their "shell" form and will be needed to be co=
nverted into
> their "C" form as per the project description.
[...]
> [1]: https://git.github.io/SoC-2019-Ideas/
> [2]: https://lore.kernel.org/git/CAP8UFD2Fo=3D2suQDLwzLM-Wg3ZzXpqHw-x0brP=
tPV0d4dRsgs9A@mail.gmail.com/

As far as I know, "git bisect" is currently being converted from shell
to C by Miriam Rubio for Outreachy project [3], so I am not sure if it
would be feasible as GSoC 2020 project.

I'm not sure if it would be possible and if it would make sense to
convert "git instaweb" and/or it's helper script "git web--browse" from
shell to C.

I think trying to convert either "git stash" or "git submodule" to C
would make more sense.

[3]: https://public-inbox.org/git/20200128144026.53128-1-mirucam@gmail.com/=
t/#u

Best,
--=20
Jakub Nar=C4=99bski
