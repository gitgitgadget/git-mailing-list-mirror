From: Jean-Luc Herren <jlh@gmx.ch>
Subject: "git rev-parse --git-dir" fails from inside .git/<any-subdir>
Date: Wed, 19 Mar 2008 00:38:28 +0100
Message-ID: <47E05274.3070908@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 22:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5q1-0005me-I5
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937080AbYCSVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbYCSVZN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:25:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:58945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937069AbYCSVZL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:25:11 -0400
Received: (qmail invoked by alias); 18 Mar 2008 23:38:28 -0000
Received: from 72-56.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.56.72]
  by mail.gmx.net (mp003) with SMTP; 19 Mar 2008 00:38:28 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/Pf6dV46PPd6EFgOr0fCNR3RlsAGeNLKXYvpiFlO
	UvK2xhrxOYOHX1
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77554>

Hello list!

I noticed that "git rev-parse --git-dir" doesn't work properly
when called from inside a sub-directory of .git.  It seems
setup_git_directory_gently() is the problem, because it simply
calls chdir("..") until "." is a valid git directory and it then
sets GIT_DIR = ".".  But this relative path only works as long as
you stay in the directory that setup_git_directory_gently() has
put you in.  It won't work when git-sh-setup uses GIT_DIR=$(git
rev-parse --git-dir).

This causes "git repack -a -f" to fail with "Nothing new to pack."
from inside .git/objects/pack, which would be handy to test
different parameters and compare the resulting pack files.

I don't know whether setup_git_directory_gently() or rather
builtin-rev-parse.c needs to be changed, I'll let someone else do
this as I don't know the code base well enough.

jlh
