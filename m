Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D269920193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbcKBNyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:54:36 -0400
Received: from ares41.inai.de ([46.4.122.207]:38456 "EHLO ares41.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbcKBNyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:35 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2016 09:54:35 EDT
Received: by ares41.inai.de (Postfix, from userid 25121)
        id 3216970002A1; Wed,  2 Nov 2016 14:46:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ares41.inai.de (Postfix) with ESMTP id F341C8022B62
        for <git@vger.kernel.org>; Wed,  2 Nov 2016 14:46:04 +0100 (CET)
Date:   Wed, 2 Nov 2016 14:46:04 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: RFE: Discard hunks during `git add -p`
Message-ID: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Current version: 2.10.2
Example workflow:

* I would do a global substitution across a source tree, e.g. `perl -i 
  -pe 's{OLD_FOO\(x\)}{NEW_BAR(x, 0)}' *.c`
* Using `git add -p`, I would verify each of the substitutions that they 
  make sense in their respective locations, and, based on that,
  answer "y" or "n" to the interactive prompting to stage good hunks.
* When done with add-p, I would commit the so-staged hunks,
  and then use `git reset --hard` to discard all changes that were 
  not acknowledged during add-p.

Being able to discard hunks (reset working copy to index contents) 
during add-p would alleviate the (quite broad) hard reset.

Similar approach:

* global substitution
* Using `git add -p`, some hunks may warrant some more editing, doable 
  with the "e" command. The index would be updated with the extra
  change, but the working copy be left as-is.
* When rerunning `git add -p` in such a state, a difference is shown 
  again for such edited spots, which I would like to discard (bring 
  the working copy into sync with index).
