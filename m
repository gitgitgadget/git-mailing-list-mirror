Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975991F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 16:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeJLAZn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 20:25:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeJLAZn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 20:25:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so10485278wrd.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Ld+utAaAwsd3G3tpQloqo2CVyyaI0SlybUkp949w7s=;
        b=ofYxVkSv/nm2FinkZ16MuNT4stSHkkTgwJhWgOq0Ihxi0O3bqTVuScgC4chnOxtkIM
         DvW1ukAh7E86Z+hUIi5VLLiVGWZiCPlwk3VneEyUKkUgCwRWdavKI3H7DxmdHseOHZ+R
         9xc6SSfwCWbe4V0amSr0Gmamz8nzHuek4hETh46UREvPRwV+iI5O23fCfS0vNSr/gxN1
         FgEQI2vDKZzP47kQAUFYlx9snFbiV4ezXuif/c0g+JLVETvWidEQzLcAAsrxPYAtQBQI
         dX8SdmH7PkozEr5Vg2iEukXnsjMlXsehxqnJ2qQUhPO7J57HyhR3go5Ro8rAkg9P2jCj
         iAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7Ld+utAaAwsd3G3tpQloqo2CVyyaI0SlybUkp949w7s=;
        b=uOBtSe2vT6DM85T0lmme+Hy2dgfEzuB5sWANEnDPmRZj75hlsb+4tf64OJfgjUZfmc
         NG07jbOYqcTP1MbhDJEMZggu9QnvI7sj7XwXd6LW/QetLXoaUjncmarLuImLGPqg2l70
         H3mWr+fQQeCyueT2abzL70Xw3v1Myu1UB3a9MIhDmxVsidOrLQr3whOEjgYTfyreYl15
         nJA1QHTnh1EGgKrh4jsjQXDexXNKuGNrGMI37eXmCCz/4ZWm6XHI1cnjC9xudGeKgCHR
         LGhZNECWl4vwj1u+RlF1DFCBlymRkbNybvHn2+xgzVNx9Rj3PHhpUXN2SvaGc0LzrRCr
         M/MQ==
X-Gm-Message-State: ABuFfoig3dcTvOxOdG4KMptbv/qg+ym5w2u/IL7lz+urrk53mdGwjAH8
        uYtRY1SV8id6gV/0gp8lS+k=
X-Google-Smtp-Source: ACcGV61RcXBmrDI5jLBQzOpVCEpD2TFgPma5YdtYpI78IL9CFZJgtPAproS3zYUKoiNjVONW51ZZkA==
X-Received: by 2002:adf:9021:: with SMTP id h30-v6mr2461762wrh.248.1539277056102;
        Thu, 11 Oct 2018 09:57:36 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.gmail.com with ESMTPSA id v1-v6sm23837095wrd.24.2018.10.11.09.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 09:57:35 -0700 (PDT)
Subject: Re: [PATCH 04/15] sequencer: refactor sequencer_add_exec_commands()
 to work on a todo_list
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-5-alban.gruin@gmail.com>
 <6188911e-fd21-4c7c-885d-a15d2b46aa86@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c55857a-ce3c-f9fc-18c6-d7cef2976931@gmail.com>
Date:   Thu, 11 Oct 2018 18:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6188911e-fd21-4c7c-885d-a15d2b46aa86@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

thanks for taking the time to review my patches.

Le 11/10/2018 à 13:25, Phillip Wood a écrit :
> On 07/10/2018 20:54, Alban Gruin wrote:
>> @@ -4419,15 +4406,38 @@ int sequencer_add_exec_commands(const char
>> *commands)
>>       }
>>         /* insert or append final <commands> */
>> -    if (insert >= 0 && insert < todo_list.nr)
>> -        strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
>> +    if (insert >= 0 && insert < todo_list->nr)
>> +        strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
>>                     offset, commands, commands_len);
>>       else if (insert >= 0 || !offset)
>>           strbuf_add(buf, commands, commands_len);
>>   -    i = write_message(buf->buf, buf->len, todo_file, 0);
>> +    if (todo_list_parse_insn_buffer(buf->buf, todo_list))
>> +        BUG("unusable todo list");}
> 
> It is a shame to have to re-parse the todo list, I wonder how difficult
> it would be to adjust the todo_list item array as the exec commands are
> inserted. The same applies to the next couple of patches
> 

Good question.

This function inserts an `exec' command after every `pick' command.
These commands are stored in a dynamically allocated list, grew with
ALLOW_GROW().

If we want to keep the current structure, we would have to grow the size
of the list by 1 and move several element to the end every time we want
to add an `exec' command.  It would not be very effective.  Perhaps I
should use a linked list here, instead.  It may also work well with
rearrange_squash() and skip_unnecessary_picks().

Maybe we could even get rid of the strbuf at some point.

> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

