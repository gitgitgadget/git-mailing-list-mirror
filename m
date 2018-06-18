Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383581F403
	for <e@80x24.org>; Mon, 18 Jun 2018 11:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeFRLTo (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 07:19:44 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:33364 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934267AbeFRLTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 07:19:43 -0400
Received: from [88.130.56.171] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fUsBs-000468-J8; Mon, 18 Jun 2018 13:19:20 +0200
Date:   Mon, 18 Jun 2018 13:19:19 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Adding nested repository with slash adds files instead of gitlink 
Message-ID: <20180618111919.GA10085@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just discovered that when you have a slash at the end of a nested
repository, the files contained in the repository get added instead of
the gitlink.

I found this when I was adding a submodule and wanted to commit a small
change before that. You get the slash by using tab autocompletion.

Here is a recipe to reproduce:

mkdir test
cd test; git init
touch a; git add a; git commit -m a
mkdir ../test.git; (cd ../test.git; git init --bare)
git remote add origin ../test.git
git push origin master
git submodule add ../test.git submodule
git reset
git add submodule/

Now instead of just submodule gitlink there is an entry for submodule/a
in the index.

I just thought I put this out there. Will have a look if I find the time
to cook up a proper testcase and investigate.

Cheers Heiko
