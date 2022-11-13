Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7AC4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 17:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiKMRbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKMRbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 12:31:20 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19F1117E
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668360672; bh=Aa/e+Nkr0L9lSsv6BcQHF/XE7AWOC+E69CvfBjmvE38=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RJ/RNGQ0JJgUcqqotU7CnTUdYFYQHd2ES6nsj/e1skRL/XS8pTaM5CdkkarJhjBHi
         /eTszmttfx+twpwq3Plp4x3mqaVgewsRnGC2LQvKtzLV7qySfcchNbZTvJQ7zMoOlo
         P0stlJUOAiXhPKVowL80uAPTOV6rXr/oWvm0Hj0pnso7Nkubvr6KFMbVHVCGmI3Qwb
         oMjr5mm2qLetdnlck0cL+MAa/WcX9d8ETu7SoJmK1l+UfJa5iWTkFyihEDUeXSsDeE
         5Nywb+5fXrj93Bz+9rzWATiV5X6p8QDAUXzeAs9xV9hDW/K8dNm/0nOLDnC35k31rk
         9gQA9JhdrZRhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1pW4YF2x2p-00bz4d; Sun, 13
 Nov 2022 18:31:12 +0100
Message-ID: <be477f52-33e0-b2e8-9bcc-9264f1b50460@web.de>
Date:   Sun, 13 Nov 2022 18:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
 <221112.86bkpcmm6i.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221112.86bkpcmm6i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5yry5K8XB2b6vl3870LFJVIjb1vU56e613OFag+tJvC17fpi/JQ
 5JKl6cXR69E3Y1/JwbpFB82sKeDL+pAaNM0QU8puIiTydOsVw7hVislK8Mb9CX7m8Znt07j
 pvWkR6GfeQdGhwRSPNufoLyknh5ma48v9nzuELdlpU2YH15VqbC9BIa8xvQGQk4gl+Ohl7X
 m+iDzwlqG4Cf/ZyZLDj9A==
UI-OutboundReport: notjunk:1;M01:P0:U3j43CyXkQc=;S7CPbMhbHT6r4K67spgrjMksdjg
 GMJSslVRY2Y3sLjhsWlkgkM0s9XSyjQa6dNJdEmiahykwdURhWCW0UztDcWVuTc/jXHFuIJJ/
 jxx13xMrKI+HJSlLiFJbMJx2FeJGssv7oy/0m7Eg34jd2lDJ6HF7rxaVuEYFMFUkc5uuqA3+I
 PJ6qYLgAjUYv9cZkn7UZ0EaMMgTqpS1Kee5iQSddYdgDjqkSM78JuXOt++V7ZYEL3DNO9jpwp
 MRServ/EsVDxpLA4iQoy24gYT2vf9yPc+FJ/vWpXTklcqT69dEmiAdNPG7jAnwtDp/7q1iTkG
 MBXvab3ALBUzL+xcdc2rVFy+3A9/WqKl2gUJ/6Jjgmq3tFUh5cwXP9ZXJdSV1gyW//lHjCaQT
 UFcQTl7hVcYUo0/LUc4uS8Ogg+R6zA+kKBRyjO2T8S/udyZr2WyiWIVGa5V3URbojIDcpZme0
 MeIhtMqlPO6UA9ruhqjD3Ta1VcGIz1JsjlW1eRLZGZamrN0W+9WveL3WtNgSTSVTDXha+pfHF
 rUL7B5zTuRHReuB5/T62gdmiyq78VjToNUoaJCSjclY9AZwMJtM1+L1qJt5GDUVix+VVVcIOS
 XpOo6NV3sMDZynmTm1+ACBe7cyv8xzU1YvbehYmxv6AFwFWnb7uDUV+rqD2J6yDAIERzbM1Pj
 iOVtsUGToBPRsOzgNQpfWp8SKy2cNUnQqJW9zPQ/fFc6t3a1pr2p6av777T6lyv24EVCWAa4X
 H7w61RIB0p5em7i3GpHhTFY7/ROfjerhFh50AT52s4sucs40ey5h5GbSK1t88a1fvXapztelS
 GlAmLiTzTV2EouIFCrHeXke8wnUje98N0QqQvq75eO44GHxtnwweIC9r47VARENJtzGKzV07l
 osZ/iwDj7Z/7fQJfd2MUZN0jW351D07/A9MEW8I9IHZuqbn8+4LRHf4f/4CQfbH1nVlNkhG/f
 eAsOQtBT18PWtQAEitvOOKWtSOY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.22 um 12:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Nov 12 2022, Ren=C3=A9 Scharfe wrote:
>
>> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
>> leak, 2022-03-28) --filter options given to git pack-objects overrule
>> earlier ones, letting only the leftmost win and leaking the memory
>> allocated for earlier ones.  Fix that by only initializing the rev_info
>> struct once.
>
> If I do e.g. this with SANITIZE=3Dleak:
>
> 	echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects --re=
vs --filter=3Dblob:limit=3D1001 --filter=3Dobject:type=3Dblob --stdout  >/=
dev/null
>
> I see one leak that wasn't there, but two that are gone now. I haven't
> looked into it, but I think the commit message should discuss what leaks
> are fixed, which remain/are new etc.

The leak is insubstantial; I mentioned it just because of the irony.  It
is caused by initializing an already initialized struct rev_info without
releasing it in between, as mentioned in the commit message.

.filter_data allocated by filter_combine__init() is not released by
filter_combine__init() in list-objects-filter.c.  Plugging that leak
allows your example command to run with SANITIZE=3Dleak.  That is a matter
for a separate patch, though.

>
>> @@ -4158,7 +4158,8 @@ static struct list_objects_filter_options *po_fil=
ter_revs_init(void *value)
>>  {
>>  	struct po_filter_data *data =3D value;
>>
>> -	repo_init_revisions(the_repository, &data->revs, NULL);
>> +	if (!data->have_revs)
>> +		repo_init_revisions(the_repository, &data->revs, NULL);
>>  	data->have_revs =3D 1;
>>
>>  	return &data->revs.filter;
>
> FWIW as this goes away in your 2/3 I think just squashing the two with a
> leak fix would be nice, if...
>
>> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-obje=
cts-filter-objects.sh
>> index bb633c9b09..bd8983bb56 100755
>> --- a/t/t5317-pack-objects-filter-objects.sh
>> +++ b/t/t5317-pack-objects-filter-objects.sh
>> @@ -178,6 +178,25 @@ test_expect_success 'verify blob:limit=3D1001' '
>>  	test_cmp expected observed
>>  '
>>
>> +test_expect_success 'verify blob:limit=3D1001+object:type=3Dblob' '
>> +	git -C r2 ls-files -s large.1000 |
>
> Aside: Should do "git >tmp && test_parse... <tmp", we lose the exit code
> of "ls-files" here.

OK.  Copied that line from the surrounding tests.  They used temporary
files before fb2d0db502 (test-lib-functions: add parsing helpers for
ls-files and ls-tree, 2022-04-04).

>
>> +	test_parse_ls_files_stage_oids |
>> +	sort >expected &&
>> +
>> +	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 \
>> +		--filter=3Dobject:type=3Dblob >filter.pack <<-EOF &&
>> +	HEAD
>> +	EOF
>> +	git -C r2 index-pack ../filter.pack &&
>> +
>> +	git -C r2 verify-pack -v ../filter.pack >verify_result &&
>> +	grep blob verify_result |
>> +	parse_verify_pack_blob_oid |
>
> Whereas this one's not a problem, no "git".
>
>> +	sort >observed &&
>> +
>> +	test_cmp expected observed
>
> Aside: It would be nice if we had a "test_cmp_sort", but some other day.=
..
>
>> +'
>> +
>>  test_expect_success 'verify blob:limit=3D10001' '
>>  	git -C r2 ls-files -s large.1000 large.10000 |
>>  	test_parse_ls_files_stage_oids |
>
> ...we can test it, but this test is in a file that's not part of "linux-=
leaks".
>
> If that one leak I mentioned above can be fixed (or maybe it's not new?)
> this could be tested if we put it in a file of its own with
> TEST_PASSES_SANITIZE_LEAK=3Dtrue.

Plugging the leak in your example command is not enough to make t5317
leak free.

Ren=C3=A9
