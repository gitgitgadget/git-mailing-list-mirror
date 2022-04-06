Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC2CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 11:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiDFLiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDFLgU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 07:36:20 -0400
Received: from lucy.dinwoodie.org (b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:de15:20ad:bda2:90f2:b98:8b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500226AE01
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:26:33 -0700 (PDT)
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1nc0zh-000uGp-KJ; Wed, 06 Apr 2022 09:26:25 +0100
Date:   Wed, 6 Apr 2022 09:26:25 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation/Makefile: fix "make info" regression in
 dad9cd7d518
Message-ID: <20220406082625.7mots3ziqchjpyhw@lucy.dinwoodie.org>
References: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
 <patch-1.1-e700d372e0c-20220405T195425Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-e700d372e0c-20220405T195425Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 05, 2022 at 09:56:20PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a regression in my dad9cd7d518 (Makefile: move ".SUFFIXES" rule to
> shared.mak, 2022-03-03). As explained in the GNU make documentation
> for the $* variable, available at:
> 
> 	info make --index-search='$*'
> 
> This rule relied on ".texi" being in the default list of suffixes, as
> seen at:
> 
> 	make -f/dev/null -p | grep -v -e ^# -e ^$|grep -F .SUFFIXES
> 
> The documentation explains what was going on here:
> 
> 	In an explicit rule, there is no stem; so '$*' cannot be determined
> 	in that way.  Instead, if the target name ends with a recognized
> 	suffix (*note Old-Fashioned Suffix Rules: Suffix Rules.), '$*' is
> 	set to the target name minus the suffix.  For example, if the
> 	target name is 'foo.c', then '$*' is set to 'foo', since '.c' is a
> 	suffix.  GNU 'make' does this bizarre thing only for compatibility
> 	with other implementations of 'make'.  You should generally avoid
> 	using '$*' except in implicit rules or static pattern rules.
> 
> 	If the target name in an explicit rule does not end with a
> 	recognized suffix, '$*' is set to the empty string for that rule.
> 
> I.e. this rule added back in 5cefc33bffd (Documentation: add
> gitman.info target, 2007-12-10) was resolving gitman.texi from
> gitman.info. We can instead just use the more obvious $< variable
> referring to the prerequisite.
> 
> This was the only use of $* in our Makefiles in an explicit rule, the
> three remaining ones are all implicit rules, and therefore didn't
> depend on the ".SUFFIXES" list.
> 
> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Tue, Apr 05 2022, Adam Dinwoodie wrote:
> 
> > With this commit, I get the same noisy warnings, but I also get the
> > error "could not open .texi: No such file or directory".
> 
> Sorry about the regression. This fixes it, and as noted above I'm
> pretty sure this was the only fallout of the change.
> 
> (I didn't have building the full extended documentation as part of my
> local build, but I'll be adding it now).

Confirmed this patch fixes things for me.  Thanks for the quick fix!

Tested-by: Adam Dinwoodie <adam@dinwoodie.org>
