Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BF42047F
	for <e@80x24.org>; Wed, 27 Sep 2017 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbdI0SPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 14:15:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:48905 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdI0SPF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 14:15:05 -0400
Received: by mail-it0-f68.google.com with SMTP id m123so8366602ita.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=UItAk2qKgXY3ECpihR3cLbDL/bk1W5T8mguK3mh4Lho=;
        b=LgrQu2To/iVKWesWA1Et8xbo+CAcfLaF1mA0D13eHRckP23P2kHDs8wvJGPZIXttl0
         UlrrbHnxe72iuoOGWPMdiuigewydnGidI9wNZzQYds6Jg6gzUr10Dr+/PWQbLCXUJh6Y
         hBPL1MphaSqPobxHxoNTeCX1Z1+1ZU9noZRxSVQSM/Q7X+t0PsrWA/MEogSDAOCy+gWj
         0wBoJZLCiCTrAVpNeHlNIF1Skk0RpOdZM3Lq7FFiieEbbDU0QJnGqWfjfjjjgkO7KzDu
         KBszGsKLpmFg59ZacNQljlILSu8i6uWNcsmOo6iBJ7/cUj8cvFY3dYXfmhnAUgq2lMXc
         DzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=UItAk2qKgXY3ECpihR3cLbDL/bk1W5T8mguK3mh4Lho=;
        b=DdWFy06MfkaeCADdD8WMTj0scvhdFqP4B9PK3F4a4grZilmbjncJVC8yCYUJ1pzkCc
         9krFQYZ51XbpoPsY5E0bZde2r+zVgcgtKYjQf787l1hKPMlwMe7Fyxu772xYCJaePXaE
         mP0q4bKorBSmnSVzG5ionn0KdqZxICJYh3JyqDjoKPCBkXnR2+LxmfVCanyAZ2ElBIUR
         Biu9SpdORAXpysX53fyWzlEl1AbDjCdXxe3uggyygFSHQHLxLppjqVOOfp5GNY8rpgGs
         64xiFSUi88aDdU0DyKxkpMfG3+RwEDP2kWEgllsJ/DRLkOREDkdRq8x2At86p10Z1Z3o
         Y1pw==
X-Gm-Message-State: AHPjjUgSvjt7Ri0Z8NqaH3oijm6BJYmKeoBocyuxopwMDK/RI3iADSXm
        bb4EpMJNVqsYvGHzllLl1ySAZdX5edkyCLtITsdoC2iR
X-Google-Smtp-Source: AOwi7QBQzPL8YP7lza1pRcWLXMHPSjbG/x6P+0ytgRD5UXUZ2n/ujG1g/OHocR12SZhDZa18hGVyUdDnZ1E/h/C+Oag=
X-Received: by 10.36.199.130 with SMTP id t124mr2091196itg.2.1506536104873;
 Wed, 27 Sep 2017 11:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Wed, 27 Sep 2017 11:15:04 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2017 11:15:04 -0700
X-Google-Sender-Auth: R7ig0BDENgHvelt1Sm5vqtqDD5U
Message-ID: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
Subject: diffstat summary mode change bug
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current git shows file-mode changes incorrectly in the diffstat
summary, as I just noted from a pull request I did on the kernel.

The pull request *should* have resulted in a summary like this:

   ...
   21 files changed, 247 insertions(+), 67 deletions(-)
   mode change 100644 => 100755 tools/testing/selftests/memfd/run_tests.sh
   create mode 100644 tools/testing/selftests/net/reuseaddr_conflict.c

but instead that "mode change" line didn't have a newline at the end, and I got

   ...
   21 files changed, 247 insertions(+), 67 deletions(-)
   mode change 100644 => 100755
tools/testing/selftests/memfd/run_tests.sh create mode 100644
tools/testing/selftests/net/reuseaddr_conflict.c

(ok, linewrapping in this email may make that look wrong - but the
"mode change" land the "create mode" are both on the same line.

Bisecting it got me:

  146fdb0dfe445464fa438f3835557c58a01d85d7 is the first bad commit
  commit 146fdb0dfe445464fa438f3835557c58a01d85d7
  Author: Stefan Beller <sbeller@google.com>
  Date:   Thu Jun 29 17:07:05 2017 -0700

      diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY

      Signed-off-by: Stefan Beller <sbeller@google.com>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

and the reason seems to be that the '\n' at the end got dropped as the
old code was very confusing (the old code had two different '\n' cases
for the "show filename or not").

I think the right fix is this whitespace-damaged trivial one-liner:

  diff --git a/diff.c b/diff.c
  index 3c6a3e0fa..653bb2e72 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -5272,6 +5272,7 @@ static void show_mode_change(struct
diff_options *opt, struct diff_filepair *p,
                          strbuf_addch(&sb, ' ');
                          quote_c_style(p->two->path, &sb, NULL, 0);
                  }
  +               strbuf_addch(&sb, '\n');
                  emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
                                   sb.buf, sb.len, 0);
                  strbuf_release(&sb);

but somebody should double-check that.

                        Linus
