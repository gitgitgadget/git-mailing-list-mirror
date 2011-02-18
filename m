From: in-gitvger@baka.org
Subject: Re: git remote repo using http
Date: Fri, 18 Feb 2011 13:40:58 -0500
Message-ID: <201102181840.p1IIewCp027093@no.baka.org>
References: <4D5EAC34.3060504@anorasolutions.com>
Cc: git@vger.kernel.org
To: chris <christian@anorasolutions.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 19:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqVGS-0004L6-FW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 19:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab1BRSlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 13:41:06 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:50323 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab1BRSlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 13:41:05 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p1IIexE1020496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Feb 2011 13:40:59 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p1IIewCp027093;
	Fri, 18 Feb 2011 13:40:58 -0500
In-reply-to: <4D5EAC34.3060504@anorasolutions.com>
Comments: In reply to a message from "chris <christian@anorasolutions.com>" dated "Fri, 18 Feb 2011 11:28:20 -0600."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167223>


    -----------[code]-----------
    $ git clone http://website.com/public_fpt/repos/proj.git
    Cloning into proj ...
    fatal: http://website.com/public_ftp/repos/proj.git/info/refs not found: 
    did you run the git update-server-info on the server?
    -----------[/code]--------------

This is a sign that you are using the dumb http protocol instead of
the new smart one.  You do NOT need to run update-server-info.  You
*are* trying to use the smart protocol (which typically requires web
server reconfiguration), right?

First, make sure you are running a modern version of git.  1.7.4.1
recommended but the smart backend was introduced in 1.6.6

Then check out the web server logs for clues or otherwise strace to
make sure the directory you think it should be using is actually the
directory it is using is good--often times the web server translation
is a bit subtle..

Rerun:

GIT_TRACE=2 GIT_CURL_VERBOSE=1 git clone http://website.com/public_fpt/repos/proj.git

I'll assume fpt is not a misspelled ftp here.

When you `ls` the git directory on the server, do you see the config
and info and objects directory, or do you see something else?

					-Seth Robertson
