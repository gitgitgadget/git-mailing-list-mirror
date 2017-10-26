Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413E7202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbdJZSt0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 26 Oct 2017 14:49:26 -0400
Received: from smtp.cantanea.com ([212.72.196.90]:36878 "EHLO
        smtp.cantanea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbdJZStZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 14:49:25 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Oct 2017 14:49:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.cantanea.com (Postfix) with ESMTP id 6CE69280750
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 21:42:03 +0300 (EEST)
X-Virus-Scanned: amavisd-new at cantanea.com
Received: from smtp.cantanea.com ([127.0.0.1])
        by localhost (smtp.cantanea.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FnPDHyXGEFdt for <git@vger.kernel.org>;
        Thu, 26 Oct 2017 21:41:46 +0300 (EEST)
Received: from dyn-ip-117.dh24.flohr (unknown [93.152.223.214])
        by smtp.cantanea.com (Postfix) with ESMTPSA id 63C79280739
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 21:41:46 +0300 (EEST)
From:   Guido Flohr <guido.flohr@cantanea.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Discrepancy between git-check-ignore and git-status for negated
 pattern
Message-Id: <60C66671-B124-4933-AC91-31D9A202D11D@cantanea.com>
Date:   Thu, 26 Oct 2017 21:40:49 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This .gitignore file does not work as expected with git-check-ignore:

    *.o
    !a.o

It seems that “git check-ignore a.o” ignores that “a.o” was re-included.  This is what happens:

    $ git --version
    git version 2.15.0.rc2.48.g4e40fb302
    $ mkdir repo
    $ cd repo
    $ git init
    Initialized empty Git repository in /path/to/repo/.git/
    $ echo '*.o' >.gitignore
    $ echo '!a.o' >>.gitignore
    $ >a.o
    $ >b.o
    $ git check-ignore a.o b.o
    a.o
    b.o
    $ git status --short
    ?? a.o

According to git-check-ignore, “a.o” is ignored.  According to git-status, it is not.

Is that a bug or did I miss something because of my limited search capabilities?

Tested on a Mac with current master from git.  The 2.13.4 binary from Mac Ports exhibits the same behavior. 

Thanks!
