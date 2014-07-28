From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 11:18:04 +0100
Message-ID: <53D6235C.90608@ramsay1.demon.co.uk>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:18:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBi0V-0001mI-LK
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaG1KSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:18:11 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:42550 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbaG1KSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:18:10 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 4A78038407C;
	Mon, 28 Jul 2014 09:40:31 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 02806384089;
	Mon, 28 Jul 2014 09:40:31 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Mon, 28 Jul 2014 09:40:30 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254289>

On 28/07/14 10:42, Bryan Turner wrote:
> Using git diff-tree --stdin on 2.0.2 and 2.0.3 produces incorrect
> commit messages.
> 
> Here's an example to reproduce the issue:
> 
> bturner@ubuntu:/tmp$ git init --bare test.git
> Initialized empty Git repository in /tmp/test.git/
> bturner@ubuntu:/tmp$ git clone test.git
> Cloning into 'test'...
> warning: You appear to have cloned an empty repository.
> done.
> bturner@ubuntu:/tmp$ cd test
> bturner@ubuntu:/tmp/test$ echo "Hello" > file.txt
> bturner@ubuntu:/tmp/test$ git add file.txt
> bturner@ubuntu:/tmp/test$ git commit -m "Initial commit"
> [master (root-commit) c5e16f3] Initial commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 file.txt
> bturner@ubuntu:/tmp/test$ echo "World" >> file.txt
> bturner@ubuntu:/tmp/test$ git commit -am "Second commit"
> [master 9214ac7] Second commit
>  1 file changed, 1 insertion(+)
> bturner@ubuntu:/tmp/test$ git push origin HEAD
> Counting objects: 6, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (6/6), 446 bytes | 0 bytes/s, done.
> Total 6 (delta 0), reused 0 (delta 0)
> To /tmp/test.git
>  * [new branch]      HEAD -> master
> bturner@ubuntu:/tmp/test$ cd ../test.git/
> bturner@ubuntu:/tmp/test.git$ git rev-list -1
> --format="%H|%h|%P|%p|%aN|%aE|%at%n%B%n" 9214ac7
> commit 9214ac79728424a971244c34432c6d948754198d
> 9214ac79728424a971244c34432c6d948754198d|9214ac7|c5e16f37164f1b7411685def64d7390775437f07|c5e16f3|Bryan
> Turner|bturner@atlassian.com|1406539558
> Second commit
> 
> 
> bturner@ubuntu:/tmp/test.git$ /opt/git/2.0.3/bin/git diff-tree
----------------------------------------^^^^^^^

You appear to have used v2.0.3 on both invocations of diff-tree
(see also below); cut-n-paste error?

> --no-renames --always --format="commit
> %H%n%H|%h|%P|%p|%aN|%aE|%at|%B%n" --root
> 9214ac79728424a971244c34432c6d948754198d
> commit 9214ac79728424a971244c34432c6d948754198d
> 9214ac79728424a971244c34432c6d948754198d|9214ac79728424a971244c34432c6d948754198d|c5e16f37164f1b7411685def64d7390775437f07|c5e16f37164f1b7411685def64d7390775437f07|Bryan
> Turner|bturner@atlassian.com|1406539558|Second commit
> 
> 
> 
> :100644 100644 e965047ad7c57865823c7d992b1d046ea66edf78
> f9264f7fbd31ae7a18b7931ed8946fb0aebb0af3 M    file.txt
> bturner@ubuntu:/tmp/test.git$ /opt/git/2.0.3/bin/git diff-tree
> --no-renames --always --format="commit
> %H%n%H|%h|%P|%p|%aN|%aE|%at|%B%n" --root --stdin
> --9214ac79728424a971244c34432c6d948754198d
> commit 9214ac79728424a971244c34432c6d948754198d
> 9214ac79728424a971244c34432c6d948754198d|9214ac79728424a971244c34432c6d948754198d|c5e16f37164f1b7411685def64d7390775437f07|c5e16f37164f1b7411685def64d7390775437f07|Bryan
> Turner|bturner@atlassian.com|1406539543|Initial commit
---------------------------------------^^

The timestamp is also different than the above.

> 
> 
> 
> :100644 100644 e965047ad7c57865823c7d992b1d046ea66edf78
> f9264f7fbd31ae7a18b7931ed8946fb0aebb0af3 M    file.txt
> bturner@ubuntu:/tmp/test.git$
> 
> Running a git bisect between v2.0.1, which does not manifest this
> issue, and v2.0.2 fingers the following commit:
> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
> c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0 is the first bad commit
> commit c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0
> Author: Jeff King <peff@peff.net>
> Date:   Tue Jun 10 17:43:02 2014 -0400
> 
>     commit: convert commit->buffer to a slab
> 

ATB,
Ramsay Jones
