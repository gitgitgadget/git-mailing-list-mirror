Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFCD20802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbdFVXaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:30:03 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34426 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdFVXaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:30:02 -0400
Received: by mail-pf0-f175.google.com with SMTP id s66so15425426pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ru3mFyx4xtAa5EsvopbC7V1UqGE7sNYBNLgVCbuyiag=;
        b=XNay7d8Sixxi5Xg1G3EWXSzEazGtjaHVxPJqNoh/FRVq3EsG5rrjJ8yLvpt6PHw2yu
         aHRo4LxeLX7DvCh50Z7MZv9n86C8ASKLnFUjzl3MdXk7L4U9S+lW/VkUuJomYXJFJ0/x
         PIkCX6Aq2/bxTYw0940agPoCObO3w7CSFpnIa73gnybfb5CjyI9gDuMmTbxmh5Qfnii7
         QLEU3hXQvqU99fh+thJcFRGl7nHe3adMyyTRGSDiKjgJWnfl8AdcszWh9x+R3HlIyr3v
         DOMBH9DoChe9KuXXULT9kTSgvICAOXM9h8w3L4zXlAlGy/qXnDbRZr2CoVSuYESSNgUq
         Ee4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ru3mFyx4xtAa5EsvopbC7V1UqGE7sNYBNLgVCbuyiag=;
        b=Atrh1KpYlN8/SkY5gsV9pHx5GGYcR31fBT6Gj9xsVhZlSDyMeyi6NpNL9AwBOqG5aH
         CPRIvG3ZuzCALunb3wW2dfSbJJZs3/Rg4g9+xQZGdQrdtVc11dTd/swZD/yXAluGqkTI
         9/rMOdxAsdQDfirKNt5f01XgvXG5kzDwsND2sWwjUyUWJNyAHSbOFeCPMx2K4V7gMEJ0
         /11ApEtz2C0icxSQNDV272uuiT3JtMgJoGrpT2WrFgcOhft14VznEYIXlB2UMtVyNSb/
         jhXEOAhjFbnq9sfkB0PsfhyHWUY3FTW05Hz94dlvHA4xdVZ8w95nJ9Fhd2vPU9c246PC
         m0sQ==
X-Gm-Message-State: AKS2vOwKSmyRd+hCyH773z1utp9icQtzxyMu016HPzwuyayvqWEBya7r
        Qe6IMntDDCiQktBKK3K0t6jtp+Yj7Dlmeow=
X-Received: by 10.98.34.8 with SMTP id i8mr5132645pfi.194.1498174202057; Thu,
 22 Jun 2017 16:30:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 16:30:01 -0700 (PDT)
In-Reply-To: <xmqq37atp0ng.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-9-sbeller@google.com>
 <xmqq37atp0ng.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 16:30:01 -0700
Message-ID: <CAGZ79kY46UGwBt2A20bwX_CFNuVP8hy_inCqh6hqiA5VfcfSxA@mail.gmail.com>
Subject: Re: [PATCH 08/26] diff.c: migrate emit_line_checked to use emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  static void emit_add_line(const char *reset,
>>                         struct emit_callback *ecbdata,
>>                         const char *line, int len)
>>  {
>> -     emit_line_checked(reset, ecbdata, line, len,
>> -                       DIFF_FILE_NEW, WSEH_NEW, '+');
>> +     unsigned flags = WSEH_NEW | ecbdata->ws_rule;
>> +     if (new_blank_line_at_eof(ecbdata, line, len))
>> +             flags |= DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF;
>> +
>> +     emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
>>  }
>
> This is a bit unsatisfactory that the original code didn't even have
> to make a call to new_blank_line_at_eof() at all when we know we are
> not checking for / coloring whitespace errors, but the function is
> called unconditionally in the new code.

We could check if we do colored output here, I think'll just do that for now,
but on the other hand this becomes a maintenance nightmare when we
rely on these flags in the future e.g. for "machine parse-able coloring"
and would markup according to the flags strictly. I guess we can fix it then.

>
>> diff --git a/diff.h b/diff.h
>> index 5be1ee77a7..8483ca0991 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -148,9 +148,9 @@ struct diff_options {
>>       int abbrev;
>>       int ita_invisible_in_index;
>>  /* white-space error highlighting */
>> -#define WSEH_NEW 1
>> -#define WSEH_CONTEXT 2
>> -#define WSEH_OLD 4
>> +#define WSEH_NEW (1<<12)
>> +#define WSEH_CONTEXT (1<<13)
>> +#define WSEH_OLD (1<<14)
>
> Hopefully this is a safe conversion, as everything should come from
> parse_ws_error_highlight() that uses these constants.

I reviewed the conversion again and I think it is safe, still.

We could do the up and downshifting for the flags to keep these
as-is, but I am not sure if that is a good idea, the up and downshifting
is not just run time complexity but also a readability issue.

>
> But this is brittle; there must be some hint to future readers of
> this code why these bits begin at 12th (it is linked to 07777 we saw
> earlier); otherwise when they change something that needs to widen
> that 07777, they will forget to shift these up, which would screw
> up everything that is carefully laid out here.

I added a note there. and a BUG check at the beginning of the output.
Smart compilers will drop that and for dumb compilers we'll have an
extra check per commit, which is not too bad
