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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F2E6120D
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhFUSfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:35:11 -0400
Received: from mout.web.de ([217.72.192.78]:43435 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhFUSfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624300374;
        bh=0B1Ui8Hw0bntTdaAa+6VwTscxI+NxK0o3McD06oFqKg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VfJ6GB9zGK64g/my2uBCPobUxfnqd4wwd/XbByv6Etp3KCgiYitSviyeRXkr5Yyaz
         jrg6vdq71FG48vW49Ni0FlC24PC3+NvNzvg/djmI9BtKDDjLx9Dt9H7IFhY1OT7e8z
         rHG3wq3N1SX9VUYHr5rCcNORhCLcGse0maHEE+KY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MWj6V-1ll9yf0PP9-00XwGh; Mon, 21 Jun 2021 20:32:54 +0200
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
Date:   Mon, 21 Jun 2021 20:32:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87a6nk41wy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VByVPAkNAINYKeycwp4BlDGih4Tyirm2AWrLK+zgpOrSFgN4DxH
 L7cZt7rsQXKaB+afDYPUMDCQaQbcJf8nEZjXQyMFBKAOtJodxqEV2rKNQg3CzYCS1a2iBT5
 IH2c6wtJeDAFiN7hR2EGvLoqGwZQmykHZFjk1WxuqMFxKYq/69c4m+0y8ncfAUk3VcFPGDL
 H1lpL9agR3WaUhO3xVusw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LS1mas1bMGY=:s3m+RZISINEDYTSdAT+r8Z
 oVFlIAxzEdz5+vZLj4hKsgoHmqre5r+6ga7hX5eD5MevEYk/+4ICfRs04V742+tgvlri3Ycz9
 +eyZRIyEJwMqzfn+7uJeq6aFt0p66qO8anj4HL5DD//n4bbv7M9qD/F1RXsCtxa1DryoPIDqQ
 ++4YOuWvB6uFQF7p/us7JCJY+jvkw0xrMw6hNcyd135tziKWZEgD9ItWqGg0klETVE5jFOb+X
 d97tGfOalTPIHTwA8O+Lt9ziZvWITKdz81A14vMAeVoy/rsAz1WdrHIO7nKILQO6xCxl8iGC4
 jD0Fnp8Gk3XwdHDe9y5BA6QpVom12girhAt6OBb01DMl3KnUQwDHvi1ounJuGQ9bVKo3U7Tog
 WoCr5bIzPno+hwx2BS6Z3lX5/EKa1o9+7XxljfAXCR3AfmxFKKyQSkJ44NcPyycNqqj+YILVz
 epNtw5D9sQmjUpzidTBEvWJ3dcWk4GtpmufWrtCctsngr7877ETGD66P4Mp5F0nrFMbEvcx8L
 +tff0aMv8j+3auR8j5hZ6uWosJFpjMB/HeNGgnSSKWPRL54iGTSxGydgrwSIdYDIpjJR614Ua
 FmwEQJuLGeeWLBOVu8u4GU8brqQZ05VtjxzTK+fQV+yFCb9b9dzg1GfzSUCD/6JbObuShcBCt
 ILN1TlxbIUU8iErQRLxrka4YMnR5G74bRhIcUF6KCLIHrFNH7mvhGL5Px4u4JfPze6B+NRVUx
 wbhGNeT/Xw16gtEbTo4lNJ+5g3fmlT0EJaRMU7ozaDx+3P25VBxn3WElsnL3pdd7dha6znt22
 1SVZCTKYkG5fcfwsG3SfVmE37C/JPwuLPEkLGjjN3j/vYHTf/8UUybWQQgGQH/vz8tkhfWEF3
 LSGp7beQouBUuBnHQB+ksgpB121Adu15rvC/XvdVSs2NCvPEtnu6+MrgXYZ2TqnuqS5fF+Fwr
 Il68en8CnkId0bMPyY9ogUyOJiX9/vP9myzWADPBAWMyUKM502w05tXo0/Gi8EVDcXPZZ8slR
 LDawPpyRV/OcM3tTvB7u7jP5kg4DLT6EB9cfBblHMgwVfjyHPPjAbCx+ZS7qVN52AaMKTk4Mv
 B5GRMx7ro9hFh6OfWQSzntGxcjAqUH1KvoC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.21 um 00:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:
>
>> The final value of the counter of the "Scanning merged commits"
>> progress line is always one less than its expected total, e.g.:
>>
>>   Scanning merged commits:  83% (5/6), done.
>>
>> This happens because while iterating over an array the loop variable
>> is passed to display_progress() as-is, but while C arrays (and thus
>> the loop variable) start at 0 and end at N-1, the progress counter
>> must end at N.  This causes the failures of the tests
>> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
>> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>>
>> Fix this by passing 'i + 1' to display_progress(), like most other
>> callsites do.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  commit-graph.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 2bcb4e0f89..3181906368 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct w=
rite_commit_graph_context *ctx)
>>
>>  	ctx->num_extra_edges =3D 0;
>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>> -		display_progress(ctx->progress, i);
>> +		display_progress(ctx->progress, i + 1);
>>
>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>  			  &ctx->commits.list[i]->object.oid)) {
>
> I think this fix makes sense, but FWIW there's a large thread starting
> at [1] where Ren=C3=A9 disagrees with me, and thinks the fix for this so=
rt of
> thing would be to display_progress(..., i + 1) at the end of that
> for-loop, or just before the stop_progress().
>
> I don't agree, but just noting the disagreement, and that if that
> argument wins then a patch like this would involve changing the other
> 20-some calls to display_progress() in commit-graph.c to work
> differently (and to be more complex, we'd need to deal with loop
> break/continue etc.).
>
> 1. https://lore.kernel.org/git/patch-2.2-042f598826-20210607T144206Z-ava=
rab@gmail.com/

*sigh*  (And sorry, =C3=86var.)

Before an item is done, it should be reported as not done.  After an
item is done, it should be reported as done.  One loop iteration
finishes one item.  Thus the number of items to report at the bottom of
the loop is one higher than at the top.  i is the correct number to
report at the top of a zero-based loop, i+1 at the bottom.

There is another place: In the loop header.  It's a weird place for a
function call, but it gets triggered before, between and after all
items, just as we need it:

	for (i =3D 0; display_progress(ctx->progress), i < ctx->commits.nr; i++) =
{

We could hide this unseemly sight in a macro:

  #define progress_foreach(index, count, progress) \
  for (index =3D 0; display_progress(progress, index), index < count; inde=
x++)

Hmm?

Ren=C3=A9
