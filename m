Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7931F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeETKnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:43:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36423 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeETKnb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:43:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id n10-v6so21937115wmc.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/emUPg/uJcm/iIVQayl+SRO1RP7HIjvCMT58mwJ7D9Q=;
        b=VdUVtS+779QQxXKr0Ne9yzzodlARBXf71T63Kn5LhwShWuTreF71VNBzk31CiziOty
         sGxIkduZHEZJVw1q3dW88fquqh5MlPP/JGwjMChXo/Y0EN1MY0yvB3Wj14v/ZYbKYj+H
         3cgVt04+YGk15Qm9q2ciQiQlt2f/9cQDK0ybJuyXuO02rV3SO3f+NdwI9ViiXkHZ6IzS
         9M9bUUQ3JzZpEpdL+yXdlohDNQ++qC7F1i4FCyrUPqOfb8cwtlBGmQtyEKEu+XjgYL2X
         Paq/qujRaAs04JxIXSBYrlB4wLUlNrQDWOODAcwQ5YpQwNig9o3xmcmov583oC9r90qA
         pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/emUPg/uJcm/iIVQayl+SRO1RP7HIjvCMT58mwJ7D9Q=;
        b=A7INWwZWHzATkcpO/jAse61NiiV+/2vhJ1ZLD41BanNg1Q1SM8NkhVyF50xccUY+lr
         ZiRpIJljbReGmciFh7sk2C4Bt6BJEjcOIoRfKlWd7PI6YT7kWUk61BXBriJ3MZEK3yve
         Vw4pawUBDmL7qNfXMVO9ayPtesZx4Z6s3SoCmS+109y27+BtGhxngZIPXizwHPemejAX
         3GQ94n0VRHq4zq0n3PIlvxnhiY9otj2HnV+RA2o+YHsQtrGCLfOPcjtVojjD1XfryLHl
         3r0NGakClB3XPFYrvxgjSFQMk1s7Angjyqydnf/kOk1Gj8a695RovrE1P5CrmO+GIy6k
         KP1w==
X-Gm-Message-State: ALKqPwdaGh6vLLFUAvOaHFSiY6HiM3epTsA/2uQBJ7bg59i5ItUEzSxw
        rcwe1vAYyMiyhl+o/MgYbnmrAONa5os=
X-Google-Smtp-Source: AB8JxZq4/ptPbI8tCHWFfE25+NsevFpugdi8g+vC0hChFr/027jcOdEOFrfoDft+1+lFpQHaeEEaog==
X-Received: by 2002:a1c:470d:: with SMTP id u13-v6mr8194974wma.56.1526813010777;
        Sun, 20 May 2018 03:43:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id c21-v6sm13595974wre.81.2018.05.20.03.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:43:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/3] config: free resources of `struct config_store_data`
Date:   Sun, 20 May 2018 12:42:32 +0200
Message-Id: <cover.1526812503.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14 May 2018 at 05:03, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 13, 2018 at 5:58 AM, Martin Ågren <martin.agren@gmail.com> wrote:
>>
>> How about the following two patches as patches 2/3 and 3/3? I would also
>> need to mention in the commit message of this patch (1/3) that the
>> function will soon learn to clean up more members.
>>
>
> Yep, making this a multi-part patch series and updating the commit
> message of the patch which introduces config_store_data_clear(), as
> you suggest, makes sense. The patch series could be organized
> differently -- such as first moving freeing of 'value_regex' into new
> config_store_data_clear(), then freeing additional fields in later
> patches -- but I don't think it matters much in practice, so the
> current organization is likely good enough.

I tried such a re-ordering but wasn't entirely happy about the result
(maybe I didn't try hard enough), so here are these patches again, as a
proper series and with improved commit messages.

Martin

Martin Ågren (3):
  config: free resources of `struct config_store_data`
  config: let `config_store_data_clear()` handle `value_regex`
  config: let `config_store_data_clear()` handle `key`

 config.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.17.0.840.g5d83f92caf

