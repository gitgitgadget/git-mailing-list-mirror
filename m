Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9281F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGEOUB (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 10:20:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40121 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEOUA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 10:20:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so7207700qtj.7
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PRiIiU1MADBAO93uj6W6UuxlzpgvLxFDK8O7t/TqUq8=;
        b=Znit2MqDsKTxKhplygC1A+XjuuagEbFvT5bGpdIzV5oIe+YVo85E9/CFgX8Rsvx4Ax
         MNF2d4tSv8aKcY/vgI+i626lh52FJOqG3b4NeEIEG5T0H5ysuek0QiU0q9LIx5qOOwy3
         KTRRVXmzOQmcndY/G2jRVPXYgxVcFCFU6HhWBEwWzjHmolvdnSytdSskznWQP8BxMJG5
         4ILrzdKXpA6fEOo7qk39l/N5urV6iZ73202bGK5f5Tr9dBbjGT9j6FSKrRwGNMo8qhoT
         m29rAjoB7GBAOeXVFHHMMjHtWxu5J4hEtD/++7K2VGD+7dAaFCa1cQFJEf2VXOzP0Knn
         /IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PRiIiU1MADBAO93uj6W6UuxlzpgvLxFDK8O7t/TqUq8=;
        b=M8dYqyPzxz4OgMn6wa51fgCnlm+BTy4Dhdh0+i0MnbFbPJn9+3ZiXT+tzKSfF45YLo
         BnIAwwSwyr5rzUl2qr7fTi7ff4eI151JI4bv62I63GfZeRyzY9CJ30EQNQDiTmz/wX6F
         ngesWfPQrNhWMtjgUJyTiN//y5D36Z2WilcYVyifG3RIpp5D1KQJr9InQwmfaVAB8hMj
         i3MLN29vhYqnGS7f9/nVTWcM4Oy0pWlPYb4xj+Es2N+2xw9Uc46hTUhSUSZUumgV3QKa
         iHtr3HYrT/dElYwOBmShbJbH5eWZ6yE95qJHRhgUEEmEfWGcsxjvKcJcBTbL7DU0s7FQ
         sq5w==
X-Gm-Message-State: APt69E1FC4feHc0GIcsWGDAakkxNxQRF1xCZMAO0Gt30oP1Sy5WZHU8l
        JtcAd5yZQQaIhJ+JaLGVFsM=
X-Google-Smtp-Source: AAOMgpeH0EUH4LgAhKKaY1k7Kw1QKpVCIGzag4Fy8ifwvdKkv+irg9RbX3Ezrpl3RrR9kpA37gQkEg==
X-Received: by 2002:ac8:b45:: with SMTP id m5-v6mr5570265qti.335.1530800400029;
        Thu, 05 Jul 2018 07:20:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6515:4fd3:d5dd:f9bf? ([2001:4898:8010:0:4e4b:4fd3:d5dd:f9bf])
        by smtp.gmail.com with ESMTPSA id l7-v6sm4368959qtc.27.2018.07.05.07.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:19:59 -0700 (PDT)
Subject: Re: [PATCH v2 06/24] multi-pack-index: load into memory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
 <20180625143434.89044-7-dstolee@microsoft.com>
 <xmqqfu1aodw3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2bb2a12f-f22d-990b-636c-73b2b805d12d@gmail.com>
Date:   Thu, 5 Jul 2018 10:19:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu1aodw3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2018 3:38 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> +	cat >expect <<- EOF
> "<<-\EOF", i.e. make it easy for readers to spot that there is no
> funny substitutions happening in the here-doc body.

While I don't use substitutions in this patch, I do use them in later 
patches. Here is the final version of this method:

midx_read_expect () {
         NUM_PACKS=$1
         NUM_OBJECTS=$2
         NUM_CHUNKS=$3
         OBJECT_DIR=$4
         EXTRA_CHUNKS="$5"
         cat >expect <<-\EOF
         header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
         chunks: pack_names oid_fanout oid_lookup 
object_offsets$EXTRA_CHUNKS
         num_objects: $NUM_OBJECTS
         packs:
         EOF
         if [ $NUM_PACKS -ge 1 ]
         then
                 ls $OBJECT_DIR/pack/ | grep idx | sort >> expect
         fi
         printf "object_dir: $OBJECT_DIR\n" >>expect &&
         test-tool read-midx $OBJECT_DIR >actual &&
         test_cmp expect actual
}

Using <<-\EOF causes these substitutions to fail. Is there a different 
way I should construct this method?

Thanks,
-Stolee
