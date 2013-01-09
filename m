From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t7400 broken on pu (Mac OS X)
Date: Wed, 09 Jan 2013 19:43:03 +0100
Message-ID: <50EDBA37.30205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 19:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt0ca-00085h-33
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 19:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab3AISnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 13:43:07 -0500
Received: from mout.web.de ([212.227.17.12]:49631 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292Ab3AISnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 13:43:06 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MEEMy-1TmLhI0stE-00Fa55; Wed, 09 Jan 2013 19:43:04
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Provags-ID: V02:K0:xCB7IpH3yE9pW38dGclQNl6BkbhohX0cttZsJgLAcyW
 ZKu2xO33kYOyDV8TC6TATKXzczwgPLJl4qSO1NEUbCoGDdlcsp
 WweDZ2MYQscYnphff6zv5vdWIcbk0gj5go1qwR0UFX0r6CxDwE
 SrmDHxoX04RWiNeVsCN11cTDLM9GGHEJ8EemxQP42KcWPZX9fZ
 3TCotWK3jiQSi5LUJV7RA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213077>

The current pu fails on Mac OS, case insensitive FS.


Bisecting points out
commit 3f28e4fafc046284657945798d71c57608bee479
[snip]
Date:   Sun Jan 6 13:21:07 2013 +0700

    Convert add_files_to_cache to take struct pathspec

And I veryfied that the preceeding commit 05647d2d8a5dc456d1f4ef73
is OK.

It fails here:
not ok 38 - gracefully add submodule with a trailing slash

A run of a modified t7400 looks like this:
Is there anything more, that I can do to debug this?


[snip]
ok 37 - do not add files from a submodule

expecting success: 

	git reset --hard &&
	echo 1 >&2 &&
	git commit -m "commit subproject" init &&
	echo 2 >&2 &&
	(cd init &&
	echo 3 >&2 &&
	 echo b > a) &&
	echo 4 >&2 &&
	git add init/ &&
	echo 5 >&2 &&
	git diff --exit-code --cached init &&
	echo 6 >&2 &&
	commit=$(cd init &&
	echo 7 >&2 &&
	 git commit -m update a >/dev/null &&
	echo 8 >&2 &&
	 git rev-parse HEAD) &&
	echo 9 >&2 &&
	git add init/ &&
	echo 10 >&2 &&
	test_must_fail git diff --exit-code --cached init &&
	echo 11 >&2 &&
	test $commit = $(git ls-files --stage |
		sed -n "s/^160000 \([^ ]*\).*/\1/p")


HEAD is now at 57f2622 super commit 1
1
[second 1b8c63f] commit subproject
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
2
3
4
5
6
7
8
9
10
test_must_fail: command succeeded: git diff --exit-code --cached init
not ok 38 - gracefully add submodule with a trailing slash
