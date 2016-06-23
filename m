Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F5B1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 13:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbcFWN6E (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 09:58:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42524 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcFWN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 09:58:03 -0400
X-Greylist: delayed 9498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jun 2016 09:58:03 EDT
Received: from mfilter40-d.gandi.net (mfilter40-d.gandi.net [217.70.178.171])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 2703FFB8CE;
	Thu, 23 Jun 2016 15:58:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter40-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter40-d.gandi.net (mfilter40-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id H3VgrOXiAX1O; Thu, 23 Jun 2016 15:57:58 +0200 (CEST)
X-Originating-IP: 90.127.150.110
Received: from Lumpy.local.mail (LFbn-1-3387-110.w90-127.abo.wanadoo.fr [90.127.150.110])
	(Authenticated sender: scourtois@cubyx.fr)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7F9E2FB8A1;
	Thu, 23 Jun 2016 15:57:58 +0200 (CEST)
Date:	Thu, 23 Jun 2016 15:57:58 +0200
From:	Simon Courtois <scourtois@cubyx.fr>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Message-ID: <etPan.576beae6.5440514e.9bf5@cubyx.fr>
In-Reply-To: <20160623131028.GB12653@sigill.intra.peff.net>
References: <20160623130828.GA25209@sigill.intra.peff.net>
 <20160623131028.GB12653@sigill.intra.peff.net>
Subject: Re: [PATCH 2/2] color: support "italic" attribute
X-Mailer: Airmail Beta (369)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Wow I wasn't expecting such a rapid response, you're awesome! :-D

Simon Courtois

On 23 June 2016 at 15:10:33, Jeff King (peff@peff.net) wrote:
> We already support bold, underline, and similar attributes.
> Let's add italic to the mix. According to the Wikipedia
> page on ANSI colors, this attribute is "not widely
> supported", but it does seem to work on my xterm.
> 
> We don't have to bump the maximum color size because we were
> already over-allocating it (but we do adjust the comment
> appropriately).
> 
> Requested-by: Simon Courtois 
> Signed-off-by: Jeff King 
> ---
> Documentation/config.txt | 2 +-
> color.c | 8 ++++----
> color.h | 3 ++-
> t/t4026-color.sh | 4 ++--
> 4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 58673cf..4b97d8d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -154,7 +154,7 @@ color::
> colors (at most two) and attributes (at most one), separated
> by spaces. The colors accepted are `normal`, `black`,
> `red`, `green`, `yellow`, `blue`, `magenta`, `cyan` and
> - `white`; the attributes are `bold`, `dim`, `ul`, `blink` and
> + `white`; the attributes are `bold`, `dim`, `italic`, `ul`, `blink` and
> `reverse`. The first color given is the foreground; the
> second is the background. The position of the attribute, if
> any, doesn't matter. Attributes may be turned off specifically
> diff --git a/color.c b/color.c
> index 8f85153..698682c 100644
> --- a/color.c
> +++ b/color.c
> @@ -125,11 +125,11 @@ static int parse_color(struct color *out, const char *name, int 
> len)
> 
> static int parse_attr(const char *name, int len)
> {
> - static const int attr_values[] = { 1, 2, 4, 5, 7,
> - 22, 22, 24, 25, 27 };
> + static const int attr_values[] = { 1, 2, 3, 4, 5, 7,
> + 22, 22, 23, 24, 25, 27 };
> static const char * const attr_names[] = {
> - "bold", "dim", "ul", "blink", "reverse",
> - "nobold", "nodim", "noul", "noblink", "noreverse"
> + "bold", "dim", "italic", "ul", "blink", "reverse",
> + "nobold", "nodim", "noitalic", "noul", "noblink", "noreverse"
> };
> int i;
> for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
> diff --git a/color.h b/color.h
> index e24fa0b..3af01a6 100644
> --- a/color.h
> +++ b/color.h
> @@ -16,7 +16,8 @@ struct strbuf;
> *
> * The space for attributes is also slightly overallocated, as
> * the negation for some attributes is the same (e.g., nobold and nodim).
> - * We also allocate space for 6 attributes (even though we have only 5).
> + *
> + * We allocate space for 6 attributes.
> */
> #define COLOR_MAXLEN 70
> 
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 2b32c4f..05625c5 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -56,8 +56,8 @@ test_expect_success 'long color specification' '
> 
> test_expect_success 'absurdly long color specification' '
> color \
> - "#ffffff #ffffff bold nobold dim nodim ul noul blink noblink reverse noreverse" \
> - "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
> + "#ffffff #ffffff bold nobold dim nodim italic noitalic ul noul blink noblink reverse 
> noreverse" \
> + "[1;2;3;4;5;7;22;23;24;25;27;38;2;255;255;255;48;2;255;255;255m"
> '
> 
> test_expect_success '0-7 are aliases for basic ANSI color names' '
> --
> 2.9.0.209.g845fbc1
> 

