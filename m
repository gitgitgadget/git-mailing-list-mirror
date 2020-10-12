Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277BFC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88AF208D5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzP4dg+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgJLUjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgJLUji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594CC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 13:39:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so18877913qkg.8
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w5bgdcRHxLmDjZLy7jd3ObpH6mOOSo5AreAhz07T0Cw=;
        b=TzP4dg+SS7iZGdRvem8jXLVILY4EPK+4nBdD7z3zt3Silp65JB9UVL6T+P7+UV9f5q
         vMgy2mW40IV6iygGq4ILQdEgOWWJhSgZWdnaQAUplf+z5/2iypFMYckulM/Rueo+2uyZ
         SNZHudlkwvArdePGNqdnsaSSZyUfhxgWhEKDsF+3mGsS72hHqdlN5DomikQE0jK+gPMp
         X3yGJC7qFh2eQhS5ilXD+UaRgl3BapWVnYFzoGEo+bH9FIZgC2xwsQlWD+Z8iSKB1jsO
         5bg4OLfqOegmiopTmK+m0sHF1okppMJgib5P/T/pYygUCvsOoNphb591Yhvi2xkk/f71
         TzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w5bgdcRHxLmDjZLy7jd3ObpH6mOOSo5AreAhz07T0Cw=;
        b=Ffx5BVeU9AFFkSR+3flqA7koWop8ERiDNYBppeEVE2jxSuqsk7hhG1C2RSvS9JuPqY
         bjGOvBspkBwIn6Il6uNpj+FyVzqgI9kIR7xqnraj6rs7CunOxiTlkMGPoToX3xPXrJB2
         eRBgoT+WVT58/OfdacAqmMQ5Q9y75Wmp8ix0bafO6BWUbOsZO3P8gUnbEm0aCYib5v09
         oj7yXq9A7DB5UvnVAcTpzduEwnueqvJLFq9FWDp4NNcoUKhzzoj/apddg1c5yRlRX1uc
         WEuxeEvCQqRtViwf7Z7jLIf9kx5/oEwi2pC6fVCgJRJn9d5xILad060e7fT0o4DLtKIq
         78gw==
X-Gm-Message-State: AOAM530ymHgcxiNks4t5yFSsxKlCZszRAslE6Rm7ITTlQ9wk6FevLip1
        WiGYh5AdOWnf5XRKm38+YHtYlinzytgbVLH+
X-Google-Smtp-Source: ABdhPJyMxexipP9R+cH8Hpj1Bt8uS/VIuICXBz3Bgnf/rHLCXJjacgPAITo3T1f/IHn71C9gk54zaA==
X-Received: by 2002:a37:4e45:: with SMTP id c66mr11928609qkb.36.1602535175541;
        Mon, 12 Oct 2020 13:39:35 -0700 (PDT)
Received: from [192.168.0.108] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id t12sm8781518qkg.132.2020.10.12.13.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 13:39:34 -0700 (PDT)
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200925055954.1111389-1-gitster@pobox.com>
 <20200925055954.1111389-3-gitster@pobox.com>
 <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
 <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
 <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
 <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de>
From:   Barret Rhoden <brho@google.com>
Message-ID: <cd2c51da-55c6-cc5e-2da1-69db90aaf438@google.com>
Date:   Mon, 12 Oct 2020 16:39:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 10/11/20 12:03 PM, René Scharfe wrote:
[snip]
>> Any performance improvement would be welcome.  I haven't looked at
>> the code in a while, but I don't recall any reasons why this wouldn't
>> work.
> 
> Using a commit flag instead of an oidset would only improve
> performance noticeably if the product of the number of suspects and
> ignored commits was huge, I guess.
> 
> I get weird timings for an ignore file containing basically all commits
> (created with "git log --format=%H").  With Git's own repo and rc1:
> 
> Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
>    Time (mean ± σ):      8.470 s ±  0.049 s    [User: 7.923 s, System: 0.547 s]
>    Range (min … max):    8.434 s …  8.605 s    10 runs
> 
> And with the patch at the bottom:
> 
> Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
>    Time (mean ± σ):      8.048 s ±  0.061 s    [User: 7.899 s, System: 0.146 s]
>    Range (min … max):    7.987 s …  8.175 s    10 runs
> 
> That looks like a nice speedup, but why for system time alone?  Malloc
> overhead perhaps?

Hard to say.  Maybe page faults when walking the old ignore_list?

> Anyway, here's the patch:

Looks good to me.

Barret


> ---
>   blame.c         |  2 +-
>   blame.h         |  5 +++--
>   builtin/blame.c | 16 ++++++++++++----
>   object.h        |  3 ++-
>   4 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/blame.c b/blame.c
> index 686845b2b4..6e8c8fec9b 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -2487,7 +2487,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
>   	/*
>   	 * Pass remaining suspects for ignored commits to their parents.
>   	 */
> -	if (oidset_contains(&sb->ignore_list, &commit->object.oid)) {
> +	if (commit->object.flags & BLAME_IGNORE) {
>   		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
>   		     i < num_sg && sg;
>   		     sg = sg->next, i++) {
> diff --git a/blame.h b/blame.h
> index b6bbee4147..d35167e8bd 100644
> --- a/blame.h
> +++ b/blame.h
> @@ -16,6 +16,9 @@
>   #define BLAME_DEFAULT_MOVE_SCORE	20
>   #define BLAME_DEFAULT_COPY_SCORE	40
> 
> +/* Remember to update object flag allocation in object.h */
> +#define BLAME_IGNORE	(1u<<14)
> +
>   struct fingerprint;
> 
>   /*
> @@ -125,8 +128,6 @@ struct blame_scoreboard {
>   	/* linked list of blames */
>   	struct blame_entry *ent;
> 
> -	struct oidset ignore_list;
> -
>   	/* look-up a line in the final buffer */
>   	int num_lines;
>   	int *lineno;
> diff --git a/builtin/blame.c b/builtin/blame.c
> index bb0f29300e..1c6721b5d5 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -830,21 +830,29 @@ static void build_ignorelist(struct blame_scoreboard *sb,
>   {
>   	struct string_list_item *i;
>   	struct object_id oid;
> +	const struct object_id *o;
> +	struct oidset_iter iter;
> +	struct oidset ignore_list = OIDSET_INIT;
> 
> -	oidset_init(&sb->ignore_list, 0);
>   	for_each_string_list_item(i, ignore_revs_file_list) {
>   		if (!strcmp(i->string, ""))
> -			oidset_clear(&sb->ignore_list);
> +			oidset_clear(&ignore_list);
>   		else
> -			oidset_parse_file_carefully(&sb->ignore_list, i->string,
> +			oidset_parse_file_carefully(&ignore_list, i->string,
>   						    peel_to_commit_oid, sb);
>   	}
>   	for_each_string_list_item(i, ignore_rev_list) {
>   		if (get_oid_committish(i->string, &oid) ||
>   		    peel_to_commit_oid(&oid, sb))
>   			die(_("cannot find revision %s to ignore"), i->string);
> -		oidset_insert(&sb->ignore_list, &oid);
> +		oidset_insert(&ignore_list, &oid);
>   	}
> +	oidset_iter_init(&ignore_list, &iter);
> +	while ((o = oidset_iter_next(&iter))) {
> +		struct commit *commit = lookup_commit(sb->repo, o);
> +		commit->object.flags |= BLAME_IGNORE;
> +	}
> +	oidset_clear(&ignore_list);
>   }
> 
>   int cmd_blame(int argc, const char **argv, const char *prefix)
> diff --git a/object.h b/object.h
> index 20b18805f0..6818c9296b 100644
> --- a/object.h
> +++ b/object.h
> @@ -64,7 +64,8 @@ struct object_array {
>    * negotiator/default.c:       2--5
>    * walker.c:                 0-2
>    * upload-pack.c:                4       11-----14  16-----19
> - * builtin/blame.c:                        12-13
> + * blame.c:                                     14
> + * builtin/blame.c:                        12---14
>    * bisect.c:                                        16
>    * bundle.c:                                        16
>    * http-push.c:                          11-----14
> --
> 2.28.0
> 

