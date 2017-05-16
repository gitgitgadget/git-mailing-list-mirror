Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB6C201A7
	for <e@80x24.org>; Tue, 16 May 2017 01:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdEPBFZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:05:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33068 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEPBFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:05:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so19183356pgc.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6r5BS1FVE9ESEZvX15wFVFA9VUfoq9YcixQu2hBrcyU=;
        b=q6xg+EYtnggKtHAL/xm8/JHlIrkGbUvjZo+qd5Bb4Yd2T2dsR/CMx7at3Hc1zcMh8d
         m6s/2R/6XOLM34Y0cDcM27E1Rxa5YyItk48+sKcV1rhGq0Yh3SzNklNTfxCKFl6C7UwQ
         H/AJEc7VnVfugJcXqP/7r4EuJUu52yJhsZL5/vv53z10nGSdRjUV/00sRuAe048fPVcZ
         3gzOSAJxK5nB8EfAanQin6O3aN5XaKFjycsyQHES/koyW9xi/cLM5F63RpC/6pmzxk9k
         3a9s3iEPNuKgnv8R82Bzcp22cmhhyl5mks2QR7QIMA/ud3/CMHxaJn0LRynGCZbNz3yZ
         zE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6r5BS1FVE9ESEZvX15wFVFA9VUfoq9YcixQu2hBrcyU=;
        b=MQPw9n1PAIJSUC9VFoS8mOtotFyamvZXkUXRkHq+DNpiVYZBkDS9wHbo6nr2l7EQwJ
         gDy5rbJr2e3lwjl7hqeZ40eTXroS7g8G/AAUUGW6TbCQzMk3diHn4LprKJLz8//ut6vU
         QREN4caSEBqo1B7pzOkKYfrL1kCr3AF6gPzlcNmuRqKf9RUxNDj4GdA2Ad3EUYjdIuDg
         VX+a2WABKlTOpiQjWO3hMT1Agn+DsNj/HPndwOaFHsl19QnEb2qpGdfMH88eq3yhxkGR
         3jTkdLre59WK65EAEWFf9m3ZoxSBLbrVMP5M/vM+6s1C6CH0vZc0as/QH9nrMKi8E4wK
         LoEQ==
X-Gm-Message-State: AODbwcCi/vZrXP1PdW6/DzmI4rmD4mmQW/Vb/BBm3cMrjxHBqbFosnVE
        /LNtPF2bF6Vyxu7qAqk=
X-Received: by 10.99.95.79 with SMTP id t76mr9043775pgb.82.1494896723286;
        Mon, 15 May 2017 18:05:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id s68sm22654476pgc.5.2017.05.15.18.05.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 18:05:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 07/19] diff.c: convert fn_out_consume to use emit_line_*
References: <20170514040117.25865-1-sbeller@google.com>
        <20170514040117.25865-8-sbeller@google.com>
        <xmqqtw4l4nuk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 16 May 2017 10:05:21 +0900
In-Reply-To: <xmqqtw4l4nuk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 16 May 2017 10:00:51 +0900")
Message-ID: <xmqqpof94nn2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -		fprintf(o->file, "%s%s--- %s%s%s\n",
>> -			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
>> -		fprintf(o->file, "%s%s+++ %s%s%s\n",
>> -			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
>> +		emit_line_fmt(o, meta, reset, "--- %s%s\n",
>> +			      ecbdata->label_path[0], name_a_tab);
>> +		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
>> +			      ecbdata->label_path[1], name_b_tab);
>
> How is the loss of line_prefix from this call site compensated?

OK, emit_line_0() has already been aware of line_prefix, so that is
how the loss of line_prefix in the above is accounted for.  We are
good here.

>>  		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
>>  	}
>>  
>> @@ -1349,7 +1346,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>>  		diff_words_flush(ecbdata);
>>  		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
>>  			emit_line(o, context, reset, line, len);
>> -			fputs("~\n", o->file);
>> +			emit_line(o, NULL, NULL, "~\n", 2);

So unless we have some magic here, we would see an extra line-prefix
before that "~\n" thing, no?


>>  		} else {
>>  			/*
>>  			 * Skip the prefix character, if any.  With
