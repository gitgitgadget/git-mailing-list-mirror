Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56D920898
	for <e@80x24.org>; Wed, 19 Jul 2017 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbdGSQtO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 12:49:14 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36470 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753559AbdGSQtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 12:49:13 -0400
Received: by mail-qt0-f170.google.com with SMTP id 21so6730666qtx.3
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0jm6SQynJNK5kAYYCrptVYo9BmF5WRHMTp4tGzfTEB0=;
        b=o4SDGGVwiQjai+q2bsQqycTQVQZnRwQrknqBQOiUW3HXsK3X0VbMXT3JsiLrn/Bgu7
         FTnCMRXdbZFwzncvM9mjKh9kX/ChHL/zeL2tE9r0QoPnElaSlg6bVO4PWvH9JDj0DQ66
         K2zENbA69yhXxlunRyRpF1xVYqgwHKP966QZ5nRIsSvQh3yFC3EV0+W8Qdb4T85k0fyF
         5h5Jt93RYKQAo8cSimk8rFzdMAB33/P9xUiERU+vN3W307/TD8MpPLr4V4fFDllk3uku
         xaeeY/KJNrKvnrL4D99NmVMs/PzUpNNX4FUW/8zAOoxtsfTcr6cw669QUlvWXyqJDmQi
         0Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0jm6SQynJNK5kAYYCrptVYo9BmF5WRHMTp4tGzfTEB0=;
        b=kYG59xigqq4wGK10D6mlKtmse7A3vEoyX/pN3nOWH+Xslg0EVcchl/R7/eg2vLIH1p
         888IAee8TT/Nok3pPrcPNf6XPOSRWf8hHu0Gn2+ihr3avre7SVWftE6wioZs+3FTMNMw
         jiZpmsk6UXOykOhO+hEKGqs/GZPxJGfJ1sihxPilRirNW2LJGf6LgV61An/5mMBiumnc
         4UokUfDtmJQIVmpsUslnmweXue2L2gs0hxWSkJPKCc6oIcgLzOLCuaj1sp3ESoEE6u5V
         ZdQbCWbqnTYg/CZfEgBjbDmBKwvWr7Z26xnlsO/TYHcxJWxScTpUizbBH9eSuiCKtlSX
         RNeg==
X-Gm-Message-State: AIVw110QmcyijjyWSyazIigPuFbaHcqd5d24xtsnAkwR9L0HuMU7NqSW
        7fWD+6ivn+wJ9YhL02n6pUAX5HvIHnRW+1w=
X-Received: by 10.237.35.239 with SMTP id k44mr1132133qtc.125.1500482952079;
 Wed, 19 Jul 2017 09:49:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.58.135 with HTTP; Wed, 19 Jul 2017 09:48:41 -0700 (PDT)
From:   Victor Toni <victor.toni@gmail.com>
Date:   Wed, 19 Jul 2017 18:48:41 +0200
Message-ID: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
Subject: Handling of paths
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a .gitconfig in which I try to separate work and private stuff
by using includes which works great.

When using [include] the path is treated either
- relative to the including file (if the path itself relative)
- relative to the home directory if it starts with ~
- absolute if the path is absolute

This is fine and expected.

What's unexpected is that paths used for sslKey or sslCert are treated
differently insofar as they are expected to be absolute.
Relative paths (whether with or without "~") don't work.

It would't be an issue to use absoulte paths if I wouldn't use the
same config for Linux and Windows and each OS has its own semantic
where it $HOME ishould be.

To avoid double configurations I tried to use the same directory
structure within my $HOME for both OS.

This approach fails since paths other than for [include] seem to have
to be absolute which seems like a bug to me.

Do you have any suggestions how I could make this work?

Thank you,
Victor
