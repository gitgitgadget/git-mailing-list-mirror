X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: git-add fails after file type change
Date: Sat, 16 Dec 2006 10:16:00 -0800
Message-ID: <458437E0.1050501@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 18:16:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34629>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gve5R-00068S-Cf for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161334AbWLPSQD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 13:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWLPSQC
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:16:02 -0500
Received: from tater.midwinter.com ([216.32.86.90]:34957 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1161331AbWLPSQA
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 13:16:00 -0500
Received: (qmail 1215 invoked from network); 16 Dec 2006 18:15:48 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 16 Dec 2006 18:15:48
 -0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

In the course of experimenting with using git for my snapshot backups, I 
ran into what looks like a bug in git-add: it croaks when it tries to 
add a file whose type has changed, specifically when a directory gets 
moved and a symbolic link is put in the old location pointing to the new 
one. Here's a simple test case:

$ git init-db
defaulting to local storage area
$ mkdir dir
$ echo foo > dir/file
$ git add .
$ git commit -m "initial commit" -a
Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
 create mode 100644 dir/file
$ mv dir dir.real
$ ln -s dir.real dir
$ git add .
fatal: unable to add dir to index

Is "git add ." the wrong thing to do here? I have been using it as a 
generic "pick up all the files I haven't added yet" command. Or is this 
a bug?

For what it's worth, "git update-index dir" and "git update-index --add 
dir" both fail too.

