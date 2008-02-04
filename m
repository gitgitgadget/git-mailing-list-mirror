From: Anand Kumria <wildfire@progsoc.org>
Subject: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Mon, 4 Feb 2008 18:25:25 +0000 (UTC)
Message-ID: <pan.2008.02.04.18.25.26@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 19:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM61I-0002o1-Rk
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbYBDSZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYBDSZl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:25:41 -0500
Received: from main.gmane.org ([80.91.229.2]:38435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbYBDSZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:25:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JM60c-0008SC-2f
	for git@vger.kernel.org; Mon, 04 Feb 2008 18:25:34 +0000
Received: from 82-68-18-158.dsl.in-addr.zen.co.uk ([82.68.18.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 18:25:34 +0000
Received: from wildfire by 82-68-18-158.dsl.in-addr.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 18:25:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82-68-18-158.dsl.in-addr.zen.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72539>


Hi,

Having recently upgraded to git-core 1.5.4, I seen to have stumbled onto 
a regression.

$ git --version
git version 1.5.4

$ cat .git/config
{{ ... }}
[remote "richard"]
    url = https://server.example.com/~richard/newfoo.git
    fetch = +refs/heads/*:refs/remotes/richard/*

$ git fetch richard
error:  (curl_result = 77, http_code = 0, sha1 = 
0bc27e5162d0e74053b71fc637cbbf8fc942e969)
Getting pack list for https://server.example.com/~richard/newfoo.git
error:
Getting alternates list for https://server.example.com/~richard/newfoo.git
error: Unable to find 0bc27e5162d0e74053b71fc637cbbf8fc942e969 under 
https://server.example.com/~richard/newfoo.git
Cannot obtain needed object 0bc27e5162d0e74053b71fc637cbbf8fc942e969
fatal: Fetch failed.

But:


$ git clone https://server.example.com/~richard/newfoo.git
Initialized empty Git repository in /home/anand/projects/newfoo/.git/
Getting alternates list for https://server.example.com/~richard/newfoo.git
Getting pack list for https://server.example.com/~richard/newfoo.git
Getting index for pack 4b4ae2516826a864230a1e2e83e3cf900e7dbbb3
Getting index for pack 28255a0fb8b9369afe9b46b79164de160c0c532d
Getting index for pack a43ad1dff20585c7f903f498c65260a26cf57a3c
Getting index for pack 78e01c912dc4987099c40a68cbb741cb69365522
Getting index for pack ee32d85b391fda784dd5afccb22434746f112acc
Getting pack a43ad1dff20585c7f903f498c65260a26cf57a3c
 which contains 12daf1b07314589a93c2e3dbe7cb0a2f3074f4af
walk 12daf1b07314589a93c2e3dbe7cb0a2f3074f4af
walk 15542942acf5021eb911ee80a8c89f7c2bdb471e
walk cf3558da086dccc24c76c371917df73c0cfd1b6f
Getting pack 4b4ae2516826a864230a1e2e83e3cf900e7dbbb3
 which contains c761504e5e08c9111a819a4a707d86f860a24afa
Getting pack 28255a0fb8b9369afe9b46b79164de160c0c532d
 which contains df0eb371252791a066a3ebdd7feeb445245fcb80
walk 1496f6f7ffc39f44a1dc26584baf68c4b62ebfb5
[snip]
walk bce69a02c5ea897a4a1302cb603a74d9f19afa9f
walk 7bec5801836ee2b2486093da74deee0b39e693c3
got 0bc27e5162d0e74053b71fc637cbbf8fc942e969
walk 0bc27e5162d0e74053b71fc637cbbf8fc942e969
[snip]
Getting alternates list for https://server.example.com/~richard/newfoo.git
got e7ddd78769bf781707c2fed5e6b9c3c8d827b89b
walk e326801f90a554bc0af089c8a7afffa45662fd7d
Getting pack list for https://server.example.com/~richard/newfoo.git
Getting pack 78e01c912dc4987099c40a68cbb741cb69365522
 which contains 0da3b81806aa51d854f06c4a61fe45dafbdc66d3
[snip
got ac162a07d389e110aa6725e4ef2a3eedc42f05bd
got 227139e3eef336917f8a50aba06cd5e172608899


Downgrading to git-core in Debian (1.5.3.8) and it works perfectly.

$ git fetch richard
Fetching refs/heads/master from https://server.example.com/~richard/
newfoo.git using https
Fetching refs/heads/master-richard from https://server.example.com/
~richard/newfoo.git using https
got 0bc27e5162d0e74053b71fc637cbbf8fc942e969
walk 0bc27e5162d0e74053b71fc637cbbf8fc942e969
got bb7bfc531acee412ea945928073fadef5eba0fb4
got 1223925015090bad2b4b4e3cc0524a23a9bd644c
got 785e2d3d4f9834cf9c5c81d89d590c82d82c032c
* refs/remotes/richard/master-richard: fast forward to branch 'master-
richard' of https://server.example.com/~richard/newfoo
  old..new: e326801..0bc27e5
Fetching refs/heads/resellers from https://server.example.com/~richard/
newfoo.git using https

Suggestions?

Anand
