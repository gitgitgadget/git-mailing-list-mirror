X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Non-ASCII paths and git-cvsserver
Date: Thu, 09 Nov 2006 12:11:42 +0100
Message-ID: <45530CEE.6030008@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 11:13:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 72
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31196>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi7q0-0003jY-G0 for gcvg-git@gmane.org; Thu, 09 Nov
 2006 12:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932802AbWKILMt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 06:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWKILMt
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 06:12:49 -0500
Received: from main.gmane.org ([80.91.229.2]:48273 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932802AbWKILMs (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 06:12:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gi7pc-0003fl-8Y for git@vger.kernel.org; Thu, 09 Nov 2006 12:12:28 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 12:12:28 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 09
 Nov 2006 12:12:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I want to access a git repository via git-cvsserver. The problem is that 
the repository contains paths with umlauts. These paths come out quoted 
and escaped when checked out with cvs.

Test case:

#! /bin/sh

set -e -u -x

WORK='/tmp/gittest'
FILE=$'\303\244'

mkdir "${WORK}"
mkdir "${WORK}/git"

#trap 'rm -r "${WORK}"' EXIT

cd "${WORK}/git"

git init-db
git repo-config gitcvs.enabled 1
git repo-config gitcvs.logfile "${WORK}/git/.git/cvslog.txt"

touch "${FILE}"
git add "${FILE}"
git commit -a -mx

cd "${WORK}"

CVS_SERVER='git-cvsserver'
export CVS_SERVER

cvs -d ":fork:${WORK}/git/.git" co master

ls master

### end


This is what I get:

+ WORK=/tmp/gittest
+ FILE=$'\303\244'
+ mkdir /tmp/gittest
+ mkdir /tmp/gittest/git
+ cd /tmp/gittest/git
+ git init-db
defaulting to local storage area
+ git repo-config gitcvs.enabled 1
+ git repo-config gitcvs.logfile /tmp/gittest/git/.git/cvslog.txt
+ touch $'\303\244'
+ git add $'\303\244'
+ git commit -a -mx
Committing initial tree 23d6145738bba135994775c19d6e8ae707d399ee
+ cd /tmp/gittest
+ CVS_SERVER=git-cvsserver
+ export CVS_SERVER
+ cvs -d :fork:/tmp/gittest/git/.git co master
cvs checkout: Updating master
U master/"\303\244"
+ ls master
"\303\244"  CVS


I do not speak perl so can anyone help?

Regards

Stephan
