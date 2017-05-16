Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717C11FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbdEPQXl (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:23:41 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36394 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbdEPQXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:23:40 -0400
Received: by mail-pg0-f49.google.com with SMTP id x64so59382971pgd.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AAnaLvD+zKtjZ+VmMhr/yFOj521InwHz2K3MF+Nuuy4=;
        b=tEa6HH+f46wLkwpC7b1OULKZyUZ7A3ww+g/bbNiAFMHkROuRhSVmIBC+Tdkvj2/ujd
         1FbXNlnuXzthoTZXtsf9Un1yFAW70ThKZu9XPrlBXviNjztD9B8s0geNvCxoHydMlSwH
         aq+1rk4ELXxxC07JaiXA78t9XCf2KKTWfMMYPUHWw6YS09a3uXQM3KqZLCsgj2MIVnRM
         6yvR5spr/1N/1LSEo6mrd2WZo4rQo5Egej2sezuey8xxPfpAErzDOOZttjpG+A28GYK0
         /E1//DOPVDbxE+35J9ETn1wpxOXBEr2O7YoZ19eeGLTgxLlXL6NEJNTWH18AIisovdi9
         TgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AAnaLvD+zKtjZ+VmMhr/yFOj521InwHz2K3MF+Nuuy4=;
        b=AOkFA10DYeYoujOzkS3fmW5W2gCDeQA1DxyBKjkPDpMqt8mqgXHCI6WPAYe34JRz3t
         ODxC7f2NUZX66MT+ClgYT5sFL5C4a4P1SrVU6+FV9Wkc+7D1MRHEYrs+FpDr+Y5HMp+C
         ObwkdAt/BoCtZ2IsGLhtSsleVtFJY6ojONenWpcmzphAOdT01C1V7gNCSlaPAy8/JtLz
         IE9G8VXWuUXkLjVPt3FWns8GEG2+jDsgy49l6ljw4u8ka5v126ryE00Yvt2Lp5d3/+kM
         tNfNvWM1jWRn+ScfCP/GKY4motXsxVXjjPs+3ANzEZ2DyBayZPfHiI3EJFmW/+HusG3+
         FS1g==
X-Gm-Message-State: AODbwcBTh67lc/69QsW28fxLOwtjs2SRL/AwDxDJZ7mhDiOiFR8aD9Ui
        HQDAsRveD2blUIIyU3TZBM7ke4ZCntur
X-Received: by 10.84.231.206 with SMTP id g14mr16818410pln.12.1494951819957;
 Tue, 16 May 2017 09:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 16 May 2017 09:23:39 -0700 (PDT)
In-Reply-To: <xmqqpof94nn2.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-8-sbeller@google.com>
 <xmqqtw4l4nuk.fsf@gitster.mtv.corp.google.com> <xmqqpof94nn2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 May 2017 09:23:39 -0700
Message-ID: <CAGZ79ka3JU=7WgF1tYTTam32QhZVokJxdqyOi33P-sd=XrUecw@mail.gmail.com>
Subject: Re: [PATCH 07/19] diff.c: convert fn_out_consume to use emit_line_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> -            fprintf(o->file, "%s%s--- %s%s%s\n",
>>> -                    line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
>>> -            fprintf(o->file, "%s%s+++ %s%s%s\n",
>>> -                    line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
>>> +            emit_line_fmt(o, meta, reset, "--- %s%s\n",
>>> +                          ecbdata->label_path[0], name_a_tab);
>>> +            emit_line_fmt(o, meta, reset, "+++ %s%s\n",
>>> +                          ecbdata->label_path[1], name_b_tab);
>>
>> How is the loss of line_prefix from this call site compensated?
>
> OK, emit_line_0() has already been aware of line_prefix, so that is
> how the loss of line_prefix in the above is accounted for.  We are
> good here.
>
>>>              ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
>>>      }
>>>
>>> @@ -1349,7 +1346,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>>>              diff_words_flush(ecbdata);
>>>              if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
>>>                      emit_line(o, context, reset, line, len);
>>> -                    fputs("~\n", o->file);
>>> +                    emit_line(o, NULL, NULL, "~\n", 2);
>
> So unless we have some magic here, we would see an extra line-prefix
> before that "~\n" thing, no?

Right.

With all the discussion on the the convert* patches, I consider just introducing
another parameter to emit_line, which specifies whether we want
emit_line to output
a line_prefix. Then the conversion becomes a lot easier as well.

Thanks,
Stefan
