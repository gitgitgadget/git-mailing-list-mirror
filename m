Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC87B2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 16:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbcGGQlc (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 12:41:32 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36669 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbcGGQkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 12:40:49 -0400
Received: by mail-lf0-f54.google.com with SMTP id q132so15083138lfe.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 09:40:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=a3xFyocBF2Xd5n6FUE3vl3lVdP/E1tpCeDQ6vrNIxMw=;
        b=b8TU922jnwnsQdMT+avAfDEIhatNHu4Pa1BvTyxn7b2iD9sAmEc3i6J0IzkC2aVD2h
         qaVG+VYkVvOAg+MS80Oj+YU8i/w89FLZxzkGdDFOa/1U+imnq8hWj0mqfA2sI4LkbBj4
         0EYlprO9V02jlIK64v9gE5mONs2R0t8+Dw4usmtqZ/dZxF+kozd/5sBIJGnP18r7ni1E
         s0/8oFZJUbLmM0g9AcXMbgPGxeFq8ck4vGj5za2/aKA1PbEeuE3jWAyt6p0sA1ZmBQ7M
         3uXnZ0j9Hf3/U3qAqlP1pwrHFZ2k9V99zvTprzZUOQGZIXL4GgG/eEf9pTzebj0M/LRc
         BvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a3xFyocBF2Xd5n6FUE3vl3lVdP/E1tpCeDQ6vrNIxMw=;
        b=TMUGBVqgwvwb8WMD51OvRZbhm5pwqTeVWQx+gaHzqNYJBo9p7B/crDJIVA8zMrC1mR
         AauOCbquQy8zANKzAFzacBiJadLdWsP+X5jicHLWycEY8G1Xdi+JpSoixX2o3uynKfv/
         OvTqlHLDkkHgo/bIb17o7WKVI4VTnkkZc7kNyvQsuPE4JrsgvWx3pxZNoDJwgeJYyVe3
         dDgSnR88sPYTA5+D1te4lOIZaprVA55MgyTLnvRlbxKmnrb7pW09eWreCdU5NjoJ78GD
         D+v/kos1Sar5hJZ+MLijNKC56kUHkyx4m5DqJzxOnHdQ/S9ThYNz0+9jlnP/7aWCZ+9r
         korg==
X-Gm-Message-State: ALyK8tJv9sy7fki34xT7JPy8MMmoAb+3AskccaSlltVFmFKUT7Mave9ooxz8nJhuPCBY+07eeWAw3pIog2lOWw==
X-Received: by 10.25.138.65 with SMTP id m62mr378585lfd.16.1467909613659; Thu,
 07 Jul 2016 09:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.10.138 with HTTP; Thu, 7 Jul 2016 09:40:13 -0700 (PDT)
From:	Stephanos <spapanik21@gmail.com>
Date:	Thu, 7 Jul 2016 17:40:13 +0100
Message-ID: <CA+z9LHJmjz2DWgRAJaO29YyeEcxpSuDSFPnCJPRTnHoVMisOvQ@mail.gmail.com>
Subject: bug: depth 1 and recursive update of submodules broke in 2.9.0
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When I try to ```git clone --depth 1 --recursive
https://github.com/davidhalter/jedi-vim.git``` in 2.9.0, it fails with
the message: ```
Cloning into 'jedi-vim'...
remote: Counting objects: 37, done.
remote: Compressing objects: 100% (27/27), done.
remote: Total 37 (delta 1), reused 16 (delta 0), pack-reused 0
Unpacking objects: 100% (37/37), done.
Checking connectivity... done.
Submodule 'jedi' (https://github.com/davidhalter/jedi.git) registered
for path 'jedi'
Cloning into '/home/stephanos/jedi-vim/jedi'...
error: no such remote ref 995a6531225ba0b65e1ff863d97e5404d989047b
Fetched in submodule path 'jedi', but it did not contain
995a6531225ba0b65e1ff863d97e5404d989047b. Direct fetching of that
commit failed.
```, while with git 2.8.3 it succeeds. The commit
995a6531225ba0b65e1ff863d97e5404d989047b exists.
