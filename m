From: Michael Weber <michaelw@foldr.org>
Subject: [BUG] git-svn: does not work with tilde in repo URL
Date: Tue, 22 Apr 2008 11:52:36 +0200
Message-ID: <05652775-37F4-4B5C-8DE1-2BA439814C83@foldr.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 11:53:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFBm-00020R-Nc
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbYDVJwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbYDVJwl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:52:41 -0400
Received: from lambda.foldr.org ([88.198.49.16]:41549 "EHLO mail.foldr.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751672AbYDVJwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:52:40 -0400
Received: from zilver015088.mobiel.utwente.nl (zilver015088.mobiel.utwente.nl [130.89.15.88])
	(authenticated bits=0)
	by mail.foldr.org (8.14.2/8.14.2/Debian-3) with ESMTP id m3M9qaK8005986
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 22 Apr 2008 11:52:38 +0200
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80090>

git svn does not work for me when tilde (~ or %7E) is present in a svn  
repository URL.  Everything works as expected when I export the same  
repository on a URL without ~.

Test case 1:
% git svn clone -s --username michaelw http://svn.example.com/~michaelw/project/
Initialized empty Git repository in .git/
Using higher level of URL: http://svn.example.com/~michaelw/project => http://svn.example.com/%7Emichaelw/project
W: Ignoring error from SVN, path probably does not exist: (175002): RA  
layer request failed: REPORT request failed on '/~michaelw/project/! 
svn/bc/32': REPORT of '/~michaelw/project/!svn/bc/32': 200 OK (http://svn.example.com 
)
W: Do not be alarmed at the above message git-svn is just searching  
aggressively for old history.
This may take a while on large repositories
Path 'http:' was probably deleted:
RA layer request failed: REPORT request failed on '/~michaelw/project/! 
svn/bc/32': REPORT of '/~michaelw/project/!svn/bc/32': 200 OK (http://svn.example.com 
)
Will attempt to follow revisions r0 .. r32 committed before the deletion

Two things to note:
* In this case the svn-remote section in .git/config looks wrong, too:
[svn-remote "svn"]
	url = http://svn.example.com/%7Emichaelw/project
	fetch = http://svn.example.com/~michaelw/project/trunk:refs/remotes/trunk
	branches = http:/svn.example.com/~michaelw/project/branches/*:refs/ 
remotes/*
	tags = http:/svn.example.com/~michaelw/project/tags/*:refs/remotes/ 
tags/*

* The line "Path 'http:' was probably deleted:" apparently comes from  
the "http:" prefix in the URL.

Test case 2:
% git svn clone -s --username michaelw http://svn.example.com/%7Emichaelw/project/
Initialized empty Git repository in .git/
Apache got a malformed URI: REPORT request failed on '/~michaelw/ 
project/!svn/vcc/default': Unusable URI: it does not refer to this  
repository at /Users/michaelw/sys/i686-apple-darwin9/bin/git-svn line  
3837

(Both tests are with the patch from <20080418131204.GA53634@roadkill.foldr.org 
 > applied, so git-svn line numbers might be different.)


Cheers,
Michael
