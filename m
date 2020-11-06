Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E0C55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6224C206FA
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3j3L0fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgKFR4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFR4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:56:32 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AE0C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 09:56:32 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so2300410ljk.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HYIO94DG7IsvnSGiMySBVAQVyL9OSkdShE0hidSeqas=;
        b=Q3j3L0fI+l5/RsjBaKApSSGCP6QSY2bxaXdhhMtpSynsDRo9Y1Q9dzKaGyue+RBZLN
         Vj+nw5p44+S+nmkEPgE4ZEpfFD0h3b9OHPqAjuX6sEncZYjXF1/l27Xde6tLgH3gcRim
         G9+lkDHu6QveynENe951ChAxePRex7AJl44WfurJugPQDcRSiWT+l9a0TfoWZ13v/hm3
         lDBJuEt5qBH4XIO0eO6ptryZIj/4OMu2KM2AUr0sSLz5Gnb4d6WDOB5E++uj5JS1XCiX
         HVxB12BXy52SOZNhDNkmk8uopnfkCDXEBjB5AwDHtGAyY4nxx7AL0i/qZ/ChoStatWzB
         89bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=HYIO94DG7IsvnSGiMySBVAQVyL9OSkdShE0hidSeqas=;
        b=FBalXt12oY9GofK/+c3KpQK60d6MKke0MebT1RfZ4C8Puqr0suHiRphogV83xU3qsy
         QHwsLaG8ZRPkaZSER8wzo2a7mMF8+daq6vXfcg69fWJYBgddrsF0iHV+K1NsdR79U75D
         HeHNVhIKolFQ/fLdMUiuKNEf02VlwtaV3AgrueDVlgnfW2qCQ0+oiToSNqu38Z+Jih1r
         9MB7psZ6CR7N7Fx52QlkEFUnm6iIgdWW/1Qk4PJ58akAOgw7R4h8AoOaaCUClPgUH6rY
         QZYfqeckQ4ZK4LPbFwyNfmQVd5ON78jEZtx/VoKsgPRkWoXe/ZTLfb+oXVRiBZfxuEHx
         YxGw==
X-Gm-Message-State: AOAM532GjPDPViI8XTo0C9MFqW1U9T9Ud+LHH+si3WsQuxoqOInAuzLG
        JPIddNdYj0Mkg50mFL+dGandIl9Bu8wqyhN0
X-Google-Smtp-Source: ABdhPJxo5oo1JVtwtCL1j0kMdSnWT0zrgMDqqoM1px4W0NazAJHjPEfjZ3U8AiUqdECVnbZtkAxffQ==
X-Received: by 2002:a2e:9746:: with SMTP id f6mr1215860ljj.270.1604685390565;
        Fri, 06 Nov 2020 09:56:30 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 2sm241524lfd.67.2020.11.06.09.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:56:29 -0800 (PST)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 07/10] commit-graph: implement generation data chunk
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <b903efe2ea11bc0b7e1ef8f239ed34f72caa4f03.1602079786.git.gitgitgadget@gmail.com>
        <854kmbx4pi.fsf@gmail.com> <20201106112513.GA1553@Abhishek-Arch>
Date:   Fri, 06 Nov 2020 18:56:28 +0100
In-Reply-To: <20201106112513.GA1553@Abhishek-Arch> (Abhishek Kumar's message
        of "Fri, 6 Nov 2020 16:55:13 +0530")
Message-ID: <858sbel67n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In short: I think that because current implementation of writing GDOV
chunk follows an example of writing EDGE chunk, it should be left as it
is now (simple), and posible performance improvements be postponed to
some future commit.

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Fri, Oct 30, 2020 at 01:45:29PM +0100, Jakub Nar=C4=99bski wrote:
[...]
>>> We test the overflow-related code with the following repo history:
>>>
>>>            F - N - U
>>>           /         \
>>> U - N - U            N
>>>          \          /
>>>            N - F - N
>>=20
>> Do we need such complex history? I guess we need to test the handling of
>> merge commits too.
>>=20
>
> I wanted to test three cases - a root epoch zero commit, a commit that's
> far enough in past to overflow the offset and a commit that's far enough
> in the future to overflow the offset.

All right, if I understand this correctly this would be U as root, U-F
pair of commits and N-F pair of commits, respectively.  Did I get it
right?

Anyway, it might be a good idea to put this explanation in the commit
message.

>>>
>>> Where the commits denoted by U have committer date of zero seconds
>>> since Unix epoch, the commits denoted by N have committer date of
>>> 1112354055 (default committer date for the test suite) seconds since
>>> Unix epoch and the commits denoted by F have committer date of
>>> (2 ^ 31 - 2) seconds since Unix epoch.
>>>
>>> The largest offset observed is 2 ^ 31, just large enough to overflow.

[...]
>>> @@ -1120,6 +1149,44 @@ static int write_graph_chunk_data(struct hashfil=
e *f,
>>>  	return 0;
>>>  }
>>>=20=20
>>> +static int write_graph_chunk_generation_data(struct hashfile *f,
>>> +					      struct write_commit_graph_context *ctx)
>>> +{
>>> +	int i, num_generation_data_overflows =3D 0;
>>=20
>> Minor nitpick: in my opinion there should be empty line here, between
>> the variables declaration and the code... however not all
>> write_graph_chunk_*() functions have it.
>>=20
>>> +	for (i =3D 0; i < ctx->commits.nr; i++) {
>>> +		struct commit *c =3D ctx->commits.list[i];
>>> +		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
>>> +		display_progress(ctx->progress, ++ctx->progress_cnt);
>>=20
>> All right.
>>=20
>>> +
>>> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
>>> +			offset =3D CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_d=
ata_overflows;
>>> +			num_generation_data_overflows++;
>>> +		}
>>=20
>> Hmmm... shouldn't we store these commits that need overflow handling
>> (with corrected commit date offset greater than GENERATION_NUMBER_V2_OFF=
SET_MAX)
>> in a list or a queue, to remember them for writing GDOV chunk?
>>=20
>
> We could, although write_graph_chunk_extra_edges() (just like this functi=
on)
> prefers to iterate over all commits again. Both octopus merges and
> overflowing corrected commit dates are exceedingly rare, might be
> worthwhile to trade some memory to avoid looping again.

I'm sorry, I have not looked what write_graph_chunk_extra_edges() does,
or rather how it does what it does -- it is a good idea to pattern your
solution in similar existing code.

For me this is an even stronger hint that we should strive for
simplicity first, and leave possible performance improvements for the
future commit.  Especially that you perform the most significant
optimization for this overflow handling: ensuring that we do not perform
any work if there are no commits with generation data overflow.

Maybe, maybe we should add that information about similarity between
write_graph_chunk_generation_data_overflow() and write_graph_chunk_extra_ed=
ges()=20
in the commit message.  I am unsure...

>> We could store oids, or we could store commits themselves, for example:
>>=20
>> 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
>> 			offset =3D CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_dat=
a_overflows;
>> 			num_generation_data_overflows++;
>>=20
>> 			ALLOC_GROW(ctx->gdov_commits.list, ctx->gdov_commits.nr + 1, ctx->gdo=
v_commits.alloc);
>> 			ctx->commits.list[ctx->gdov_commits.nr] =3D c;
>>             ctx->gdov_commits.nr++;
>> 		}
>>=20
>> Though in the above proposal we could get rid of `num_generation_data_ov=
erflows`,=20
>> as it should be the same as `ctx->gdov_commits.nr`.
>>=20
>> I have called the extra commit list member of write_commit_graph_context
>> `gdov_commits`, but perhaps a better name would be `commits_gen_v2_overf=
low`,=20
>> or similar more descriptive name.

[...]
>>> @@ -741,4 +742,47 @@ test_expect_success 'corrupt commit-graph write (m=
issing tree)' '
>>>  	)
>>>  '
>>>=20=20
>>> +test_commit_with_date() {
>>> +  file=3D"$1.t" &&
>>> +  echo "$1" >"$file" &&
>>> +  git add "$file" &&
>>> +  GIT_COMMITTER_DATE=3D"$2" GIT_AUTHOR_DATE=3D"$2" git commit -m "$1"
>>> +  git tag "$1"
>>> +}
>>=20
>> Here we add a helper function.  All right.
>>=20
>> I wonder though if it wouldn't be a better idea to add `--date <date>`
>> option to the test_commit() function in test-lib-functions.sh (which
>> option would set GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, and also
>> set notick=3Dyes).
>>=20
>
> Yes, that's a better idea - I didn't know how to change test_commit()
> well enough to tinker with what's working.
>
>> For example:
>>=20
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index f1ae935fee..a1f9a2b09b 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -202,6 +202,12 @@ test_commit () {
>>  		--signoff)
>>  			signoff=3D"$1"
>>  			;;
>> +        --date)
>> +            notick=3Dyes
>> +            GIT_COMMITTER_DATE=3D"$2"
>> +            GIT_AUTHOR_DATE=3D"$2"
>> +            shift
>> +            ;;
>>  		-C)
>>  			indir=3D"$2"
>>  			shift

Note however that I have while I have followed example of other options
(namely '-C <directory>'), I have not actually tested this proposed
implementation in tests; I have just tested that it looks like it works
OK.

[...]
>>> +test_expect_success 'overflow corrected commit date offset' '
>>> +	objdir=3D".git/objects" &&
>>> +	UNIX_EPOCH_ZERO=3D"1970-01-01 00:00 +0000" &&
>>> +	FUTURE_DATE=3D"@2147483646 +0000" &&
>>=20
>> It is a bit funny to see UNIX_EPOCH_ZERO spelled one way, and
>> FUTURE_DATE other way.
>>=20
>> Wouldn't be more readable to use UNIX_EPOCH_ZERO=3D"@0 +0000"?
>
> It would, for some reason - I couldn't figure out the valid format for
> this. Changed.

Well, if "@2147483646 +0000" works (i.e. "@<Unix epoch/timestamp> <offset>"=
),
why the same for timestamp 0, i.e. "@0 +0000", wouldn't work?

[...]
>>> +graph_git_behavior 'overflow corrected commit date offset' repo left r=
ight
>>=20
>> All right, here we compare the Git behavior with the commit-graph to the
>> behavior without it... however I think that those two tests really
>> should have distinct (different) test names. Currently they both use
>> 'overflow corrected commit date offset'.
>>=20
>
> Following the earlier tests, the first test could be "set up and verify
> repo with generation data overflow chunk" and the git behavior test can
> be "generation data overflow chunk repo"

First is OK, the second could possibly be improved but is all right.

[...]
>> Though to reduce "noise" in this patch, the rename of run_three_modes()
>> to run_all_modes() and test_three_modes() to test_all_modes() could have
>> been done in a separate preparatory patch.  It would be pure refactoring
>> patch, without introducing any new functionality.
>>=20
>
> Sure, that makes sense to me - this is patch is over 200 lines long
> already.

Thanks in advance.

Best,
--=20
Jakub Nar=C4=99bski
