Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B183F1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfGKNCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 09:02:20 -0400
Received: from gate3.osm-gmbh.de ([194.77.68.107]:59773 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGKNCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 09:02:20 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 09:02:19 EDT
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id A2F103C0E1
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:55:45 +0200 (CEST)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id A57A03DC01F
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:55:45 +0200 (CEST)
Date:   Thu, 11 Jul 2019 14:55:43 +0200 (CEST)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     git@vger.kernel.org
Subject: Bug with deleted files and stash-push --keep-idex
Message-ID: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1707157324-927516998-1562849745=:3570"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1707157324-927516998-1562849745=:3570
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi!

I don't know if this is a software or documentation bug.

man git-stash says about --keep-index:
     If the --keep-index option is used, all changes already added to
     the index are left intact.

If a file is deleted and this deletion is in the index a following
     $ git stash push --keep-index
keeps this deletion in the index but not in the working-tree.

If a file is changed and this change is in the index a following
     $ git stash push --keep-index
keeps this change in the index and also in the working-tree.

This is inconsistent.

------------- deletion -------------
$ git status
On branch master
Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)

         deleted:    test-file

$ git stash push --keep-index
Saved working directory and index state WIP on master: a3171f887b new test-file
$ git status
On branch master
Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)

         deleted:    test-file

Untracked files:
   (use "git add <file>..." to include in what will be committed)

         test-file

------------- change -------------
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)

         modified:   test-file

$ git stash push --keep-index
Saved working directory and index state WIP on master: a3171f887b new test-file
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)

         modified:   test-file

--------------------------

My expectation was that the deletion would be preserved within the
working-tree because this is a change added to the index and should be
left intact.

Best regards
Martin Nicolay

-- 

No MS-Word attachments (http://www.gnu.org/philosophy/no-word-attachments.html)
_______________________________________________________________________________
OSM AG | Ruhrallee 191 | 45136 Essen | Fon: 0201-89 555 | Fax: 0201-89 55 400
web: www.osm-ag.de | e-mail: info@osm-ag.de
IBAN: DE67 4325 0030 0001 0059 82 | BIC: WELADED1HRN
USt-ldNr.: DE163337313 | HRB: 28171 Essen
Aufsichtsratsvorsitzende: Dipl.-Kff. Sabine Elsas
Vorstand: Johannes Kuhn (Vorsitzender), Christian Damsky, Axel Roland

--
Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich erhalten
haben, informieren Sie bitte sofort den Absender und vernichten Sie diese Mail.
Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht
gestattet.
_______________________________________________________________________________
--1707157324-927516998-1562849745=:3570--
