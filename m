Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9A5207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 20:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933172AbcJFUYE (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 16:24:04 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35016 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcJFUYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 16:24:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id l131so26077434lfl.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=oTTmzba7CewzJ3ZTVQ9AF0srd2OABdAHpzMDlPpp7lI=;
        b=xXQFJq5NG1MnhiQViSVMRg8TiWk20Hd9/P5ndXk7boNb8tF8VE2c3t++p/jMbpcxCt
         tu8c60/MSMDs5kEQCbDJ75CRhxJ0jWBdHDe5Vmtg7HDgB6p3lcjxcuaabKEOTq5EpzwO
         Cvvy1YJVLxs6wI6kDXDdVa3ZP89HETNAk24Tyb7V+qd5jLsKHDNeaDeOAtJdt/euLLfU
         MvUYazwecI63eMBkejLAbRIYvXFjexleRdIWL1uA0J1ff0dAJ0qbo5BhLFndgens1FH9
         dTryUdXO/pwHhVqhQ04u95RNw7RkRYdwLkhhxDLygiNHhcJ9Y3wsP1/ujEdfxN0t2jN9
         DvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oTTmzba7CewzJ3ZTVQ9AF0srd2OABdAHpzMDlPpp7lI=;
        b=gJXqAe7ok3HtzOFysenrr9x+UBOqY1I1KuzfIioY8dKdjYiB+eMZt1QjWjTo9YifLV
         oQdDlnUOD3/swoIIK6SaEJ+IPFdlXpnpJtdCw2wX5IDDlCZzzWtErsFLkkFFjgNfaa21
         IfX/iRpE9Ge5DUV/Un+ot3v7W67JnUpmlcxh9gIAqHPUvFzNpYZTZe68mGov6DzL1irA
         ROStqrpOP9Qnkg8RjwH810Non/Vj4oXSm4CJZqk5frCy3+BjoHqCpOGmND6OpwtzCX+S
         NPpkS7haJ9K4qF/dR5JhvYlywLr7XPnNNvTCSkXwJYhwKexdWf/VLhCNXGoUMh6+YALR
         X/3g==
X-Gm-Message-State: AA6/9RlktbrL7ojjtIKm2ZLCyUjCIA/eCpa5AiylZotZP3ofhpQtjhPUijzWzBahsS3jm8tRTa1NLI+I38TN9g==
X-Received: by 10.25.66.3 with SMTP id p3mr3826840lfa.154.1475785441454; Thu,
 06 Oct 2016 13:24:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.18 with HTTP; Thu, 6 Oct 2016 13:24:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 6 Oct 2016 22:24:01 +0200
Message-ID: <CAP8UFD30HNTzF8grvPYjkafF6B=iw3R1t2S3swf4HUmPU5iuVQ@mail.gmail.com>
Subject: [BUG?] git log with --follow and --skip
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

At GitLab, we are annoyed by the fact that `git log` doesn't seem to
work well when using it with both --follow and --skip.

For example:

> git log --oneline -6 README.md
a299e3a README.md: format CLI commands with code syntax
c9a014e README.md: don't take 'commandname' literally
a217f07 README.md: move down historical explanation about the name
28513c4 README.md: don't call git stupid in the title
d9b297d README.md: move the link to git-scm.com up
6164972 README.md: add hyperlinks on filenames

> git log --skip 2 --oneline -6 README.md
a217f07 README.md: move down historical explanation about the name
28513c4 README.md: don't call git stupid in the title
d9b297d README.md: move the link to git-scm.com up
6164972 README.md: add hyperlinks on filenames
4ad21f5 README: use markdown syntax

The above 2 commands seem to work well, but:

> git log --follow --skip 2 --oneline -6 README.md
a299e3a README.md: format CLI commands with code syntax
c9a014e README.md: don't take 'commandname' literally
a217f07 README.md: move down historical explanation about the name
28513c4 README.md: don't call git stupid in the title
d9b297d README.md: move the link to git-scm.com up
6164972 README.md: add hyperlinks on filenames

So with --follow it looks like the top 2 commits are not skipped any more.

Thanks,
Christian.
