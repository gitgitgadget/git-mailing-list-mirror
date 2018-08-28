Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6221F404
	for <e@80x24.org>; Tue, 28 Aug 2018 18:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeH1Wcr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:32:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54338 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeH1Wcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:32:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so2895080wmb.4
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RMbGiNMbN1zVJl25TJQDjyxB84LrrjDY8F4d9G35Rf4=;
        b=c04WPWvbteF5j4QtA6EZ9EIf/nDBFDbq7jBtyJmnhNen1vCLuIRyjpcUatt2gupBru
         1MeEYANKgubGYr5Ls+GanlhrLL4uPJCHvJRG9QLy8fJqNvLBoI5qLS2FL65QFQTLAnIO
         xoH4SwodXCbOtl0v6bP1w8LsfHHzn7+J+1RDJj0BTgbcSLtRAnX8NM3pPVZiTufrQhgJ
         +INqHrcufGrK556V6Yu8uBSSbK/gInMSFfKQjBFmDOAMA4XL3nbcxZTjHlsgueGyV/+n
         uCX6CzFVH95uQmm2MHOnIPlVMv7he6XEMX7Smd84ItOxzhfKKIRuzG0ZAdahFtXAC7Yr
         2KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RMbGiNMbN1zVJl25TJQDjyxB84LrrjDY8F4d9G35Rf4=;
        b=dT3rmi2hqQ3Gsy5DwcV2REPpLGF76KQVOhCLmwQTwSogWyct0Rq3N8cHAC1mzjGJDp
         Cqqqp+bULhPcbfz/bNYX2k0YaQDli0auR07ICCuBIqn7Zj+POD6/YP4B1U88htsx5otF
         EB1rcMZpBleLxVreacKQvf79oCk2Z9W/bENl594InzmxOLFviUKx/ZW83VJlGErXCy4E
         gVlNvLkhlYYea1GAcFJRarnU4XUt3ivje2TqgrdhrUDOVXUA0rUTjckMKW23znlRIu9H
         tLtaPw+Mr3m616Lyf0wtFqzkE14VKl/NHCh8eF4pfGT3BPYzB+Vb01jP944GBBsFCyRF
         WgHg==
X-Gm-Message-State: APzg51BITvm3hwRGU0OgDR3TiDBpGjaff+F9e93M3WEJyNcKQFF+ewCJ
        pbiT01GRNhx59I9qq3bWxNU=
X-Google-Smtp-Source: ANB0Vdazzze8T6Rw67ZPjSJ8xTnp2l1VL8Z8QEqc1Y0/2Kx5Y/AEP0nYCVnXXZ0nGn6tnKLAEavZdg==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr2003874wme.15.1535481588920;
        Tue, 28 Aug 2018 11:39:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r30-v6sm3363650wrc.90.2018.08.28.11.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 11:39:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tiago Botelho <tiagonbotelho@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com>
        <nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet>
Date:   Tue, 28 Aug 2018 11:39:47 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 28 Aug 2018 15:21:09 +0200 (DST)")
Message-ID: <xmqqy3cqfi8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Tiago,
>
> On Tue, 28 Aug 2018, Tiago Botelho wrote:
>
>> This will enable users to implement bisecting on first parents
>> which can be useful for when the commits from a feature branch
>> that we want to merge are not always tested.
>
> This message is still lacking the explanation I asked for, namely for the
> lines:
>
> 	@@ -329,6 +334,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
> 	 	if (0 <= weight(p))
> 	 		continue;
> 	 	for (q = p->item->parents; q; q = q->next) {
> 	+		if ((bisect_flags & BISECT_FIRST_PARENT)) {
> 	+			if (weight(q) < 0)
> 	+				q = NULL;
> 	+			break;
> 	+		}
> 	 	if (q->item->object.flags & UNINTERESTING)
> 	 		continue;
> 	 	if (0 <= weight(q))

I've just finished scanning the discussion thread on public-inbox
for v5, v4, v3, v2 and the initial round of this series, but found
your comments only on the tests.  If you have a pointer that would
be great; it also is OK to say what kind of explanation is needed
for that addition again.  

FWIW I too was puzzled about the correctness of the added logic
above, especially the part that reads weight(q) before checking if
it is not UNINTERESTING, but I covered it on a separate message.

> I would have preferred to reuse the already existing commits generated in
> the `setup` phase rather than generating yet another batch, and to not
> introduce an inconsistent way to present a commit graph (compare your
> diagram with the one in
> https://github.com/git/git/blob/v2.18.0/t/t6002-rev-list-bisect.sh#L64-L90
> i.e. *in the same file*)

As I already said in the previous round, I do agree with these.
That is, ...

>> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
>> index a66140803..1bc297de5 100755
>> --- a/t/t6002-rev-list-bisect.sh
>> +++ b/t/t6002-rev-list-bisect.sh
>> @@ -263,4 +263,62 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
>>  	test_cmp expect.sorted actual.sorted
>>  '
>>  
>> +# We generate the following commit graph:
>> +#
>> +#   B ------ C
>> +#  /          \
>> +# A            FX
>> +#  \          /
>> +#   D - CC - EX
>> +
>> +test_expect_success 'setup' '
>> +  test_commit A &&
>> +  test_commit B &&
>> +  test_commit C &&
>> +  git reset --hard A &&
>> +  test_commit D &&
>> +  test_commit CC &&
>> +  test_commit EX &&
>> +  test_merge FX C
>> +'

... the above graph construction should not be necessary.  An
earlier part of t6002 would have already created a history of
suitable shape to use for writing the following tests.

>> +test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
>> +$(git rev-parse CC)
>> +EOF
>> +
>> +test_output_expect_success "--first-parent" 'git rev-list --first-parent FX ^A' <<EOF
>> +$(git rev-parse FX)
>> +$(git rev-parse EX)
>> +$(git rev-parse CC)
>> +$(git rev-parse D)
>> +EOF
>> +
>> +test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
>> +bisect_rev='$(git rev-parse CC)'
>> +bisect_nr=1
>> +bisect_good=1
>> +bisect_bad=1
>> +bisect_all=4
>> +bisect_steps=1
>> +EOF
>> +
>> +test_expect_success "--bisect-all --first-parent" '
>> +cat >expect <<EOF &&
>> +$(git rev-parse CC) (dist=2)
>> +$(git rev-parse EX) (dist=1)
>> +$(git rev-parse D) (dist=1)
>> +$(git rev-parse FX) (dist=0)
>> +EOF
>> +
>> +# Make sure we have the same entries, nothing more, nothing less
>> +git rev-list --bisect-all --first-parent FX ^A >actual &&
>> +  sort actual >actual.sorted &&
>> +  sort expect >expect.sorted &&
>> +  test_cmp expect.sorted actual.sorted &&
>> +  # Make sure the entries are sorted in the dist order
>> +  sed -e "s/.*(dist=\([1-9]*[0-9]\)).*/\1/" actual >actual.dists &&
>> +  sort -r actual.dists >actual.dists.sorted &&
>> +  test_cmp actual.dists.sorted actual.dists
>> +'
>> +
>>  test_done
>> -- 
>> 2.16.3
>> 
>> 
