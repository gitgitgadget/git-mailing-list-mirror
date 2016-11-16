Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66832042F
	for <e@80x24.org>; Wed, 16 Nov 2016 17:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbcKPRDd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Nov 2016 12:03:33 -0500
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:39823 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbcKPRDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 12:03:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id BFA9C100050;
        Wed, 16 Nov 2016 17:03:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k93k0t77e2BQ; Wed, 16 Nov 2016 17:03:30 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id ADA8A8002E;
        Wed, 16 Nov 2016 17:03:30 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Wed, 16 Nov 2016 17:03:30 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Wed, 16 Nov 2016 17:03:30 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Subject: RE: [PATCH 14/16] checkout: recurse into submodules if asked to
Thread-Topic: [PATCH 14/16] checkout: recurse into submodules if asked to
Thread-Index: AQHSP5UABD/l8VQ2lkOrL+nq828ECaDbyRGw
Date:   Wed, 16 Nov 2016 17:03:30 +0000
Message-ID: <a9c85966bf174509a246106d782c36a3@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-15-sbeller@google.com>
In-Reply-To: <20161115230651.23953-15-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> 
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh index
> 79cdd34..e0773c6 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -634,7 +634,13 @@ test_submodule_forced_switch () {
> 
>  	########################## Modified submodule
> #########################
>  	# Updating a submodule sha1 doesn't update the submodule's work tree
> -	test_expect_success "$command: modified submodule does not update
> submodule work tree" '
> +	if test
> "$KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST" =
> 1
> +	then
> +		RESULT="failure"
> +	else
> +		RESULT="success"
> +	fi
> +	test_expect_$RESULT "$command: modified submodule does not update
> submodule work tree" '

Why does this break?  I thought it was only if checkout is run with --recurse-submodules that anything should change?

> +test_expect_success 'dirty file file is not deleted' '

Duplicate 'file' in this test name.
> +# This is ok in theory, we just need to make sure # the garbage
> +collection doesn't eat the commit.
> +test_expect_success 'different commit prevents from deleting' '

This isn't a different commit -- it's a dirty index, right? 

> +test_expect_failure '"checkout --recurse-submodules" does not care about
> untracked submodule content' '
> +	echo untracked >submodule/untracked &&
> +	git checkout --recurse-submodules master &&
> +	git diff-files --quiet --ignore-submodules=untracked &&
> +	git diff-index --quiet --cached HEAD &&
> +	rm submodule/untracked
> +'

Use test_when_finished for cleanup.

> +test_expect_failure '"checkout --recurse-submodules" needs -f when
> submodule commit is not present (but does fail anyway)' '
> +	git checkout --recurse-submodules -b bogus_commit master &&
> +	git update-index --cacheinfo 160000
> 0123456789012345678901234567890123456789 submodule &&
> +	BOGUS_TREE=$(git write-tree) &&
> +	BOGUS_COMMIT=$(echo "bogus submodule commit" | git commit-tree
> $BOGUS_TREE) &&
> +	git commit -m "bogus submodule commit" &&
> +	git checkout --recurse-submodules -f master &&
> +	test_must_fail git checkout --recurse-submodules bogus_commit &&
> +	git diff-files --quiet &&
> +	test_must_fail git checkout --recurse-submodules -f bogus_commit &&
> +	test_must_fail git diff-files --quiet submodule &&
> +	git diff-files --quiet file &&
> +	git diff-index --quiet --cached HEAD &&
> +	git checkout --recurse-submodules -f master '
> +KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST=1
>  test_submodule_switch "git checkout"
> 
> +KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST=
>  test_submodule_forced_switch "git checkout -f"
> 
>  test_done
> --
> 2.10.1.469.g00a8914

