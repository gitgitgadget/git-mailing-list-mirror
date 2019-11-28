Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE64C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FD12176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rarus.ru header.i=@rarus.ru header.b="YQPqntdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfK1HLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:11:50 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39920 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfK1HLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 02:11:49 -0500
Received: by mail-lj1-f182.google.com with SMTP id e10so18099956ljj.6
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 23:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=bphuXgl/uoLj3nr6gXolzWBvq3RQJIBE/Oxj4bN8efk=;
        b=YQPqntdWbrO3A3VA02KOr80mBXZndtAELXOe4IHVNTG9KvpUEfTdIfwrzP4Rt7FzSo
         /P9W1z7hwU2UhvRnPoopCre5qQvw03ZQDRG6Int70ayYm+Pg56ij6k6eA9sZJf6BJw+Q
         oenF8rG2o8laRZg8Xzv8m/aXzzrKHHJeuaFYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=bphuXgl/uoLj3nr6gXolzWBvq3RQJIBE/Oxj4bN8efk=;
        b=IVKZ93KpyNe+HyVa3YQpvgC43qoKl59IVUPNJWyVzrdZKrQMEkqR8jxXGwK2g3F0xR
         8DQys8AqiGWMZV50qeFqzVNmIytpRucTBojj3MS6yIJF4bNyptDtTfyo8zCSaZxJwegH
         1OGdOpC+hlw82fLeA1/l/XO2+IZBaGwrhzg7FhlN4nyWVUWI+cLb6cbDxVT4E7ISfdnS
         DPsI2HyHeEdzZyPGA/eLAdY2QCL4kUvk1ouKrObrWVWmVt1YWS9KV+vLNp+L2BApi8ws
         8+KGislurOloBK4VI099bzprNhi/pcdT2E5b+C9WSq3iRzEIGl+Xa+nDUazdwF7vSZ+a
         oJug==
X-Gm-Message-State: APjAAAXtVi7KvbRcqJFTxWG4H+SZP65Lgr3AlJ+moasKlFLyjMIvesWr
        SB0IiBZUubsCHCDHOjCkRT2OTQtN7GU=
X-Google-Smtp-Source: APXvYqwvqHEtNNOQMxHP1LtCO5RTes4Fn6Cu65szZ8f6A+EWrN/663pY0EtZSKd/ZPIyReiWdmsdtA==
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr30049728ljq.180.1574925107355;
        Wed, 27 Nov 2019 23:11:47 -0800 (PST)
Received: from [192.168.63.115] ([80.252.24.240])
        by smtp.gmail.com with ESMTPSA id y6sm8111155ljm.95.2019.11.27.23.11.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 23:11:46 -0800 (PST)
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JDQs9C40LHQsNC70L7QsiDQodC10YDQs9C10Lkg0JDQu9C10LrRgdCw0L0=?=
         =?UTF-8?B?0LTRgNC+0LLQuNGH?= <agibse@rarus.ru>
Subject: Bug whith reporting of git push
Message-ID: <c95b4a3d-d290-2e14-73c9-563746655a4d@rarus.ru>
Date:   Thu, 28 Nov 2019 11:11:45 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------BBED3C49007D17DA5C643930"
Content-Language: ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------BBED3C49007D17DA5C643930
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

After git push log is sent into a error list, but there is no error. 
Whith git pull is all correct. See files.

Yours faithfully, Sergey Agibalov.

-- 
С уважением, Агибалов Сергей.
Руководитель группы разработки ООО «ВЦ 1С-Рарус Самара»
Телефон: 202 27 70, доб. 1311
Skype agibalovsa


--------------BBED3C49007D17DA5C643930
Content-Type: application/octet-stream;
 name="GitLog_zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="GitLog_zip"

UEsDBBQAAAAAAGdZfE8AAAAAAAAAAAAAAAALAAAAjuiooaqoIKOo4i9QSwMEFAAAAAgAGFh8
T6LG3KR4AAAArQAAABcAAACO6Kihqqggo6jiL2dpdCBwdWxsX2JhdJXLsQrCMBAA0D2Qfzj6
AWJLB+0QiG0tglOTbgch1CDFSI7mFD9fcHTr21/bSDHfoG1wymHNqIfLyfTYhfzgRDjqcTI4
LOzWQAltb6wU94WBXjFCqRQU/1UTdZ49XtPsI9rwJHwf3PlY167a7/jDBVRKbWrlr0nxBVBL
AwQUAAAACAB2WHxPmJP0rH4AAAC0AAAAFwAAAI7oqKGqqCCjqOIvZ2l0IHB1c2hfYmF0lcxL
CsIwEADQfSF3GHoAwdKF7SIQ21oEV026Gwihhhr8ZEhG8fiCS3ce4L2uFcVyhq7FOfuUUY3H
vR6w9/nKkXBS06xxDGyTp4hm0EYUa2CgZ75ATGEND9hKCeXvoIh6xw5PcXE3NP5O+NrZQ1PX
tmo2/OYSKin/Yu7LRPEBUEsDBAoAAAAAAD1YfE+/ht8nFAAAABQAAAAZAAAAjuiooaqoIKOo
4i92OF9GOTQ0XzIwLnR4dEFscmVhZHkgdXAgdG8gZGF0ZS4KUEsDBAoAAAAAAFZYfE8AAAAA
AAAAAAAAAAAZAAAAjuiooaqoIKOo4i92OF9GOTQ0XzIxLnR4dFBLAwQKAAAAAACaWHxPAAAA
AAAAAAAAAAAAGQAAAI7oqKGqqCCjqOIvdjhfRjk0NF8yOS50eHRQSwMECgAAAAAArVh8T+M5
DysWAAAAFgAAABkAAACO6Kihqqggo6jiL3Y4X0Y5NDRfMmEudHh0RXZlcnl0aGluZyB1cC10
by1kYXRlClBLAQI/ABQAAAAAAGdZfE8AAAAAAAAAAAAAAAALACQAAAAAAAAAEAAAAAAAAACO
6Kihqqggo6jiLwoAIAAAAAAAAQAYADlO7gO7pdUBOU7uA7ul1QFZr96JuaXVAVBLAQI/ABQA
AAAIABhYfE+ixtykeAAAAK0AAAAXACQAAAAAAAAAIAAAACkAAACO6Kihqqggo6jiL2dpdCBw
dWxsX2JhdAoAIAAAAAAAAQAYABGfCI+5pdUBEZ8Ij7ml1QGYsACPuaXVAVBLAQI/ABQAAAAI
AHZYfE+Yk/SsfgAAALQAAAAXACQAAAAAAAAAIAAAANYAAACO6Kihqqggo6jiL2dpdCBwdXNo
X2JhdAoAIAAAAAAAAQAYAJzCyPi5pdUBnMLI+Lml1QHAc8H4uaXVAVBLAQI/AAoAAAAAAD1Y
fE+/ht8nFAAAABQAAAAZACQAAAAAAAAAIAAAAIkBAACO6Kihqqggo6jiL3Y4X0Y5NDRfMjAu
dHh0CgAgAAAAAAABABgArmWCuLml1QGuZYK4uaXVAWpderi5pdUBUEsBAj8ACgAAAAAAVlh8
TwAAAAAAAAAAAAAAABkAJAAAAAAAAAAgAAAA1AEAAI7oqKGqqCCjqOIvdjhfRjk0NF8yMS50
eHQKACAAAAAAAAEAGABR35jUuaXVAVHfmNS5pdUBNDuQ1Lml1QFQSwECPwAKAAAAAACaWHxP
AAAAAAAAAAAAAAAAGQAkAAAAAAAAACAAAAALAgAAjuiooaqoIKOo4i92OF9GOTQ0XzI5LnR4
dAoAIAAAAAAAAQAYAFVAKCG6pdUBVUAoIbql1QElBCAhuqXVAVBLAQI/AAoAAAAAAK1YfE/j
OQ8rFgAAABYAAAAZACQAAAAAAAAAIAAAAEICAACO6Kihqqggo6jiL3Y4X0Y5NDRfMmEudHh0
CgAgAAAAAAABABgAGemINLql1QEZ6Yg0uqXVAUacfzS6pdUBUEsFBgAAAAAHAAcA2wIAAI8C
AAAAAA==
--------------BBED3C49007D17DA5C643930--
