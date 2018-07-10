Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9FF1F6AC
	for <e@80x24.org>; Tue, 10 Jul 2018 00:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeGJAXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 20:23:15 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44767 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeGJAXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 20:23:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id v17-v6so8231354qkb.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VLMXKQ2lMwdxBblldMM57/ZthHcDVirUr8OM4Z1W3iQ=;
        b=U+n2lYxEE6ppg+YsJmRvWWH9/XFWjRtWixLySWLbSQh1glIz1IYRlAoXssKi29hypR
         aJvbgx5ArCaL1gZk7OWZg9IzYOjOEMedYKvQn1FcGKdy2Wg+pw7h+GEWgcPiRMir4OpE
         /YK/9bbQr44bQ15i0HXh1nz6X1HON1OMgJbhEYYNqrdPnrC2bzA6ghG0GA+wJPBfefNq
         0nKljgPvkkixzQ4W0J4EHc+CTGyHuhYhH+L005SV9oaopTF5TMG0da1yyL7W+bC22N8F
         F76x5ROhE2bQV825/WZ0EJEXPpEGvF83vfc/RvkMAe2OwnjqGvtoFFS3nRW+4Xn0Gxa8
         2twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VLMXKQ2lMwdxBblldMM57/ZthHcDVirUr8OM4Z1W3iQ=;
        b=pu3Aqm/xkuJC+jdknmDeqmlnj1LqV8gowR2Q6xXZmdOdynWiXV76ns8cBPXzrsbqO1
         HXNxyMppdrVUiS5bMujL6EjyLhb+yakqGjFi+xifDVME5pDkkrJtL+XOZYnYJ/LIfCA/
         9fKKXOX4LrM3MyNKxv66f+bZ5Jhd46CgGa7fDRHIJeF6PNTE3bvYP9W1QsmpuSmvvmf6
         hsjZajxLqAFahTYmEbArztQ0QpF8Ce9hvWj4RXjuJFsrhlpze8YHqFtMGlmGsNh0uPCV
         KsZJCySOj9Z9G+nVUcjviduvO6W1fZm+XUxp2JdG/0+LaYDJ5ybTuwCqO8X7PJqUk5Ih
         zZHg==
X-Gm-Message-State: AOUpUlGEBaJ4q+HzNNM3uOmfJaiAmbAqicaiDFlJiB6MCTuBtUfn39xN
        5jBlj9Rk9Javej+WvWuvu5Ju+hBT
X-Google-Smtp-Source: AAOMgpf3Jo4pVAmksQQWmfoS8dGJfwGIJ4ogHrKEA/R5T2RHzbsAD81CLQOyVhJkCjnWYdEK3Kt+VQ==
X-Received: by 2002:a37:8f41:: with SMTP id r62-v6mr3147712qkd.412.1531182191636;
        Mon, 09 Jul 2018 17:23:11 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m12-v6sm9461994qkl.54.2018.07.09.17.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 17:23:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] commit-graph: refactor preparing commit graph
To:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com>
 <9769e2a7471c2b32185896e833cc74824ac5437e.1531168854.git.jonathantanmy@google.com>
 <CAGZ79kaE_42A2B=VjRcNdJzueeVZmrsj6iNgk=6u9bi6pA4hQA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45e838b8-7741-bc6a-f0e5-d7604639a006@gmail.com>
Date:   Mon, 9 Jul 2018 20:23:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaE_42A2B=VjRcNdJzueeVZmrsj6iNgk=6u9bi6pA4hQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2018 5:41 PM, Stefan Beller wrote:
> Hi Jonathan,
> On Mon, Jul 9, 2018 at 1:44 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>> Two functions in the code (1) check if the repository is configured for
>> commit graphs, (2) call prepare_commit_graph(), and (3) check if the
>> graph exists. Move (1) and (3) into prepare_commit_graph(), reducing
>> duplication of code.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>
>
>>   static int prepare_commit_graph_run_once = 0;
>> -static void prepare_commit_graph(void)
>> +
>> +/*
>> + * Return 1 if commit_graph is non-NULL, and 0 otherwise.
>> + *
>> + * On the first invocation, this function attemps to load the commit
>> + * graph if the_repository is configured to have one.
> and as we talk about in-memory commit graph (and not some
> stale file that may still be around on the fs), we can assertly return
> 0 when core_commit_graph is false.
>
> Makes sense!
>
>> @@ -337,22 +348,17 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
>>
>>   int parse_commit_in_graph(struct commit *item)
>>   {
>> -       if (!core_commit_graph)
>> +       if (!prepare_commit_graph())
>>                  return 0;
>> -
>> -       prepare_commit_graph();
>> -       if (commit_graph)
>> -               return parse_commit_in_graph_one(commit_graph, item);
>> -       return 0;
>> +       return parse_commit_in_graph_one(commit_graph, item);
> Makes sense.
>
>>   }
>>
>>   void load_commit_graph_info(struct commit *item)
>>   {
>>          uint32_t pos;
>> -       if (!core_commit_graph)
>> +       if (!prepare_commit_graph())
>>                  return;
>> -       prepare_commit_graph();
>> -       if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
>> +       if (find_commit_in_graph(item, commit_graph, &pos))
>>                  fill_commit_graph_info(item, commit_graph, pos);
> here too,
>
> This is
> Reviewed-by: Stefan Beller <sbeller@google.com>

These changes make sense. Thanks!

