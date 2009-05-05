From: "Kana Natsuno" <kana@whileimautomaton.net>
Subject: Two problems on alias of git
Date: Tue, 05 May 2009 21:42:04 +0900
Message-ID: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 14:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1JyW-00060W-BE
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 14:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZEEMmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbZEEMmN
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 08:42:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:34698 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbZEEMmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 08:42:11 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2046685rvb.5
        for <git@vger.kernel.org>; Tue, 05 May 2009 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=Lh/TCjpAHaO+iCoZi6k96CMqEOSyqjBpTJTPR++Iz+I=;
        b=nOfU2ldFj6lTPW4ZC7f0wESLq9sBBPRyaolvkhGsmRvn2kPyWZwRj1O0/YGBWU/b3n
         hATeV8C7fkAQ+5/lVp6O4JwRj5b7TtiwOrQ4MiaKc0yPBzMovbTO6jf7jzlJIAwngkvu
         CXmlBN6amY2kyDVM60Pr1UHWRwHRqDnjQHAXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=cngzUSpcadmvBRodtpecmvT2MJ7kooQDro8Crsifx+0HPAKEQmJSsvwBo2vUbDlWjL
         /Xzq7hux5qQNX6OShWRSwdr6E28qHTXR7jx4N3arqKPpu12jh5hT+VqOC7eHrn6cu/BX
         KF06j0U2y72nSyM5jyjFAI2Ss1utdho22pqdw=
Received: by 10.141.12.15 with SMTP id p15mr5797rvi.170.1241527331198;
        Tue, 05 May 2009 05:42:11 -0700 (PDT)
Received: from i220-99-253-139.s27.a098.ap.plala.or.jp (i220-99-253-139.s27.a098.ap.plala.or.jp [220.99.253.139])
        by mx.google.com with ESMTPS id l31sm4840274rvb.59.2009.05.05.05.42.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 05:42:10 -0700 (PDT)
User-Agent: Opera Mail/9.63 (MacIntel)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118293>

Hello.  I found 2 problems on alias of git.


The first one is that git crashes with the following situation.
Without GIT_TRACE, everthing works well.  But with GIT_TRACE=1,
git crashes every time.

---- 8< ---- 8< ---- 8< ---- 8< ---- 8< ----
$ git remote show origin
* remote origin
  URL: git://repo.or.cz/git.git
  Remote branch merged with 'git pull' while on branch master
    master
  Tracked remote branches
    html
    maint
    man
    master
    next
    pu
    todo

$ git --version
git version 1.6.2.rc0.90.g0753

$ git show HEAD | grep commit
commit 3536ae331014c68a25c80b3fb530a19c8dee0f11

$ uname -a                   
Darwin foobarbaz 9.6.1 Darwin Kernel Version 9.6.1: Sun Dec 21 19:45:33 PST 2008; root:xnu-1228.9.75~4/RELEASE_I386 i386 i386 MacBook5,2 Darwin

$ git config --get alias.l1
log --pretty=oneline

$ GIT_TRACE=1 git l1         
trace: exec: 'git-l1'
trace: run_command: 'git-l1'
trace: exec 'git-l1' failed: No such file or directory
[1]    41772 segmentation fault  GIT_TRACE=1 git l1
---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ----


The second one is that git doesn't expand a kind of aliases
properly, especially with double quotation marks (").  I used the
following alias recently to list the last 10 commits on HEAD:

[alias]
        lr = !git l1 | head | tac

Then I want to extend this alias to list the last N commits on
a branch with "git lr 20", "git lr master", "git lr master 20",
etc.  So that I wrote the following definition (note that the
actual definition is written in a single line, though the quoted
definition is folded in multiple lines for readability):

[alias]
        lr = !$SHELL -c '
                n=10;
                1="${1:-$n}";
                if ! [ "${1##[0-9]*}" = "" ]; then
                  t="$1";
                  1="${2:-$n}";
                  2="$t";
                fi;
                git --no-pager l1 --reverse -"$1" "${2:-HEAD}"
              ' __dummy__

But it doesn't work because git expands as follows:

$ git config --get alias.lr
!$SHELL -c '1=${1:-10}

Double quotation marks (") are removed and the aliased string is
cut at a random position.  I expect that the aliased string is
passed to system() as-is, but git doesn't so.  Why does git behave
so?  Is it a bug or an intentional behavior?


-- 
To Vim, or not to Vim.
http://whileimautomaton.net/
