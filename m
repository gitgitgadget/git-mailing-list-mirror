Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BBC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiBBLB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiBBLBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:01:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78977C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:01:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m11so41148193edi.13
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vjmOxKIXf35SS8R02DMbL9Df1Nkld0m7Rp+j0ROneh8=;
        b=V1Catt1x/jKY37d1rByA+Fef5OMWUk6qxL4jzPbRN2KPSpPAMyw0o2hpkfJn2Rm8GO
         nD82+MN/skm+pTaSMz6bvZqmZWiC4Mu/BI4EKlEKt14sDjFWMkS8+IiwlLAtN8hDfK+H
         QoGRhWZm+zp8eZtmZlpFbH2c4UKQJiFxIAy/4bycCPKjauW3bCvzYz7IBKtRMJ+a4Lto
         RTaDh5njXQkutOSQSfT8fcDCv8irjneLNtbA1yEXJSwKwUs6O7vAwJ4ir7epYhl2Yde8
         Vq8wzaJdkazCCPIMSCNn2103eyMmr4Z+T0Lj+9HkMTjPiQcUqTl2wKjhmVmIDIstTYSm
         SFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vjmOxKIXf35SS8R02DMbL9Df1Nkld0m7Rp+j0ROneh8=;
        b=gi6OACkE5I4xuauJ5ifizoyrBbhXQDWJPhu+U7N9Zni8qyfT+x8UnPAz4MQTsSI+nN
         wC0SDyQvnmtCa42Pvgy9fZIwYNQUG+Nh3NYMdVsomHeW7Rmj4+pKghAm3/xXnOHcF+PX
         qjgqtI+MREdkVQR5TcrK9z9VuJH8glB4bNmz+6qCa7f6Dk5+ivRR0d8W+Cncf9wgtEzD
         mXtuayJkk+oSGIK64sQ0fAX1ma8EU2ckLARTIfXXQUg9QbjtQ6WVcB51ImXsn6CUcpRW
         qFp/IaTloWppqim8RiO0Ip3i5oKoRCJHBtWxqM5qlAm4ZnjZ1XIG6LlPeOTterEh0d0j
         UBoA==
X-Gm-Message-State: AOAM530VXwcykM/mP9YX2lCeMn4enyff2EYubuj8+B+Ou/L5ZjwfXEel
        pt0MYZp3CzwBNUfeU7NWjje4GBb+mQUDGA==
X-Google-Smtp-Source: ABdhPJw90N/bPkJg36MIENkl+1a/xg5bwRDTnIZ2cp/d23LAVzDYkLU7B446leqb886IOduclt2f0A==
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr30046846edt.33.1643799683410;
        Wed, 02 Feb 2022 03:01:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w6sm6949588edd.50.2022.02.02.03.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:01:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFDO6-004Vwo-10;
        Wed, 02 Feb 2022 12:01:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v9 0/5] unpack large blobs in stream
Date:   Wed, 02 Feb 2022 11:59:47 +0100
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
 <20220120112114.47618-1-chiyutianyi@gmail.com>
 <220201.86wnie8eg0.gmgdl@evledraar.gmail.com>
 <CAO0brD2Pe0aKSiBphZS861gC=nZk+q2GtXDN4pPjAQnPdns3TA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAO0brD2Pe0aKSiBphZS861gC=nZk+q2GtXDN4pPjAQnPdns3TA@mail.gmail.com>
Message-ID: <220202.86czk58rcu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Han Xin wrote:

> On Wed, Feb 2, 2022 at 5:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>>
>> On Thu, Jan 20 2022, Han Xin wrote:
>>
>> > From: Han Xin <hanxin.hx@alibaba-inc.com>
>> >
>> > Changes since v8:
>> > * Rename "assert_no_loose ()" into "test_no_loose ()" in
>> >   "t5329-unpack-large-objects.sh". Remove "assert_no_pack ()" and use
>> >   "test_dir_is_empty" instead.
>> >
>> > * Revert changes to "create_tmpfile()" and error handling is now in
>> >   "start_loose_object_common()".
>> >
>> > * Remove "finalize_object_file_with_mtime()" which seems to be an over=
kill
>> >   for "write_loose_object()" now.
>> >
>> > * Remove the commit "object-file.c: remove the slash for directory_siz=
e()",
>> >   it can be in a separate patch if necessary.
>> >
>> > Han Xin (4):
>> >   unpack-objects: low memory footprint for get_data() in dry_run mode
>> >   object-file.c: refactor write_loose_object() to several steps
>> >   object-file.c: add "stream_loose_object()" to handle large object
>> >   unpack-objects: unpack_non_delta_entry() read data in a stream
>> >
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>> >   object-file API: add a format_object_header() function
>>
>> I sent
>> https://lore.kernel.org/git/cover-00.10-00000000000-20220201T144803Z-ava=
rab@gmail.com/
>> today which suggests splitting out the 5/5 cleanup you'd integrated.
>>
>> I then rebased these patches of yours on top of that, the result is
>> here:
>> https://github.com/avar/git/tree/han-xin-avar/unpack-loose-object-stream=
ing-9
>>
>> The range-diff to your version is below. There's a few unrelated
>> fixes/nits in it.
>>
>> I think with/without basing this on top of my series above your patches
>> here look good with the nits pointed out in the diff below addressed
>> (and some don't need to be). I.e. the dependency on it is rather
>> trivial, and the two could be split up.
>>
>> What do you think is a good way to proceed? I could just submit the
>> below as a proposed v10 if you'd like & agree...
>>
>
> Yes, thanks for the suggestions, and I'm glad you're happy to do so.

Willdo.

>> 1:  553a9377eb3 ! 1:  61fcfe7b840 unpack-objects: low memory footprint f=
or get_data() in dry_run mode
>>     @@ Commit message
>>          unpack-objects: low memory footprint for get_data() in dry_run =
mode
>>
>>          As the name implies, "get_data(size)" will allocate and return =
a given
>>     -    size of memory. Allocating memory for a large blob object may c=
ause the
>>     +    amount of memory. Allocating memory for a large blob object may=
 cause the
>>          system to run out of memory. Before preparing to replace callin=
g of
>>          "get_data()" to unpack large blob objects in latter commits, re=
factor
>>          "get_data()" to reduce memory footprint for dry_run mode.
>>     @@ Commit message
>>
>>          Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>>          Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
>>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>>
>>       ## builtin/unpack-objects.c ##
>>      @@ builtin/unpack-objects.c: static void use(int bytes)
>>     @@ t/t5328-unpack-large-objects.sh (new)
>>      +
>>      +test_no_loose () {
>>      +  glob=3Ddest.git/objects/?? &&
>>     -+  echo "$glob" >expect &&
>>     -+  eval "echo $glob" >actual &&
>>     ++  echo $glob >expect &&
>>     ++  echo "$glob" >actual &&
>>      +  test_cmp expect actual
>>      +}
>>      +
>
> I have a small doubt with this, it works fine with dash, but not
> others like zsh. Wouldn't
> it be better to do compatibility, or would it introduce other issues
> that I don't know?

Ah, I hadn't spotted that zsh issue. I don't think the test suite will
run on it in general, but in any case I'll fix this.

There's a few other tests that do this just by piping "find" to "wc -l",
it's probably better to just follow that pattern. I think the eval
works, but I thought it was a bit unusual/stood out.
