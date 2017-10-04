Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A552036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdJDCW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:22:27 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40566 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdJDCW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:22:26 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id HENM1w0020M91Ur01ENNTc; Wed, 04 Oct 2017 03:22:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=iwDNb8gy02JDgGpsTgwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
 <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
 <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com>
 <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b2816cf9-4657-1124-2172-e15b619d6d42@ramsayjones.plus.com>
Date:   Wed, 4 Oct 2017 03:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/10/17 04:51, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 02/10/17 14:44, Pranit Bauva wrote:
>> [snip]
>>> ...
>> Yes, I also meant to tidy that up by removing some, now
>> redundant, initialisation later in that function.
>>
>> Note, that wasn't the only bug! (I have probably forgotten
>> some of them, but look at 964f4e2b0, for example).
> 
> It seems that Pranit needs a bit more work to take known fixes from
> your efforts and we should wait for the series to be rerolled?

This series is just the first few patches from the original 28/29
patch series; in particular, patches 1-5 and 8 of that series.
If I compare just the first 5 patches, then the differences are
small and (maybe) not worth a re-roll. For some reason, I changed
the message passed to the delete_refs() call from "bisect: remove"
to "bisect: clean", we both added "terms" to the 'builtin command'
list but in different positions and some calls to die() have
been replaced with 'return error(...)'.

Viz:

  $ git log --oneline v2.14.0..bisect~34
  d8ce077c8 t6030: explicitly test for bisection cleanup
  1fd8e44a1 bisect--helper: `bisect_clean_state` shell function in C
  5aa9d18eb bisect--helper: `write_terms` shell function in C
  1b94b2ff1 bisect: rewrite `check_term_format` shell function in C
  a97a96ccf bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  $ 
  $ git log --oneline v2.14.0..pranit~1
  6012123c7 t6030: explicitly test for bisection cleanup
  7c945c391 bisect--helper: `bisect_clean_state` shell function in C
  9240c3962 bisect--helper: `write_terms` shell function in C
  ba496589c bisect--helper: rewrite `check_term_format` shell function in C
  f1563a33f bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  $ 

Note that the subject line of patch #2 has also been corrected
in this new series (bisect: -> bisect--helper:). I haven't
compared the commit messages.

  $ git diff bisect~34 pranit~1
  diff --git a/bisect.c b/bisect.c
  index b19311ca7..2838d672d 100644
  --- a/bisect.c
  +++ b/bisect.c
  @@ -1066,7 +1066,7 @@ int bisect_clean_state(void)
   	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
   	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
   	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
  -	result = delete_refs("bisect: clean", &refs_for_removal, REF_NODEREF);
  +	result = delete_refs("bisect: remove", &refs_for_removal, REF_NODEREF);
   	refs_for_removal.strdup_strings = 1;
   	string_list_clear(&refs_for_removal, 0);
   	unlink_or_warn(git_path_bisect_expected_rev());
  diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
  index 2af024f60..0f4d4e41c 100644
  --- a/builtin/bisect--helper.c
  +++ b/builtin/bisect--helper.c
  @@ -43,8 +43,8 @@ static int check_term_format(const char *term, const char *orig_term)
   	if (res)
   		return error(_("'%s' is not a valid term"), term);
   
  -	if (one_of(term, "help", "start", "terms", "skip", "next", "reset",
  -			"visualize", "replay", "log", "run", NULL))
  +	if (one_of(term, "help", "start", "skip", "next", "reset",
  +			"visualize", "replay", "log", "run", "terms", NULL))
   		return error(_("can't use the builtin command '%s' as a term"), term);
   
   	/*
  @@ -111,14 +111,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
   		return bisect_next_all(prefix, no_checkout);
   	case WRITE_TERMS:
   		if (argc != 2)
  -			die(_("--write-terms requires two arguments"));
  +			return error(_("--write-terms requires two arguments"));
   		return write_terms(argv[0], argv[1]);
   	case BISECT_CLEAN_STATE:
   		if (argc != 0)
  -			die(_("--bisect-clean-state requires no arguments"));
  +			return error(_("--bisect-clean-state requires no arguments"));
   		return bisect_clean_state();
   	default:
  -		die("BUG: unknown subcommand '%d'", cmdmode);
  +		return error("BUG: unknown subcommand '%d'", cmdmode);
   	}
   	return 0;
   }
  diff --git a/git-bisect.sh b/git-bisect.sh
  index f1202dfb4..045830c39 100755
  --- a/git-bisect.sh
  +++ b/git-bisect.sh
  @@ -209,7 +209,7 @@ bisect_start() {
   	eval "$eval true" &&
   	if test $must_write_terms -eq 1
   	then
  -		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
  +		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
   	fi &&
   	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
   	#
  $ 

So, the major differences and bug fixes are in later patches.

ATB,
Ramsay Jones

