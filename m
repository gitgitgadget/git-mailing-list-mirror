Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA565C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9EC20895
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBLZHHO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfKTQo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:44:56 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:37708 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfKTQoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 11:44:55 -0500
Received: by mail-pf1-f174.google.com with SMTP id p24so4635pfn.4
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pKAZ5Lu0dntLZolu5ynsFSXDUoUKVQ6Hx2ddaf1Gtrc=;
        b=rBLZHHO6tOKaLe74Fgl7aYs+cEViqw/eCHmQAQ8rv/l1mEiaMA6ObDCighocFpr1gM
         txKI/oTEgnG6T2WZdhTspREfSsVGWGB++5O5148hDganExBjiepkbD85OFsRfU4cI0NG
         +xtqJwPMg8yWVhvXA1cmXRFol7/17EE/mfA21QVrfrg74mW1FdFE/sbdopRAwtq7dJGG
         WM+ngrRpUhYEisVq9/D0CGURxO0bmjssQQR7A759WYE4fzbC3OxxdTj+eug26bSQdmWJ
         FMq2110LG4VIZFdusjlSG+OrpKUqyez6hvhkE4hHFnf4OkwMZI8uMKWzB426MfEuulbq
         /Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pKAZ5Lu0dntLZolu5ynsFSXDUoUKVQ6Hx2ddaf1Gtrc=;
        b=f0fNgI26Qh4akvDxZwqpv67vYov7RiezSqI2y1W/b5fyDe6gfiLozBkrBBo5Sn9CeN
         4MJiX+1OicswcWXknzMlvzFoyHjvjS/VR+PcNqWbceM8o2Bk4qYbXZUktKk37guZyTE0
         YkVHMEdNB/CmPIn5AGJgkMA8O8AD45ZihDU9VqFW/YzR5kAy8fPgH8DZBNrKqH67lXLy
         sQDx8X6360e9hwfzCJcv8WVhSRoEyez2t+Bi226zo9/TA7dA1VZ2jWyciVIldcCqNGMC
         rAfH/EVdjV3bnw9Qu8dSrXbyEKh7/SB8VYOoXOGh9sjhR8hb1qD4vc5ewiCHuMrQ+9OM
         Dqjw==
X-Gm-Message-State: APjAAAUah8H5vAvYGHhQSm+/jTc+3a6ayy7TPjLRW6xkpv/f5t4VkgBv
        7Sr3Y1YosgsTWG82U+GsKsqTLy9O
X-Google-Smtp-Source: APXvYqyxWxLG2yMWQq20r/pohU+0z1xMWBwIHleCyfnNAgXK8ArTXoT9d9c2sB9KDXrSNCyM7HbGzQ==
X-Received: by 2002:a63:4915:: with SMTP id w21mr4320224pga.313.1574268294691;
        Wed, 20 Nov 2019 08:44:54 -0800 (PST)
Received: from [128.18.14.225] ([128.18.14.225])
        by smtp.gmail.com with ESMTPSA id b17sm30594708pfr.17.2019.11.20.08.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:44:53 -0800 (PST)
To:     git@vger.kernel.org, picevio <picevio@gmail.com>
From:   M Lewis <picevio@gmail.com>
Subject: GitAttributes feature export-ignore works, but -export-ignore (with
 dash) should also work
Message-ID: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
Date:   Wed, 20 Nov 2019 08:44:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git archive', the .gitattributes file is used to determine 
paths that should be ignored when building the archive by using 
'export-ignore'.
But it would be useful to include certain sub-paths in the ignored path.

For example, say I have folders like these
     /all_useful                  # this entire sub directory is needed 
in the archive
     /mostly_unuseful             # there are many sub directories in 
here to ignore
/mostly_unuseful/needed_a    # but these specific sub directories are 
desired in the archive
/mostly_unuseful/needed_b

The git-attribute document says a dash '-' prefix should unset the 
attribute. It should work with 'export-ignore'

So if I want for example '/mostly_unuseful/needed_a' in my archive, I 
should be able to specify that
in my .gitattributes file like this:


     /mostly_unuseful                  export-ignore # do not archive
/mostly_unuseful/needed_a -export-ignore # do add to archive
/mostly_unuseful/needed_b    -export-ignore # do add to archive

Thank you

