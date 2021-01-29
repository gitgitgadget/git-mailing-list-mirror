Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA9C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B4264E04
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhA2ROn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:14:43 -0500
Received: from mout.web.de ([212.227.15.4]:43837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhA2RN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 12:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611940284;
        bh=BKkP8TjV0BPRAYSotsmZZ0WhY+I7bFNO1Kb1/vOwciQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rr/LUIiWgZm8Gnxcoz6E07VAfm5C8ESZCIBybBpKIjfnKKTVCRqP5HKMZqbewqwcU
         1epBYZyp8Mazg89pXd2tOSK4kcu1a86taRikwCixmAwn96kGf8QQ/s9ghaa+Y76UBV
         F6bNfVV6Sq3dqaATcMVbbOZ0ustXvLplc1qg4nTI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M9Xfb-1lGJCG484t-00D3dm; Fri, 29 Jan 2021 18:11:24 +0100
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
 <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <198f7766-190d-d361-d6f4-23adefedaf6c@web.de>
Date:   Fri, 29 Jan 2021 18:11:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yoIDMNlkNlOgAjJFzFFUl3wexRhM1+MGz5gbNXFDouP05b6n1gA
 ea3VoIjpiTTEROVUgzEH7G+7/oRvVIZo6s7QSGjwalmWxGZvELjpaHuvULCV0kcpl0pKHKH
 2/HhfjP0BaEnWW/yehgC2O4CZCVBJ9cii7OrhSvz4Fhe2Vrr88WvDwKEICJpK0dNrMzlSVT
 1T6aNU/N/p7u6rMTOCsxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0dOpcZ43oOg=:3Gj4Pc7jkJvgmsnI4lNoRm
 I/uvfTr6jE1zojBYfuMyQbGpB5bR1wLKs/xWjLAkQG9TcGnmq3ouk/I9kPd9Tz5jq3xr0qLR0
 ARiPOS7A/UC3PER0BRWsTK6vGDyKU3ozxMu15DRWYbw0p5YxPtIv0V0qK8hkBGiSSdSYAORSC
 f2CizbvTSKFmLxmxuVU0f8eYdws3Tw4RkHDvuNnAeecopeJA4RcGgrxKJ36AruxfPtoQCPz2j
 cmgacfr3qEzdM6H2MS3zELIXieAZWdoExc22SS6X2BOx1pN/B/ACOIia2B+QTP5zrGBunKDAj
 Uxr5NDTPbFxd/SSDJ4jpLZ9g7f4jtV82mC44nAUHbeU31mm4K5Nfh+vdH6WTr3KxfngPRovz1
 4QGedu4vA/jKgZAORYRr0OqUF72HOLUaE+n6si5icYOWnI2J45nSowpyDsHOH2zTh7AkO8B+a
 qJ4IZ8dwQdy+gNCBMXW7pfxdoBsT37CpSO0u8acyXNUu8L3jZepzHwbtKnGQ99X5aKwHYJOub
 eEbx7TrIU8RGVT8iXes4aumDWwkMjsg5VeMM41KCumtapnjt0D14zsiiJDiEsVc3XGoIaDWL4
 NSj+nvQy+0R8LuQRws1UOP68jIa3XaVgaAyT4dOLK5/5Jv/M97Z7n0zgpv+YqIHp3XcJhmrUC
 Kp15336vU3W0OtqFS9ArCj9ymqafhT3bCFwRdP1VwwZH6wf4mVTDuGY0rlJ2lb+r3uxFLgMZ9
 pwGKoiMAI8zDBjI/hjLp+HHqIPkC0Ak8FeA1ot13S3uauHEC+swGpHezVvRj5Gr1Wj8oQt9FJ
 5KIdqfs2TW+b8X52xIog8fa7qxHjolfURTbZyzfi4NivIjiUqZU6Dm0kq+0qZ9wqhsujANqyr
 YVh8vS9ujo2/FUzzyElg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.01.21 um 21:51 schrieb Junio C Hamano:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +	/* rearrange array */
>> +	dup =3D xcalloc(cnt, sizeof(struct commit *));
>> +	COPY_ARRAY(dup, array, cnt);
>> +	for (i =3D 0; i < cnt; i++) {
>> +		if (dup[i]->object.flags & STALE) {
>> +			int insert =3D cnt - 1 - (i - count_non_stale);
>> +			array[insert] =3D dup[i];
>> +		} else {
>> +			array[count_non_stale] =3D dup[i];
>> +			count_non_stale++;
>> +		}
>> +	}
>> +	free(dup);
>
> The "fill stale ones from the end, non-stale ones from the
> beginning" in the loop looks unnecessarily complex to me.  I wonder
> if we can do only the "fill non-stale ones from the beginning" half,
> i.e.
>
> 	for (i =3D count_non_stale =3D 0; i < cnt; i++) {
> 		if (dup[i] is not stale)
> 			array[count_non_stale++] =3D dup[i];
> 	}
>
> without the "keep the stale one at the end of array[]", and clear
> marks using what is in dup[] as starting points before discarding
> dup[]?
>
> Or do the callers still look at the entries beyond count_non_stale?

Had the same reaction.  Both callers ignore the stale entries.

> Other than that, nicely done.
>
>> +	/* clear marks */
>> +	for (i =3D 0; i < cnt; i++) {
>> +		struct commit_list *parents;
>> +		parents =3D array[i]->parents;
>> +
>> +		while (parents) {
>> +			clear_commit_marks(parents->item, STALE);
>> +			parents =3D parents->next;
>>  		}

This loop clears STALE from the parents of both the non-stale and
stale entries.  OK.  Should it also clear it from the stale entries
themselves?

>> -		common =3D paint_down_to_common(r, array[i], filled,
>> -					      work, min_generation);
>> -		if (array[i]->object.flags & PARENT2)
>> -			redundant[i] =3D 1;
>> -		for (j =3D 0; j < filled; j++)
>> -			if (work[j]->object.flags & PARENT1)
>> -				redundant[filled_index[j]] =3D 1;
>> -		clear_commit_marks(array[i], all_flags);
>> -		clear_commit_marks_many(filled, work, all_flags);
>> -		free_commit_list(common);
>>  	}
>>
>> -	/* Now collect the result */
>> -	COPY_ARRAY(work, array, cnt);
>> -	for (i =3D filled =3D 0; i < cnt; i++)
>> -		if (!redundant[i])
>> -			array[filled++] =3D work[i];
>> -	for (j =3D filled, i =3D 0; i < cnt; i++)
>> -		if (redundant[i])
>> -			array[j++] =3D work[i];
>> -	free(work);
>> -	free(redundant);
>> -	free(filled_index);
>> -	return filled;
>> +	return count_non_stale;
>>  }
>>
>>  static struct commit_list *get_merge_bases_many_0(struct repository *r=
,

