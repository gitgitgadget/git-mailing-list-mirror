Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7D81F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeHBXWj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Aug 2018 19:22:39 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:34236 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeHBXWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:39 -0400
Received: from [192.168.129.15] (x015.home.local [192.168.129.15])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w72LTPLX13828208;
        Thu, 2 Aug 2018 21:29:26 GMT
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sha1dc: update from upstream
From:   "Michael Felt (aixtools)" <aixtools@felt.demon.nl>
X-Mailer: iPhone Mail (15E216)
In-Reply-To: <20180802205044.23631-1-avarab@gmail.com>
Date:   Thu, 2 Aug 2018 23:29:25 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Dan Shumow <shumow@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <496FCCBF-078F-404C-869C-720D2100CC45@felt.demon.nl>
References: <87o9emtuf6.fsf@evledraar.gmail.com> <20180802205044.23631-1-avarab@gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone

> On 2 Aug 2018, at 22:50, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> Update sha1dc from the latest version by the upstream
> maintainer[1]. See 2db87328ef ("Merge branch 'ab/sha1dc'", 2017-07-10)
> for the last update.
> 
> This fixes an issue where AIX was wrongly detected as a Little-endian
> instead of a Big-endian system. See [2][3][4].
> 
> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/232357eb2ea0397388254a4b188333a227bf5b10
> 2. https://github.com/cr-marcstevens/sha1collisiondetection/pull/45
> 3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/42
> 4. https://public-inbox.org/git/20180729200623.GF945730@genre.crustytoothpaste.net/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
>> On Wed, Aug 01 2018, Ævar Arnfjörð Bjarmason wrote:
>> https://github.com/cr-marcstevens/sha1collisiondetection/pull/45
>> [...]
>> It should work, but as noted in the MR please test it so we can make
>> sure, and then (if you have a GitHub account) comment on the MR saying
>> it works for you.
> 
> This got merged upstream, and as noted in that upstream PR I've
> personally tested this on AIX under both GCC and IBM's xlc on the GCC
> compile farm, it works.
> 
Thanks. I already have git 2.18 in use with the manual patch. 
> sha1collisiondetection |  2 +-
> sha1dc/sha1.c          | 12 +++++++++++-
> 2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/sha1collisiondetection b/sha1collisiondetection
> index 19d97bf5af..232357eb2e 160000
> --- a/sha1collisiondetection
> +++ b/sha1collisiondetection
> @@ -1 +1 @@
> -Subproject commit 19d97bf5af05312267c2e874ee6bcf584d9e9681
> +Subproject commit 232357eb2ea0397388254a4b188333a227bf5b10
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 25eded1399..df0630bc6d 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -93,13 +93,23 @@
> #define SHA1DC_BIGENDIAN
> 
> /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
> +#elif (defined(_AIX))
> +
> +/*
> + * Defines Big Endian on a whitelist of OSs that are known to be Big
> + * Endian-only. See
> + * https://public-inbox.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
> + */
> +#define SHA1DC_BIGENDIAN
> +
> +/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> */
> #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
> /*
>  * As a last resort before we do anything else we're not 100% sure
>  * about below, we blacklist specific processors here. We could add
>  * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
>  */
> -#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist>  or <processor blacklist> */
> +#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> or <processor blacklist> */
> 
> /* We do nothing more here for now */
> /*#error "Uncomment this to see if you fall through all the detection"*/
> -- 
> 2.18.0.345.g5c9ce644c3
> 

