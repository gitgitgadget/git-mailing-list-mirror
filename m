Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886EC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhKVVkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhKVVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:40:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C67C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:37:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so83170288edd.3
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j1amtjzdLSi45iPLZ2oSC2OX+MTJKbcmucjIZDpl49Y=;
        b=XR7eDKSUHTD6c/MhFDGU7+ypitAla+/tMaGsu2+3iTmtrv6+ZmqEg50sX08TIRfX61
         h9qOpVk0tgtVfTrfmCzQanv/k1D+SqzpSdTb8MHVbINriRR7LOVhAh3N17ctxA4XhWl9
         FsTWOw0Bj6OMsTz14ln63DFlLtENHnJ2ZO7zvL0zDTiiGT7DEExKcYpo/kkF7aFvp8Vb
         tFg4b4ViruvqlAesK+JHa4Mso4ezbxzgUw3Bdrp8UTuxGUjL1dNckoglrJu60cbzv+d4
         aeDBGoTup+PoQloGMDn7GFCJOoLy4Pxw7FCtL8XIJ+rNM9+otNqCjTMiMJnITgGprnpq
         Zr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j1amtjzdLSi45iPLZ2oSC2OX+MTJKbcmucjIZDpl49Y=;
        b=PEQjzAHAYJ/9IkY5n6usK8fItGehHtgP9RCl4nyq95By5ONEduLpwGLB+AbY7ps9hV
         AUuh9ZskPnGiGGFRvnTMTCQBAWFaaSncC2JYeZcf9X/ablfhZMqiblI+Fd9oepcmwN6W
         asnC69mtMPFhO2xJ/Rt5RO9fE0YLhjAAsXUnakYmHN1zEXLkv4ofyppHEdjVG5NjYR3c
         +0GlYLX9qQIF4b3kzN9Y69mPsjVzC9OkBdUamRLmZh3iHksYYSp9e+0R4B+ZNxjKIXFO
         /blSC5BN2A44Q3LlluiG1b1ISc2vGtoiSewTFsGiPO7zv/wiirYN1Vg5dGmMtqfTfIV2
         EIuw==
X-Gm-Message-State: AOAM531lLVBE2R/FXDurK3KDYqj1k7aihPDONq4qvm/yk1pYVouyKuAL
        ZHxO6uNGxHLT11UZ3GQ2mLk=
X-Google-Smtp-Source: ABdhPJwpxTg7MkDsD88ZENDl1NecVcpesoEEunywG2oUulr2VHr5UZva8G+kLpu/ozlzTZN3zqjXXg==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr411567eds.176.1637617022257;
        Mon, 22 Nov 2021 13:37:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z25sm4204506ejd.80.2021.11.22.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:37:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpGzl-001C0X-7W;
        Mon, 22 Nov 2021 22:37:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 2/5] upload-archive: use regular "struct child_process"
 pattern
Date:   Mon, 22 Nov 2021 22:36:31 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
 <211122.86fsrnyko4.gmgdl@evledraar.gmail.com>
 <YZwHNkf2l9uPrIJv@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZwHNkf2l9uPrIJv@coredump.intra.peff.net>
Message-ID: <211122.867dczyirm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Jeff King wrote:

> On Mon, Nov 22, 2021 at 09:53:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> But as to skipping the "argc > 1" test I've got this still:
>>=20=20=20=20=20
>>     @@ -89,9 +89,11 @@ int cmd_upload_archive(int argc, const char **arg=
v, const char *prefix)
>>              * multiplexed out to our fd#1.  If the child dies, we tell =
the other
>>              * end over channel #3.
>>              */
>>     -       argv[0] =3D "upload-archive--writer";
>>             writer.out =3D writer.err =3D -1;
>>             writer.git_cmd =3D 1;
>>     +       strvec_push(&writer.args, "upload-archive--writer");
>>     +       if (argc > 1)
>>     +               strvec_pushv(&writer.args, argv + 1);
>>             if (start_command(&writer)) {
>>                     int err =3D errno;
>>                     packet_write_fmt(1, "NACK unable to spawn subprocess=
\n");
>>=20
>> We'll segfault if we give NULL to strvec_pushv() so we still need that
>> check. Were you thinking of strvec_pushl(), or am I missing something?
>
> We wouldn't be giving NULL to strvec_pushv(). We'd be giving argv+1,
> which is guaranteed non-NULL, but may point to NULL. In that case the
> loop condition in strvec_pushv() would turn it into a noop.

D'oh. Thanks. Yes I was stupidly conflating a case where I'd tested it
with strvec_pushl() and moved that dereferenced version to
strvec_pushv(), sorry.
