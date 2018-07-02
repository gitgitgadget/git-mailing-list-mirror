Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC8A1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 13:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeGBNbK (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 09:31:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36186 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeGBNbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 09:31:08 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so15871268oie.3
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yYSiCMUgSwEVOAeoy0JLDh4DFvb8JftrCTcF8API16s=;
        b=phT9HT2KvyOHJxauDNVUx+8cv+F8dPF1Jh4O00sCl9hCEAaY5OWMfUKJCE+2S2rYMk
         wh9w79wyEUZey8IJC7XmskRSclS+iU+tVp6NgCdBHsIPJ/h8TV3rOlCO6onWXXG8atp4
         w5himx6VEmTtAxaJBNag9sWGgU5ohz5DW8HlFmc4Hqd+DUeKyPbxg2eAUEcuMLMv4aq1
         Ed+e+mX8Sa95AvQqqkv+4VCWW0k2QZzkjutA+F1qPZ2OvrhNTPcUaGifeAgLt+l/mRDv
         hLYfHNpFglsL4SoKOyqybIHSl93Qshgl0LxDs1E3cdxVTiNYA/DKRBX87c6CrWyIyvZ1
         NI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yYSiCMUgSwEVOAeoy0JLDh4DFvb8JftrCTcF8API16s=;
        b=bXV/lukYJnHtzBK+nbnEg1t5rOvNBjVWRwUDK5up9xrKjw8cxJI5DJqb+AgrWjyyH/
         icEToT44QSj8UYBe5frQFU9XYlwhhWh2HfKR5GyCGOPIOaONGf4TRB9CS9SEnsql98P+
         B8Rp2yn3qjaziCab/2hisIlT1B/Py81IfGrUQO2Wx3O8ftvvuBb33qQ7EnIWbB1t5AT4
         HhrZ/cS7KVMq73xiD2+tTY3FKb9ZiKIi+b676SkYJCYp8JnuivsdxUFMYxVFrcEYl4hn
         UrCmbY5w0XiWjEsLxDdo4qKE+gBmAdl0Mrl21slbLmh+bDxoqHhgGnSYa+fWezpaem4T
         Pz4A==
X-Gm-Message-State: APt69E1q+vpkDTsFpTA8OAfvxt267lDUCI4tTc9L0pN1JRTeBytlOKHa
        pvGFLG970zT0KpRMmK2X7L6qVA==
X-Google-Smtp-Source: AAOMgpdlm6Ap16XzQOz/A3cNimebqo8XYe8SX5iVDXLkNnEZthfoaUR3YNzmpuQEk3Xe08s8nvAIkQ==
X-Received: by 2002:aca:f10b:: with SMTP id p11-v6mr16541643oih.80.1530538267461;
        Mon, 02 Jul 2018 06:31:07 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id r16-v6sm12232366otd.43.2018.07.02.06.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:31:06 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] Add missing rename-related corner cases for merging
Date:   Mon,  2 Jul 2018 06:30:51 -0700
Message-Id: <20180702133054.18638-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In merging, every rename acts as a two-piece lego in terms of conflicts.
We have long realized that the other branch can (1) delete the source
side of a rename, giving a rename/delete conflict, or (2) add a file in
the way of the rename destination, giving a rename/add conflict, or (3)
have a rename of its own touching either the same destination or source
path, giving either a rename/rename(2to1) or rename/rename(1to2)
conflict.  But only in one case did we ever consider chaining these
merge-conflict lego pieces (namely with rename/rename(1to2)/add/add
conflicts).  Add some testcases that show other ways these conflicts can
be chained.

In short, any rename's source side can attach to a delete or another
rename, and any rename's destination side can attach to an add or
another rename.

This series was spurred by Robert Dailey's report back in March of a
rename case that git currently handles poorly:
  https://public-inbox.org/git/CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com/

This series adds a testcase covering the issue he reported, and then
rounds things out additional testcases demonstrating other ways rename
conflicts could be "chained" together.


Elijah Newren (3):
  t6042: add testcase covering rename/add/delete conflict type
  t6042: add testcase covering rename/rename(2to1)/delete/delete
    conflict
  t6042: add testcase covering long chains of rename conflicts

 t/t6042-merge-rename-corner-cases.sh | 245 +++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

-- 
2.18.0.130.gd703bbb5d

