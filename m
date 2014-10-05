From: Alberto Scotto <scotto.alberto.86@gmail.com>
Subject: [bug] [UX] `stash save --untracked` produces a stash that *looks* empty
Date: Sun, 5 Oct 2014 18:28:45 +0100
Message-ID: <CACsY31pSeijqGC4Rw=q+qAGHJQ+bNibindVReYoZZACvYL7O+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 19:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XapcN-0006xj-W2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 19:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbaJER3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2014 13:29:08 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:63041 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaJER3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 13:29:06 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so2720708oig.33
        for <git@vger.kernel.org>; Sun, 05 Oct 2014 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=VjAxvHhmqmPZxWRNtNTAcZhu90B9LTsdzBjXDkM0H/U=;
        b=ALFICoaNQlqG1NOsfPB3my/X0wNu16j8fLi87Yvda01Ppr/v+Xvd9WuyBe+jRnrSBf
         1OqId2pudul+QL5vUiQb1Gr3FQV45RZL2FLf1RLQ9prZYA61e55ttZgnXHii6xGEGwfp
         bqewssHBadswJ6FH8P86wClnTwlyVdfzY7zuoX0AYQfB8QUNOd0dqsWKv5tdLcDA1rT7
         +A+ROP8IxTAZusJNFuQS4Os55q/PgSzqRXjajRx5VcX9/U0DTUzE+C6pk/SKtmKx+w4e
         ZAjLZHL/pwKulOXcAmXyW/fCPM5RWmwPdlny/yFI54yZGgmqmpFp5xtOX81y19OpdIOw
         n0XA==
X-Received: by 10.182.63.105 with SMTP id f9mr4108498obs.59.1412530145850;
 Sun, 05 Oct 2014 10:29:05 -0700 (PDT)
Received: by 10.76.103.141 with HTTP; Sun, 5 Oct 2014 10:28:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257900>

Hi all,

I've just found that:
- given you have an empty staging area
- and you have only untracked files in your working dir
- when you do `git stash --untracked`
- then `git stash show` gives you an empty output => stash looks empty

My first thought was "oh god, my files are lost!"
Second thought: "Jeez I found a bug in git! cool!"
Then I found that actually `git stash apply` restores the apparently lost
files
So I think it's a UX issue.
It cost me a few lost files already, as I thought "an empty stash? uhm..
can't remember what/when I stashed.. whatever.. let's just delete it and
clean up a little bit this mess of stashes".


Here are the reproducible steps:

   1. create new fresh git repo in $REPO_DIR
   2. create a couple of files/dirs and commit
   3. edit src/MyClass.java and commit
   4. create dir src/new-dir with one file inside
   5. edit file.txt and stage it
   6. stash => stashes staged changes; only untracked files are left
   7. stash -u => stashes untracked changes => working dir is clean
   8. stash list
   9. git stash show -p => empty output
   10. git stash apply (restore stashed untracked files)


I made a bash script that runs through those steps.
Please check it out.
https://gist.github.com/alb-i986/a4002f1ac50ce355278e

Envs:

   - Mac OSX 10.9.5
   - Darwin 13.4.0 Darwin Kernel Version 13.4.0: Sun Aug 17 19:50:11 PDT
      2014; root:xnu-2422.115.4~1/RELEASE_X86_64 x86_64
      - git version 1.9.3 (Apple Git-50)
      - GNU bash, version 3.2.51(1)-release (x86_64-apple-darwin13)
   - Ubuntu precise <-
   https://github.com/alb-i986/vagrantfiles/tree/master/basic
      - Linux precise64 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51
      UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
      - git version 1.7.9.5
      - GNU bash, version 4.2.24(1)-release (x86_64-pc-linux-gnu)


Thank you


Alberto Scotto
http://alb-i986.me
