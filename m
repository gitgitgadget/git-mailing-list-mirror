Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370481F453
	for <e@80x24.org>; Wed, 24 Apr 2019 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfDXVHI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 17:07:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbfDXVHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 17:07:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so9933634pfj.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+7G2l/DEanUiTbOH1vFRhBRhjBxr137ylH6vsqT40I=;
        b=U8qqAjLQMF7agD4mf6Nl80ptIF/pYXExt+GxsGO6KCWX9ICLRShVXxOjrg/fektOXL
         xGg/lDoqV0GKuvZEo95qnBzfNCEuINy5m+O17pp9JReEwqL3ULh7yqgoWjbcMlRs0UNL
         LOvqUT6T7S11mXJ6Wo1RZMmbUEJaj4hPil9CSqRxbZ0q7FpZIVa7kDc8DeZ4rKdtQSNp
         V0yUrwItRU7oD9UT91w7id9J3chbnT9KAf0+PsRzWQKoLldVyZm0lPLiGAwTuUFElgq7
         6wil5vHgL+KLnp3R1lIdgMYyKrRUnZlYm2mekIEXY6jOPaKnBt4M+IuYWnyDew76qO44
         S6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+7G2l/DEanUiTbOH1vFRhBRhjBxr137ylH6vsqT40I=;
        b=FmtD+PhRjZ7M1VjWnlyot37d+KC0NJbwGBxHVOBLlC8ogM+VizFqO5s2qHOxVbmqxD
         tOGdGK8R3oSmhTEPdSBUNpZjcsor8XYeSAn/JfbCKFq75MzoUREl+SpR0V1XIUJD4wZS
         0qT4NVSLg1wqq63rvrhvAFA6hs71I40Q4rwSBvY/Om1IYSvIzxeV3WT1JmKOoLLU+TiF
         tMi4rPtxsnZG45134Ua3WA9m0tOfzwSH3rAYP+vCPEPPg1lYXDxcUw14cLJSNnRFCTYJ
         6m/kg8TV82R7oPo7qfjvBW7Ch0tc0wvf2AUNdTH12oGEWKWCJnbmPGB4MtPjJk8b9s3d
         VocQ==
X-Gm-Message-State: APjAAAXqoP5YwMRT7Emk5S0hw4afwp/+jkO0p2a4AWaS1YPhH3xfsKdO
        JSwyV9STBVYs4PoMcuhGODebgg==
X-Google-Smtp-Source: APXvYqwCT/Cb/ix0hbMXexbRTpGzYKt9cfaJjRvXmez22tPtPG2YO8eoCfcpj1dQejqmG4064vdOxA==
X-Received: by 2002:a63:af0a:: with SMTP id w10mr32883995pge.67.1556140026280;
        Wed, 24 Apr 2019 14:07:06 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id o7sm13539555pgv.63.2019.04.24.14.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:07:04 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
 <20190422222647.48628-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <f3149591-443f-8378-5221-ce4a1879d4af@google.com>
Date:   Wed, 24 Apr 2019 17:07:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190422222647.48628-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Michael -

I dug into the code a bit more and have some more comments below.  Take 
anything I say with a grain of salt; I'm still trying to understand how 
it all works.  =)

If you do have updates to your patch, see if you can make it apply onto 
my branch at https://github.com/brho/git/commits/master.  I have a 
commit there called "WIP-michael-fuzzy", which is mostly all of your 
stuff plus the style changes and whatnot I was talking about.  Though if 
you give me something else, I can make that work too.

All in all, I think we're pretty close to having something cool.  =)

On 4/22/19 6:26 PM, michael@platin.gs wrote:

> @@ -0,0 +1,434 @@
> +#include "fuzzy.h"
> +#include <ctype.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "git-compat-util.h"
> +#include "hashmap.h"
> +
> +struct fingerprint_entry {
> +	struct hashmap_entry entry;
> +	int count;
> +};
> +struct fingerprint {
> +	struct hashmap map;
> +	struct fingerprint_entry *entries;
> +};
> +

The whole fingerprinting section could use a good comment.  What is a 
fingerprint, why/how we use them, what it means to be similar, etc.

> +static void get_fingerprint(struct fingerprint *result,
> +			    const char *line_begin,
> +			    const char *line_end) {
> +	unsigned hash;
> +	char c0, c1;
> +	int map_entry_count = line_end - line_begin - 1;
> +	struct fingerprint_entry *entry = xcalloc(map_entry_count,
> +		sizeof(struct fingerprint_entry));
> +	struct fingerprint_entry *found_entry;
> +	hashmap_init(&result->map, NULL, NULL, map_entry_count);
> +	result->entries = entry;
> +	for (const char *p = line_begin; p + 1 < line_end; ++p, ++entry) {
> +		c0 = *p;
> +		c1 = *(p + 1);
> +		/* Ignore whitespace pairs */
> +		if (isspace(c0) && isspace(c1))
> +			continue;
> +		hash = tolower(c0) | (tolower(c1) << 8);
> +		hashmap_entry_init(entry, hash);
> +
> +		if ((found_entry = hashmap_get(&result->map, entry, NULL))) {
> +			found_entry->count += 1;
> +		}
> +		else {
> +			entry->count = 1;
> +			hashmap_add(&result->map, entry);
> +		}
> +	}
> +}

[snip]





> +static int get_closest_local_line(int start_a,
> +			    int local_line_b,
> +			    int closest_line_calc_offset1,
> +			    int closest_line_calc_offset2,
> +			    int closest_line_calc_numerator,
> +			    int closest_line_calc_denominator) {
> +	return ((local_line_b + closest_line_calc_offset1) * 2 + 1) *
> +		closest_line_calc_numerator /
> +		(closest_line_calc_denominator * 2) +
> +		closest_line_calc_offset2 - start_a;
> +}

Overall, I found the final four parameters (offset1, offset2, numer, and 
denom) to be confusing, used here and passed through all of the functions.

What are they exactly?  Do they ever change from the first invocation of 
fuzzy_find_matching_lines_recurse()?  The only one I saw that changed 
was 'closest_line_calc_offset1 + offset_b' in the upper half of the 
recursive call.

So if I'm following it correctly, closest_line_calc_offset2 is always == 
start_a, so then in what 'file space' does the return val from 
get_closest_local_line() reside?  A's space?  Relative number to the 
beginning of start_a?

What all is the closest_local_line?  The line in A that corresponds to 
the line in B, for some mapping function?  Maybe the corresponding 
fractional bit?  (hence the division, but there's also that *2 in there)

The assertion that trips for me is related to this - we get a 
closest_local_line_a that is farther than max_search_distance_a from 
local_line_a.

On a related note, any 1-1 offsetting between A and B seems precarious. 
It's the 'offset' variable passed in from guess_line_blames().  But if 
you're calculating it from start_b - start_a, that is a little brittle. 
start_b is the tiny window of e->s_lno.  If we ever change things to 
look into the entire diff chunk (the one passed to guess_line_blames()), 
then that will break.  Not sure if you're offsetting in this manner or 
not.  (looks like 'no').

> +
> +static int *get_similarity(int *similarities, int max_search_distance_a,
> +			   int local_line_a, int local_line_b,
> +			   int closest_local_line_a) {
> +	assert(abs(local_line_a - closest_local_line_a) <= max_search_distance_a);
> +	return similarities + local_line_a - closest_local_line_a +
> +		max_search_distance_a +
> +		local_line_b * (max_search_distance_a * 2 + 1);
> +}

This needs some sort of comment.  From it's allocation below (and from 
staring at the code long enough), I gather the similarities array is a 
2D array, "each line in B" by "each line in a window (of size X) in A 
centered on some line in A mapping to B", where X is 
(max_search_distance_a * 2 + 1), and 'some line' is closest_local_line_a.

Is this something like "for line b, get sim for local_line a"?  Is it 
local_line_a or closest_local_line_a that we are getting?  It's not 
clear from the prototype alone.

Maybe the 'closest_local_line_a' ought to be decided inside this 
function, so it's a simpler-looking 'getter.'  Or better yet, maybe 
there's a lookup array mapping B -> "window in A".  (more on this later).

> +
> +#define CERTAIN_NOTHING_MATCHES -2
> +#define CERTAINTY_NOT_CALCULATED -1
> +
> +static void find_best_line_matches(const int max_search_distance_a,
> +				   int start_a,
> +				   int length_a,
> +				   int local_line_b,
> +				   struct fingerprint *fingerprints_a,
> +				   struct fingerprint *fingerprints_b,

I was a little worried about keeping track of what offset / "address 
space" we're in.  The fingerprint arrays passed in are both set so the 
0th member corresponds to the FP for start_a or start_b, with length_a 
or length_b members.

start_a and local_line_b are in different types spaces: start_a is 
absolute in 'A' and local_line_b is relative in 'B'.  Eventually, I 
figured out that that is what 'local' meant.  Seeing both start_a 
(absolute) and local_line_b (relative) passed in made me worry a little 
about whether or not there was a bug.  Maybe compute and pass in the 
local_a_line instead?

I see later on that you use start_a in this function so you can store 
result[] and second_best_result[] in A's absolute space.

It might make sense to pick a space (absolute or relative) and use it 
throughout.

> +				   int *similarities,
> +				   int *certainties,
> +				   int *second_best_result,
> +				   int *result,
> +				   int closest_line_calc_offset1,
> +				   int closest_line_calc_offset2,
> +				   int closest_line_calc_numerator,
> +				   int closest_line_calc_denominator) {
> +
> +	int i, search_start, search_end, closest_local_line_a, *similarity,
> +		best_similarity = 0, second_best_similarity = 0,
> +		best_similarity_index = 0, second_best_similarity_index = 0;
> +
> +	if (certainties[local_line_b] != CERTAINTY_NOT_CALCULATED)
> +		return;
> +
> +	closest_local_line_a = get_closest_local_line(start_a,
> +					  local_line_b,
> +					  closest_line_calc_offset1,
> +					  closest_line_calc_offset2,
> +					  closest_line_calc_numerator,
> +					  closest_line_calc_denominator);
> +
> +	search_start = closest_local_line_a - max_search_distance_a;
> +	if (search_start < 0)
> +		search_start = 0;
> +
> +	search_end = closest_local_line_a + max_search_distance_a + 1;
> +	if (search_end > length_a)
> +		search_end = length_a;
> +
> +	for (i = search_start; i < search_end; ++i) {
> +		similarity = get_similarity(similarities, max_search_distance_a,
> +					    i, local_line_b,
> +					    closest_local_line_a);
> +		if (*similarity == -1) {
> +			*similarity = fingerprint_similarity(
> +				fingerprints_b + local_line_b,
> +				fingerprints_a + i) *
> +				(1000 - abs(i - closest_local_line_a));

Need some assertion that "1000 > 2*max_search_distance_a + 1" or 
something?  I know that number is '21', but it's based on a hard-coded 
integer somewhere else.

> +		}
> +		if (*similarity > best_similarity) {
> +			second_best_similarity = best_similarity;
> +			second_best_similarity_index = best_similarity_index;
> +			best_similarity = *similarity;
> +			best_similarity_index = i;
> +		}
> +		else if (*similarity > second_best_similarity) {
> +			second_best_similarity = *similarity;
> +			second_best_similarity_index = i;
> +		}
> +	}
> +
> +	if (best_similarity == 0) {
> +		certainties[local_line_b] = CERTAIN_NOTHING_MATCHES;
> +		result[local_line_b] = -1;
> +	}
> +	else {
> +		certainties[local_line_b] = best_similarity * 2 -
> +			second_best_similarity;
> +		result[local_line_b] = start_a + best_similarity_index;
> +		second_best_result[local_line_b] =
> +			start_a + second_best_similarity_index;
> +	}
> +}
> +
> +/*
> + * This finds the line that we can match with the most confidence, and
> + * uses it as a partition. It then calls itself on the lines on either side of
> + * that partition. In this way we avoid lines appearing out of order, and
> + * retain a sensible line ordering.
> + */
> +static void fuzzy_find_matching_lines_recurse(
> +	int max_search_distance_a,
> +	int max_search_distance_b,
> +	int start_a, int start_b,
> +	int length_a, int length_b,
> +	struct fingerprint *fingerprints_a,
> +	struct fingerprint *fingerprints_b,
> +	int *similarities,
> +	int *certainties,
> +	int *second_best_result,
> +	int *result,
> +	int closest_line_calc_offset1,
> +	int closest_line_calc_offset2,
> +	int closest_line_calc_numerator,
> +	int closest_line_calc_denominator) {

For all of the arguments that never change, which seem to be the last 
three args and the search distances, you could consider putting them in 
a struct and passing that along.  Similarly, the only time the 
fingerprints and the four int arrays change is in the upper half of the 
recursive call.

You might be able to put most all of those array args into the args 
struct too, such that that struct always represents the original window 
(or even the absolute numbers?), and then pass along the offsets. 
You're somewhat doing that already when you pass second_half_start_a, 
second_half_start_b (which includes offset_b), etc, down below.

> +
> +	int i, barrier, invalidate_min, invalidate_max, offset_b,
> +		second_half_start_a, second_half_start_b,
> +		second_half_length_a, second_half_length_b,
> +		most_certain_line_a, most_certain_local_line_b = -1,
> +		most_certain_line_certainty = -1,
> +		closest_local_line_a;
> +
> +	for (i = 0; i < length_b; ++i) {
> +		find_best_line_matches(max_search_distance_a,
> +				       start_a,
> +				       length_a,
> +				       i,
> +				       fingerprints_a,
> +				       fingerprints_b,
> +				       similarities,
> +				       certainties,
> +				       second_best_result,
> +				       result,
> +				       closest_line_calc_offset1,
> +				       closest_line_calc_offset2,
> +				       closest_line_calc_numerator,
> +				       closest_line_calc_denominator);
> +
> +		if (certainties[i] > most_certain_line_certainty) {
> +			most_certain_line_certainty = certainties[i];
> +			most_certain_local_line_b = i;
> +		}
> +	}
> +
> +	if (most_certain_local_line_b == -1) {
> +		return;
> +	}
> +
> +	most_certain_line_a = result[most_certain_local_line_b];
> +
> +	/* Subtract the most certain line's fingerprint in b from the
> +	 matched fingerprint in a. This means that other lines in b can't also
> +	 match the same parts of the line in a. */
> +	fingerprint_subtract(fingerprints_a + most_certain_line_a - start_a,
> +			     fingerprints_b + most_certain_local_line_b);

FYI, if I comment out fingerprint_subtract, this will pass your test 2 
(currently failing), but fail test 5 (currently passing).

> +
> +
> +	/* Invalidate results that may be affected by the choice of pivot. */
> +	invalidate_min = most_certain_local_line_b - max_search_distance_b;
> +	invalidate_max = most_certain_local_line_b + max_search_distance_b + 1;
> +	if (invalidate_min < 0)
> +		invalidate_min = 0;
> +	if (invalidate_max > length_b)
> +		invalidate_max = length_b;
> +
> +	for (i = invalidate_min; i < invalidate_max; ++i) {
> +		closest_local_line_a = get_closest_local_line(
> +			start_a, i,
> +			closest_line_calc_offset1,
> +			closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +		*get_similarity(similarities, max_search_distance_a,
> +				most_certain_line_a - start_a, i,
> +				closest_local_line_a) = -1;

The assert in get_similarity fails on my example when called from here. 
I guess something went wrong with finding the window center.

> +	}
> +
> +	barrier = most_certain_line_a;
> +
> +	for (i = most_certain_local_line_b - 1; i >= invalidate_min; --i) {
> +		if (certainties[i] >= 0 &&
> +		    (result[i] >= barrier || second_best_result[i] >= barrier)) {
> +			    certainties[i] = CERTAINTY_NOT_CALCULATED;
> +			    barrier = result[i];
> +			    invalidate_min = i - max_search_distance_b;
> +			    if (invalidate_min < 0)
> +				    invalidate_min = 0;
> +		    }
> +	}

Is it important for this function (above) to go in descending order, and 
the next to go in ascending order?  If you can go i = 0; i<foo; i++ for 
both, then maybe a helper function can replace both of these functions 
(above and below this comment).

> +
> +	barrier = most_certain_line_a;
> +
> +	for (i = most_certain_local_line_b + 1; i < invalidate_max; ++i) {
> +		if (certainties[i] >= 0 &&
> +		    (result[i] <= barrier || second_best_result[i] <= barrier)) {
> +			    certainties[i] = CERTAINTY_NOT_CALCULATED;
> +			    barrier = result[i];
> +			    invalidate_max = i + max_search_distance_b + 1;
> +			    if (invalidate_max > length_b)
> +				    invalidate_max = length_b;
> +		    }
> +	}

What's the intuition behind the steps to invalidate the results?

It looks like you want to reset the similarity calculations for any 
other line in B that was compared to the matching A line, so that that A 
line is not matched again until its similarity is recomputed (due to the 
"fingerprint subtraction"?).

You limit it to invalidate_min and max, then clamp those to the real 
min/max (0, length_b).  Initially, I thought that's a performance 
optimization (vs correctness) since you want to limit recalculations. 
Though I think the assumption is that you'll never ask for a 
get_similarity(a, b) where A is outside the reachable radius of B 
(max_search_distance_b).

What about with the certainties?  It seems like you're trying to limit 
which ones get reset.  Why do you check result[i] <= barrier, instead of 
just equality?

> +
> +
> +	if (most_certain_local_line_b > 0) {
> +		fuzzy_find_matching_lines_recurse(
> +			max_search_distance_a,
> +			max_search_distance_b,
> +			start_a, start_b,
> +			most_certain_line_a + 1 - start_a,
> +			most_certain_local_line_b,
> +			fingerprints_a, fingerprints_b, similarities,
> +			certainties, second_best_result, result,
> +			closest_line_calc_offset1, closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +	}
> +	if (most_certain_local_line_b + 1 < length_b) {
> +		second_half_start_a = most_certain_line_a;
> +		offset_b = most_certain_local_line_b + 1;
> +		second_half_start_b = start_b + offset_b;
> +		second_half_length_a =
> +			length_a + start_a - second_half_start_a;
> +		second_half_length_b =
> +			length_b + start_b - second_half_start_b;
> +		fuzzy_find_matching_lines_recurse(
> +			max_search_distance_a,
> +			max_search_distance_b,
> +			second_half_start_a, second_half_start_b,
> +			second_half_length_a, second_half_length_b,
> +			fingerprints_a + second_half_start_a - start_a,
> +			fingerprints_b + offset_b,
> +			similarities +
> +				offset_b * (max_search_distance_a * 2 + 1),
> +			certainties + offset_b,
> +			second_best_result + offset_b, result + offset_b,
> +			closest_line_calc_offset1 + offset_b,
> +			closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +	}
> +}
> +
> +int *fuzzy_find_matching_lines(const char *content_a,
> +			       const char *content_b,
> +			       const int *line_starts_a,
> +			       const int *line_starts_b,
> +			       int start_a,
> +			       int start_b,
> +			       int length_a,
> +			       int length_b) {
> +
> +	int i, *result, *second_best_result,
> +		*certainties, *similarities, similarity_count;
> +	struct fingerprint *fingerprints_a, *fingerprints_b;
> +
> +	/* max_search_distance_a means that given a line in `b`, compare it to
> +	the line in `a` that is closest to its position, and the lines in `a`
> +	that are no greater than max_search_distance_a lines away from the
> +	closest line in `a`.
> +	max_search_distance_b is an upper bound on the greatest possible
> +	distance between lines in `b` such that they will both be compared with
> +	the same line in `a` according to max_search_distance_a. */
> +	int max_search_distance_a = 10, max_search_distance_b;
> +
> +	if (max_search_distance_a >= length_a)
> +		max_search_distance_a = length_a ? length_a - 1 : 0;
> +
> +	if (length_a == 0) {
> +		max_search_distance_b = 0;
> +	}
> +	else {
> +		max_search_distance_b = ((2 * max_search_distance_a + 1) *
> +			length_b - 1) / length_a;
> +	}

A few questions / comments about these search distances:

- max_search_distance_a and _b sounds like different concepts.  maybe 
different names?  it's also hard to follow how you get these numbers, 
especially since it seems there is some scaling involved when converting 
from A space to B space.

- is the max_search_distance_a limited to 10 for performance reasons? 
conceptually, it'd be easier the similarities array was length_b * 
length_a.  instead, it sounds like every line B has a (potentially) 
separate window into A.  maybe it'd be simpler to have another array 
that tracks for each B, which line in A is the *start* of its window. 
that'd also make me rest easier when worrying about odd numbers, 
division, and off-by-one issues.

- the (2 * max_search_distance_a + 1) comes up a lot.  similarly, that 
calculation involving dividing by length_a comes up too.  maybe 
encapsulate those in some other smaller set of functions, so it's clear 
when they are being used for the same purpose.  i'm having a hard time 
convincing myself there aren't off-by-one issues.  (not that there are).

Thanks,

Barret

