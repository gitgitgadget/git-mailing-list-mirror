Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D1C211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeLESrO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 13:47:14 -0500
Received: from mout.web.de ([217.72.192.78]:46985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLESrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 13:47:14 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Po-1hG3oU2hbg-00pref; Wed, 05
 Dec 2018 19:41:46 +0100
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
 <20181205044645.GA12284@sigill.intra.peff.net>
 <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
 <20181205065136.GA27263@sigill.intra.peff.net>
 <20181205081544.GA9271@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <48ab861b-46c8-2bd5-0508-fa106efd8e56@web.de>
Date:   Wed, 5 Dec 2018 19:41:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205081544.GA9271@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SuhpoQXxLoP/dAfHHBlNqDekpVHz8IHlRoYbU6qhHPk0Tabo1Bh
 9MqYBbq1XEZGEL6RqXrl5oq+etYekVW+cYlNh6n/By9dx/v8qfOqsNYjgHAeW4ETK60YHPT
 8M8AmLyaJDy0jcjdACTKnulk3GtrafwTfiDhuIqv1/V/z2atL1udSnGnRQVdSV8KMerC5Wk
 yn/F5HZvB8Wh+zSkMooDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4bx5tr/Ni9M=:q6NEl/ldeZiwnA3wiKZRox
 e6UGKBDPBfgxUsmnV8inZpeYl+Hzp9JF7ZiNzb2Cm7BspDj2bR1u0xRfyK3RzFLo5pnQ6aTSl
 76KKGsYlT6YXl9eEuucfDZI1LIQa4zqaLCiQDNwWTme2t+zMqHKh8MrobhHv0T54wJmO5Q605
 90bu81UW3S1qIsBF7AEDILzAGTuk0rkzKnPaWMkvUEoNg4gECcIntLXhI+Brzk8NknUf1+eLZ
 /5xSD81NAXzxXjDf7Ut4eN38Yt7mBKAcaj07qBex7xWsoFuR1Ts5U/iE3JoHZbcPGKQj5Zf6f
 HPsaNqwmACX9Gh3U3JoU062T4KwhCjcBqeP0od/yNDp0qm20l8QsG04u+3XzeKT8MpILeTZrc
 zSu8h+jNUhixmPGcgjFQBxbuDAarafhdppVFx4IxW8xOaiSQccUDIlTzCcrUXvevdhFFWOpUC
 X5oXwtt5459+0rhyk3pUStG96v505dUIwRRc+wVAbWxX67bDWgYzbk8W/F8ryhXMh7wZDrcz9
 7P4UOozP9bmo+sEG7L989REzvf/IYlH1xe/40AMpRALt1IeRhExycfNTHgkACzaMP65VHZkQK
 dN7nzD+PnqODSskoAIxsOOAhDZWR6gBoLRiZ2swdU2fYYiCmIH2kpTuruNn87PRYp5G0fnb18
 yjc0ctQQTlIzn+jF+RMyNpYJ2XezaP9ZrAm/Q0PUMqLjHMReMSkBjQ1Gg8Vg9OCjb9U3G52JR
 5JIXpSAgX5Rh/Y5/j8AeNFh1+4baeykPmQjagM0gtSTBiOIe7HPUUiKxLnzIROFMNx4gg5ZSN
 TEXpHnN5FaOpHwkB2N5YtKgkCVAx0d91wL7gQx6ZDpBTCBwoVRfcEv//DiZnOpkzYfESniKdk
 iJ9BlP8ZaGTQNGLU3CDzb1rl17CPcAbM1Y7Ljp0tca1LbZF56KxOFDxauy/8hH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.2018 um 09:15 schrieb Jeff King:
> On Wed, Dec 05, 2018 at 01:51:36AM -0500, Jeff King wrote:
> 
>>> This
>>> function is easily converted to struct object_id, though, as its single
>>> caller can pass one on -- this makes the copy unnecessary.
>>
>> If you mean modifying sha1_loose_object_info() to take an oid, then
>> sure, I agree that is a good step forward (and that is exactly the "punt
>> until" moment I meant).
> 
> So the simple thing is to do that, and then have it pass oid->hash to
> the other functions it uses.

Yes.

> If we start to convert those, there's a
> little bit of a rabbit hole, but it's actually not too bad.

You don't need to crawl in just for quick_has_loose(), but eventually
everything has to be converted.  It seems a bit much for one patch, but
perhaps that's just my ever-decreasing attention span speaking.

Converting one function prototype or struct member at a time seems
about the right amount of change per patch to me.  That's not always
possible due to entanglement, of course.

> Most of the spill-over is into the dumb-http code. Note that it actually
> uses sha1 itself! That probably needs to be the_hash_algo (though I'm
> not even sure how we'd negotiate the algorithm across a dumb fetch). At
> any rate, I don't think this patch makes anything _worse_ in that
> respect.

Right.

> diff --git a/sha1-file.c b/sha1-file.c
> index 3ddf4c9426..0705709036 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -333,12 +333,12 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
>  	return ret;
>  }
>  
> -static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
> +static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)

The new name fits.

> @@ -879,15 +879,15 @@ int git_open_cloexec(const char *name, int flags)
>   * Note that it may point to static storage and is only valid until another
>   * call to stat_sha1_file().
>   */
> -static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
> -			  struct stat *st, const char **path)
> +static int stat_loose_object(struct repository *r, const struct object_id *oid,
> +			     struct stat *st, const char **path)

Hmm, read_sha1_file() was renamed to read_object_file() earlier this
year, and I'd have expected this to become stat_object_file().  Names..

Anyway, the comment above and one a few lines below should be updated
as well.

>  {
>  	struct object_directory *odb;
>  	static struct strbuf buf = STRBUF_INIT;
>  
>  	prepare_alt_odb(r);
>  	for (odb = r->objects->odb; odb; odb = odb->next) {
> -		*path = odb_loose_path(odb, &buf, sha1);
> +		*path = odb_loose_path(odb, &buf, oid);
>  		if (!lstat(*path, st))
>  			return 0;
>  	}
> @@ -900,7 +900,7 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
>   * descriptor. See the caveats on the "path" parameter above.
>   */
>  static int open_sha1_file(struct repository *r,
> -			  const unsigned char *sha1, const char **path)
> +			  const struct object_id *oid, const char **path)

That function should lose the "sha1" in its name as well.

> -static void *map_sha1_file_1(struct repository *r, const char *path,
> -			     const unsigned char *sha1, unsigned long *size)
> +static void *map_loose_object_1(struct repository *r, const char *path,
> +			     const struct object_id *oid, unsigned long *size)

Similarly, map_object_file_1()?

> -void *map_sha1_file(struct repository *r,
> -		    const unsigned char *sha1, unsigned long *size)
> +void *map_loose_object(struct repository *r,
> +		       const struct object_id *oid,
> +		       unsigned long *size)

Similar.

> @@ -1045,7 +1043,9 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>  	return -1;
>  }
>  
> -static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
> +static void *unpack_loose_rest(git_zstream *stream,
> +			       void *buffer, unsigned long size,
> +			       const struct object_id *oid)

Hmm, both old and new name here look weird to me at this point.

> -static int sha1_loose_object_info(struct repository *r,
> -				  const unsigned char *sha1,
> -				  struct object_info *oi, int flags)
> +static int loose_object_info(struct repository *r,
> +			     const struct object_id *oid,
> +			     struct object_info *oi, int flags)

And nothing of value was lost. :)

René
