Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6505C20401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdFUUJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:09:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34930 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUUJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:09:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so32635660pfs.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4jrebx2ARhLXQBwnKjiPmpg5j6APjbdvTvNdwL762D0=;
        b=RvOAgyMiOjtxlFly4vclDnV5wrXJoQkuDGOJFpp0MNMFuKRuKGdCliy93qI7WvTD7W
         mCLaFZOSI3DjmGQuGM0BsUz+9I3FyUsbAfaJ9qwdG6/k1VTIgOH1r5XIpEXISpGnHW9I
         i7C7s6qw6J3H69+N//0DTpnwjEckZ0ivdoniqjXl7mZ7+oS9CN1aadFICTcFYqtWPi6X
         PJ+HBO4y8Khfghz3YuffSoiRIL3JeBTAWaSPXGTaK1vXZUX8BWapRpL+ZttO5wxMeTgl
         vvwpKuwIh9D2TWYyzUf0Qj/tFojBnxkkxb4arw4dEKxORxtvC1gDlrHv8d8XCT5nPgf3
         tU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4jrebx2ARhLXQBwnKjiPmpg5j6APjbdvTvNdwL762D0=;
        b=CAC8ETsUJ/ZiXNNd5kZBLT7aI9cJMRf54Rrjsujtr9dJVf65qonKcEE1SiTu38vA2X
         b6RtRZLnJKLF6DLWvsW0RdxOw6wqgoF0R1aJSLXoYnad+U/NB7ufN3kqOhYdUVNp4yec
         kuU4RyAGyAfGDefWYaoucqm+d/4CZ9pen+7XbZgrisDsu/8grWVYIcZqAv89sKg9iiYd
         U6ktHQEy8gMMbqcVHLc19rQ9Tixh7Y5vtUESEyT/FMPQljDxXC+3jFiB8wRNLbVk0pew
         /ViyvRnudLACBV88KOT6Hoxiwdd97dMEJ4j8Kk1a463KlTMrWQxpyll11UBNEdBBjYgf
         2/mQ==
X-Gm-Message-State: AKS2vOwnQT5MZiT5sw2QM8t1tII86m4esnbD+JDG5k1MTSNXaaNBrG8Y
        UiRgS0n5Lyxs6SlVRho=
X-Received: by 10.99.145.67 with SMTP id l64mr20765691pge.184.1498075786580;
        Wed, 21 Jun 2017 13:09:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id j27sm22802585pgn.63.2017.06.21.13.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:09:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, bmwill@google.com,
        git@vger.kernel.org, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: Re: [PATCH 11/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-12-sbeller@google.com>
        <20170620130147.75e1fb78@twelve2.svl.corp.google.com>
Date:   Wed, 21 Jun 2017 13:09:45 -0700
In-Reply-To: <20170620130147.75e1fb78@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Tue, 20 Jun 2017 13:01:47 -0700")
Message-ID: <xmqqvanpnlva.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Mon, 19 Jun 2017 19:48:01 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> @@ -676,6 +677,14 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>>  		}
>>  		emit_line(o, context, reset, line, len);
>>  		break;
>> +	case DIFF_SYMBOL_FILEPAIR:
>> +		meta = diff_get_color_opt(o, DIFF_METAINFO);
>> +		reset = diff_get_color_opt(o, DIFF_RESET);
>> +		fprintf(o->file, "%s%s%s%s%s%s\n", diff_line_prefix(o), meta,
>> +			flags ? "+++ " : "--- ",
>
> I think that a constant should be defined for this flag, just like for
> content lines. If not it is not immediately obvious that a flag should
> be set for the +++ lines.

True.

>> +			line, reset,
>> +			strchr(line, ' ') ? "\t" : "");
>> +		break;

Also this is somewhat misnamed in that a call to it only deals with
one half of a filepair, iow, the caller must call it twice to show a
single filepair.
