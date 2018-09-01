Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EFC1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeIBBzV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 21:55:21 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46968 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeIBBzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 21:55:21 -0400
Received: by mail-wr1-f43.google.com with SMTP id a108-v6so14227134wrc.13
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XbaRiYcTU26K9IORMczUZSnDZ61TZX6YvqqLl9tPUW0=;
        b=ppC+tiEM1OEb/odj7l0kpYuqoDgT+VY2XFONLjWObAqjs3+z4zzNi6Yxoy6O7hyf3Y
         bcoEg1IaLWInl43EA8VCkceGyA+csGELwDCWGouBczuLEf8Xtsen/HvfR1Z6IPRClPMd
         iSE60BoFAI95rUFprQ9JPOykuWg1jyaFXfRbY90pPE1HaYZF11ehD/n9AsBD3HcdKggP
         dO2W8s3aDW1y7K3vpNUaPLOGWZREecs2rVhkOHWTTgJC39IP0hKSr6vjDdryX8kryYpn
         Zr7liZxgswfHQPmMgniOKjb1WLKomLiWXmXqOZUbXIp7Er7nUwWcFjEOpP0KSCQa2mWr
         eXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XbaRiYcTU26K9IORMczUZSnDZ61TZX6YvqqLl9tPUW0=;
        b=L5iD6chbIvoEjpLuSF+F9wBvAn37iPfh5anbsWUXoHSO/pF2K6VMWywYiyYfEPp7BV
         xzN2Lh+SOPYerZaVizMVLUo4QcBvtJ0r6kGVed5f1SZNpmR2gMemb1VeqNA7leYgGtJg
         ihUmjVcc4lkeHhoFGVDdASeKedsOO8fhDl8PElNcgE2wbkICG1a1pQ1SkYEEY6pCpsqs
         RzLkltB6bE76B7ViHelmYfnGM10gH0cMV8J1vAzSsoe6H6t9pO+34rrTJV9RIple9EOH
         7i0+cQZLwr5oGgKVrcxfCV53vRPMQlxYHXMtIRxVlXaDbs10SZOgQM47koV2Q6uUNbjg
         18pg==
X-Gm-Message-State: APzg51BylBeMEIQwSusxWtK2RLMjANpFjLYtKLzuw4cBgTd5vIaLQ/vV
        /bazUPpX/4a0UZWUFYHZzNfbl9C8
X-Google-Smtp-Source: ANB0VdajRYI7e4XuWdKu8YUgxIPdvLh5zLp+V3IYXBBAe/UBUKyVEyNCySwq7ibYvOYE7+I3f6C+tQ==
X-Received: by 2002:a5d:4d82:: with SMTP id b2-v6mr14187561wru.80.1535838120337;
        Sat, 01 Sep 2018 14:42:00 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:54a3:bd15:9fe9:2a1])
        by smtp.gmail.com with ESMTPSA id r13-v6sm6418767wmf.35.2018.09.01.14.41.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 14:41:59 -0700 (PDT)
Date:   Sat, 1 Sep 2018 23:41:58 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] index corruption with git commit -p
Message-ID: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've just had a scary error:
	error: index uses $?+? extension, which we do not understand
	fatal: index file corrupt

Things were quickly recovered by deleting the index but it clearly
looks to a but to me.

Here are the steps to reproduce it:
  $ git clone git://github.com/lucvoo/sparse-dev.git <somedir>
  $ cd <somedir>
  $ git co index-corruption
  $ git rm -r validation/ Documentation/
  $ git commit -m <some message> -p
  $ git status
error: index uses $?+? extension, which we do not understand
fatal: index file corrupt


The 'extension' pattern '$?+?', can vary a bit, sometimes
it's just '????', but always seems 4 chars.
If the commit command doesn't use the '-p' flag, there is no
problem. The repository itself is not corrupted, it's only
the index. It happends with git 2.18.0 and 2.17.0


-- Luc Van Oostenryck
