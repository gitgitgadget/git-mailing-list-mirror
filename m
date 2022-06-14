Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 20:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiFNUFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiFNUFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 16:05:32 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562FC4C7B2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655237102;
        bh=4rN4s+M/0DeY4Wwzg+q6111s+8pjMh2/twqHoIko1xY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jz6fD6JGET5c7RVQ2S3paxgvJFsCTc9p/qZn/1PEsfN+hIvs1RaNFFWRZQTFgpo4K
         AmtLWQBms0HOI5G0SWrqBNUqCAEGOi5aBAb9EGmFj4ICzBcFRQ0irY2vgf9/FM+ESB
         sRmeZTnonabUAfeFdmvoFszBvb4lba4NuQ+/+IBs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnpGi-1nLnPw3JdK-00pWTU; Tue, 14
 Jun 2022 22:05:02 +0200
Message-ID: <4b4da5b3-7898-e97b-af74-a6874c8cb7e2@web.de>
Date:   Tue, 14 Jun 2022 22:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
 <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> <xmqqk09k449y.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
 <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
 <nycvar.QRO.7.76.6.2206141802310.353@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <nycvar.QRO.7.76.6.2206141802310.353@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mIXi7YRWE5IeiZs6y3UsI8zNbgV4pAJIgE7CZaP74BJIE73udAx
 4N6yawfDCnF6ZCsLutog1rK1I3jzICpwThrzy4pP3O9t7FY1OeymczXS4sGpjWRzb5Xt9vn
 9PBw8FYmywYVCibOu8YbZsM7yE0BcZEvFwbgClH/7PPuhZPfggKWXkmd0EBWkLnswOoN41H
 y+kpemyMEPDToK7/e7Hbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qdqfawVobLY=:TwdqCbggOULK88GJ6CxvDL
 B/bedGaIlUm3XfSrwUYonmOIScreMB4W2vcPBVuna2A9vUJHZZZuQhR63OykHlzKqHPba3kZ3
 GcpsED/wHRgqWQSXzBSBqf3TAnuj2BXdT7lStJmCL6B5P8Ikmcc0iPU03OGBSD2cQJlCQvA6i
 8EKKnGm/SStncby1OaNEcGAEAP0dyOJABj8Ulj7XZ+jRnaBga7vbAz1RW+K5Zs5PznoBaq7Ib
 kEc8sOpqpRiMeUAcMrZm07X+qKoZ19c9+T4l7HaLjiF5jzdK4r3QpHkPRsixZrFVaZ9tAkRuB
 TL961lu+iLjIKrkkkbpJ+j1SjXVW4VJd0hKb70kTZBjNikU7SKbptpY9378M1MDjHAyrJhbh9
 yir+YIlzrkEF2H08s1IYtSuS98VVjoYBpAdlhsOOjUP+XcYs6x4yDdNZ/hifNCmSHIycM8az3
 xaviZD3AtLu9qNIFbEhu65f3+9yFMvsyeYXfo+eNrJEindePO3i8WcS+ExHFR3WT1xTyM6mfv
 yUMEqSPwfatQPkPYpbmeREjB+j2GXRLJ7uzGRTCfFjHc+ZOql4R5l5Iby+1U+kFkRNI5V5Kmh
 ZFr+09s2jRlLPEhWLGtdmBw9Mmj1xfkMggle6oRu9v1TVZcbTgDjxDdTRtIRL4Va+vHCoMSli
 CJsqZBLZGR3fHvcrTqwCLlfzVHBK5sRlOYxL+DtdvOSZ2KxlacqJEb5Tzf36vSXefC294PJl0
 JkEiZb291B1NEpyBSe4RfAC86w8ohV74KxJu8JPe7r1vLNUOJOewK6SfRpvBFN1kIFUbMy1J5
 lYFSr46Nh0pc2pSSD4Q0DA05980CPXUg/589UFNpYOCHGtwLPdtjg9/N+VIhFOTJAKqaG5K40
 0EkPPHy6pHIJPFFCT3h+ZjOzbPY64yCorroH5zpB0ViML03YTvY/+cH0pxEf67Auv/TxMV9Ia
 690IQwRkMiEaj3rREwPmiJ1GXYGpeX9P4lDFWfrtyB7MoDMQc6/hsJ7lUQNLXIn/EkkXt9VL6
 ckbieJYUngw2HLR6N7Z6H7da+7VAM0+1uBGHA9IMoiqDUu4d/VcleppxeMF5TdMrxF5wEQzpM
 aLCxNDXlSJ8kLGy6Cfrb+uMh1jYsbVTkoT5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.22 um 18:29 schrieb Johannes Schindelin:
> Hi Ren=C3=A9,
>
> On Tue, 14 Jun 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 14.06.22 um 13:27 schrieb Johannes Schindelin:
>>
>>> The solution is to move the heap variable back into a scope that match=
es
>>> the lifetime of the compression:
>>>
>>> -- snip --
>>> diff --git a/archive-tar.c b/archive-tar.c
>>> index 60669eb7b9c..3d77e0f7509 100644
>>> --- a/archive-tar.c
>>> +++ b/archive-tar.c
>>> @@ -460,17 +460,12 @@ static void tgz_write_block(const void *data)
>>>
>>>  static const char internal_gzip_command[] =3D "git archive gzip";
>>>
>>> -static void tgz_set_os(git_zstream *strm, int os)
>>> -{
>>> -#if ZLIB_VERNUM >=3D 0x1221
>>> -	struct gz_header_s gzhead =3D { .os =3D os };
>>> -	deflateSetHeader(&strm->z, &gzhead);
>>> -#endif
>>> -}
>>> -
>>>  static int write_tar_filter_archive(const struct archiver *ar,
>>>  				    struct archiver_args *args)
>>>  {
>>> +#if ZLIB_VERNUM >=3D 0x1221
>>> +	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducib=
ility */
>>> +#endif
>>>  	struct strbuf cmd =3D STRBUF_INIT;
>>>  	struct child_process filter =3D CHILD_PROCESS_INIT;
>>>  	int r;
>>> @@ -481,7 +476,10 @@ static int write_tar_filter_archive(const struct =
archiver *ar,
>>>  	if (!strcmp(ar->filter_command, internal_gzip_command)) {
>>>  		write_block =3D tgz_write_block;
>>>  		git_deflate_init_gzip(&gzstream, args->compression_level);
>>> -		tgz_set_os(&gzstream, 3); /* Unix, for reproducibility */
>>> +#if ZLIB_VERNUM >=3D 0x1221
>>> +		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
>>> +			BUG("deflateSetHeader() called too late");
>>> +#endif
>>>  		gzstream.next_out =3D outbuf;
>>>  		gzstream.avail_out =3D sizeof(outbuf);
>>>
>>> -- snap --
>>
>> Good find, thank you!  A shorter solution would be to make gzhead stati=
c.
>
> I should have said that I had considered this, but decided against it
> because it would introduce yet another issue: it would render the code
> needlessly un-multi-threadable. And that can be avoided _really_ easily.

archive-tar.c (and archive-zip.c) use other static variables, so a
static gzhead won't break or block anything in this regard.  There was
no interest in running it in parallel threads so far AFAIK, and it's
hard for me to imagine the usefulness of creating multiple .tgz files at
the same time.

The doubled ZLIB_VERNUM is unsightly and I'm not sure the BUG check is
useful -- I omitted error checking because there is no recurse for us if
deflateSetHeader() doesn't work, and on ancient zlib versions we
silently continue anyway.

But that's all just minor quibbling -- I'll include your changes in the
next version, they look fine overall.

Ren=C3=A9
