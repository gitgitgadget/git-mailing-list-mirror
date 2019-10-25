Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918AE1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 10:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408888AbfJYKRb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 06:17:31 -0400
Received: from gate3.osm-gmbh.de ([194.77.68.107]:51328 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408990AbfJYKRb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 06:17:31 -0400
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id 38E2E3C108;
        Fri, 25 Oct 2019 12:17:26 +0200 (CEST)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id 2D5143DC01E;
        Fri, 25 Oct 2019 12:17:26 +0200 (CEST)
Date:   Fri, 25 Oct 2019 12:17:26 +0200 (CEST)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: missing tags from "git fetch"
In-Reply-To: <20191002135518.GA3599@sigill.intra.peff.net>
Message-ID: <alpine.LSU.2.20.1910251150411.2754@cpza.bfz-tzou.qr>
References: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr> <20191002135518.GA3599@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1707157324-1905239275-1571998646=:2754"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1707157324-1905239275-1571998646=:2754
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi!

On Wednesday 2019-10-02 15:55, Jeff King wrote:
> It's a documentation bug, I think. We won't auto-follow tags when
> fetching into FETCH_HEAD (but this is further confused by the fact that
> fetching into FETCH_HEAD will auto-update a tracking ref).
>
> So instead of this:
>
>> $ git fetch origin master
>
> try this:
>
>  $ git fetch origin
>
> or even this:
>
>  $ git fetch origin master:refs/remotes/origin/master

I thought it would work, but it works only once. On the second time the 
ref for the remote branch is deleted. It seems git is confused by 
specifying a ref it expect to manage itself.

Is there any other way to force auto-follow tags? If there is no sane 
way, I have to create a throwawy branch and delete it immediately.

=====================================================
$ git fetch origin master:refs/remotes/origin/master
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From /tmp/r1
  * [new branch]            master     -> origin/master
  * [new tag]               t1         -> t1
  * [new tag]               t2         -> t2
$ ls .git/refs/remotes/origin
master
$ git fetch origin master:refs/remotes/origin/master
From /tmp/r1
  - [deleted]               (none)     -> origin/master
$ ls .git/refs/remotes/origin
/bin/ls: cannot access .git/refs/remotes/origin: No such file or directory
$ git fetch origin master:refs/remotes/origin/master
From /tmp/r1
  * [new branch]            master     -> origin/master
$ ls .git/refs/remotes/origin
master
$ git --version
git version 2.23.0
=====================================================

Best regards
Martin Nicolay

-- 
_______________________________________________________________________________
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
--1707157324-1905239275-1571998646=:2754--
