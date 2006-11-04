X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with git-apply?
Date: Sat, 04 Nov 2006 10:26:13 +0100
Organization: At home
Message-ID: <eihmas$8sj$1@sea.gmane.org>
References: <20061104072349.GA19667@cubit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 4 Nov 2006 09:26:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 50
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30910>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgHn1-00047C-E8 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 10:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964913AbWKDJ0I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 04:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWKDJ0H
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 04:26:07 -0500
Received: from main.gmane.org ([80.91.229.2]:17854 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S964913AbWKDJ0F (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 04:26:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GgHmm-00044d-7x for git@vger.kernel.org; Sat, 04 Nov 2006 10:25:56 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 10:25:56 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 04 Nov 2006
 10:25:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kevin Shanahan wrote:

> I seem to be having problems using git-apply to apply any patch which
> creates a new file. Unfortunately it's been a few weeks since I last
> used git here locally, but this seems like some behaviour change since
> the last version I was using. I'm currently using version 1.4.3.3 from
> Debian Sid. This little test script demonstrates the problem I'm
> having:
> 
> #!/bin/sh
> 
> mkdir a b repo
> echo foo > b/foo
> diff -urN a b > test.diff

Which produces the following diff:

diff -urN a/foo b/foo
--- a/foo       1970-01-01 01:00:00.000000000 +0100
+++ b/foo       2006-11-04 10:05:04.000000000 +0100
@@ -0,0 +1 @@
+foo
 
> (
>     cd repo
>     echo bar > bar # need something to init the db
>     git init-db
>     git add .
>     git commit -a -m "Test Commit"
> 
>     git apply ../test.diff
>     git commit -a -m "Test Commit (file added)"
> )
> 
> Here, this outputs for me:
> 
> defaulting to local storage area
> Committing initial tree ee314a31b622b027c10981acaed7903a3607dbd4
> error: foo: No such file or directory
> nothing to commit

This I think is a bug, or rather misfeature in git-apply (or at least
inconsistency between GNU diff and git patch format). But if you change
from-file line from "--- a/foo" to "--- /dev/null" then git-apply happily
applies creation patch and creates file.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

