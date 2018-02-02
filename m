Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDD41F404
	for <e@80x24.org>; Fri,  2 Feb 2018 15:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeBBPc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 10:32:26 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45975 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeBBPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 10:32:19 -0500
Received: by mail-wr0-f193.google.com with SMTP id h9so9908542wre.12
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDcnoKjNdj9w0C3DRIgeferf5n8ZEYRNtqUgcOU5eCU=;
        b=DEnR9F57DnxZlGjsnpLqzDIdejLeQumFCOSoiENburz4XPSPZC4cvlsEJWPAJRlYno
         Nkz1WBKHcZu+YbTgwmdv5pwt1/dY84knHoVL53wHuZjtUUgfRJtr7NWVB8OvFOH1Diw+
         5Eo8cpqY15CD7axFCs0sgbbHww23jo7iYmhTiyOZmrcr1BuhRJgTimrqePaszE5ppHsS
         atjKjK9TA3yb+JF3hby9EvyqBzVuywUC38ZMow3aEBO+AA2K7whW0VmHHoMaDWoKQZAl
         rmHHXCp1dFOGidw1z5xqz4VNlwwOi5ziakXfQeB8pCRWdGFgnQHYYkYC7zoMOO2VWry+
         Mj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDcnoKjNdj9w0C3DRIgeferf5n8ZEYRNtqUgcOU5eCU=;
        b=DmBEg/6eXzD+8yohdkfN+9k5EIt8itzG0OSJpPBh5q+1zM45nntq5t4PmCmu2NiXou
         BTA5WQLWRtJ8iDzzetJ5xWHQ1sC9cd2+1dhmrZY2Zl5hgRuwDlXsYeQplfy1Tqz7kHqg
         II95YEO3GKfw0numj/1Rlx2LRll7ONXNx2RDqQ+kaWkIloj+o52iSPC/03GaTcQbKznI
         g2I1VDhsRtWywSozaR5q4YjDjivdgduWGUobTzlP0d5yiER/0OtZFQVwHzaQ8EaKuHYk
         moFX14+fuN/P6RJbTzeWW0Uwvx/Gtd8U9+jLIez4p+agMb4yLpy7sSc6qTHQvUzWoLEE
         7FfQ==
X-Gm-Message-State: AKwxyte+0ocNUkqXrf50umKBcYhpCJlyFaYuXuz7kklh9c+yajfH4FM0
        WqAMR4yQRNp1qd6SS/yNlTA=
X-Google-Smtp-Source: AH8x224LGSk2o9Fd9eAPdDL988zfHQq9JY57380ZHF3nqo8Vy7fBN4Amw9acrpooVLSUmohN/Y0ORQ==
X-Received: by 10.223.183.27 with SMTP id l27mr24437086wre.181.1517585538483;
        Fri, 02 Feb 2018 07:32:18 -0800 (PST)
Received: from localhost.localdomain (x4db2a0d5.dyn.telefonica.de. [77.178.160.213])
        by smtp.gmail.com with ESMTPSA id d73sm2124443wma.16.2018.02.02.07.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Feb 2018 07:32:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
Date:   Fri,  2 Feb 2018 16:32:12 +0100
Message-Id: <20180202153212.29746-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Teach Git to write a commit graph file by checking all packed objects
> to see if they are commits, then store the file in the given pack
> directory.

I'm afraid that scanning all packed objects is a bit of a roundabout
way to approach this.

In my git repo, with 9 pack files at the moment, i.e. not that big a
repo and not that many pack files:

  $ time ./git commit-graph --write --update-head
  4df41a3d1cc408b7ad34bea87b51ec4ccbf4b803

  real    0m27.550s
  user    0m27.113s
  sys     0m0.376s

In comparison, performing a good old revision walk to gather all the
info that is written into the graph file:

  $ time git log --all --topo-order --format='%H %T %P %cd' |wc -l
  52954

  real    0m0.903s
  user    0m0.972s
  sys     0m0.058s



> +char* get_commit_graph_filename_hash(const char *pack_dir,
> +				     struct object_id *hash)
> +{
> +	size_t len;
> +	struct strbuf head_path = STRBUF_INIT;
> +	strbuf_addstr(&head_path, pack_dir);
> +	strbuf_addstr(&head_path, "/graph-");
> +	strbuf_addstr(&head_path, oid_to_hex(hash));
> +	strbuf_addstr(&head_path, ".graph");

Nit: this is assembling the path of a graph file, not that of a
graph-head, so the strbuf should be renamed accordingly.

> +
> +	return strbuf_detach(&head_path, &len);
> +}

