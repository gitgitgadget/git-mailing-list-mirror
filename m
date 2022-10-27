Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D2FA3742
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiJ0T2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiJ0T2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:28:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168067A51D
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:28:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r18so2507906pgr.12
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSoWVF1EQ6VIqjH0uiNsiUY0acOrZuz7ht4J2MzpIDw=;
        b=DDC7jlEJPedvuguz/qxJItkuRJzQRO+IDVU2CnUZAcQm5a2UsUKGsk+BzOpxA/66sE
         l4SU758JfHRutpWg8xCEq4vJfj/Rnwtd4BPy9iA1u2eBy0fTHDZxAT1ZcYxjF92ICv2S
         1gyHWZmBaBih8Qi3BDRumyfUKUywC8NmS2A/4Wp+p0VLPgSgIRbvNs9reB1E5wfjk9GP
         wIDy1wLoF9svN+SwtBRVjzDHLNhGa2C7ssBf1MC2naa/0TSo/eBzVoryP3Cq6j1OmuXU
         633p31Wu0lCXFxn9XBp/uRnWnPYc9zOBM3OKc5POyF7+dmAbzWtz1bwA01AojtqAeJeI
         sbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSoWVF1EQ6VIqjH0uiNsiUY0acOrZuz7ht4J2MzpIDw=;
        b=Wg0dCs6YJHpYUEuSct6yzd2kpKnSsJWbClylrCUOPoeCbVNdkZCIAeKS9XLxYQwafo
         eWGgOS1NRbMhgNKn7JTz9y8d/8KLAzTFr26/tvnQDzjUCtGqWuqiLhdkOwB5ULUtT7Vj
         3gQ+CA5jIFVJMMksCp/cFL0POt5MUII7GiqO1dPnviyWqXGOgkpKb+DBp1XadkVynmbc
         hT6ouhGJtmO7e0LmgTLnjJMXab1ZUtkuQqMCTob7faXGK73VE9QcqccDf+tcj8IKxHMD
         NH8fLhvSBUqBosOKvmKJh/mAaSK1/xv/lt+/xF1/9uiTOj4TmlARgZeS7MBn46SEKwda
         TAjw==
X-Gm-Message-State: ACrzQf3zuph9Y50d5UK2vyLp5UyNGVQa+dRLAA/bbubE6Vmz61nIh/R6
        hKan6fM0p2BBRobTKPtVl5E=
X-Google-Smtp-Source: AMsMyM6YGKps97Ldq0wWHT4ARSBUHb/wd8cgAqBN5A4aB6Xx1L3aUhNizC/m8j9HrsBuBjRe9JX+6w==
X-Received: by 2002:a63:6f89:0:b0:45e:cbb1:732 with SMTP id k131-20020a636f89000000b0045ecbb10732mr42783819pgc.162.1666898879542;
        Thu, 27 Oct 2022 12:27:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b00179e1f08634sm1539364plc.222.2022.10.27.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:27:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 01/10] config API: have *_multi() return an "int" and
 take a "dest"
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-01.10-eefa253ab1f-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:27:58 -0700
In-Reply-To: <patch-01.10-eefa253ab1f-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:14
        +0200")
Message-ID: <xmqqsfj9kqwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> By changing the *_multi() function to return an "int" for the status
> and to write to a "const struct string_list **dest" parameter we can
> avoid losing this information. API callers can now do:
>
> 	const struct string_list *dest;
> 	int ret;
>
> 	ret = git_config_get_value_multi(key, &dest);
> 	if (ret < 1)
> 		die("bad key: %s", key);
> 	else if (ret)
> 		; /* key does not exist */
> 	else
> 		; /* got key, can use "dest" */

It is a good thing to allow the callers to tell "no such key-value
pair exists", "key is malformed", and "here are the values for the
key".  And the above if/else if/else cascade is a reasonable
interface to give the callers for that (modulo that "negative is
bad" should be kept to match our API convention).

>
> A "get_knownkey_value_multi" variant is also provided, which will
> BUG() out in the "ret < 1" case. This is useful in the cases where we
> hardcode the keyname in our source code, and therefore use the more
> idiomatic pattern of:
>
> 	if (!git_config_get_value_multi(key, &dest)
> 		; /* got key, can use "dest" */
> 	else
> 		; /* key does not exist */

I doubt it is a good idea to add such a specialized interface begin
with.  Let's not bloat the API for little benefit.
