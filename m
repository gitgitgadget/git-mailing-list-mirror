Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F6CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A2C611CA
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbhIQJ3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbhIQJ3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 05:29:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E5C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:27:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z94so27490649ede.8
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SrhH2V2dAOXlSTqKuz2pLTHMbTXDy1/RZYhLD3VLds0=;
        b=ZvOwaPEMXxQJ6rZ9s4DFE9TMlyIfEUYbl/zAAocG8wPfbpfkgDAjS6i+vB7DKUgj+I
         YBpcE9HcfuQBHTIy26Gl1tcPZM6ptFWxRx/s9Pgxc0fM7b8MXLPwN1FaeqhfhwypISUT
         t+JfkV7BP/oBe3sU+ipXFgP5Uxgm7Z4j2ztSzzVL4Wlog16V8Dn8csp2AjThfnZJKlqZ
         EA6mxd1lAv2H25HfOOpvvbxe0yd/TpR4CyyI4ue0eaN0Vpzc/Q7lVRlbEc9inIQU8GGM
         1L05n1rPck6Fw1Y+DH+XqwJAfSSBU0HJKq5V/pVP0UGXKGNHzBBufcKELGsXrl1Pcz2w
         dRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SrhH2V2dAOXlSTqKuz2pLTHMbTXDy1/RZYhLD3VLds0=;
        b=8HWSi+XPwVbVn/TuItOq/hJHzr/10nXU4uUKaPHXch4gZoizmenOOF2UGaIDr/ii4T
         fGqp2/LCFqp9FH3bjGbi/3HvOSFfkO4ugUWLeba7i1Zj2IYNSc8Y4RNYmr/xxAtBOkhN
         34UUFS5a3UpgRyb+IeL6LgW7bZrJtlNCm5U1EZrXXJT4Pj1mV+VDrV+7GxUMT9VNSj+W
         imHnBrtn5Yxi/IDNWok2na5OLvBaNHF5gcxqc4FRDfNMCrbou66PUTcp11rnyTf+yEbs
         zX0EmoqdLMVT8jZ5SOY5LIVoo88fSKVWf0t69d811Ll0zZGJv+B4b0bSdmVZn0siy1AP
         +YaA==
X-Gm-Message-State: AOAM531o9/C/Knwe8FGPL5uiOdo/f9paiNsGIIvpZAes5gWEWTX6Wy21
        IwsWw8SGHnIv1aTolTniJLY=
X-Google-Smtp-Source: ABdhPJyljIFpgcWYiL+z4zFpDOapAPa3O0+WZtV87CH3hQuP0Froi50iAO92z2MHExpQHXhJxiXf5w==
X-Received: by 2002:a17:906:2a44:: with SMTP id k4mr8997719eje.328.1631870864471;
        Fri, 17 Sep 2021 02:27:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u19sm1137211edr.15.2021.09.17.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:27:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 01/22] fsck tests: refactor one test to use a sub-repo
Date:   Fri, 17 Sep 2021 11:27:19 +0200
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-01.22-ebe89f65354-20210907T104559Z-avarab@gmail.com>
 <YUOds4kcHRgMk5nC@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUOds4kcHRgMk5nC@nand.local>
Message-ID: <87tuijeels.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 12:57:56PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Refactor one of the fsck tests to use a throwaway repository. It's a
>> pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
>> teardown of a tests so we're not leaving corrupt content for the next
>> test.
>
> OK. I seem to recall you advocating against this pattern elsewhere[1], but
> this is a good example of why it can sometimes make writing tests much
> easier when not having to reason about what leaks out of running a test.
>
> [1]: https://lore.kernel.org/git/87zgsnj0q0.fsf@evledraar.gmail.com/,
> although after re-reading it it looks like you were more focused on the
> unnecessary "rm -fr repo" there and not the "git init +
> test_when_finished rm -fr" pattern.

I was referring to a different pattern there, replied in some detail at
https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/

>> -test_expect_success 'object with bad sha1' '
>> -	sha=3D$(echo blob | git hash-object -w --stdin) &&
>> -	old=3D$(test_oid_to_path "$sha") &&
>> -	new=3D$(dirname $old)/$(test_oid ff_2) &&
>> -	sha=3D"$(dirname $new)$(basename $new)" &&
>> -	mv .git/objects/$old .git/objects/$new &&
>> -	test_when_finished "remove_object $sha" &&
>> -	git update-index --add --cacheinfo 100644 $sha foo &&
>> -	test_when_finished "git read-tree -u --reset HEAD" &&
>> -	tree=3D$(git write-tree) &&
>> -	test_when_finished "remove_object $tree" &&
>> -	cmt=3D$(echo bogus | git commit-tree $tree) &&
>> -	test_when_finished "remove_object $cmt" &&
>> -	git update-ref refs/heads/bogus $cmt &&
>> -	test_when_finished "git update-ref -d refs/heads/bogus" &&
>> -
>> -	test_must_fail git fsck 2>out &&
>> -	test_i18ngrep "$sha.*corrupt" out
>> +test_expect_success 'object with hash mismatch' '
>> +	git init --bare hash-mismatch &&
>> +	(
>> +		cd hash-mismatch &&
>> +		oid=3D$(echo blob | git hash-object -w --stdin) &&
>> +		old=3D$(test_oid_to_path "$oid") &&
>> +		new=3D$(dirname $old)/$(test_oid ff_2) &&
>> +		oid=3D"$(dirname $new)$(basename $new)" &&
>> +		mv objects/$old objects/$new &&
>> +		git update-index --add --cacheinfo 100644 $oid foo &&
>> +		tree=3D$(git write-tree) &&
>> +		cmt=3D$(echo bogus | git commit-tree $tree) &&
>> +		git update-ref refs/heads/bogus $cmt &&
>> +		test_must_fail git fsck 2>out &&
>> +		test_i18ngrep "$oid.*corrupt" out
>> +	)
>>  '
>
> This all looks fine to me. The translation is s/sha/oid and removing all
> of the now-unnecessary test_when_finished calls.
>
> But the test_i18ngrep (which isn't new) could probably also stand to get
> cleaned up and converted to a normal grep.

Thanks, I missed that one!
