Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7AC1F42D
	for <e@80x24.org>; Thu, 15 Mar 2018 19:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCOTVk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 15:21:40 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36617 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOTVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 15:21:39 -0400
Received: by mail-wm0-f47.google.com with SMTP id i194so12575345wmg.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oPhp4Uhl1BCHqMIvZehY82T9N+fM1L4qJImQGfuhN8c=;
        b=dO/vtnSxMq/S5M2apBofFDtz5QuBlRvmgiHrSfOnYOVTSNQ0ApbIDwRxGNrSLKeGVh
         jdyE40DlPEOfheLvQoFW5SsMpfYOyTH5jopOsPBj5SOhGpW05l+wkZ7JWT5oNAjbxyrz
         eIQEHVg6WZO/meL85eISPbo/TIyhv/5mBMPIeJxkECcSTPFnWStm73OhnZd7Evkqscu6
         VncnOpU8zU4xB4iFH6Mg74676ggr0FLOit6qnH6EWC4q39FDozB3zFVzgAdRM041AcJ2
         OB9gqd7EbueIjL/BhJPEU/D4LzOXYkLKrUj9T2wubXBgr2qHi4VMZPRuDovq+hSX08Qv
         JHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oPhp4Uhl1BCHqMIvZehY82T9N+fM1L4qJImQGfuhN8c=;
        b=p+kc8nZ0zFyYSf/XJYiZ6Z/fSHHfrAbdrVUUwUJ/k8vxBNYfNzK8L0D5sglR7E5QRR
         bqOKPRFix1B+pN6V4QkK4PlznU+HZG1TfY/jciXugEewkefVSCrOFoSnx1tGsGPrFjoW
         9sydWTZC513fzSlvLHgTR8H9hyzC06C+yNUrQY3qxDCuSA2DGG2t5F33j1gscHQhkEI1
         raBKwL6h/DS31MmTGeu1ErEbu7kfPErMtElhMPzthbjL9A8zUHGPMuM5Ome7UrmTLgUO
         c4t7vnnrTVN7bB1J6lZyneOq+mAki6kipct9kDcpGmuDSqr0mZWDDn7Uf6C6TG4jLZxl
         SvXg==
X-Gm-Message-State: AElRT7HySBR3w2ySOXBhYNe4+Ad9O9uaBKl0xNQEAa94uA50DQhUv7rh
        /W6QuV4eZWbP+Z5NnxD24J4=
X-Google-Smtp-Source: AG47ELtCWlmkGh7eJ22/85CAHdjrCD1e8wiBQHGy1+T9KRxENEPzOA+ssmi8GsOYcOOXx+1yUXDO6g==
X-Received: by 10.80.144.93 with SMTP id z29mr10096697edz.235.1521141697825;
        Thu, 15 Mar 2018 12:21:37 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l23sm2883353edc.27.2018.03.15.12.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 12:21:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-4-pclouds@gmail.com>
        <87a7vdqegi.fsf@evledraar.gmail.com>
        <CACsJy8DZGa8v6z6c3SUjENMd4h6Qi55iPfsT2c5-cejqv5jA2Q@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8DZGa8v6z6c3SUjENMd4h6Qi55iPfsT2c5-cejqv5jA2Q@mail.gmail.com>
Date:   Thu, 15 Mar 2018 20:21:35 +0100
Message-ID: <87muz9du0w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 15 2018, Duy Nguyen jotted:

> On Mon, Mar 12, 2018 at 8:30 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> We already have pack.packSizeLimit, perhaps we could call this
>> e.g. gc.keepPacksSize=2GB?
>
> I'm OK either way. The "base pack" concept comes from the
> "--keep-base-pack" option where we do keep _one_ base pack. But gc
> config var has a slightly different semantics when it can keep
> multiple packs.

I see, yeah it would be great to generalize it to N packs.

>> Finally I wonder if there should be something equivalent to
>> gc.autoPackLimit for this. I.e. with my proposed semantics above it's
>> possible that we end up growing forever, i.e. I could have 1000 2GB
>> packs and then 50 very small packs per gc.autoPackLimit.
>>
>> Maybe we need a gc.keepPackLimit=100 to deal with that, then e.g. if
>> gc.keepPacksSize=2GB is set and we have 101 >= 2GB packs, we'd pick the
>> two smallest one and not issue a --keep-pack for those, although then
>> maybe our memory use would spike past the limit.
>>
>> I don't know, maybe we can leave that for later, but I'm quite keen to
>> turn the top-level config variable into something that just considers
>> size instead of "base" if possible, and it seems we're >95% of the way
>> to that already with this patch.
>
> At least I will try to ignore gc.keepPacksSize if all packs are kept
> because of it. That repack run will hurt. But then we're back to one
> giant pack and plenty of small packs that will take some time to grow
> up to 2GB again.

I think that semantic really should have its own option. The usefulness
of this is significantly diminished if it's not a guarantee on the
resource use of git-gc.

Consider a very large repo where we clone and get a 4GB pack. Then as
time goes on we end up with lots of loose objects and small packs from
pulling, and eventually end up with say 4GB + 2x 500MB packs (if our
limit is 500MB).

If I understand what you're saying correctly if we ever match the gc
--auto requirements because we have *just* the big packs and then a
bunch of loose objects (say we rebased a lot) then we'll try to create a
giant 5GB pack (+ loose objects).

>> Finally, I don't like the way the current implementation conflates a
>> "size" variable with auto detecting the size from memory, leaving no way
>> to fallback to the auto-detection if you set it manually.
>>
>> I think we should split out the auto-memory behavior into another
>> variable, and also make the currently hardcoded 50% of memory
>> configurable.
>>
>> That way you could e.g. say you'd always like to keep 2GB packs, but if
>> you happen to have ended up with a 1GB pack and it's time to repack, and
>> you only have 500MB free memory on that system, it would keep the 1GB
>> one until such time as we have more memory.
>
> I don't calculate based on free memory (it's tricky to get that right
> on linux) but physical memory. If you don't have enough memory
> according to this formula, you won't until you add more memory sticks.

Ah, thanks for the clarification.

>>
>> Actually maybe that should be a "if we're that low on memory, forget
>> about GC for now" config, but urgh, there's a lot of potential
>> complexity to be handled here...
>
> Yeah I think what you want is a hook. You can make custom rules then.
> We already have pre-auto-gc hook and could pretty much do what you
> want without pack-objects memory estimation. But if you want it, maybe
> we can export the info to the hook somehow.

I can do away with that particular thing, but I'd really like to do
without the hook. I can automate it on some machines, but then we also
have un-managed laptops run by users who clone big repos. It's much
easier to tell them to set a few git config variables than have them
install & keep some hook up-to-date.
