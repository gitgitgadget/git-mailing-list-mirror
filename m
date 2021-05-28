Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6158C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8157613D4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhE1QON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 12:14:13 -0400
Received: from mout.web.de ([212.227.15.3]:33671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhE1QOK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622218350;
        bh=G0gN/8Lbq4T4DbioqXuP+kw37f20BOnh07emJXz4l5Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ssMrYePnlYnCmXQb5PmOQzg4SGSEbRfeZMr/6EwjE7bpz/kDlqVq4yQ+8pZHe42G8
         JE1uapZ/yYszu4w4IMV5O7S3DoS414m+SoIIRhMS5Hwb0AS3R4Oi98gqxTVKMSVz00
         HYDs2JWvxI6V1mYlNhp+kUI9UQBNaOOgh8lvTiek=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6Dve-1lTboV3sba-00y8si; Fri, 28 May 2021 18:12:29 +0200
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
 <e0842d32-a11c-91d8-3660-cffdb5639193@web.de>
 <CABPp-BH_nFJ2N6Jf64jZPNKdbwm2Yt=zo6pw-9s6S+fzo7a=pg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <106a5592-4e5e-cf06-16e4-100ca3c3fb5f@web.de>
Date:   Fri, 28 May 2021 18:12:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BH_nFJ2N6Jf64jZPNKdbwm2Yt=zo6pw-9s6S+fzo7a=pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:93XXTU/ZCv2rvxD9bleoOTKKFDIsw933F7sS7GY2g8uvmLUx7fZ
 golJi8jD0oZNxBpLDmZa3UAXCpEX0eG/dqq2cqwvaVVjYUI7FwxhfO3SU29kNhN+RmmnKxz
 3ACFv2NlblyxWZPmfPN9G0ejvRIPyJu6kf6my/IAcqtGcSjej5H1lJxTaSQZB5hh6bRmFRq
 TB8v5cjmcvzdF2ZMKtHiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7qUyMblFo5s=:d3x9O4HimKQIMQD+nyZ89D
 QpeXOVbEpDnOPExvaAVzVN306n7YaV/5XBayyiKQwFoAAKwWslrSKb6kif9bIDE/0ZmClTVgo
 SA5WKeBPTuskrOeIqJY48wF5SvQqbjzhDynhnKe0J7mpbjE5VtR1wYVdQu3YJDPOSiQTUvK2B
 mEiPqntKAOXtmma0K6awn+dJt0gLj5QLHCKlvlCOyAURUwKqNxppotXq07ikupJhT0JiAlUJW
 zcec9zrW0tQDTdWohUFOW+jHgrH2lSkSWhC940ht3HRDr8yOC0D/2gqad7baCSIQI6nTIqbxk
 jqZ6gzOR+B9KC2r+x8tNj3tMWxALgBS5szXnmenbcNdIP26AiB7deaanVrNzoQKZI8bQ79xGe
 pVz6eKNYCzfQUdZXywTL2WnbRpfiVLex4Oj86wrIzpOXfxxQS2o71JfEiAjERuOsSQnLICZ3D
 +ceG9g7skZYvAwxUjVueHgGCx4oV68NlaS8jjUED1o1H8c0batMnSw9sC/ID9tf17HYnCHThW
 oYv3sTmOa2Hnu5414XcosQLYGbmQMnEAlrWyFMyIEH763+qnO2mDWUKXRkphSx1ygs67bYMZL
 FlCoO5szqs+sTRQch7jAR+KeOakQNNEOzUZELn1aYmZuEdGdIIPL64ufkBY8q+SmygFGEzPCQ
 Ecpu+D3HaPqhu7EJdB5dK9nEqe+CHnSAMd5rdtwF8Ga+f290z7GFebsbET7GIZJrlJy29LNmG
 BnStKmKQd8/TMm1KRGBqjcXx9PWs1j1VPUToNebu9pxJ7qzA2O/uUas4UBtPvxvUJ903avI8V
 AZtMNT+PwYVEF1gFS+pC4Zgzeb6eXF0uegG0vJDYJQxFyfhH8xJOVQH49BvaZ0NC43tpGGCh4
 HCLH/f8W66QG0Tyk0YRvfLsXuPyiNrfoKpgWL8yLdJJGS2HzHVjPNRNwyo3cm1CrkULk9XT8y
 5SECLwtb5iJ4oSwhWc1LdMAmK80Aw2MnkYXKayVE+9LlAa5iLcCgLvnrXrev2jZad4sX/cJUQ
 cTriTSX0O8pEYVM0ka6n2cdy/+P6s9PsRw/xDxREQeoX4RBgWB6hiHbFOeVqjVBmA2zRWKXhO
 Bu80hpObQeDQ855BNuHGSH8nZTUk4nUMXV9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.21 um 00:47 schrieb Elijah Newren:
> On Thu, May 27, 2021 at 2:00 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 27.05.21 um 10:37 schrieb Elijah Newren via GitGitGadget:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Gathering accumulated times from trace2 output on the mega-renames
>>> testcase, I saw the following timings (where I'm only showing a few
>>> lines to highlight the portions of interest):
>>>
>>>     10.120 : label:incore_nonrecursive
>>>         4.462 : ..label:process_entries
>>>            3.143 : ....label:process_entries setup
>>>               2.988 : ......label:plist special sort
>>>            1.305 : ....label:processing
>>>         2.604 : ..label:collect_merge_info
>>>         2.018 : ..label:merge_start
>>>         1.018 : ..label:renames
>>>
>>> In the above output, note that the 4.462 seconds for process_entries w=
as
>>> split as 3.143 seconds for "process_entries setup" and 1.305 seconds f=
or
>>> "processing" (and a little time for other stuff removed from the
>>> highlight).  Most of the "process_entries setup" time was spent on
>>> "plist special sort" which corresponds to the following code:
>>>
>>>     trace2_region_enter("merge", "plist special sort", opt->repo);
>>>     plist.cmp =3D string_list_df_name_compare;
>>>     string_list_sort(&plist);
>>>     trace2_region_leave("merge", "plist special sort", opt->repo);
>>>
>>> In other words, in a merge strategy that would be invoked by passing
>>> "-sort" to either rebase or merge, sorting an array takes more time th=
an
>>> anything else.  Serves me right for naming my merge strategy this way.
>>>
>>> Rewrite the comparison function and remove as many levels of indirecti=
on
>>> as possible (e.g. the old code had
>>>     cmp_items() ->
>>>       string_list_df_name_compare() ->
>>>         df_name_compare()
>>> now we just have sort_dirs_next_to_their_children()), and tweak it to =
be
>>> as optimized as possible for our specific case.  These changes reduced
>>> the time spent in "plist special sort" by ~25% in the mega-renames cas=
e.
>>>
>>> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
>>> performance work; instrument with trace2_region_* calls", 2020-10-28),
>>> this change improves the performance as follows:
>>>
>>>                             Before                  After
>>>     no-renames:        5.622 s =C2=B1  0.059 s     5.235 s =C2=B1  0.0=
42 s
>>>     mega-renames:     10.127 s =C2=B1  0.073 s     9.419 s =C2=B1  0.1=
07 s
>>>     just-one-mega:   500.3  ms =C2=B1  3.8  ms   480.1  ms =C2=B1  3.9=
  ms
>>
>> Interesting.
>>
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>  merge-ort.c | 64 ++++++++++++++++++++++++++++++++++------------------=
-
>>>  1 file changed, 41 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/merge-ort.c b/merge-ort.c
>>> index 142d44d74d63..367aec4b7def 100644
>>> --- a/merge-ort.c
>>> +++ b/merge-ort.c
>>> @@ -2746,31 +2746,50 @@ static int detect_and_process_renames(struct m=
erge_options *opt,
>>>
>>>  /*** Function Grouping: functions related to process_entries() ***/
>>>
>>> -static int string_list_df_name_compare(const char *one, const char *t=
wo)
>>> +static int sort_dirs_next_to_their_children(const void *a, const void=
 *b)
>>>  {
>>> -     int onelen =3D strlen(one);
>>> -     int twolen =3D strlen(two);
>>
>> The old code scans both strings fully, while the new one stops when it
>> reaches a difference and doesn't look at any further characters.  How
>> much does that contribute to the speedup?  (I suspect a lot.)
>
> Oh, indeed, good catch.  It appears to be responsible for essentially al=
l of it.

Then you can keep the original function signature (as well as the use of
string_list_sort) and avoid explicit casts.

The same function exists in merge-recursive.c, by the way.  I suspect we
could avoid sorting entirely there by taking advantage of the index
order and a mechanism like the one in the second half of
fsck.c::verify_ordered().  That's a bit tricky, though (for me anyway).

All tests still pass when I replace string_list_df_name_compare() with
strcmp() in merge-recursive.c, so the first thing needed would be tests
that highlight the difference between those comparison functions,
however.  Not sure if it's worth it -- merge-recursive is on its way
out, right?

Not sure if d/f conflicts could also be detected in merge-ort.c without
sorting -- the original order is lost when the paths are thrown into
a strmap.

>
>>>       /*
>>> -      * Here we only care that entries for D/F conflicts are
>>> -      * adjacent, in particular with the file of the D/F conflict
>>> -      * appearing before files below the corresponding directory.
>>> -      * The order of the rest of the list is irrelevant for us.
>>> +      * Here we only care that entries for directories appear adjacen=
t
>>> +      * to and before files underneath the directory.  In other words=
,
>>> +      * we do not want the natural sorting of
>>> +      *     foo
>>> +      *     foo.txt
>>> +      *     foo/bar
>>> +      * Instead, we want "foo" to sort as though it were "foo/", so t=
hat
>>> +      * we instead get
>>> +      *     foo.txt
>>> +      *     foo
>>> +      *     foo/bar
>>> +      * To achieve this, we basically implement our own strcmp, excep=
t that
>>> +      * if we get to the end of either string instead of comparing NU=
L to
>>> +      * another character, we compare '/' to it.
>>>        *
>>> -      * To achieve this, we sort with df_name_compare and provide
>>> -      * the mode S_IFDIR so that D/F conflicts will sort correctly.
>>> -      * We use the mode S_IFDIR for everything else for simplicity,
>>> -      * since in other cases any changes in their order due to
>>> -      * sorting cause no problems for us.
>>> +      * The reason to not use df_name_compare directly was that it wa=
s
>>> +      * just too expensive, so I had to reimplement it.
>>>        */
>>> -     int cmp =3D df_name_compare(one, onelen, S_IFDIR,
>>> -                               two, twolen, S_IFDIR);
>>> -     /*
>>> -      * Now that 'foo' and 'foo/bar' compare equal, we have to make s=
ure
>>> -      * that 'foo' comes before 'foo/bar'.
>>> -      */
>>> -     if (cmp)
>>> -             return cmp;
>>> -     return onelen - twolen;
>>> +     const char *one =3D ((struct string_list_item *)a)->string;
>>> +     const char *two =3D ((struct string_list_item *)b)->string;
>>
>> Casting away const, hmm. :-/  Harmless because no actual write is
>> attempted, but still looks needlessly scary to me.
>
> Right, that should have been
> +     const char *one =3D ((const struct string_list_item *)a)->string;
> +     const char *two =3D ((const struct string_list_item *)b)->string;
> but since I was just assigning to a const char * on those lines, I'm
> not sure why it'd qualify as scary.  Regardless, I'm happy to put
> these consts back in.

Explicit casts are a red flag already (anything could be cast to
anything else) and if they remove const their severity increases.  The
resulting object text is fine, but the code yells "TYPE SYSTEM
OVERRRULED!"  And type checks in C are weak to begin with, so a casual
reader has to wonder what kind of black magic is at work.  None in
this case, as an implicit casts would have sufficed:

	const struct string_list_item *item_a =3D a, *item_b =3D b;
	const char *one =3D item_a->string, *two =3D item_b->string;

Boring.  Calming.  Nice. ;)  The compiler would warn us if the pieces
didn't fit.

Ren=C3=A9
