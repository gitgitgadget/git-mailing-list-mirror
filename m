Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71FC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6612D6128E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhGMXy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMXyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:54:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A58C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:52:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so540227edk.9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Audq82nbv/BcvkofB0mHL1Va0YMNRUrSHGuEJRBNDeI=;
        b=VlTrP9hOXoRpaNqr+hTOeRiuQLFHhpIWkTlFZxf09mPfvd9HPUcY8biAvKotgg8GsQ
         c0+h1w/9nJbWrz99JPnIU0y6KA2g9W14N5BNetFts6EMovx8OME+o1fhNMCxrxXTU93E
         uupETJvoRsBCbPZvSqwewPg6FwZcsAz72p19ALw/GSk7zdJhO3g6QgHgbrVaBqCGcpjg
         P2AFsTRvjgUZG9FCP/hspgEseJL4HPl1LFsPsi6g+wY2psPKsslhKvXlNLbdznnqq3Vr
         cbzL9sEJR4aUWVDtlcWmyRLX5QYD34MLqoj6L+LVGHs8zZPCPEqUutqV8CE5d32gajBn
         L7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Audq82nbv/BcvkofB0mHL1Va0YMNRUrSHGuEJRBNDeI=;
        b=P5Jumbhe8EvR/wk3o//Yjyjb5gc1l5UtNs4clWpye07jxDrMqu/yCOELmqLWAK4hDA
         rC5HtAMDatWQ9LD9WkWwSS7+x+B6Wjj+NUHF0URAQSv3tM4EtI4C0Fh/ps7k8TbCAGwW
         J4w18+octc8vSjKm7J7PzT2xgaurkEfgD/k5tHn97bc9w7dOH6FKemTJAZEMQGMClg5S
         szwxNyofn2JVUlCS1i4kJEU/t/EJnc3vHu5lKwbqcWLJGKlclRXTv74sGHBZbT5MAL6Z
         MYOZoT1CO8lzhf5o7C2YzeMhvgznE1U5OkmNY0nxshqvUONgTGNZpkOI3k9hZ2+/rE4q
         ghqQ==
X-Gm-Message-State: AOAM5321vP6MH2C5b0SHGErmUZGNRix4YQbbR9miMvhptEbTNhTc47if
        OfR52siKAspBfVXtJvOzD1pD9FyjBso2eOwu
X-Google-Smtp-Source: ABdhPJwiaSOMAbLyb3ttiRwP6Iyn+/7pT5xTRh/+7mN2yEZlUoeqhJycYRSBB4N+9iqBnfeRSpbL2Q==
X-Received: by 2002:aa7:df12:: with SMTP id c18mr9222966edy.62.1626220323326;
        Tue, 13 Jul 2021 16:52:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qt10sm107532ejb.110.2021.07.13.16.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:52:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: replace [de]packetize() shell+perl
 test-tool pkt-line
Date:   Wed, 14 Jul 2021 01:41:27 +0200
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-3.5-c33f344ab20-20210712T164208Z-avarab@gmail.com>
 <YO38ladlVVGAmQnl@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO38ladlVVGAmQnl@coredump.intra.peff.net>
Message-ID: <875yxd3h7c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff King wrote:

> On Mon, Jul 12, 2021 at 06:44:18PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> The shell+perl "[de]packetize()" helper functions were added in
>> 4414a150025 (t/lib-git-daemon: add network-protocol helpers,
>> 2018-01-24), and around the same time we added the "pkt-line" helper
>> in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
>> 2018-03-14).
>>=20
>> For some reason it seems we've mostly used the shell+perl version
>> instead of the helper since then. There were discussions around
>> 88124ab2636 (test-lib-functions: make packetize() more efficient,
>> 2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
>> stdin code, 2020-03-29) to improve them and make them more efficient.
>
> This seems like a good goal, and the conversions look mostly faithful
> (with one exception below). Having the helper tool recognize "0000" as a
> flush makes some of the scripts much nicer to read (even if it is
> technically ambiguous in the input).
>
> I did seem like there were some other stylistic things happening, too,
> though. For instance:
>
>> -extract_haves () {
>> -	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
>> -}
>> -
>>  test_expect_success 'with core.alternateRefsCommand' '
>>  	write_script fork/alternate-refs <<-\EOF &&
>>  		git --git-dir=3D"$1" for-each-ref \
>> @@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsCommand'=
 '
>>  			refs/heads/public/
>>  	EOF
>>  	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
>> -	git rev-parse public/branch >expect &&
>> -	printf "0000" | git receive-pack fork >actual &&
>> -	extract_haves <actual >actual.haves &&
>> -	test_cmp expect actual.haves
>> +
>> +	test-tool pkt-line pack >in <<-\EOF &&
>> +	0000
>> +	EOF
>> +
>> +	cat >expect <<-EOF &&
>> +	$(git rev-parse main) refs/heads/main
>> +	$(git rev-parse base) refs/tags/base
>> +	$(git rev-parse public) .have
>> +	0000
>> +	EOF
>
> This is testing the whole output, rather than just the "have" lines (as
> the original did). It was intentionally written the other way for two
> reasons:
>
>   - it keeps the focus on what we are actually testing: the .have
>     behavior
>
>   - it makes the test less brittle to other changes in the script
>
> I can buy the argument that sometimes testing the whole output, even if
> it is more brittle, helps us find other unexpected outcomes (e.g., the
> stderr test_cmp vs grep thing earlier in the series). But here it just
> seems strictly worse to me.
>
> It would be easy to just replace depacketize with "pktline unpack", but
> keep the perl one-liner. I don't think it's a _huge_ deal in this case
> either way, but I'm not enthused about the trend.

FWIW this series was spun off from an effort of fixing a bug related to
protocol-y tests doing just such a "we can grep the output, we know we
only need xyz", and the only test for it not failing because we picked
the wrong xyz.

In this case yeah we could keep the grep. I do think in general that
unless output is overly verbose we should test_cmp it, and in this case
it's really not.

On the focus it seems it's the opposite for the two uf us. It takes my
focus away from the test itself when reading it. I.e. I start wondering
why the grep, is the output variable or whatever, especially in a case
like this where we're hardly saving ourselves overall lines or reducing
complexity.

>> +	test-tool pkt-line pack >in <<-\EOF &&
>> +	0000
>> +	EOF
>
> This used to just be "printf 0000". The new version is longer and less
> efficient, but I'm OK with it on the grounds of consistency (all inputs
> flow through "pkt-line pack", and all outputs through "pkt-line unpack").

They aren't equivalent because the pkt-line helper (and pkt-line.c in
general) will be forgiving about the presence or lack of trailing
newlines, but some of these tests were not.

I think we should use the helper in/out for all of those, because we're
explicitly interested if the protocol round-trips the way we expect, and
not per-se if the exact bytes match.

>> diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-r=
eport-status-v1.sh
>> index 1233a46eac5..cf33d993192 100644
>> --- a/t/t5411/once-0010-report-status-v1.sh
>> +++ b/t/t5411/once-0010-report-status-v1.sh
>> @@ -34,13 +34,13 @@ test_expect_success "proc-receive: report status v1"=
 '
>>  				$A $B | packetize
>>  		fi &&
>>  		printf "%s %s refs/for/main/topic1\n" \
>> -			$ZERO_OID $A | packetize &&
>> +			$ZERO_OID $A | test-tool pkt-line pack &&
>>  		printf "%s %s refs/heads/foo\n" \
>> -			$ZERO_OID $A | packetize &&
>> +			$ZERO_OID $A | test-tool pkt-line pack &&
>>  		printf "%s %s refs/for/next/topic\n" \
>> -			$ZERO_OID $A | packetize &&
>> +			$ZERO_OID $A | test-tool pkt-line pack &&
>>  		printf "%s %s refs/for/main/topic2\n" \
>> -			$ZERO_OID $A | packetize &&
>> +			$ZERO_OID $A | test-tool pkt-line pack &&
>
> Now that you're using the multi-line-capable helper, these could all be
> a single (and much more readable):
>
>   test-tool pkt-line pack <<-EOF
>   $ZERO_OID $A refs/for/main/topic1
>   $ZERO_OID $A refs/heads/foo
>   $ZERO_OID $A refs/for/next/topic
>   $ZERO_OID $A refs/for/main/topic2
>   EOF
>
> couldn't they?

Yeah, but you never know what you'll get "let's do the small change"
v.s. "let's avoid refactoring while we're at it" feedback :)

I figured it was easier to review with just the s/packetize/test-tool
pkt-line pack/g, but sure, I can change it.

>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backe=
nd-content-length.sh
>> index e5d3d15ba8d..e6c8338b648 100755
>> --- a/t/t5562-http-backend-content-length.sh
>> +++ b/t/t5562-http-backend-content-length.sh
>> @@ -53,12 +53,13 @@ test_expect_success 'setup' '
>>  	test_commit c1 &&
>>  	hash_head=3D$(git rev-parse HEAD) &&
>>  	hash_prev=3D$(git rev-parse HEAD~1) &&
>> -	{
>> -		packetize "want $hash_head" &&
>> -		printf 0000 &&
>> -		packetize "have $hash_prev" &&
>> -		packetize "done"
>> -	} >fetch_body &&
>> +	test-tool pkt-line pack >fetch_body <<-EOF &&
>> +	want $hash_head
>> +	0000
>> +	have $hash_prev
>> +	done
>> +	0000
>> +	EOF
>
> There's a flush packet at the end of your input in the post-image that
> doesn't seem to be in the original.

Yeah, but isn't round-tripping through the helper the right thing here?

>> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
>> index 82c31ab6cd8..2dde0348816 100755
>> --- a/t/t5570-git-daemon.sh
>> +++ b/t/t5570-git-daemon.sh
>> @@ -198,12 +198,14 @@ test_expect_success FAKENC 'hostname interpolation=
 works after LF-stripping' '
>>  		printf "0000"
>>  	} >input &&
>
> This one doesn't use "pkt-line pack". Which is good, because we care
> about being exact about things like newlines here.

Yes, as opposed to here, where we don't want the helper.

>>  	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
>> -	depacketize <output >output.raw &&
>> +	test-tool pkt-line unpack <output >actual &&
>> +
>> +	cat >expect <<-EOF &&
>> +	$(git rev-parse HEAD) HEAD
>> +	$(git rev-parse refs/heads/main) refs/heads/main
>> +	0000
>> +	EOF
>>=20=20
>> -	# just pick out the value of main, which avoids any protocol
>> -	# particulars
>> -	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actua=
l &&
>> -	git -C "$repo" rev-parse main >expect &&
>>  	test_cmp expect actual
>>  '
>
> This is another case where you're checking the output for more than the
> original did, ignoring the comment. :) When using depacketize, the bits
> after the "\0" were encoded and kept, so it was necessary. The pkt-line
> helper just throws those bits away, so it's OK (I'm a little surprised
> that discarding those bits wasn't a roadblock for converting some tests,
> but I guess we didn't have any low-level protocol tests that cared).

... I see you got to this bit in 4/5.
