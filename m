Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675E51F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfJBNSr (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 09:18:47 -0400
Received: from gate3.osm-gmbh.de ([194.77.68.107]:36254 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBNSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 09:18:47 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 09:18:46 EDT
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id 620273C09D
        for <git@vger.kernel.org>; Wed,  2 Oct 2019 15:10:12 +0200 (CEST)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id 5077D3DC01E
        for <git@vger.kernel.org>; Wed,  2 Oct 2019 15:10:12 +0200 (CEST)
Date:   Wed, 2 Oct 2019 15:10:12 +0200 (CEST)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     git@vger.kernel.org
Subject: missing tags from "git fetch"
Message-ID: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1707157324-1484178433-1570021812=:32588"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1707157324-1484178433-1570021812=:32588
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi!

I don't know if this is a lack of understanding or a software or 
documentation bug.

man git-fetch says about tags:
        By default, any tag that points into the histories being fetched is
        also fetched; the effect is to fetch tags that point at branches that
        you are interested in.

If I fetch without --tags the tags that point to the commits of the 
fetched branch are not fetched. If I fetch with --tags than all tags are 
fetched but I only wish to fetch tags pointing to something in the 
branch fetched.

Here is a self contained example:
--------------------------
$ cd /tmp
$ git init r1 && cd r1
Initialized empty Git repository in /tmp/r1/.git/
$ date >f1
$ git add f1
$ git commit -minitial f1
[master (root-commit) 61753c60ac] initial
  1 file changed, 1 insertion(+)
  create mode 100644 f1
$ git tag -mt1 t1
$ git tag t2
$ git init ../r2 && cd ../r2
Initialized empty Git repository in /tmp/r2/.git/
$ git remote add origin $(cd ../r1; pwd)
$ git fetch origin master
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /tmp/r1
  * branch                  master     -> FETCH_HEAD
  * [new branch]            master     -> origin/master
$ git tag | wc
       0       0       0
$ git fetch --tags origin master
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (1/1), done.
From /tmp/r1
  * branch                  master     -> FETCH_HEAD
  * [new tag]               t1         -> t1
  * [new tag]               t2         -> t2
$ git tag | wc
       2       2       6
$ git rev-parse FETCH_HEAD
61753c60ac550a5315b7c930a701b94f36e08e4f
$ git rev-parse t1^{commit}
61753c60ac550a5315b7c930a701b94f36e08e4f
$ git rev-parse t2^{commit}
61753c60ac550a5315b7c930a701b94f36e08e4f
--------------------------

Obviously the two tags point to the fetched commit but without --tags 
they are not fetched. The behavior is identical for lightweight and 
annotated tags.

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
--1707157324-1484178433-1570021812=:32588--
