Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADB01F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJKCUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:20:16 -0400
Received: from mail.ao2.it ([92.243.12.208]:50038 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJKCUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=LZRWCbcATVAN4VXy9bo65p/FWK5QdM/KtoBDGY4l51g=;
        b=fQK6NIJz9rPkIh72oNOMf40khRgoP0Ltp/d+0TMHXivjh/0Dr7nYCZKQLrAcp5/GlPDqYctFPnCgC8HPiQO710hZfCEADco/ZeMVl4H1kDODxIAilqEhOJr4w2HERk3+vSQ8J9P/B9vPA5zGZbl4zn22K+spbQReVU14nL8aZ61OL/r2XmqWl+QiTW1x4z3gWEKNRQjzBg7EpAjssTcZM+PeytU1TI8z22WOu8RbnDlD99CooAOkv3KoO1IDCPEJ4+Hj5FFO9ILm70nf4N+ifHO4nJQ7aXDvEa8YJ9Us9Ek7hFd7bjIakT2nuekyJJ+fk8eovju0utulII9SLa2cPw==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gAJf1-0005RX-U0; Wed, 10 Oct 2018 20:56:43 +0200
Date:   Wed, 10 Oct 2018 20:56:45 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 09/10] submodule: support reading .gitmodules when
 it's not in the working tree
Message-Id: <20181010205645.e1529eff9099805029b1d6ef@ao2.it>
In-Reply-To: <CAGZ79kZTQB29SuB52Efk-j7jX11BRU_RFiX+znttvP2tFRaNvg@mail.gmail.com>
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-10-ao2@ao2.it>
        <CAGZ79kZTQB29SuB52Efk-j7jX11BRU_RFiX+znttvP2tFRaNvg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Oct 2018 15:19:00 -0700
Stefan Beller <sbeller@google.com> wrote:

> > +test_expect_success 'not writing gitmodules config file when it is not checked out' '
> > +        test_must_fail git -C super submodule--helper config submodule.submodule.url newurl
> 
> This only checks the exit code, do we also want to check for
> 
>     test_path_is_missing .gitmodules ?
>

OK, I agree, let's re-check also *after* we tried and failed to set
a config value, just to be sure that the code does not get accidentally
changed in the future to create the file. I'll add the check.

> > +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> > +       git -C super submodule init
> > +'
> > +
> > +test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
> > +       git -C super submodule summary
> > +'
> 
> Same for these, is the exit code enough, or do we want to look at
> specific things?
>

Except for the "summary" test which was not even exercising the
config_from_gitmodule path,  checking exist status should be sufficient
to verify that "submodule--helper config" does not fail, but we can
surely do better.

I will add checks to confirm that not only the commands exited without
errors but they also achieved the desired effect, to validate the actual
high-level use case advertised by the test file. This should be more
future-proof.

And I think I'll merge the summary and the update tests.

> > +
> > +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> > +       (cd submodule &&
> > +               echo file2 >file2 &&
> > +               git add file2 &&
> > +               git commit -m "add file2 to submodule"
> > +       ) &&
> > +       git -C super submodule update
> 
> git status would want to be clean afterwards?

Mmh, this should have been "submodule update --remote" in the first
place to have any effect, I'll take the chance and rewrite this test in
a different way and also check the effect of the update operation, and
the repository status.

I'll be something like this:

ORIG_SUBMODULE=$(git -C submodule rev-parse HEAD)
ORIG_UPSTREAM=$(git -C upstream rev-parse HEAD)
ORIG_SUPER=$(git -C super rev-parse HEAD)

test_expect_success 're-updating submodule when the gitmodules config is not checked out' '
	test_when_finished "git -C submodule reset --hard $ORIG_SUBMODULE;
	                    git -C upstream reset --hard $ORIG_UPSTREAM;
	                    git -C super reset --hard $ORIG_SUPER;
	                    git -C upstream submodule update --remote;
	                    git -C super pull;
	                    git -C super submodule update --remote" &&
	(cd submodule &&
		echo file2 >file2 &&
		git add file2 &&
		test_tick &&
		git commit -m "add file2 to submodule"
	) &&
	(cd upstream &&
		git submodule update --remote &&
		git add submodule &&
		test_tick &&
		git commit -m "Update submodule"
	) &&
	git -C super pull &&
	# The --for-status options reads the gitmdoules config
	git -C super submodule summary --for-status >actual &&
	cat >expect <<-\EOF &&
	* submodule 951c301...a939200 (1):
	  < add file2 to submodule
	
	EOF
	test_cmp expect actual &&
	# Test that the update actually succeeds
	test_path_is_missing super/submodule/file2 &&
	git -C super submodule update &&
	test_cmp submodule/file2 super/submodule/file2 &&
	git -C super status --short >output &&
	test_must_be_empty output
'

Maybe a little overkill?

The "upstream" repo will be added in test 1 to better clarify the roles
of the involved repositories.

The commit ids should be stable because of test_tick, shouldn't they?

Thanks for the comments, they helped improving the quality of the tests
once again.

I'll wait a few days before sending a v7, hopefully someone will find
time to take another look at patch 9 and comment also on patch 10, and
give an opinion on the "mergeability" status of the whole patchset.

Ciao ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
