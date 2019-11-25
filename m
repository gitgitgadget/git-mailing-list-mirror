Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A48C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D220659
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 20:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFTaX0M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYUSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:18:10 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38674 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYUSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 15:18:09 -0500
Received: by mail-wm1-f41.google.com with SMTP id z19so737864wmk.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:cc:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0i0h+bHFQ3nEBrJpA1neiG1dQuaj/sJqEcC7tm41T0k=;
        b=iFTaX0M+Uq6CHi1AbSP5lxZpa7bJhSu16wz31fl8/rSlkRfy/NqFureshtOFJHy+Rm
         OWIoeBh00ecv8ErRRPRfT8jp0aRckqkfhqqQOvSMgSMhd70PIqBbt8WwGs/bBgb4dFLd
         hxVmrwYMMh4AzfXhdN5UeXls3XI126zMIapAFuvjiScVlAQtoHrwGXZVlAu290UEroh+
         b8gHTgILptNTfsaScnFHwRjG7d09UnIs68/z32lmrdN9LZ++/7FuVi1C8xHkLAlQyDbI
         acNC7CtPFuu7Uqq94GTHke9BkY5A+hh3MXgFeNsY55qKTdFy0vK/54Sd3MtPD/YBurDI
         wzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:cc:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0i0h+bHFQ3nEBrJpA1neiG1dQuaj/sJqEcC7tm41T0k=;
        b=un3xMmX5E6dU2IH33NyXJE2AU+eIOJQjpLuomGeLa7aKlMHlGa58rzkffQ1lkea0ba
         Lj00RAhTpIsb4Bn0QlAyMx6puML8rrYQlAxwGP6jTm66irwwmAc+Hw33dO16WwzpAc14
         hPw4f/WWDvftiiXzYejqhvNNOr2JQHaVzfB+7T3BWTQfQFlLs8c3UZTGFF4k9xiw7YWJ
         UX7+rjVK1MLsmEp6dXud4yJTAvmz/tNLFx5/3L0b1pHc7bD0vMrJ64wjxpeO0bm+cUzw
         C0QY0Ge6fyxJc8RRQGiWxWV99cfZwzHyiFWQdTcZ1q6DOB/8q9dBsPetJ+OqRAQ7bqdM
         ZjLw==
X-Gm-Message-State: APjAAAXPnuDuhCzJqtYEoIun6jFXwqcjumr0+waHN3/HwaxmiXESPHz1
        0vXMyqYIFKMS8KNHL36sB3/J73m7
X-Google-Smtp-Source: APXvYqx/LI9CTHh7kZOGyKfkqE8tLSgoqhAohuYTYaJ8yB5/a+1QSdcpiBY+7DMIol1GDkiDNFYuIg==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr594177wmj.152.1574713087224;
        Mon, 25 Nov 2019 12:18:07 -0800 (PST)
Received: from [192.168.168.4] (aftr-62-216-209-232.dynamic.mnet-online.de. [62.216.209.232])
        by smtp.gmail.com with ESMTPSA id c12sm11678044wro.96.2019.11.25.12.18.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:18:06 -0800 (PST)
Subject: Fwd: [BUG] "git checkout BRANCH -- FILE" deletes staged commits
References: <aaa2b05a-4c0c-8194-6488-f1b770f3b852@gmail.com>
Cc:     git@vger.kernel.org
From:   Tasnad Kernetzky <tasnadk@gmail.com>
Autocrypt: addr=tasnadk@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFblpqIBCAC4TkkXJbIXuaGVk8HmobciF+UUKyOigeJyVq9W+TXTFdT5dDb9B7G9o3M3
 azuRLhZsWF0sB+XtIW+SuG6jRbiymFet+NYZ8M8zDU38CKg8tLRWbOhqIxEhDebVvJTL4yZ5
 FqkeNP9gx01h0yTycATO19lC/NixQkS2MgaDVUEE5VS9XYBu68sHgJrQsSm758By4WckcimY
 seyuw+a/+zElFdfFxhkmzE7YzP0io/qk6cLPiEdQqwbgyBu3zuU6O5ZLqbl4h5mhciyexwQc
 O2jNk2ISCTXtNu65AFsAru96hxG0wVmCJ5U4BNUUTQwA7H/v3okI9Xg2a/oHD/2d647fABEB
 AAG0JFRhc25hZCBLZXJuZXR6a3kgPHRhc25hZGtAZ21haWwuY29tPokBNwQTAQgAIQIbAwUL
 CQgHAgYVCAkKCwIEFgIDAQIeAQIXgAUCVuWqKAAKCRANFbbGxqZtJkdhB/4l39UFmfZ1M9bW
 hNcm4/mIT+4psqTezkzvxUUmdTsnSBiF4fDzDsfB/4OhEEMJQ01Rufcg4LIsemd+i80viTtp
 NoLFI9kBc5GSlaCSdx/m99w/0gYhsWXx8jYBGyrLrxD66ZrZ7OBSjLTP5zVjASsEqG0pqGZr
 VO1jdJGxLJDSUdh9pwrWKGJ1R9yn5XVSSA9K7Gjp6v0J6g2lnO8j4BBFLIjjQWekhMlrgdp1
 mbZqoDYpTS/mLDKkcj+8xjKLm9jBrDwa/zZ/6rUDztyXnPY7WsXc1RsSQXpmGk6Wk+QP0jMH
 dAFHLfvoX/ulLHOVZps8Jbd01v/PdEgemWj4pjLVuQENBFblpqIBCADO5fKPowDcuYcAcF6f
 bmeUWE3MmywB7BasGk9JDCll9U9FcVskRwHwEauFUpHP07fyj7A55SF1wWbDIzvM5WHRUoci
 +HuWvXbldAdI0/NYv6dKZVaPnnRJUfkzZ4+P/t/BL45RrFY+b5Vf8S/H42FHahDbm20hbJYa
 3qCyxkRr1Uxw4EzOKUqGb/z2E8NPapdwj68vemJSVaEE71OBBu56soQz8sQ1ru/XkKcp9SOg
 oOlAtQlE+G+aNplirIG3QPGd8LJQlwreKx00dAF903f7dJ2/Xr5VeR/we7aVdryG58DX/A4+
 nYS+RDPerWIPZGu1Hm/h6Y0lsXT1F20yy6yZABEBAAGJAR8EGAEIAAkCGwwFAlblrYIACgkQ
 DRW2xsambSalVwf/XweibiJpqvuKyGJO9w8T5PW8WjDYe6dE2QJiMmVrurJJ2ndHDGF3g7c0
 /89Ba/tyfWMvHzTEuPvFvs7Jg/862ATsyRemCb9VXRgsQHlEANTUhre3Cb3WAnRIT1cKZiHm
 Zk3dPxl25WQfA8tlvodo1s3mehnUQavtwp7ijWnV5pml7ADJcNZ5YFK+3bIJBckulDk0lv1P
 /s8Ak6jlaAZewUaFupp9tpLNTbhVOAXc+YM9pMXh5v6jlm1Xrlrauew2dpLNow8qj5Q/vtvp
 Ktdi0mD5VctHHrliQ2Hc3KSogP6uagbTSvsVa/4UWTcuS98oP00pOJzKxsOhPkQZJIpd5g==
X-Forwarded-Message-Id: <aaa2b05a-4c0c-8194-6488-f1b770f3b852@gmail.com>
Message-ID: <b1898690-667b-f413-7ac1-08ef733e7fa5@gmail.com>
Date:   Mon, 25 Nov 2019 21:18:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aaa2b05a-4c0c-8194-6488-f1b770f3b852@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

Thanks for your deep inspection!

I know that the checkout command I was using was supposed to overwrite
the file, but I didn't know that it automatically stages changes. So I
agree, that step makes sense and I should have rtfm.

My only suggestion for the docs would be to add "staging" or so to the
sentence "When a |<tree-ish>| is given, the paths that match the
|<pathspec>| are updated both in the index and in the working tree.".
However, I think it's also clear enough as-is, so I don't see much room
for improvement there.

Please find my last comment in-line.


Best,

Tasnad


On 22.11.19 04:14, Brandon McCaig wrote:
[...]
> When you switch back to branch B the state of the tst file is the
> same as it exists in the branch B. There is no conflict here so
> it succeeds, and once it does you no longer have any changes made
> to tst because the version in your index and working tree matches
> the version in the HEAD commit.
>
> git status at this point would report nothing (assuming no other
> files are modified).

This is the point I actually considered as a bug. There are staged
changes and usually git doesn't let me switch away from a branch in such
cases.

Although I don't lose data, I do lose the newest state of the master
branch, if I'm not cautious and remember that I copied over changed from
"B".

I would prefere at least a warning :) 

