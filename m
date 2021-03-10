Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653AAC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D48A64FE5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhCJH55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 02:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhCJH5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 02:57:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B059C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 23:57:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w11so22015666wrr.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 23:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZumplTNWOApcGbN6RL1LDMtcYYLeOrl1gH2/Yr4eZFw=;
        b=jpb0aR86Vl4NqrAGptIbmL64bSTKx3ux1so3/0ivsAQFQwNS9AgDAz7JjSF3zaaV4P
         mwcIWXQIR+0tuwlNjamcysYLWO/m7YV5O/lcujirx1SScPLtvKPBO2/mPjiVdTbV99tm
         9hqxBeIf+kracHWOROhP0rMN0sNg1agTNNdaMQcfqwWzHQ55r8yvXCN/nbkC3C244oTm
         uhNP1wuB7dZY2YNMMEy94Y3CF/etj2JYQ9fnXR8zIW+CcpCvKB/apBrjMpgqHmPGkBpX
         f6u3FJayekl+3UwPlDN4Ot7GSOJ9MeUx5D3Fd4oafSvXfPj394le20rocraPd2b18857
         jx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=ZumplTNWOApcGbN6RL1LDMtcYYLeOrl1gH2/Yr4eZFw=;
        b=f1Cq1nmfg6y+9vahnrkYMyJqQKER1CPJwB57wu2BpSiQjfEe2IvFImy1UDJgUeHy4s
         l1WCxbzo93QiBBWbject01z9M8MWJtYn4oZGIn2TwMNj58mVVD6j4fDVDB6s3F4WXhXQ
         7g3dKg+zIVTF2Z+G0TpyWs2Wemd7ksiz1wv3ieQo0bg/9WgJyyov7cFK7wacLOuDRGgI
         eMZlgkr6aAVAhp6Q3Nza2Us3GC40qEojMq8y87OKu4Ln5lAzsQOnkpWgn+EvRK+4KVhj
         60bRh6ZKYlO8mK6wo4vrQNJgY23rQllXDbkr8H8C69HesJa88p1PfcGCEUFHHs38Mtks
         1s5g==
X-Gm-Message-State: AOAM5307fB3X5eO3UdmL0xEnOIEAO/lujRlDckFN/r8IksP7yc/Mr4oY
        lwcNmvR19jxScXyZs9jWVRg=
X-Google-Smtp-Source: ABdhPJzqNAJ9oTttzQmLqrAd7gxc7lvOqEnXIkfVRuN29118eYwF3ruRJYlyRF+E9SfRFIElmoiYqA==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr2080333wrg.167.1615363064386;
        Tue, 09 Mar 2021 23:57:44 -0800 (PST)
Received: from [192.168.178.32] (pd9e1c3b3.dip0.t-ipconnect.de. [217.225.195.179])
        by smtp.gmail.com with ESMTPSA id g5sm12997268wrq.30.2021.03.09.23.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:57:44 -0800 (PST)
To:     git@vger.kernel.org
From:   Ephrim Khong <dr.khong@gmail.com>
Subject: [RFC PATCH] merge-recursive: create new files with O_EXCL
Openpgp: preference=signencrypt
Autocrypt: addr=dr.khong@gmail.com; keydata=
 mQENBF2KH3QBCACy66z3LoDOvFnn3Jl07bZvGy8IWXoClBLBEVQEDMgX6/2VskvAiDFYXjYY
 CBnpMZS7pkHyMj2nAuk8rfz8ofhTMxW1YthQGAGJt0eYMp9dymKG4O9c6Lzwlb54lwWet1AE
 x326ePst0QaBkvksN8HmoqNrTZVth2U+IiAI5y7RJB65ZsXmHoXBt4pfPEoQ01WFTXBrQ2ZR
 LHcweZQdU1uhwPjCB6JV9pNTclzFfQyqqga/JbbDbbplhL5XhA15VJq+3CJSM3Y0M1UGEOUv
 5dcWC15x65jlX4yDIrXUYkWq48byHlC8B75n9EnMAvmkFZ09ntSjwsRJmLILxr8cz9jtABEB
 AAG0J0JlcnRyYW0gRHJvc3QgPGJlcnRyYW0uZHJvc3RAbXZ0ZWMuY29tPokBVAQTAQgAPhYh
 BLWZoXdIkApCXec/7OxiOFtXzt5/BQJgAaaWAhsDBQkDw4IsBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEOxiOFtXzt5/k0MH/3G9nXfyfOiTQlANSQwQrXfpsvX+OJHCjLIpWgIUzMlN
 1LNacOn3fKxUWhiy/eXzNUAumL8lqRuLcjz6BcEhSIp7aWOYNqiQ0zSl7Qo3QxcL4k1tuAXz
 aOo1l9Kk9SzviPN7SGjCK4jrMKlEjBoA3G8OtxaJfk9XQRbkYVJFiIaTHh5puz2aoFgTCtB6
 qWpBfd59rmmYo16VbgK7qx0HaVijFQK6YyUFwnYVzCpGj4xCtrWs0awexbgzRmBUn3hEtD8P
 oMLbf/SaPqYhbH/iRUT8YAteWNi4teD9PQX436FOWXzFTR0DnURlNB9CfDj4YjGm9jeZ31i7
 8KdCEL+7/P25AQ0EXYofdAEIANMR2v+vHOPGHZUG/KrziIdliwF+VIUh58z92nIlvdrb+B2K
 QCVseYwkYvqMJkLaad5DbA2POwU1AofvXhGiNiNhiC02mwO+gHnX6Bz0SubfytdZd70SBcrD
 YNHsqJKHYPRS/AwWA5xRPTt7elsGrMkx7QU3QBeJhYPjEfjOjSAFNuPbSKKBw1oG8cZFihse
 D44MeDUJeODVWI7wl5VfIzW7cQ1HfmhPMC4I7cdz0D19RmTsvwDY5Er8uCiuKD/otnH/GeHp
 PYNSXxcAOjyuCbZOi/ps1BQp1UXJudIxS6w1Z9weJ3dgndd4ZmwcSPq+VHT2xcypM77Iff/g
 nvWK7zcAEQEAAYkBPAQYAQgAJhYhBLWZoXdIkApCXec/7OxiOFtXzt5/BQJdih90AhsMBQkD
 w4IsAAoJEOxiOFtXzt5/f58H/2tYnryojtNWwuVE1iJwBol1FJ+wg+NgqxQ+lgYu/JfoxNJY
 fDAPv5bNsfIoC7D6zJwZ+d6XFjb5tQITXT5fFJYgTaVKE9p+acsgXPoERLqF2NNK5hVHPz5K
 fENTojGN9aLElsyPDmFrnYZYqrvm1Ex4qcQ4mkIWI20CLfK84+Wi/6o/dE/uYu1chKNbfkZh
 B8krQZMfy1FAkrPbaIvuG6HgFd7gTWNmg2O4g7RRM/n+SgBFocnHY4bBc7WNgS+9h5imFeQk
 2Xy+Vjg5pJ+Q5b+6ULbGNUonKFhT9++RFH/FA2A4rYKoyEW3MbZKQAgqOVLDknad5HOaDFA7
 Mt212FU=
Message-ID: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
Date:   Wed, 10 Mar 2021 08:57:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When re-writing the content of a file during a merge, the file
is first unlinked and then re-created. Since it is a new file
at the time of the open call, O_EXCL should be passed to clarify
that the file is expected to be new.

Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
---
This is actually a fix for an issue we ran into on an nfs4
mount. Files created with O_TRUNC instead of O_EXCL sometimes
had their permissions wrong. However, it appears to be a safe
thing to change this, especially since other parts of the
git codebase also prefer the O_EXCL flag.

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f736a0f632..f72a376c5b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -974,7 +974,7 @@ static int update_file_flags(struct merge_options *opt,
 			int fd;
 			int mode = (contents->mode & 0100 ? 0777 : 0666);

-			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			fd = open(path, O_WRONLY | O_EXCL | O_CREAT, mode);
 			if (fd < 0) {
 				ret = err(opt, _("failed to open '%s': %s"),
 					  path, strerror(errno));
-- 
2.30.1.1.g07d5ea6f42.dirty

