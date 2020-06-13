Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695ECC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328E92078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 22:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dhappy-org.20150623.gappssmtp.com header.i=@dhappy-org.20150623.gappssmtp.com header.b="thW+IOYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgFMWiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgFMWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 18:38:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974DC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 15:38:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 205so12447189qkg.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dhappy-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iV9p9ktLGKoW2CB/1ff8oKmKWQc85McEPc4L5BAqpWk=;
        b=thW+IOYIhYFqF7uUOF3G5YlNu5AroFNVFfixNmjMs70+zldER36qpOhhz1uEvj8OLb
         o+jxTe3Z4IMOS/rX3fTiuoeXkZXVa3CAY3dFgzg0/VFB7j7CzHBQImcz9Pjw8pgiFKk0
         IBDxRGKCrnwjQ3XMD6Ka4rP9JuCSyeirebIswaXgfhcztlT3UlVTEmhjfGlcG+smNbGf
         e3tQ2CRd+JhcHCt/l2Mw1sNHE30QnRz/nsPsIfxAA3UOC5Y2WtHkhnNxGUFbrfns0kQm
         tv1pFApmY8VWbrtiv75I3XeeqvUNxAxIZcA8qpDPxu/004YMe12UZ7VNGHWyXx+xw7t+
         bK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iV9p9ktLGKoW2CB/1ff8oKmKWQc85McEPc4L5BAqpWk=;
        b=EUwegv4QOqvV3EqrYn1PKLQERMLOzgDEUxWkXmkWwnyAsZWHWJNquLI3O7GN60yfZB
         cMh1gS/+sXVFfRqZ2SzbuSBWgyuqtamth98s+30Qh6/1/y3exVWaFbI36/0DVx8wDpR4
         vwXu3BGots5otRBIkdBOdhgblflYOWnQ2IcV6u6dSU0KXe2oQqR/NTaStao+wvDbVk+I
         MXlFxkNfASfYbzPT3CX1VqKU4G5lhlxJtOSE0PgDua6jGtFmwjCXU3oaJUlCR5WcEEOr
         akjK8b8v/kTSJOZ7uM55ajD0mm6FrLzb6/9ySuOz7fsl6lvSR3HDiHI4J5hqkT/O3tgX
         TN1w==
X-Gm-Message-State: AOAM530GPRPMhFlix2ZmVuSmuiG+uYnzejKEVh67Yzo4noCxEIfVe9Dn
        9dHDJQ3LOd9xJ8Q34yIry9AZQ1C/Df250CiqgZnQ9LR5ix4=
X-Google-Smtp-Source: ABdhPJyz2x2aGX9TlXnNNRNfeH63ED0saajFzR6hKM543qM21c6P/knOL8DEA/aQnMubDAIEsFoNzvDacjK2SZdD7FI=
X-Received: by 2002:a37:4594:: with SMTP id s142mr9151613qka.183.1592087897118;
 Sat, 13 Jun 2020 15:38:17 -0700 (PDT)
MIME-Version: 1.0
From:   Will Holcomb <w@dhappy.org>
Date:   Sat, 13 Jun 2020 18:37:41 -0400
Message-ID: <CAB8ffCD4jO6GxRohMpsyszdvi7dmz7HzE=2aNdqBG_zOGgOCoA@mail.gmail.com>
Subject: regenerating tags when cloning
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am working on a git remote
(https://github.com/dhappy/git-remote-ipfs), and I am confused as to
how to recreate signed tags when cloning.

My remote serializes the commit chain to IPFS and back. It works
correctly for branches, but I'm having difficulty with tags:
 =E2=80=A2 If I recreate tags, I get the error: "fatal: BUG: initial ref
transaction called with existing refs".
 =E2=80=A2 If I don't create the tags, I get an error like: "Error: referen=
ce
'refs/tags/v0.3.4' not found".
 =E2=80=A2 If I create the tags and remove the references, the clone will
complete, but the resultant repo has a detached head and no tags.

I created a minimum failing example when I posted to stackoverflow:
https://stackoverflow.com/q/62360443/264008

I can do a "git clone --tags" from Github, and it creates a clone with
tags, so I know it can be done. I just don't understand what I need to
change.

It might be germane that I am translating the git objects into a
CBOR-DAG: https://explore.ipld.io/#/explore/Qmcnzkb1YGyDWBqSaFz1k7qi3F1VDaH=
NsBWNF2SvRiYeL5/.git
and relying on nodegit to reconstruct objects with the same SHA1
hashes on fetch, so I can't directly insert things into the object
database.

Any suggestions would be greatly appreciated.

=E2=80=93=E2=98=AEW
