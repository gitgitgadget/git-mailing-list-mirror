Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1FC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 07:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiADHaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 02:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiADHaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 02:30:00 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA1C061792
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 23:29:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id y9so3502278pgr.11
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkHNWQPcfV+bAZuwf57gjA7t3YAn88WW75XZeWmGVsU=;
        b=OTTbrKstFEuiqfcrxHI9A2GjGVBV4LDORtPTrnrbktJ2auS11H1F/vssGwFzqiyZGR
         TKnkgXHxCLk38T3Qnm+HFqdZmLne/jyAGt2ZIIOZs3bLektdxtAh5VuycREiSsrjlk0O
         v1H8k2bwrXIbzoAyjs5sshi0UeJoCgHp73SMyiB3v2Sa2/EoE5q3SE86Mf6LjkBgbxBd
         eV/1f4zLdKECSLY+4Gaq8+u71AMkMmU6OPEyT4NkGGkcLRkbaWSll72G2PyHPmRYH5EJ
         6CRZouxYJY/tbN9rom2Z3fFrrYgxUmSAxNQSj0Y3SpV8knkAANMPZPL0IKGYZ8swEeQ/
         suAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkHNWQPcfV+bAZuwf57gjA7t3YAn88WW75XZeWmGVsU=;
        b=wTxa76jwnEW4QTC9dhGuM51zTNNCIhLMsNVjbMNprf42xmn/8hKtt4ecOA+TZSoHw0
         SUpvuVrm2QdfTGz4tyzuov0Ib1BNa4SPrA/fr2OlNT5A2qTf9jx9/0qO6D11k3996SAj
         iOxARBFqLV1r9/c+xQyLP9pIvdg5tfDGbODAByd7pfHvkPFAvxoQoypuNQWV3XIAs7Sy
         o5VH4VGmtx3pwlRXfvAdi/jVNxw9INbLFahYJwQIiv1Gdkq7r6TlHe+hQdGQ81jQ5UHk
         Dg3h/tLpkq60ijDMiQxQw8EaktMQbzgX2G4Tmtx4+0/1rfi7CW4OVtHwNZZwR3h6/9eu
         suGw==
X-Gm-Message-State: AOAM532oaSF5A0h4SdtyokfQWXExrtua0z/lZfmOlXakQHPRmaQqaiM2
        Fe7LEXbJdBz8s2TGJ9SCYkA=
X-Google-Smtp-Source: ABdhPJzWv1wCccEuVsZm1aoEMRHgilFx2+vI2xbQ64lV68l/3FdXVLmiJPs22GyvKyDAT3yfUU+CzQ==
X-Received: by 2002:a05:6a00:88f:b0:4bc:3b4e:255a with SMTP id q15-20020a056a00088f00b004bc3b4e255amr25593224pfj.79.1641281399227;
        Mon, 03 Jan 2022 23:29:59 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id ls6sm44472292pjb.33.2022.01.03.23.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 23:29:57 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 6/8] ls-tree.c: support --object-only option for "git-ls-tree"
Date:   Tue,  4 Jan 2022 15:29:51 +0800
Message-Id: <20220104072951.10153-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.398.gc70192232f.dirty
In-Reply-To: <xmqqh7akgutd.fsf@gitster.g>
References: <xmqqh7akgutd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The resulting code looks unnecessarily complex and brittle; some
> SHOW_FOO mean SHOW_FOO_ONLY_AND_NOTHING_ELSE while other SHOW_BAR
> means SHOW_BAR_BUT_WE_MAY_SHOW_OTHER_THINGS_IN_LATER_PART, and the
> distinction is not clear from their names (which means it is hard
> to later extend and enhance the behaviour of the code).

I agree with you that the relevant code is not very clear, So I
think I will take these steps:

1. Rename "shown_bits" -> "shown_fields"

   essentially we want to show the fields but not bits to user that
   may firstly solve the unclear nameing problem for "shown_bits"
   itself.

2. Rename related macro definitions of "shown_fields by :


	   SHOW_FILE_NAME -> FILE_NAME_FIELD
    	   SHOW_SIZE -> SIZE_FIELD
    	   SHOW_OBJECT_NAME -> OBJECT_NAME_FIELD
    	   SHOW_TYPE -> TYPE_FIELD
    	   SHOW_DEFAULT -> DEFAULT_FIELDS

    I think the confusion comes from " SHOW_FOO_ONLY_AND_NOTHING_ELSE"
    and " SHOW_BAR_BUT_WE_MAY_SHOW_OTHER_THINGS_IN_LATER_PART" is
    because some macros's is named by mixed the "flags" and "the
    operation of flags" together. 

    So with renamings, we try to unify these definitions meaning,
    they are just used for defining a "field" with a specified
    non-repetitive bits.
    
    After that, you can show many "fields" by combining any of "fields",
    such as what the builtin "DEFAULT_FIELDS" does, it shows all the
    fields but except the "size" field.

    By far, the "field(s)" only means the definition themselfs, and
    no business with "which one/ones" or  "how" to shown.

3. Decide "which" fields need to show

   The definition of "WHICH_FIELDS_TO_SHOWN" is by "shown_fields",
   it's used for parse from the options and compute it's value
   by function "parse_shown_fields()".

   Actually, the function already represent what work it do,
   but the problem is I didn't notice to rename "show_bits"
   to "show_fields" before. This may bring some confusion,
   because we are not going to show the bits but the field(s).
   So, I will do the <STEP.1>.

4. Decide "How" fields to be shown

    Now we have already know the field(s) we care about, next
    step is to show the fields.

> > +	if (!(shown_bits ^ SHOW_FILE_NAME)) {

> Is the use of XOR operator significant here?
> 
> I.e. "if (shown_bits & SHOW_FILE_NAME)" would have been a much more
> natural way to guard "this is a block that shows the file name",
> than "the result MUST BE all bits off if we flip SHOW_FILE_NAME bit
> off".  If various SHOW_FOO bits are meant to be mutually exclusive,
> then "if ((shown_bits & SHOW_FILE_NAME) == SHOW_FILE_NAME)" would
> also make sense, but as I said upfront, it is unclear to me if
> shown_bits are meant to be a collection of "this bit means this
> field is shown (and it implies nothing else)", so I dunno.

    Not significant. Both work and It's all right for me. Your
    readability is better, and now I know how to handle this
    situation better.

    E.g, if we only want to show a "filename" field
    (with `--name-only`), we will use a way like
    "if ((shown_fields & FILE_NAME_FIELD) == FILE_NAME_FIELD)"
    to judge this situation.

    And if we want to show fields in a builtin way
    (as described in 'git-ls-tree.txt', default output format
    is compatible with what `--index-info --stdin` of
    'git update-index' expects.), we will use "DEFAULT_FIELDS"
    instead.


I am not sure if this solves the problem you are considering as I
may misunderstand, I can quickly finish this new patch and we can
look at it then。

Thanks.

