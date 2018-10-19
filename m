Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884E81F453
	for <e@80x24.org>; Fri, 19 Oct 2018 18:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJTClA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 22:41:00 -0400
Received: from kitenet.net ([66.228.36.95]:49232 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbeJTClA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 22:41:00 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1539974016; bh=p8s1bBBzOUwO9kot86TiepI0HOXKqRuNO1F6gPQN9Dw=;
        h=Date:From:To:Subject:From;
        b=FVYEdNmQ08HP5relv853F7fHwzm5K+Fk7ayDilmmPSDNKSM8ADeFbhHf+XbAodeF0
         QyRTfhGD1dRriiqunsUOhG7aIlTPZiCBEIvrEd8hTwiIzgDI/nkGPy2jz3VgeyBV1/
         0fJh76578rCbBiJ9HcmVOwphDB3im08A8rCb1NYs=
Date:   Fri, 19 Oct 2018 14:33:35 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Subject: git ls-files --with-tree documentation
Message-ID: <20181019183335.GA12353@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

       --with-tree=<tree-ish>
           When using --error-unmatch to expand the user supplied <file> (i.e.
           path pattern) arguments to paths, pretend that paths which were
           removed in the index since the named <tree-ish> are still present.
           Using this option with -s or -u options does not make any sense.

This seems to say that it only affects it when --error-unmatch is used,
but in fact it goes deeper; for example I can use it to list files that
are present in either the current work tree or some other branch:

joey@darkstar:/tmp/v> git checkout foo
joey@darkstar:/tmp/v> git ls-files --with-tree=master
in-foo
in-master
joey@darkstar:/tmp/v> git ls-files
in-foo
joey@darkstar:/tmp/v> git ls-tree master 
100644 blob 0242cc10fdf4e9afdfd0928c2a209d4545780168	in-master

This is very useful behavior, but I'm not sure if I should rely on it
behaving this way in the future, given the documentation.

t/t3060-ls-files-with-tree.sh does indeed test that it
"should add entries from named tree", and it does it without using
--error-unmatch.

How about changing the documentation to something like this to make
more explicit what it does.

       --with-tree=<tree-ish>
           Treat all files in the <tree-ish> as if they were present in the index.
           When using --error-unmatch to expand the user supplied <file> (i.e.
           path pattern) arguments to paths, this has the effect that paths which were
           removed in the index since the named <tree-ish> are still present.
           Using this option with -s or -u options does not make any sense.

-- 
see shy jo
