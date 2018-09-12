Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8038E1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeILWk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 18:40:26 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36949 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeILWkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 18:40:25 -0400
Received: by mail-qt0-f175.google.com with SMTP id n6-v6so2692310qtl.4
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XpQZwB1tu4sXZ8cWIw3zizkMwM8l3YcEnULNxQpolZM=;
        b=fANUrgAqz6JraJPEYVU3mj8ClG+ze+Vit1KIx8Kb4ma7THiCeMVQ4BS8OnkXPdXsSK
         FGIqvd0DOUjqpxC+CaRqQaADVE46RYOYqEYDT+CCYHxfr0/NYahj6Re0E6VY4DwU/O4D
         B+0LasTXKXRB/Vo9cJdepmmIJveBmbV/0WlFXf6J/rX5HwLw8ItopQOZh4wqCPSpFNEv
         bj8GMQ0enoaT6K+BAGL6SO6vw/KIoGXCvIyQXzP4PuKmlke6edvnx1ZJLPAEt38rB39Y
         NH5JTGL9pxDYWqu1aUj+M7/E0g5ni6B3TPwYxRHiMZ42MmJTs1QyuNqZzaMicxzL9sVF
         qWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XpQZwB1tu4sXZ8cWIw3zizkMwM8l3YcEnULNxQpolZM=;
        b=aK3soE6P0u9A9JTNAZvtDHgQW+n70hs/BkYeE5nnc3Cq+Zez6q3TD8Ryix9CemRr8U
         nRpSQtu+eN2llxigsgIckEXsguSxVvFgG9pKvbKu5lMz2Cf4W68CJN1wcjrb9AHN30p1
         E2WnR63hs2Ho/XzyE4P5EjtBq3QKCOEdjPD182MqdTGPRSDiAx/ql9K87UJBTD6swmJC
         hA5rsKsovKFaUpY3FAZpSyMjd9oxya68j3wHGQJ5BbeMYt31KkVWTS6hecxbpjT7y/1l
         6Sl/7deHiT63qi2hHI8zOcwrNamfCc1rkHMQe1A0RR4nn2uAa1X00Cl7CRgAdNC8bAs0
         igGg==
X-Gm-Message-State: APzg51D3x/mvjCAWskRQVos0IYINfjBARDjNmvAT8xOb2uQe1XLqjJ/r
        9NkuyyBOK/jVDFQHI094zSNrLRGTNo8+6wmGg8B/gbn5
X-Google-Smtp-Source: ANB0VdZVNa1N2ZFMwrks4p+ED15KN2dnGPBfofu6abX6LU6BrTArcSwOXRxCoCf/2VPbqxkQeg0pF4Mzd+jMhu5zQXk=
X-Received: by 2002:ac8:1a04:: with SMTP id v4-v6mr2450588qtj.183.1536773692585;
 Wed, 12 Sep 2018 10:34:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:280d:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 10:34:52
 -0700 (PDT)
From:   Dave Marotti <landshark666@gmail.com>
Date:   Wed, 12 Sep 2018 12:34:52 -0500
Message-ID: <CA+5phNzsn8wS39aSLZJDNahxYoBuK3QZX81KWpaSKavssVLREw@mail.gmail.com>
Subject: Starting subshells via tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello -

This is not a git bug or issue. It's just something I stumbled across
and didn't see any google results for. I thought others would benefit
from being aware of it.

I saw a makefile which included of "git describe --tags --dirty" to
define version information for a binary's --version command line
parameter. The commit/tag information was passed to g++ in a Makefile
via:

CXXFLAGS += -DBUILD_COMMIT="\"$(shell git describe --tags --dirty)\""

For fun (on Linux) I made simple c++ program and Makefile with the
above CXXFLAGS, and a tag (backticks work too): git tag
'$(echo>/tmp/test.txt)'

Then built. Make executes the git command via a shell and the shell
executes the subshell. /tmp/test.txt was created.

The tags themselves don't allow spaces so the complexity of the
command is limited, though I didn't explore what I could do with
chaining shells or escape characters. It's easy enough to add a script
to the repository where the tag is located and execute that script
from the tag's subshell with a tag, such as $(./test.sh).

Again, this is not at all a git issue, git is just used as the
transport. As with every other shell attack, it comes down to "always
sanitize what you pass through to a shell". Or don't pass it to the
shell at all, use another mechanism.
