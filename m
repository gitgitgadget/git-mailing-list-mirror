From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PROBLEM] Checkout from cloned repository does not work
Date: Fri, 2 Sep 2005 14:20:32 +0300
Message-ID: <84144f0205090204201f74e425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Sep 02 13:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB9b6-0002R7-8S
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 13:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVIBLUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 07:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVIBLUg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 07:20:36 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:3270 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751136AbVIBLUg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 07:20:36 -0400
Received: by nproxy.gmail.com with SMTP id x37so198899nfc
        for <git@vger.kernel.org>; Fri, 02 Sep 2005 04:20:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OPCs19NsVy5UxrF9AYvb+VhDUKsNBWNl8IWaHAY3RknAiWF5JbByMUDmQeXdki1JVwOuPTNBB7E6AwQXSt1L273uPTJB8nSg/j79jVnWnAc2oT75x//kvuN8F4PyAuKp0IK4yGzHlBj38NTERJTa+drizPReleIgehYjreJB414=
Received: by 10.49.5.17 with SMTP id h17mr152953nfi;
        Fri, 02 Sep 2005 04:20:32 -0700 (PDT)
Received: by 10.48.157.17 with HTTP; Fri, 2 Sep 2005 04:20:32 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8020>

Hi,

I cannot checkout from a cloned git repository I have created. I am
using git 0.99.5 from Gentoo portage.

Following the tutorial, I create new git repository:

  $ mkdir git-test
  $ cd git-test/
  $ git-init-db
  defaulting to local storage area
  $ echo "Hello, Git" > hello
  $ git-update-cache --add hello
  $ git-write-tree
  4bd2134df7a908d2764f70d155e32650954cfc72
  $ echo "Initial commit" | git-commit-tree
4bd2134df7a908d2764f70d155e32650954cfc72 > .git/HEAD
  Committing initial tree 4bd2134df7a908d2764f70d155e32650954cfc72

Now on the server, I create a repository:

  $ mkdir git-test.git
  GIT_DIR=git-test.git/ git-init-db

Then I push my local repository to remote server like this:

  $ git push ssh.remote.server:/home/penberg/public_html/git-test.git master
  Password:
  updating 'refs/heads/master'
    from 0000000000000000000000000000000000000000
    to   8744316e49411509ba28e9cf567f3aec5833ec74
  Packing 3 objects
  Unpacking 3 objects
   100% (3/3) done
  refs/heads/master: 0000000000000000000000000000000000000000 ->
8744316e49411509ba28e9cf567f3aec5833ec74

After which I clone the newly created repository like this:

  $ git clone http://www.remote.server/~penberg/git-test.git cloned
  defaulting to local storage area
  Somebody should define smarter http server protocol

Now, the problem is that checkout does not work:

  $ git checkout
  usage: git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])

That's because I have no HEAD:

  $ ls -l .git/HEAD
  lrwxrwxrwx  1 penberg users 17 Sep  2 14:07 .git/HEAD -> refs/heads/master

  $ ls -l .git/refs/heads/
  total 0

What am I doing wrong here? Doing a git pull causes the following error:

  $ git pull http://www.remote.server/~penberg/git-test.git
  Fetching HEAD from http://www.remote.server/~penberg/git-test.git using http
  got 8744316e49411509ba28e9cf567f3aec5833ec74
  got 4bd2134df7a908d2764f70d155e32650954cfc72
  got b7aec520dec0a7516c18eb4c68b64ae1eb9b5a5e
  * committish: 8744316e49411509ba28e9cf567f3aec5833ec74  HEAD from
http://www.remote.server/~penberg/git-test.git
  cat: .git/HEAD: No such file or directory
  fatal: Needed a single revision
  git-resolve-script <head> <remote> <merge-message>

                                       Pekka
