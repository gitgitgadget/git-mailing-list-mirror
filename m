Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0823C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbiAKUjJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 11 Jan 2022 15:39:09 -0500
Received: from elephants.elehost.com ([216.66.27.132]:11337 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:39:08 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20BKd7sF047000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jan 2022 15:39:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com> <Ydzw+RqR6IfbT/oM@nand.local> <010b01d80697$0c848770$258d9650$@nexbridge.com> <Ydzyv8ZCEpDDRBXT@nand.local> <010d01d8069e$8d330480$a7990d80$@nexbridge.com> <Yd3gJ6C3jU7ZZskc@nand.local>
In-Reply-To: <Yd3gJ6C3jU7ZZskc@nand.local>
Subject: RE: [BUG] Re: Git 2.35.0-rc0
Date:   Tue, 11 Jan 2022 15:39:02 -0500
Organization: Nexbridge Inc.
Message-ID: <013e01d8072b$47fbc4a0$d7f34de0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIzMkomfuhrYaYzn51cwdtqNnfQqQHkNVZQAf1QdqACJzV1/gJXK5FDAmoCVyyrUaJh8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2022 2:53 PM, Taylor Blau wrote:
> On Mon, Jan 10, 2022 at 10:51:39PM -0500, rsbecker@nexbridge.com
> wrote:
> > I now have a different issue:
> >
> > make -C t/ all
> > make[1]: Entering directory '/home/git/git/t'
> > rm -f -r 'test-results'
> > /usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
> >
> > Is there anyway to move to xargs? I am not sure why /usr/bin/perl is
> > having issues with the build.
> 
> Tracing through t/Makefile, I am _pretty_ sure that this Perl invocation comes
> from the test-lint-shell-syntax recipe.
> 
> I wonder if something like this would do the trick?
> 
> --- 8< ---
> 
> diff --git a/t/Makefile b/t/Makefile
> index 46cd5fc527..d959119133 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -90,7 +90,7 @@ test-lint-executable:
>  		echo >&2 "non-executable tests:" $$bad; exit 1; }
> 
>  test-lint-shell-syntax:
> -	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
> $(TPERF)
> +	@echo $(T) $(THELPERS) $(TPERF) | xargs '$(PERL_PATH_SQ)'
> +check-non-portable-shell.pl
> 
>  test-lint-filenames:
>  	@# We do *not* pass a glob to ls-files but use grep instead, to catch
> 
> --- >8 ---

I think we don't need this yet. My CI/CD system is a bit more robust and does not get stuck here.
--Randall

