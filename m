Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE251F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbfILOrz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:47:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33608 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbfILOrz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:47:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so28818243wrr.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 07:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Za2GvI79+vC3f1ihnz2KiVFuO6wLRnODpbkpKMz8yOs=;
        b=Q4D+sDnfNhGVOROXaUTt3/TRVJIaoZDDP2U+PwoBAZPqt97myjNjIY7woe2Cjh3qgR
         2bNRf0g5ckm+la79TKsC6CyUuqxnmRNCRjIg2WMsgJC9Z7kG+b8qNjYbbGJdGTBLdP3H
         WMmYIFCj9+Uw4w43IXKg5McteTR6UEZvqemk+ozRicDSPy0il33YPt/DhI7dy1lqhDEa
         OGCdmDzx5Cf80sXyeq6/qNGlfI9YKpew7rzjdzha08UqRuhqTlwboFHcmRtLbI7Qmk+i
         x5RX2MYAUuoQh7jLz9QuiAYHrJVbuzYA23eJVR3f4CIPqXKB9xQ6pgvYSDdb1uPhBYdC
         pvWg==
X-Gm-Message-State: APjAAAV6+t12JWN+GXdCpnu9i3yHRi7iOD5ymyHpUzo+m3sv5V+1Zdpo
        pFqyfOdoswS2jgHvKST5LtDE4iSexE4bQT7q9DgdXg==
X-Google-Smtp-Source: APXvYqwa9dhlCOslNIdW+vhU4mmfDVExbob3uS1GOWJWVtiPCNQ3LV8p88x3lYQCTxGEWqoYf2+jrSW7c3cUoVr/pek=
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr32948592wru.278.1568299673244;
 Thu, 12 Sep 2019 07:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190912115201.888-1-tklauser@distanz.ch>
In-Reply-To: <20190912115201.888-1-tklauser@distanz.ch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Sep 2019 10:47:41 -0400
Message-ID: <CAPig+cQ53m0LrmScKnrcddyQzBRw_P=74cJ_H51GGrs8FD4RRg@mail.gmail.com>
Subject: Re: [PATCH] git-svn: trim leading and trailing whitespaces in author name
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 7:59 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> In some cases, the svn author names might contain leading or trailing
> whitespaces, leading to messages such as:
>
>   Author: user1
>    not defined in authors.txt
>
> (the trailing newline leads to the line break). The user "user1" is
> defined in authors.txt though, e.g.
>
>   user1 = User <user1@example.com>
>
> Fix this by trimming the author name retreived from svn before using it
> in check_author.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> @@ -1491,6 +1491,7 @@ sub call_authors_prog {
>  sub check_author {
>         my ($author) = @_;
> +       $author =~ s/^\s+|\s+$//g;
>         if (!defined $author || length $author == 0) {
>                 $author = '(no author)';
>         }

This fix seems incomplete. What happens if $author is undefined?
(There is a check for $author defined'ness just below the new code you
add.)
