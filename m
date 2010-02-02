From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What does git reset do?
Date: Tue, 02 Feb 2010 07:30:11 -0800 (PST)
Message-ID: <m3vdefac6k.fsf@localhost.localdomain>
References: <ron1-A2A2DE.23475601022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKhp-0008Vz-TL
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304Ab0BBPaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:30:16 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:10203 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab0BBPaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:30:14 -0500
Received: by qw-out-2122.google.com with SMTP id 3so35110qwe.37
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EeLCAYq7ul7WPF01WrMSHuCPfruCsFZ5uLwd3dRkQN8=;
        b=Sp/ylZn/a+IeLUMcnp4kakix/UGw2dcyraAWjNPNY9pZHFCmYvqjws/U1ig+VmWJQn
         ZZ+XVjtzRYP5NAfDFerC3YZwhN6VG8wAngY1P/98nZfSuumqtMmY/DCw1oMGEPUO494F
         JsgrwM3AMD0mIxad3Rx3KJmNxnBmpo1NRs0DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HO3Xv+Rs9SJShkaUTlLfF3xu5nNyslkbGqMi+5o/gKTUfBH3V3GNnYCcoNymurWne4
         s1HX0vApJ3jZ7YVIX+pXTvmB0Zwh0GN5/K7qdce/Yydd6kAnl7dAsGPDmA6taohNSL8x
         LCzIylNUZtINU7UPl9UIcpL0IBnhL6u3zgITg=
Received: by 10.102.207.12 with SMTP id e12mr3785135mug.97.1265124613216;
        Tue, 02 Feb 2010 07:30:13 -0800 (PST)
Received: from localhost.localdomain (abvl217.neoplus.adsl.tpnet.pl [83.8.209.217])
        by mx.google.com with ESMTPS id j10sm6433375mue.0.2010.02.02.07.30.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 07:30:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12FTe51013121;
	Tue, 2 Feb 2010 16:29:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12FTNVo013111;
	Tue, 2 Feb 2010 16:29:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ron1-A2A2DE.23475601022010@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138725>

Ron Garret <ron1@flownet.com> writes:

> The docs say that git-reset:
> 
> "Sets the current head to the specified commit..."
> 
> So I tried this:
> 
> 
> [ron@mickey:~/devel/gittest]$ git branch
> * br1
>   master
> [ron@mickey:~/devel/gittest]$ git reset --soft master
> 
> 
> ...expecting HEAD to now point to master.  But it doesn't:

First, 'current head' is what HEAD points to, which means 'br1'
branch.

Second, "git reset --soft master" sets 'br1' branch to _commit_
'master' (commit referenced by 'master' branch).

> 
> 
> [ron@mickey:~/devel/gittest]$ git branch
> * br1
>   master
> [ron@mickey:~/devel/gittest]$ more .git/HEAD 
> ref: refs/heads/br1
> 
> 
> So... what does git reset do?

Let's assume that we have the following situation:


                /-*        <-- branch_A
               /
  *---*---*---*---*---*    <-- branch_B  <--- HEAD

1. $ git checkout branch_A

sets HEAD to branch_A, and sets index and working directory:

                /-*        <-- branch_A  <--- HEAD
               /
  *---*---*---*---*---*    <-- branch_B


2. $ git reset --hard HEAD

sets current branch to commit pointer by branch_A (--soft, --mixed,
--hard), and sets index (--hard and --mixed) and working directory
(--hard):

                   /---------- branch_B  <--- HEAD
                  v

                /-*        <-- branch_A
               /
  *---*---*---*---*---*    

..................................................

Let's assume that we have the following situation:


  *---*---*---a---b---c    <-- branch_A  <--- HEAD
              ^
              |
            v1.0 (tag)


3. $ git checkout v1.0

detaches HEAD:


                /-b---c    <-- branch_A
               /
  *---*---*---a            <--- HEAD
              ^
              |
            v1.0 (tag)


4. $ git reset --hard v1.0

rewinds current branch:

                /-b---c    
               /
  *---*---*---a            <-- branch_A <--- HEAD
              ^
              |
            v1.0 (tag)

Note that commit 'c' might be referenced only by ORIG_HEAD, HEAD@{1}
(reflog for HEAD), and branch_A@{1} (reflog for branch_A); if it is
the case commits 'b' and 'c' would get garbage-collected and removed
eventually.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
