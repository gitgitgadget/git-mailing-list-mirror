Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7094C1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBIQ4Y convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Feb 2019 11:56:24 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35252 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBIQ4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 11:56:24 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19Gu5g1055074
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 11:56:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>, "'Jeff King'" <peff@peff.net>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net> <002501d4bfde$b26e6050$174b20f0$@nexbridge.com> <20190208191519.GF27673@sigill.intra.peff.net> <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com> <20190208193157.GA30952@sigill.intra.peff.net> <20190208220714.GG11927@genre.crustytoothpaste.net> <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com> <20190208223512.GA2135@sigill.intra.peff.net> <006601d4c001$2de3a160$89aae420$@nexbridge.com> <20190209042456.GB18286@sigill.intra.peff.net> <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
In-Reply-To: <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Sat, 9 Feb 2019 11:55:58 -0500
Message-ID: <000301d4c098$57df9720$079ec560$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIjYM+W43sjzL92GGLCYaE3korh7wFIjDzjAomJpT0CPT5X0wHzLXEWAlp4NWoCnO8uAAGyim5RAqNObW0BvDqaKAIxfKrjAfbM/iCkgMxaUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 9, 2019 3:40, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.02.19 um 05:24 schrieb Jeff King:
> > On Fri, Feb 08, 2019 at 05:53:53PM -0500, Randall S. Becker wrote:
> >
> >>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh index
> >>> 92cf8f812c..4afab14431 100644
> >>> --- a/t/test-lib-functions.sh
> >>> +++ b/t/test-lib-functions.sh
> >>> @@ -1302,3 +1302,8 @@ test_set_port () {
> >>>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
> >>>  	eval $var=$port
> >>>  }
> >>> +
> >>> +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> >>> +gen_zero_bytes () {
> >>> +	perl -e 'print "\0" x $ARGV[0]' "$@"
> >>> +}
> >>
> >> This function does work on platform, so it's good.
> >
> > Great. Since it sounds like you're preparing some patches to deal with
> > /dev/zero elsewhere, do you want to wrap it up in a patch as part of
> > that?
> 
> Please do not use yes to generate an infinite amount of bytes. Our
> implementation of yes() in test-lib.sh generates only 99 lines.
> 
> Perhaps do this.
> 
> ----- 8< -----
> Subject: [PATCH] t5318: avoid /dev/zero
> 
> Some platforms do not offer /dev/zero. Use printf and tr to generate a
> certain amount of NUL bytes.
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t5318-commit-graph.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh index
> 16d10ebce8..04d394274f 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -383,7 +383,8 @@ corrupt_graph_and_verify() {
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1
> seek="$pos" conv=notrunc &&
>  	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0
> &&
> -	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1
> seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> +	printf "%0*d" $(($orig_size - $zero_pos)) 0 | tr 0 '\0' |
> +		dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos"
> &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err
> --
> 2.20.1.86.gb0de946387

This would be fine with me. I'm going to prepare an alternative and let the committers decide.

