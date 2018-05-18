Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6AD1F51C
	for <e@80x24.org>; Fri, 18 May 2018 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeERSTB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 14:19:01 -0400
Received: from mx2.cribellum.net ([72.18.146.194]:5580 "EHLO mx2.cribellum.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeERSSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 14:18:49 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 May 2018 14:18:49 EDT
X-Src-Sender: (96-70-95-25-static.hfc.comcastbusiness.net) [96.70.95.25]:52270
Received: from [192.168.222.224] (96-70-95-25-static.hfc.comcastbusiness.net [96.70.95.25]) by mx2.cribellum.net with SMTP;
   Fri, 18 May 2018 14:13:11 -0400
To:     git@vger.kernel.org
From:   Nathan Bush <nathan@newshubmedia.com>
Subject: --diff-filter could use option for pre-rename files
Message-ID: <278e5e56-f031-5e84-67ac-315b38f1b64c@newshubmedia.com>
Date:   Fri, 18 May 2018 14:13:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Exim-Id: 278e5e56-f031-5e84-67ac-315b38f1b64c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been trying to hook together a build script and a GIT repo.

At one points it makes the following calls:

git diff --find-copies-harder --find-renames=101% --name-only 
--diff-filter=ACMRT 'refs/tags/0.0.25' 'refs/tags/0.0.27' > modified.txt
git diff --find-copies-harder --find-renames=101% --name-only 
--diff-filter=D 'refs/tags/0.0.25' 'refs/tags/0.0.27' > deleted.txt

If a file was renamed, but otherwise unchanged (and needs to be deleted 
by the build script), the files' original name does not appear on either 
list. Or, as far as I can tell, at all.

My current scripted workaround is something like

older = `git ls-tree --name-only --full-tree -r 'refs/tags/0.0.25'`
newer = `git ls-tree --name-only --full-tree -r 'refs/tags/0.0.27'`
deleted = older - newer
(puts deleted in deleted.txt)

Ideally this would just be a diff-filter option, say, --diff-filter=DE

-Nathan Bush

