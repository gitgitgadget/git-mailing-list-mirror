Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 07:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiGUHMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUHMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 03:12:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F287B1DA
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:12:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g1so991943edb.12
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kk2g6WldC1gZ97MqSGEiGei08Oosto57EPqV0zC2cvo=;
        b=gt/6GGNMniCfUWFx7BuLZWgLgp/3FPNuUc18NwjCOy+T1kUsu5rqXdUjhkrVCRXOoG
         XUAeJJdgOdJeqxc/pf7qCOPmsCZvUFe96NrptAUE9B6mNZFfm55sbgOSDOAP03fQW/BD
         WdtULIRH3Ja9CznsoUrk4MQ6X7zW6XkQDjVlWPJPvpbGEZA7hRR/kY6PoEHCIJOWCPqT
         wm1TIjWmZGUhKmbVkOzDHI2+ZBc9COgGxmC7dcpLbYZTRHFfvZcCnBTJNjlQbzsjX6lg
         EnZqOcijU4OrjJFTcixp8VNWAY5u3ncEfRgIWhWMzu9Y1lkKGlkuyTknNVnMzlmxMKVh
         c57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kk2g6WldC1gZ97MqSGEiGei08Oosto57EPqV0zC2cvo=;
        b=lXJ2XvdsJcYGJics43m5BIbWv/gvnXDtAX/GJ9DOJT2MZzblECIBegVlpIjw3MjzGx
         +XWvXLioa14o4VFkqJUrCfz20UgFqUfumxUvDWqiWoi835WORNGNRNR2V4PgPDmIjRHe
         EaN3PBa0e4JZJ9qipNNRbIKLc4YQl/3jLJNNQekIw8v558LPpjCz9jp3lvzfvZmH8Ifr
         MIyMFYvlbeUy/rryZOtpnPFGvjt1kDV6geUHuE5nAokcUPiWZG15+UNKUdcUfgGfn7LS
         UANxJSg5Od/PwCJ1KbOfYiDc/0Ji+qzsZmja+pAIb6c+GWuJg3pjO6ajdcUq21UxvD3m
         97tw==
X-Gm-Message-State: AJIora+ede96CTT1A+EPDHRe3Qk90sONOfXkrBFbcENkwG+IDWxKiCpW
        KVXa4P5IRFeNIsV3f4usBO4=
X-Google-Smtp-Source: AGRyM1tkz5tfnFG5verGoqVHwRLyTXbVjLsRUgjHqTbuYW6agjdicTFK8EZUD1OfdNA72bWccYPpRw==
X-Received: by 2002:a05:6402:2554:b0:43a:902b:d31f with SMTP id l20-20020a056402255400b0043a902bd31fmr54972319edb.416.1658387548956;
        Thu, 21 Jul 2022 00:12:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709065f8b00b0072b51fb36f7sm484260eju.196.2022.07.21.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:12:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEQME-004SBl-GL;
        Thu, 21 Jul 2022 09:12:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 2/8] git docs: split "User-facing file formats" off
 from "Guides"
Date:   Thu, 21 Jul 2022 09:02:00 +0200
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
 <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
 <xmqqlesqqr1v.fsf@gitster.g> <220718.86mtd6w90v.gmgdl@evledraar.gmail.com>
 <xmqqcze0664f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqcze0664f.fsf@gitster.g>
Message-ID: <220721.864jzbueg5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> If we can come up with a word that is more appropriate than
>>> "format", it would be great.  If we do not place too much emphasis
>>> on "format", I agree that both "gitignore" and "githook" fall into
>>> the same category, because they define how the contents written in
>>> these files affect the operation of Git commands.
>>
>> *nod*, another word would be most welcome :)
>
> True.  What I am absolutely sure about is that the word is not
> "format" X-<.  It is the interface end-users interact with internals
> of Git, with need similar to how "plugin" interfaces need to have
> documentation for their users.

My goal here is just to make this part of our documentation more
accessible, so I don't care about the term. But this series also seems
blocked on you not liking the term, so...

A few ways I can think of to go forward:

1. Use "format", but explain that we're using it loosely. Perhaps with
   this on top?
=09
	diff --git a/Documentation/git.txt b/Documentation/git.txt
	index 1980a0e29cd..9f8d7a3543e 100644
	--- a/Documentation/git.txt
	+++ b/Documentation/git.txt
	@@ -343,7 +343,10 @@ User-facing file formats
	 ------------------------
=09=20
	 This documentation discusses file formats that users are expected to
	-edit. These can also be listed with 'git help --user-formats'.
	+edit. "Format" here refers more broadly to files and/or file contents
	+that the user is expected to edit or know about.
	+
	+These can also be listed with 'git help --user-formats'.
=09=20
	 include::cmds-userformats.txt[]

2. I could submit this without the "git help --user-formats" change for
   now, and just focus on --git-formats:
=09
	Internal file formats and protocols:
	   format-bundle                  The bundle file format
	   format-chunk                   Chunk-based file formats
	   format-commit-graph            Git commit graph format
	   format-index                   Git index format
	   format-multi-pack-index        The multi-pack-index file format
	   format-pack                    Git pack format
	   format-pack-cruft              The cruft pack file format
	   format-pack-protocol           How packs are transferred over-the-wire
	   format-protocol-capabilities   Protocol v0 and v1 capabilities
	   format-protocol-common         Things common to various protocols
	   format-protocol-http           Git HTTP-based protocols
	   format-protocol-v2             Git Wire Protocol, Version 2
	   format-signature               Git cryptographic signature formats

   Do you have an objection to any of those being labeled "format"? I
   understood your comments above to not include those, i.e. that you
   took objection to githooks(5) in particular being in that new
   --user-formats category.

3. A re-roll of this series pretty much as-is (sans other fixes), but
   remove "githooks" from this re-categorization.

4. Come up with s/format/<something>/g, but I have no idea what that
   "something" would be. "Protocol?", After all a secret handshake is
   also a protocol....
