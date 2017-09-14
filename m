Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E7320A21
	for <e@80x24.org>; Thu, 14 Sep 2017 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdINWIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:08:04 -0400
Received: from mail5.fer.hr ([161.53.72.235]:20905 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751758AbdINWID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:08:03 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Sep 2017 18:08:03 EDT
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.361.1;
 Fri, 15 Sep 2017 00:02:35 +0200
Received: from mail-yw0-f171.google.com (209.85.161.171) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 15 Sep
 2017 00:01:46 +0200
Received: by mail-yw0-f171.google.com with SMTP id x131so428168ywa.10
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 15:01:46 -0700 (PDT)
X-Gm-Message-State: AHPjjUingEL6FI9aoFMZefme0VrB8FAcqo6qBkjO7IoPmRCorpRQy3XW
        XRmDg3StR7DSCWeaDsiT/GUe/X/Si1/MSAO8d4k=
X-Google-Smtp-Source: ADKCNb4rWKXYOv1JnfZzNdQIxNsoAGOYI9RIGqF4hfRQHAGObIlRoICtZ1+bOPernCNcyalvhNJswui9xjtbTL7Hh0E=
X-Received: by 10.129.48.1 with SMTP id w1mr21026895yww.146.1505426504607;
 Thu, 14 Sep 2017 15:01:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.138 with HTTP; Thu, 14 Sep 2017 15:01:04 -0700 (PDT)
From:   =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
Date:   Fri, 15 Sep 2017 00:01:04 +0200
X-Gmail-Original-Message-ID: <CAEPqvoyVJFe2EOvhnZD4vdF=1-VuoZrMP92TeGJ2WAE0X+B5Tw@mail.gmail.com>
Message-ID: <CAEPqvoyVJFe2EOvhnZD4vdF=1-VuoZrMP92TeGJ2WAE0X+B5Tw@mail.gmail.com>
Subject: git fast-export/import bug with -M -C
To:     <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.161.171]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands should be self explanatory. 0.2.0~20 is the first commit
where the reconstructed repository diverges, that commit had a
simultaneous copy and edit of one file. It seems that copy/rename
detection, enabled with -M -C is confused by this. I reproduced it
with git 2.14 next @ 8fa685d.

git clone https://github.com/googlecartographer/cartographer_ros
mkdir copy && cd copy && git init
(cd ../cartographer_ros; git fast-export --all --date-order -M -C) |
git fast-import
git rev-parse 0.2.0~20 #2237e1d0a974977fbcb0737dd1fb5876a2b8e29d
git rev-parse 0.2.0~21 #cd1276a99ccffcc491d0b2e50296ec04347ba5f2
cd ../cartographer_ros
git rev-parse 0.2.0~20 #9d5b221ed41783b15c84bc90b71527194b8d9a49
git rev-parse 0.2.0~21 #cd1276a99ccffcc491d0b2e50296ec04347ba5f2
