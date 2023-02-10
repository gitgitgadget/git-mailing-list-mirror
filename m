Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B3C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBJKtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBJKtB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:49:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF313125A0
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:48:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q19so4428961edd.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emfHuuLnMIuiKVCSe+gNib1569uhkOfaOnp9SceOE5g=;
        b=SQjvF7lZRLa0+V2/QbCgV0Fhnhzgu1L836VZ0yU12ywW7eZoaebUX767xb2fOvohGB
         mhMPSuk44/wOLKeFFqdiZZ4oppr1WkYqqGPHpc0U6QRoPN3pAcbZbE7egvGQMJRdTW7T
         Qo9OaVnnhtObNMSpAu4mN6r8Soc1zuucmwNn4RLzSKzXe9BcYaWWPReteL2zNv2RuHRK
         akXcl1iQomzLscqTGfrhBownqY3YieJA0vqNJVYLVdQOEUzfTlSufp+Ad9/7xl/8Vkug
         lkwkNNAupCaoacySqmqYhtXTEJDcO90Z2ylK4QoDp/qBGz6Z0BG8wMPlXgUlIQ2XUZz7
         IRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emfHuuLnMIuiKVCSe+gNib1569uhkOfaOnp9SceOE5g=;
        b=A4ziCYFMiWs4bL30G27Gq5ux2hRmbSXj1ctNZvzZvUaoFNoMGCBkhcBBjMiK57a6LD
         9gikEb466NDOEKVMPxXXVeg6OdbQhJLiybd8OeKMmAPoFvSyRGSB45xc1+AIPRVPYe+c
         Zrw1G3DxlVb5haIvQBYh2jw5hSA1uZwsXMHfKAtBJo/lDXAHWFNepzxoXeu73pOzytZV
         Nz35QgMM8aYiSSo95b23L8YRS6xI6b4PapcHOLHLJuXk0DAbNQNOuouUccP9Qc+zUDNz
         APv39eQAhU2R7J3LmU9Y9/6H+09/lXwPmeaC8G/GLExKjnPRFHfT34STAuJoJPL8qfx6
         TTzA==
X-Gm-Message-State: AO0yUKW3RfJLKmUKEsXIc4iMhkpxqNyWTTWJrM8CWXUX1+AdtG1+aMKK
        TL2/naVLBiliREiFItVOcuE=
X-Google-Smtp-Source: AK7set9Ei0jxCyRTl1MlYZghWSmgCtQLBYPsiXwQnCNSqq5oT+WiM59xcbAX8iD0PSFY7jw6THJPnw==
X-Received: by 2002:a50:8e12:0:b0:4aa:a4f7:fa17 with SMTP id 18-20020a508e12000000b004aaa4f7fa17mr15807719edw.11.1676026138381;
        Fri, 10 Feb 2023 02:48:58 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id k2-20020a508ac2000000b00499b6b50419sm2002073edk.11.2023.02.10.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:48:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQQxd-001rPS-13;
        Fri, 10 Feb 2023 11:48:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Max Gautier <max.gautier@redhat.com>
Subject: Re: [PATCH 0/2] gpg-interface: cleanup + convert low hanging fruit
 to configset API
Date:   Fri, 10 Feb 2023 11:29:31 +0100
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net>
 <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
 <xmqqlel6mswo.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqlel6mswo.fsf@gitster.g>
Message-ID: <230210.86mt5lx0bq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> On Thu, Feb 09 2023, Jeff King wrote:
>>
>>> If the gpg code used git_config_get_string(), etc, then they could just
>>> access each key on demand (efficiently, from an internal hash table),
>>> which reduces the risk of "oops, we forgot to initialize the config
>>> here". It does probably mean restructuring the code a little, though
>>> (since you'd often have an accessor function to get "foo.bar" rather
>>> than assuming "foo.bar" was parsed into an enum already, etc). That may
>>> not be worth the effort (and risk of regression) to convert.
>>
>> I'd already played around with that a bit as part of reviewing Junio's
>> change, this goes on top of that.
>
> What's your intention of sending these?

For them to be picked up on top of your jc/gpg-lazy-init.

> I think we are already in
> agreement that the churn may not be worth the risk, so if these are
> "and here is the churn would look like, not for application", I
> would understand it and appreciate it.  But did you mean that these
> patches are for application?  I am not sure...

I understood your "I specifically did not want anybody to start doing
this line of analysis" in [1] to mean that you didn't want to have the
sort of change that the last paragraph of 2/2 notes that we're
deliberately not doing.

I.e. that we'd like to keep the gpg_interface_lazy_init() boilerplate,
even though we might carefully reason that a specific API entry point
won't need to initialize the file-scoped config variables right now.

I then took your "it is vastly preferred not to do such a change in this
step" in [2] as a note that it was deliberate that the change in 1/2
here wasn't part of your jc/gpg-lazy-init, but not that we shouldn't
follow-up with such a clean-up.

The "on top once the dust settled" in [2] can then be addressed by
graduating your jc/gpg-lazy-init soon, and keeping this in "seen" for a
bit, although I think the changes here (and in particular 1/2) are
trivial enough to graduate soon thereafter.

Given that I had mixed feelings about submitting this now, but Jeff's
[3] convinced me. I.e. the change in 2/2 'reduces the risk of "oops, we
forgot to initialize the config here"' in the future.

But obviously it's up to you whether you pick this up, and you don't
seem especially keen on doing so, so if not I guess we'll just drop
this, but I'd be happy if you did.

I do think that the 2/2 here has the added benefit of making your change
easier to review, and that's why I wrote it initially. I was poking at
your patch to see what behavior changes, logic errors or bugs I could
find in it.

I.e. your end state is that we're reading 7 config variables (I'm
counting the *.program ones as one variable). The 2/2 here brings that
down to just 3. Thus the surface area of potential issues where we don't
call gpg_interface_lazy_init() before accessing the values is reduced.

Which is also I why I opted to send this sooner than later, having that
as a review aid helps others now, and not in a few months.

1. https://lore.kernel.org/git/xmqq5ycbpp8a.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqqpmaimvtd.fsf_-_@gitster.g/
3. https://lore.kernel.org/git/Y+TqEM21o+3TGx6D@coredump.intra.peff.net/
