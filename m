Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2F7209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969188AbdEYTEt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:04:49 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35805 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964904AbdEYTEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:04:48 -0400
Received: by mail-ua0-f172.google.com with SMTP id y4so114469373uay.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q28r90ocw4eJ7m3hqB3wv0tHv8eRu/ICImO/3XrUv+M=;
        b=V1s29qv0/qMQSj/cEe0M/R0ZbmO6knPuSfgNiBaXnqVRVu+2ctz57YuifsACOTyMt/
         IwVcBj8EfmtOaXsJQo2GSeNjyJwqKyN9JfWgSHv80fjfdO2p1yt7/5c20gNRp+Y+0xma
         KREc+/vI/cmc3lbMwautWTAnJudl1S5CFNMpf725uCR8HP686IfoOQWeRK2qCnGNHxHR
         0VTBduaQ8oPNvMt5T84/TMzNdl+QpKuF1sRRFSk3EdVnvvdGIkz2b3xYkKmn3VHjENJY
         vlEt4ZiLCTKS2pZohXVzmhHGdPeTmPBZXv4/FOiVo0qYlsyDHhUrKOcM6Dt+gVxc9QOz
         vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q28r90ocw4eJ7m3hqB3wv0tHv8eRu/ICImO/3XrUv+M=;
        b=emEHmrxEjXk/JDc/CAF0Yg2VcRzCn5g6X6sQowRIiJXHw4ZK6GQXrj23d4a66q2zqJ
         6dCSTiEnUae+o1KhJAatQ5onogcmij8fTxTmFpceEyHxvTrzgyZ6U23dH+Jg2kGqmbvz
         lIrSiXHbGIXrn4o7WPvw//fawUm5f2vM6YNUm0ChKpUtBAAOrQvriJkRbA5LPMJOeqMA
         fqDWCOsFGjM+0iORl1pKAPdpm7Qi6PKKwVHVstXXKc1vOx7y69stgyoHYL47spU8dZYt
         OVGp+EhrdG2OS5yyAFdz/WvQRMvQb7a218Qf6fgk99l+KTa4mYK6p7DHfuGd+B+s8Ka/
         /HjQ==
X-Gm-Message-State: AODbwcAZFg/U0DKbHKiyekECnQ03oQBrAr8XRtCo9X4FZ/ahQa0de8YM
        eOctloGqKlzM6RIj7cFpfcLKj8DFJIJKlzQ=
X-Received: by 10.176.4.80 with SMTP id 74mr11197205uav.115.1495739087606;
 Thu, 25 May 2017 12:04:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.75.72 with HTTP; Thu, 25 May 2017 12:04:27 -0700 (PDT)
From:   Alexandre Bury <alexandre.bury@gmail.com>
Date:   Thu, 25 May 2017 12:04:27 -0700
Message-ID: <CACfpxdthS4W9giaFNd7GVxPw4BMJ85GmOQAJbEL84YHrouyK9Q@mail.gmail.com>
Subject: `git svn branch` does not respect authors file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a git repository linked to a svn repository with git-svn,
including a branch path configuration and an authorsfile for svn
username -> email mapping.


When running `git svn branch new_branch`, git-svn:
* Creates a svn commit creating a new svn branch
* Creates a local git commit linked to this svn commit
The svn commit is correctly generated, but the corresponding git
commit has a bad author: the author is just the svn username.


Re-fetching the svn repository then properly applies the authors file,
but ideally it would do it directly when creating the branch.
