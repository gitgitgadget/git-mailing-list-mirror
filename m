Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3625E1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbeAXLFH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:05:07 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57703 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932891AbeAXLFG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:05:06 -0500
X-AuditID: 12074411-665ff70000000b66-81-5a6868619b0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id ED.24.02918.168686A5; Wed, 24 Jan 2018 06:05:05 -0500 (EST)
Received: from [192.168.69.190] (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OB52xZ004297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 24 Jan 2018 06:05:03 -0500
Subject: Re: [PATCH v3] packed_ref_cache: don't use mmap() for small files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20180115235251.GA21900@sigill.intra.peff.net>
 <20180116193815.4568-1-kgybels@infogroep.be>
 <20180117220902.GA14952@sigill.intra.peff.net>
 <29c51594-6e29-be34-3d5f-2b9f399490f2@alum.mit.edu>
 <xmqqh8rdn113.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
Date:   Wed, 24 Jan 2018 12:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqh8rdn113.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqJuYkRFlsH+mmEXXlW4mi4beK8wW
        /cu72CwOds5ktfjR0sPswOrx4WOcR9+RNYwez3r3MHpcvKTs8XmTXABrFJdNSmpOZllqkb5d
        AlfG9ScT2QseKFdMez2HsYFxoUwXIyeHhICJxPGP+9i7GLk4hAR2MEns/P4LyrnAJLHsyWEm
        kCphAS+JqUsOsoPYIgJqEhPbDrGAFDELTGCU2Pz6JSNERyOTxO07q1lAqtgEdCUW9TQDdXNw
        8ArYS3zflA0SZhFQlVj1uBtskKhAhMSUtWvBynkFBCVOznwCZnMKWEtsv3YYzGYWUJf4M+8S
        M4QtLnHryXwmCFteYvvbOcwTGAVmIWmfhaRlFpKWWUhaFjCyrGKUS8wpzdXNTczMKU5N1i1O
        TszLSy3SNdXLzSzRS00p3cQICX3BHYwzTsodYhTgYFTi4b1hkR4lxJpYVlyZe4hRkoNJSZQ3
        PygjSogvKT+lMiOxOCO+qDQntfgQowQHs5IIbx4rUDlvSmJlVWpRPkxKmoNFSZyXb4m6n5BA
        emJJanZqakFqEUxWhoNDSYLXOB1oqGBRanpqRVpmTglCmomDE2Q4D9BwF5Aa3uKCxNzizHSI
        /ClGXY4bL163MQux5OXnpUqJ85alARUJgBRllObBzYGlrFeM4kBvCfPmg4ziAaY7uEmvgJYw
        AS25UZMKsqQkESEl1cBotqluaUHR9sA7714V/Mw3vPjm1bPIb0paZm/rLv8uP8jZ2Mno3+Fj
        FtRUrnqn0WLJ0rPGobnvX+xMcFvF9sM91W/KWe0z/EcPKFhe33PfVrdApK94ctXDA3zrOY4J
        JB5+f2p73yzLH8L+OsUZL3s9fvpcNjDvkb21cHODi4HmFs1PdpMERKSVWIozEg21mIuKEwF8
        QfFRNAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/22/2018 08:31 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> `snapshot->buf` can still be NULL if the `packed-refs` file didn't exist
>> (see the earlier code path in `load_contents()`). So either that code
>> path *also* has to get the `xmalloc()` treatment, or my third patch is
>> still necessary. (My second patch wouldn't be necessary because the
>> ENOENT case makes `load_contents()` return 0, triggering the early exit
>> from `create_snapshot()`.)
>>
>> I don't have a strong preference either way.
> 
> Which would be a two-liner, like the attached, which does not look
> too bad by itself.
> 
> The direction, if we take this approach, means that we are declaring
> that .buf being NULL is an invalid state for a snapshot to be in,
> instead of saying "an empty snapshot looks exactly like one that was
> freshly initialized", which seems to be the intention of the original
> design.
> 
> After Kim's fix and with 3/3 in your follow-up series, various
> helpers are still unsafe against .buf being NULL, like
> sort_snapshot(), verify_buffer_safe(), clear_snapshot_buffer() (only
> when mmapped bit is set), find_reference_location().
> 
> packed_ref_iterator_begin() checks if snapshot->buf is NULL and
> returns early.  At the first glance, this appears a useful short cut
> to optimize the empty case away, but the check also is acting as a
> guard to prevent a snapshot with NULL .buf from being fed to an
> unsafe find_reference_location().  An implicit guard like this feels
> a bit more brittle than my liking.  If we ensure .buf is never NULL,
> that check can become a pure short-cut optimization and stop being
> a correctness thing.
> 
> So...
> 
> 
>  refs/packed-backend.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index b6e2bc3c1d..1eeb5c7f80 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -473,12 +473,11 @@ static int load_contents(struct snapshot *snapshot)
>  	if (fd < 0) {
>  		if (errno == ENOENT) {
>  			/*
> -			 * This is OK; it just means that no
> -			 * "packed-refs" file has been written yet,
> -			 * which is equivalent to it being empty,
> -			 * which is its state when initialized with
> -			 * zeros.
> +			 * Treat missing "packed-refs" as equivalent to
> +			 * it being empty.
>  			 */
> +			snapshot->eof = snapshot->buf = xmalloc(0);
> +			snapshot->mmapped = 0;
>  			return 0;
>  		} else {
>  			die_errno("couldn't read %s", snapshot->refs->path);
> 

That would work, though if you go this way, please also change the
docstring for `snapshot::buf`, which still says that `buf` and `eof` can
be `NULL`.

The other alternative, making `snapshot` safe for NULLs, becomes easier
if `snapshot` stores a pointer to the start of the reference section of
the `packed-refs` contents (i.e., after the header line), rather than
repeatedly computing that address from `snapshot->buf +
snapshot->header_len`. With this change, code that is technically
undefined when the fields are NULL can more easily be replaced with code
that is safe for NULL. For example,

    pos = snapshot->buf + snapshot->header_len

becomes

    pos = snapshot->start

, and

    len = snapshot->eof - pos;
    if (!len) [...]

becomes

    if (pos == snapshot->eof) [...]
    len = snapshot->eof - pos;

. In this way, most of the special-casing for NULL goes away (and some
code becomes simpler, as well).

In a moment I'll send a patch series illustrating this approach. I think
patches 01, 02, and 04 are improvements regardless of whether we decide
to make NULL safe.

The change to using `read()` rather than `mmap()` for small
`packed-refs` feels like it should be an improvement, but it occurred to
me that the performance numbers quoted in ea68b0ce9f8 (hash-object:
don't use mmap() for small files, 2010-02-21) are not directly
applicable to the `packed-refs` file. As far as I understand, the file
mmapped in `index_fd()` is always read in full, whereas the main point
of mmapping the packed-refs file is to avoid having to read the whole
file at all in some situations. That being said, a 32 KiB file would
only be 8 pages (assuming a page size of 4 KiB), and by the time you've
read the header and binary-searched to find the desired record, you've
probably paged in most of the file anyway. Reading the whole file at
once, in order, is almost certainly cheaper.

Michael
