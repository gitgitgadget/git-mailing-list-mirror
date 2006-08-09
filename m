From: Jakub Narebski <jnareb@gmail.com>
Subject: Strange output of git-diff-tree
Date: Wed, 09 Aug 2006 15:24:54 +0200
Organization: At home
Message-ID: <ebcnml$btf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 15:25:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAo3S-0007sk-04
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 15:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWHINY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHINY6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 09:24:58 -0400
Received: from main.gmane.org ([80.91.229.2]:698 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750770AbWHINY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 09:24:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAo3H-0007qQ-OU
	for git@vger.kernel.org; Wed, 09 Aug 2006 15:24:51 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 15:24:51 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 15:24:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25121>

First (noticed by matled) is that for git-diff-tree with single tree
as an argument it outputs fist commit-id of commit given at input. 
It is not mentioned in documentation and I think totally unnecessary:

1038:jnareb@roke:~/git> git diff-tree --abbrev origin
d5dc6a76d49367cddc015e01d2e9aa22e64d7e28
:040000 040000 44fb36d... 1c26294... M  Documentation


Second, for some combination of options for it returns "..." instead of
0{40} for file creation. It seems that the culprit is "--find-copies-harder"
option:

1043:jnareb@roke:~/git> git rev-list --full-history next | \
 git diff-tree --find-copies-harder -B -C -M -r --full-history --stdin \
 -- gitweb/gitweb.perl gitweb/gitweb.cgi gitweb.cgi | less | grep " A"
:000000 100755 ... 017664b8f440f5ec151cf5653245ee02aefd3db2 A   gitweb.cgi

1047:jnareb@roke:~/git> git rev-list --full-history next | \
 git diff-tree -B -C -M -r --stdin \
 -- gitweb/gitweb.perl gitweb/gitweb.cgi gitweb.cgi | less | grep " A"
:000000 100755 0000000000000000000000000000000000000000 017664b8f440f5ec151cf5653245ee02aefd3db2 A     gitweb.cgi


Third, while it detects that gitweb/gitweb.perl was renamed from 
gitweb/gitweb.cgi:
  [...]  R100   gitweb/gitweb.cgi       gitweb/gitweb.perl
it does not notice that gitweb/gitweb.cgi was gitweb.cgi in 
1130ef362fc8d9c3422c23f5d5a833e93d3f5c13.


All those for git version 1.4.1.1

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
