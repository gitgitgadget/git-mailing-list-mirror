Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8730F202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdCGNr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 08:47:26 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:48845 "EHLO
        quickstop.soohrt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdCGNrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 08:47:25 -0500
Received: (qmail 7426 invoked by uid 1014); 7 Mar 2017 13:45:43 -0000
Date:   Tue, 7 Mar 2017 12:03:28 +0100
From:   Horst Schirmeier <horst@schirmeier.com>
To:     git@vger.kernel.org
Subject: regression: git push in non-shared repo stalls (v2.11.0+)
Message-ID: <20170307110328.GE7566@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I observe a regression that seems to have been introduced between
v2.10.0 and v2.11.0.  When I try to push into a repository on the local
filesystem that belongs to another user and has not explicitly been
prepared for shared use, v2.11.0 shows some of the usual diagnostic
output and then freezes instead of announcing why it failed to push.

Horst

Steps to reproduce (tested on Debian 8 "Jessie" amd64):
 -  User A creates a bare repository:
    mkdir /tmp/gittest
    git init --bare /tmp/gittest
 -  User B clones it, adds and commits a file:
    git clone /tmp/gittest
    cd gittest
    echo 42 > x
    git add x
    git commit -m test
 -  User B tries to push to user A's bare repo:
    git push

Expected result (git v2.10.0 and earlier):
test@ios:~/gittest$ git push
Counting objects: 3, done.
Writing objects: 100% (3/3), 230 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: error: insufficient permission for adding an object to repository database objects
remote: fatal: failed to write object
error: unpack failed: unpack-objects abnormal exit
To /tmp/gittest
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to '/tmp/gittest'

Actual result (git v2.11.0, v2.12.0, and 2.12.0.189.g3bc53220c):
test@ios:~/gittest$ git push
Counting objects: 3, done.
Writing objects: 100% (3/3), 230 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
[... git freezes here ...]

-- 
PGP-Key 0xD40E0E7A
