X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 08:54:38 -0500
Message-ID: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 13:55:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33578>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsJiA-0001BB-7j for gcvg-git@gmane.org; Thu, 07 Dec
 2006 14:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032236AbWLGNyr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 08:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032237AbWLGNyr
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 08:54:47 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:37505 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1032236AbWLGNyq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 08:54:46 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id CE0EF1FFCECA for
 <git@vger.kernel.org>; Thu,  7 Dec 2006 13:54:42 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When I pulled the most recent changes for git (de51faf), `make` began  
failing with the following messages:

make -C perl PERL_PATH='/usr/bin/perl' prefix='/usr/local/stow/git' all
Makefile out-of-date with respect to Makefile.PL /System/Library/Perl/ 
5.8.6/darwin-thread-multi-2level/Config.pm /System/Library/Perl/5.8.6/ 
darwin-thread-multi-2level/CORE/config.h
Cleaning current config before rebuilding Makefile...
mv: rename perl.mak to perl.mak.old: No such file or directory
make[1]: *** [perl.mak] Error 1
make: *** [all] Error 2

My system is (OS 10.4.8):

$ uname -a
Darwin 127.0.0.1 8.8.1 Darwin Kernel Version 8.8.1: Mon Sep 25  
19:42:00 PDT 2006; root:xnu-792.13.8.obj~1/RELEASE_I386 i386 i386
$ fink --version
Package manager version: 0.25.2
Distribution version: 0.8.1.rsync i386
$ cat config.mak
prefix=/usr/local/stow/git
COLLISION_CHECK=y
NO_DARWIN_PORTS=y

I started trying to use `git bisect` and after several attempts (I  
eventually learned the correct pattern of `rm perl/Makefile` and `git  
reset --hard`) I found out that the error began with

commit f848718a6980ebda0eb5afb2ca49c3bc1e7b2b1d
Author: Alex Riesen <raa.lkml@gmail.com>
Date:   Mon Dec 4 10:50:04 2006 +0100

     Make perl/ build procedure ActiveState friendly.

     On Cygwin + ActivateState Perl, Makefile generated with
     MakeMaker is not usable because of line-endings and
     back-slashes.

     This teaches perl/Makefile to write a handcrafted equivalent
     perl.mak file with 'make NO_PERL_MAKEMAKER=NoThanks'.

     Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
     Signed-off-by: Junio C Hamano <junkio@cox.net>

I'll admit that I'm not savvy enough with make and perl to figure out  
how to correct it, although `git revert f84871` does fix it.  Can  
anyone help?

