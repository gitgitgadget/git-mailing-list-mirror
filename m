Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EDC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CD921D46
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jJFVDwmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgKFSjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:39:12 -0500
Received: from forward105j.mail.yandex.net ([5.45.198.248]:36758 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbgKFSjM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Nov 2020 13:39:12 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 13:39:12 EST
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id BCC11B21338
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 21:32:14 +0300 (MSK)
Received: from iva7-f62245f79210.qloud-c.yandex.net (iva7-f62245f79210.qloud-c.yandex.net [2a02:6b8:c0c:2e83:0:640:f622:45f7])
        by mxback16j.mail.yandex.net (mxback/Yandex) with ESMTP id owSeuKBPKq-WEjuGMPJ;
        Fri, 06 Nov 2020 21:32:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1604687534;
        bh=7bOPQ3EI2YIBwLGZvTm+nbXknznLrgqKQvL1EiHTVCA=;
        h=Subject:To:From:Date:Message-ID;
        b=jJFVDwmHemyshm8b+GZ8OetPJYYlNkOCAfm2tN4gkVvx88C+D4UHKrFecoEFjZvbU
         XpAKd8pJ/Q1KwT6mkUmVBfyYZfaAnmLCyLnL9mZdlg4XTPIO8UdcJnMsQ0wFBTkU2b
         WfL/OcIzOWI0S6JHRbv0iuMxjAkfZse9we1hONzQ=
Authentication-Results: mxback16j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-f62245f79210.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id XbxbZUxz4z-WDmuBrlY;
        Fri, 06 Nov 2020 21:32:14 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Fri, 6 Nov 2020 20:32:13 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1526558917.20201106203213@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git rebase/git rebase --abort cause inconsistent state
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I try to rebase, get conflicts. So I decide to --abort

After --abort I expect state before rebasing, but I get conflicts.

I  supposet  this  is  because `git rebase` switches to not branch and
--abort can not return to branch I was on before rebasing

Is this a bug?




kes@work ~/t/lib/MaitreD $ git rebase dev local/dev
Created autostash: 566876c8
warning: Cannot merge binary files: share/ChangeAgreement.docx (HEAD vs. f2442d9a... Update Docs.pm)
Auto-merging share/ChangeAgreement.docx
CONFLICT (content): Merge conflict in share/ChangeAgreement.docx
error: could not apply f2442d9a... Update Docs.pm
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply f2442d9a... Update Docs.pm
kes@work ~/t/lib/MaitreD $ git rebase --abort 
Applying autostash resulted in conflicts.
Your changes are safe in the stash.
You can run "git stash pop" or "git stash drop" at any time.

Here is a tree before rebasing:
> a9597aaa (HEAD -> dev) Use DateTime with correct timezone
> 822ff801 Add link to Podio into mail
> 65575afe Update Docs.pm
| < e0003861 (local/dev) Update podio.t - test person contacts
| < 28ab8630 Create docdate if agreement is new and update test for that
| < 208ead68 Specified checking of person
| < f2442d9a Update Docs.pm
|/  
o 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

Here is conflicts:
HEAD detached from 142c1b15
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
1       modified:   ../../Makefile
2       modified:   ../../etc/maitre_d.development.conf
3       modified:   Command/bank_statement.pm
4       modified:   Command/invoicing.pm
5       modified:   Command/reminding.pm
6       modified:   Controller/Cart.pm
7       modified:   Controller/Saldo.pm

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
8       both modified:   Controller/Podio.pm

$ git --version
git version 2.28.0


-- 
Best regards,
Eugen Konkov

