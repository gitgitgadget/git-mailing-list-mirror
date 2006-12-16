X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 10:44:37 -0800
Message-ID: <45843E95.2000101@midwinter.com>
References: <458437E0.1050501@midwinter.com> <em1e1v$lse$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 18:44:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <em1e1v$lse$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34633>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GveWM-0000Pz-FU for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161354AbWLPSo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWLPSo0
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:44:26 -0500
Received: from tater.midwinter.com ([216.32.86.90]:35299 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1161354AbWLPSoZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 13:44:25 -0500
Received: (qmail 1961 invoked from network); 16 Dec 2006 18:44:25 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 16 Dec 2006 18:44:25
 -0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Works if you use "git mv dir dir.real".
>   

This came up during my testing of snapshot backups. The *real* sequence 
is more like

$ git checkout -b new-snapshot
$ rsync /live/directory .
$ git add .

In other words, I don't know in advance that there's a rename or (short 
of turning on verbose rsync output and parsing it) which parts of the 
tree have changed at all. So I can't easily use git-mv here.

It still feels like a bug that "git add" can fail with no useful 
diagnostic. It actually took me a fair while to figure out what was 
going on here -- at first I thought it was having trouble with symlinks 
in general, then with absolute-path symlinks (which the actual symlink 
in question is), then I thought maybe it was a corrupt index. It wasn't 
until I went back and looked at the previous snapshot that I was 
overlaying this one on top of that I realized there used to be a 
directory where that symlink lives now.

