Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A126C1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfH0SYO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:24:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33767 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbfH0SYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:24:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so32572qtb.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1AIbinFWM7+llGB5f4axHj/I3ecqVYvraiSZiNwFDNU=;
        b=p7QQ8amT457uJXItMyB0WFYnHYrRUFN0GZHEGQ+ITDoDjacGvoJD610G3lGe62Myrj
         6kee44Qyc9zQUEKVnMmDfOzp9b8JgPx3cnzE99UTRX6Kg1Kfn6DS1X73IFdsNrzo+HRI
         COu7hE9tOoqayQ4ve0FVnsxs6pyYmjjFt0zkvmR2NxTDdYi3COpmigRJcUlTfRbvwC9Z
         qqcmbh9JC3givwoKhda//S4jHIDlrmv1ZAOj73kwTHJaeTnVaA/KoeGWPhOoCh3UVjEr
         WkJm+A1IfC+JhSTMm/HMSD3DY83qOr8WY3VHSuFMvz3nyPMW2+/SlIBwwCmFUhDOLk7F
         2GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1AIbinFWM7+llGB5f4axHj/I3ecqVYvraiSZiNwFDNU=;
        b=WnwaZ7roZk8eNEViS08JEP2eUI5PbKP5IxZ4B/mOU/sdXhltb+6ruqFH6/oJSbR6Z4
         otRaXE//p52u7yST6IfTTYtd6S0/y55TCnWLl3/6hyIGGL2djJO5cFKu+F3wEL1jF3B9
         eD09DLnG4FhyhLrlE+82P7o8nxrEyWPENNs93xcnAjHOxBfiQn0GB1hTMahZQTowf6+9
         wDspF5bU/Ir30IGx5g13rG52smSn891uVyx0em57VC1H5AhIaNl3dTgJJ1Ci8gXJAqBu
         0Wq4dDqRV7oYQq0UJhxmfoze4t12Qg6RF/D8tKKSKjEDnHpuiCR09XaZWo7pabIHI3uW
         Yq4w==
X-Gm-Message-State: APjAAAXfI8Q9bZFHA5w5msDxTD2ifVuLuOHj1CJm6KVkUJZ0/Z0hgVgp
        PR7Hs1+6HQcUgxImUj/B664TX/OCcZltJhmZsm+XF1/ZzJh48g==
X-Google-Smtp-Source: APXvYqygpMBs/SNByvy7Svuo1nyvGYkwvJ5yNaw7d+vPhyQVyNQAsZk4EvCraYSzZ3hjkXBwST9F098JNahC6s2emZc=
X-Received: by 2002:ac8:7402:: with SMTP id p2mr217493qtq.182.1566930253298;
 Tue, 27 Aug 2019 11:24:13 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Tue, 27 Aug 2019 21:24:02 +0300
Message-ID: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
Subject: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote a very simple Python script to see which arguments git-diff
passes to the external diff program when comparing files across
branches:

$ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
origin/branch1:file1.txt origin/branch2:file2.txt
['./print_argv.py',
 'file1.txt',
 '/tmp/QRaIJ1_file1.txt',
 '802b1c4ed7b06162b2ce09b7db72a576695b96e5',
 '100644',
 '/tmp/AZuOJ1_file2.txt',
 '076e8e37a712d8a66c0c3d1a103050dc509ca6ff',
 '100644',
 'file2.txt',
 'index 802b1c4..076e8e3 100644\n']

According to the docs
(https://www.git-scm.com/docs/git/2.22.0#Documentation/git.txt-codeGITEXTERNALDIFFcode),
git-diff is supposed to pass 7 parameters:

path old-file old-hex old-mode new-file new-hex new-mode

This is not what I am seeing here. Is this a bug or
incorrect/incomplete documentation?

Tested with git 2.22.0 and 2.17.1.
