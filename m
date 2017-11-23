Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342E92036D
	for <e@80x24.org>; Thu, 23 Nov 2017 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbdKWJKq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 04:10:46 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:38889 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdKWJKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 04:10:42 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 23 Nov 2017 10:10:59 +0100
  id 00000000000000D9.000000005A1690A3.00007D27
Date:   Thu, 23 Nov 2017 10:10:40 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: fix segfault under -P + PCRE2 + (*NO_JIT)
Message-ID: <20171123091040.GA8095@ruderich.org>
References: <20171122133630.18931-1-avarab@gmail.com>
 <20171122133630.18931-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171122133630.18931-2-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 01:36:30PM +0000, Ævar Arnfjörð Bjarmason wrote:
> +		 *
> +		 * This is because if the pattern contains the
> +		 * (*NO_JIT) verb (see pcre2syntax(3))
> +		 * pcre2_jit_compile() will exit early with 0. If we
> +		 * then proceed to call pcre2_jit_match() further down
> +		 * the line instead of pcre2_match() we'll segfault.
> +		 */
> +		patinforet = pcre2_pattern_info(p->pcre2_pattern, PCRE2_INFO_JITSIZE, &jitsizearg);
> +		if (patinforet)
> +			die("BUG: The patinforet variable should be 0 after the pcre2_pattern_info() call, not %d",
> +			    patinforet);

I think BUG() should be used here, and maybe shorten the error
message:

    BUG("pcre2_pattern_info() failed: %d", patinforet);

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
