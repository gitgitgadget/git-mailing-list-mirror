Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B681F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeBLIIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:08:46 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34593 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbeBLIIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 03:08:43 -0500
Received: by mail-wr0-f174.google.com with SMTP id m5so2130496wrg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 00:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QGzpClwNG9XszcRytkVEADSEjZ5wj5k8ssPlCcGplSQ=;
        b=PGIStpj6fUlrsTXUt1lBbL1UbqYL7toFR1XWjjhttk1vveJ0eoq669c7m0YaJ4K9NO
         YXYrx2ZsQSdenmUWu/chbErHQteiAKGy2h2bCaEByz587/Adtz9+QVWZBp6bwdRN693C
         rq3LIWMyAkPT4vCodroeF0LWdksURQxikuh2wrpRVOlRxdC3ZKQDJ/8lCS/pvE1lu0hw
         gl94M4sVUTfv9pPDO05BB9S8CvLcesCHJcWIi6kE9zt4anhTOCUeG3gVuP0Y+kOZnCsP
         P4UyzarOSCw7W5F/95IEXzr5HTpSoXfjtiI14D7JMV9+OlL6OPqh/M/6jfG6c8Qzx+10
         +jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QGzpClwNG9XszcRytkVEADSEjZ5wj5k8ssPlCcGplSQ=;
        b=c6M4xqjIALvHl3M4Cjz+PKO13YlGCJyupsh60Q1N+5B6N64h2JjFHba+7FLmnTeqqN
         n4B4C5fJFYW9UdCnY9DcWPUcmW8qF95n2Z+HCXfJ8WoiVty9Z0Pkoxb2R0u5y34g2dTZ
         uch1g+6YLcvJ5CcJUAZCGAk+hGa1HWh58+GnClu9tiHHIy4Kqz474srHl0XS54lKYYVi
         DrHZruoAdmHREtQEVgqzi62emaHCC8EZiIiyMRvu0sSwLacO0lsdxTANkf2+0NXl+pwP
         07fvYQKRpobNIngi4aUx3mRsVwCVu2h3x1415/yPEtbvrQAg+Lyeirenz6g5MzXuzME/
         4aEw==
X-Gm-Message-State: APf1xPD6VCOn6CT+vTMXCi9FoogKhtOD/G/x4Rw/0Oa9L1cyb++k8L+P
        x05iVsPOE6xkaDCguoRF4SYjDrHYDEPRU+VfOS/JYA==
X-Google-Smtp-Source: AH8x227SbNvQ1IEMsR4rj1IAqA4EbRRdYuPFdJpWBhtw53piu8d5vj8/YjCaFdUVhx6wSCsVXIVuXewQASSpQz187s4=
X-Received: by 10.223.176.201 with SMTP id j9mr2628489wra.210.1518422921771;
 Mon, 12 Feb 2018 00:08:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Mon, 12 Feb 2018 00:08:41 -0800 (PST)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 12 Feb 2018 11:08:41 +0300
Message-ID: <CAL21Bm=M73qePzz0Kz1sZRJa8rK+Ddac3ARf4Lu6HRr-NGSKPg@mail.gmail.com>
Subject: [PATCH v3 0/23] cat-file: reuse formatting logic from ref-filter
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main idea of the patch is to get rid of using custom formatting in
cat-file and start using general one from ref-filter.
Additional bonus is that cat-file becomes to support many new
formatting commands like %(if), %(color), %(committername) etc.

Updates since last review:
In [PATCH v3 16/23] ref-filter: make cat_file_info independent
is_cat flag is hidden into global cat_file_info variable

Also make some minor refactoring.
