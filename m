Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E670C43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKHWaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiKHW3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:29:55 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771E220E3
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:29:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m22so5035029eji.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EeRVeKlgGkwtvhaNYOIjVgT7x0SjhYEZLpTIGj/C0cs=;
        b=Z7LOpYVg046Kxm5ZHzJDULaCB/5MQ4MeUDlC6kvZVdxnfIPXmXya76vACAn3OaGQmu
         PAfPvHvhg+j79gHAgZbIZ1csIrkOzfocDFHidDBpk6ni/3OtFJOHKhrVxRnp3OTnFGwr
         +jwjT2ksSBMzCFN/VdmnetBNSZGCtwtw+r1slVGc6DSc7R1ZMP6EiKrfsETn4oucX5LK
         Jggr6dYVdGaoXqaXE9pgw0nijGeMMvfA7yFfukZMzoR/e+4efCnwqK6SA72kmK5RRtgk
         L3ryBQ0xVghP+Ytk3RruixdkGfFAquyCSoJ3sZGLdNIq0x00F20owMVy9AWOtVknSp/g
         npWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeRVeKlgGkwtvhaNYOIjVgT7x0SjhYEZLpTIGj/C0cs=;
        b=q8jdNyA2bezqem+1C3Zpqk9tjqTzSgNgX2zmhQNCjuv/WYji1y1QCG6aesf0CFhUtf
         hkI4rOI+gB5ai8i1W4agjdD6Uw8AzXuAU1O4fBt407xsDFu504jjzukJCDDHp9lDXIGQ
         abeapGCVDhaU93Jdi+5IamsQYdLCjyywvKiME3aGiJxmBKYE/dqY+NKDgMomyMQIrAXq
         CS+UxKVoXAOVxlGP121uY3xqqJFJeaBG0kBvk4ph5ZhrmuFfarxYzBh5mUUMj+F0w+9R
         DmeYFF+ImZEV2mjsE/cl2xIZmnXhHcKgqCqw2k49/i807zJpjubzMl5DTOwUm40g0K+R
         qlbA==
X-Gm-Message-State: ACrzQf34jO3wGXzAtAgCDfNmTtd441DUolfwd7UELj40LPU17DDLLBGI
        nQS3xe2b61rTU+J2ApAYRKw=
X-Google-Smtp-Source: AMsMyM4B29e+Be3daKEYBubvJeB7dLycJZedThIUUV7e227SPOftQhzW4mb530Lqo4ozyHfP+shhDQ==
X-Received: by 2002:a17:907:9705:b0:7ad:b14f:d89e with SMTP id jg5-20020a170907970500b007adb14fd89emr53738193ejc.745.1667946561182;
        Tue, 08 Nov 2022 14:29:21 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm6158967eda.37.2022.11.08.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:29:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osX5s-000l5T-0U;
        Tue, 08 Nov 2022 23:29:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
Date:   Tue, 08 Nov 2022 23:17:14 +0100
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
Message-ID: <221108.86iljpqdvj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Eric Sunshine via GitGitGadget wrote:

> When chainlint detects problems in a test, such as a broken &&-chain, it
> prints out the test with "?!FOO?!" annotations inserted at each problem
> location. However, rather than annotating the original test definition, it
> instead dumps out a parsed token representation of the test. Since it lac=
ks
> comments, indentation, here-doc bodies, and so forth, this tokenized
> representation can be difficult for the test author to digest and relate
> back to the original test definition.
>
> An earlier patch series[1] improved the output somewhat by colorizing the
> "?!FOO?!" annotations and the "# chainlint:" lines, but the output can st=
ill
> be difficult to digest.
>
> This patch series further improves the output by instead making chainlint=
.pl
> annotate the original test definition rather than the parsed token stream,
> thus preserving indentation (and whitespace, in general), here-doc bodies,
> etc., which should make it easier for a test author to relate each problem
> back to the source.
>
> This series was inspired by usability comments from Peff[2] and =C3=86var=
[3] and
> a bit of discussion which followed[4][5].
>
> (Note to self: Add =C3=86var to nerd-snipe blacklist alongside Peff.)

Heh! It's great to see a follow-up to our discussion the other day, and
having the output verbatim & annotated looks much better, especially for
complex tests.

E.g. (taking one at random, after some grepping/skimming), ruining this one:
=09
	diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
	index dcaab7265f5..c27539a773d 100755
	--- a/t/t6300-for-each-ref.sh
	+++ b/t/t6300-for-each-ref.sh
	@@ -1365,8 +1365,7 @@ test_expect_success 'for-each-ref --ignore-case work=
s on multiple sort keys' '
	                do
	                        GIT_COMMITTER_EMAIL=3D"$email@example.com" \
	                        git tag -m "tag $subject" icase-$(printf %02d $nr)=
 &&
	-                       nr=3D$((nr+1))||
	-                       return 1
	+                       nr=3D$((nr+1))
	                done
	        done &&
	        git for-each-ref --ignore-case \

Would, before emit (correct, but a bit of a token-soup):

=09
	$ ./t6300-for-each-ref.sh=20
	# chainlint: ./t6300-for-each-ref.sh
	# chainlint: for-each-ref --ignore-case works on multiple sort keys
=09
	nr=3D0 &&
	for email in a A b B
	do
	for subject in a A b B
	do
	GIT_COMMITTER_EMAIL=3D"$email@example.com" git tag -m "tag $subject" icase=
-$(printf %02d $nr) &&
	nr=3D$((nr+1)) ?!LOOP?!
	done ?!LOOP?!
	done &&
	git for-each-ref --ignore-case --format=3D"%(taggeremail) %(subject) %(ref=
name)" --sort=3Drefname --sort=3Dsubject --sort=3Dtaggeremail refs/tags/ica=
se-* > actual &&
	cat > expect <<-EOF &&
	test_cmp expect actual
	error: bug in the test script: lint error (see '?!...!? annotations above)

But now it'll instead emit:
=09
	$ ./t6300-for-each-ref.sh
	# chainlint: ./t6300-for-each-ref.sh
	# chainlint: for-each-ref --ignore-case works on multiple sort keys
	        # name refs numerically to avoid case-insensitive filesystem confl=
icts
	        nr=3D0 &&
	        for email in a A b B
	        do
	                for subject in a A b B
	                do
	                        GIT_COMMITTER_EMAIL=3D"$email@example.com" \
	                        git tag -m "tag $subject" icase-$(printf %02d $nr)=
 &&
	                        nr=3D$((nr+1)) ?!LOOP?!
	                done ?!LOOP?!
	        done &&
	        git for-each-ref --ignore-case \
	                --format=3D"%(taggeremail) %(subject) %(refname)" \
	                --sort=3Drefname \
	                --sort=3Dsubject \
	                --sort=3Dtaggeremail \
	                refs/tags/icase-* >actual &&
	        cat >expect <<-\EOF &&
	        <a@example.com> tag a refs/tags/icase-00
	        <a@example.com> tag A refs/tags/icase-01
	        <A@example.com> tag a refs/tags/icase-04
	        <A@example.com> tag A refs/tags/icase-05
	        <a@example.com> tag b refs/tags/icase-02
	        <a@example.com> tag B refs/tags/icase-03
	        <A@example.com> tag b refs/tags/icase-06
	        <A@example.com> tag B refs/tags/icase-07
	        <b@example.com> tag a refs/tags/icase-08
	        <b@example.com> tag A refs/tags/icase-09
	        <B@example.com> tag a refs/tags/icase-12
	        <B@example.com> tag A refs/tags/icase-13
	        <b@example.com> tag b refs/tags/icase-10
	        <b@example.com> tag B refs/tags/icase-11
	        <B@example.com> tag b refs/tags/icase-14
	        <B@example.com> tag B refs/tags/icase-15
	        EOF
	        test_cmp expect actual
	error: bug in the test script: lint error (see '?!...!? annotations above)

Which is so much better, i.e. as you're preserving the whitespace &
comments, and the "?!LOOP?!" is of course much easier to see with the
colored output.

I hadn't noticed before that the contents of here-docs was pruned, but
that made sense in the previous parser, but having the content.

Also, and I guess this is an attempt to evade your blacklist. I *did*
notice when playing around with this that if I now expand the "1 while"
loop here:

	my $s =3D do { local $/; <$fh> };
	close($fh);
	my $parser =3D ScriptParser->new(\$s);
	1 while $parser->parse_cmd();

To something that "follows along" with the parser it shouldn't be too
hard in the future to add line number annotations now. E.g. for
"#!/bin/sh\n" you'll emit a token like "\n", but the positions will be
0, 10.

But that's all for some hypothetical future, this is already much better
:)
