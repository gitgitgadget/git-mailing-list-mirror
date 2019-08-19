Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD021F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfHSRah (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:30:37 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:41907 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfHSRah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:30:37 -0400
Received: by mail-vs1-f44.google.com with SMTP id 66so1706766vsz.8
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KK7v7qsbq0SHV6LBzx80qnOYBybGO9vGpcQ+zkx9kv4=;
        b=g0TiotwUtHXGrwBd3k3A69e+rip4pYc08jJR2XtcCUCugXNKAFnriWQeCd4YRdSOAh
         RAxdlnY8KgFkjzWoymAgG/G65twrJ9vfAXq32ZRm4wHHq9f58aFc4TuJnKk8RWilCZrH
         nFn3Ou57a31FbDCpzVG81z8BHxTbQf3EcXVvS+oEFzsYa3xJ1j8HKaIV6km2/oF17g6Y
         qgyLn8zU7uGWXzMb29e5kof+SkKWULWjDFlBvi5mGxX93HKrugjd0m6TR7uCpbmLrmif
         hOtiARYqEeS9n3vOJXnjzTDzAdSJPwQ9fW2BpuwMjNfGlQWNstSkY1+x5vxnFzY9KrOk
         XqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KK7v7qsbq0SHV6LBzx80qnOYBybGO9vGpcQ+zkx9kv4=;
        b=i8aFBIN1QLKhl7URmh1qoFXqHHl0Gn9Mg1EpUV2+MQSybnA6rLeEX1CEP28OHAv6St
         QkFSXlKsDqNZu4XHh9U6UrpvvuCTTNeRYH8tHzMv5v7/fZXNKljSd7OUvxnYga4vMOPD
         5loZkaJput6A4ephJmB+lF0b0JBNDWZbB5D87oVyubTuirEGVYmkbPak/gEqh8eNrm3R
         +KPVCh0aCdws4MaZ5ExK92xEXlQ4eO8e6VN3Imuab7ne+ZH1f2/fdgMs4NuVF3XyOfeX
         zAPlINLkwQz6P+fBDZHi8buvBsUwsuAEEvHxQxlkdvZa7yFB9TsmJSwEKBnIQFokAkc/
         XzRw==
X-Gm-Message-State: APjAAAVrRu/AuautzlLQEfPbdu+LxfsOKbY4pEM95119WS9+NUQLJgMH
        ant1fyyuB5hONSq8Aw3Ah7BQ2IskFL4/S0qZhjJ5Khs=
X-Google-Smtp-Source: APXvYqynR9NlJR98U9HUF8cShGu3PCLyqnxgSfGHBw8qM9IieYXIuWwstESQG/RLTueeBlB7NqSNVqX7KsILpi0EL/o=
X-Received: by 2002:a67:7a8c:: with SMTP id v134mr15292797vsc.44.1566235835417;
 Mon, 19 Aug 2019 10:30:35 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Miller <aaronkmiller@gmail.com>
Date:   Mon, 19 Aug 2019 10:29:59 -0700
Message-ID: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
Subject: git-p4: Clone p4 path with bidirectional integrations
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Is it possible to `git p4 clone --detect-branches` from a Perforce
path which contains bidirectional integrations?

I've tried a bunch of things to get this to work, but here's an
example which hopefully illustrates what I'm trying to accomplish
and the issue I'm having.

Perforce setup, assuming PWD is mapped to //depot/... in your client spec:

  1. mkdir -p testing/master
  2. touch testing/master/test1 && p4 add testing/master/test1 && p4 submit
  3. p4 integrate //depot/testing/master/...
//depot/testing/staging/... && p4 submit
  3. touch testing/staging/test2 && p4 add testing/staging/test2 && p4 submit
  4. p4 integrate //depot/testing/staging/...
//depot/testing/master/... && p4 submit

Now try to clone with git-p4:

  1. git init p4_git_test && cd p4_git_test
  2. git config git-p4.branchList master:staging
  3. git config --add git-p4.branchList staging:master
  4. git p4 clone //depot/testing/...@all --detect-branches .

You end up with a failure like:

  Importing from //depot/testing/...@all into .
  Reinitialized existing Git repository in /home/amiller/p4_git_test/.git/
  Importing revision 1205832 (25%)
      Importing new branch testing/master

      Resuming with change 1205832
  fatal: ambiguous argument 'refs/remotes/p4/testing/staging': unknown
revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  Command failed: ['git', 'rev-list', '--reverse', '--no-merges',
'refs/remotes/p4/testing/staging']

I'm using Git 2.22.1.

Thanks,
Aaron
