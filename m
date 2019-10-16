Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75ED41F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436527AbfJPTKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:10:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39877 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbfJPTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:10:18 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 14ED7FF805;
        Wed, 16 Oct 2019 19:10:14 +0000 (UTC)
Date:   Thu, 17 Oct 2019 00:40:12 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] builtin/blame.c: constants into bit shift format
Message-ID: <20191016191012.ij3zbexu7pxupdho@yadavpratyush.com>
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
 <3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/19 06:30PM, Hariom Verma via GitGitGadget wrote:
> From: Hariom Verma <hariom18599@gmail.com>
> 
> We are looking at bitfield constants, and elsewhere in the Git source
> code, such cases are handled via bit shift operators rather than octal
> numbers, which also makes it easier to spot holes in the range
> (if, say, 1<<5 was missing, it is easier to spot it between 1<<4
> and 1<<6 than it is to spot a missing 040 between a 020 and a 0100).
> 
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
>  builtin/blame.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e946ba6cd9..a57020acf9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -319,18 +319,18 @@ static const char *format_time(timestamp_t time, const char *tz_str,
>  	return time_buf.buf;
>  }
>  
> -#define OUTPUT_ANNOTATE_COMPAT	001
> -#define OUTPUT_LONG_OBJECT_NAME	002
> -#define OUTPUT_RAW_TIMESTAMP	004
> -#define OUTPUT_PORCELAIN	010
> -#define OUTPUT_SHOW_NAME	020
> -#define OUTPUT_SHOW_NUMBER	040
> -#define OUTPUT_SHOW_SCORE	0100
> -#define OUTPUT_NO_AUTHOR	0200
> -#define OUTPUT_SHOW_EMAIL	0400
> -#define OUTPUT_LINE_PORCELAIN	01000
> -#define OUTPUT_COLOR_LINE	02000
> -#define OUTPUT_SHOW_AGE_WITH_COLOR	04000
> +#define OUTPUT_ANNOTATE_COMPAT      (1<<0)
> +#define OUTPUT_LONG_OBJECT_NAME     (1<<1)
> +#define OUTPUT_RAW_TIMESTAMP        (1<<2)
> +#define OUTPUT_PORCELAIN            (1<<3)
> +#define OUTPUT_SHOW_NAME            (1<<4)
> +#define OUTPUT_SHOW_NUMBER          (1<<5)
> +#define OUTPUT_SHOW_SCORE           (1<<6)
> +#define OUTPUT_NO_AUTHOR            (1<<7)
> +#define OUTPUT_SHOW_EMAIL           (1<<8)
> +#define OUTPUT_LINE_PORCELAIN       (1<<9)
> +#define OUTPUT_COLOR_LINE           (1<<10)
> +#define OUTPUT_SHOW_AGE_WITH_COLOR  (1<<11)

Nitpick: In the code you remove, tabs were used for alignment. Here, you 
use spaces. Unless there is any specific reason to do it this way, might 
as well keep the older style.

There was some discussion recently about converting these related 
#defines to enums [0]. We might consider doing that here.

If you read through that entire thread, you'd see that there were some 
disagreements about whether using enums for sets of bits is a good idea 
([1] and [2]), but it is at least something worth considering while we 
are on this topic.

FWIW, I think it is a good idea to use an enum here.

>  
>  static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
>  {

[0] https://public-inbox.org/git/20191010115230.10623-1-wambui.karugax@gmail.com/
[1] https://public-inbox.org/git/20191014182754.82302-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/xmqqk19ag60g.fsf@gitster-ct.c.googlers.com/

-- 
Regards,
Pratyush Yadav
