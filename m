From: r.ductor@gmail.com
Subject: Re: On the behavior of checkout <branch> with uncommitted local changes
Date: Fri, 20 Sep 2013 15:33:01 +0200
Message-ID: <2132571.7BXlKkKRkA@ipht-ia-004976>
References: <8904036.vOg3y5OkbU@ipht-ia-004976> <xmqqfvt0u2q3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 15:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN0mq-0003Je-74
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 15:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3ITNaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 09:30:14 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35351 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3ITNaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 09:30:12 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so543825wid.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=S9UWL7q/O7+tTNhXeWjvp2EM0vtLefznSLjOOcWbwpk=;
        b=nnLEdhtTEjNApf9yFekbZC9Nk54LGiXn7bOiaEfsSSIYt/lkJEVctbXD+wRQADNryu
         zPdPd2TW9XixFqZjPjOBl3p8QCnJ9e7uhXqll91DPRsy2Mq/4ykUzglaMiG+XWGZM0YB
         ORcceIlU/Mznec1/x8FYv3NjAALrIUGWyAuD8XpkV86MASoEdTBEgfG+f+vqbJvfO1ng
         Z3nvFovyQrlWeNtroiPUd+AmkLbahoYzfvt3sGJbddXcGLh4c6snCNMTmcbVwPiwKu7l
         ST4RRV3IVV3BKHQMxX3caJjnLH92ID3HktDlGd1Vmby6hiK++3UVFuWiN9WjhKvW568O
         xnmg==
X-Received: by 10.194.63.228 with SMTP id j4mr6079214wjs.34.1379683811081;
        Fri, 20 Sep 2013 06:30:11 -0700 (PDT)
Received: from ipht-ia-004976.localnet (ipht-ia-004976.extra.cea.fr. [132.166.22.90])
        by mx.google.com with ESMTPSA id d11sm4524108wic.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 06:30:10 -0700 (PDT)
User-Agent: KMail/4.10.5 (Linux/3.10-2-amd64; KDE/4.10.5; x86_64; ; )
In-Reply-To: <xmqqfvt0u2q3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235067>

Dear Junio,

thanks for your answer and you availability to revise the man text. Below my (irreverent) comments

On Thursday 19 September 2013 10:43:16 Junio C Hamano wrote:
> Let's see how we can improve the text.  Points to notice are:
> 
>  * "by updating the index and the files" does not say "how" they are
>    updated and can be clarified:
> 
>     - The index is made to match the state the commit at the tip of
>       <branch> records.
> 
>     - The working tree files without local modifications are updated
>       the same way.
> 
>     - The working tree files with local modifications are not
>       touched.

mmm maybe I'm wrong, but it seems to me that the first statement on the index (above) is oversimplifing and not correct in presence of local changes. In the example below, when in the branch 'dev' the index content was '2 in index' and the workspace content was  '3 in work' and the commited contents dev:a=master:a='1'. In this case checkout completed and the index (and workspace) contents after checkout where preserved, hence the index was different from the head commit in both branches master and dev.

$ echo '1'>a; git init; git add a; git commit -a -m '1';git checkout -b dev;echo '2 in index'>a;git add a; echo '3 in work'>a; git checkout master; cat a; git diff; git diff HEAD 
Initialized empty Git repository in /home/xxxx/git-test12/.git/                                                                 
[master (root-commit) d0064f1] 1                                                                                                       
 1 file changed, 1 insertion(+)                                                                                                        
 create mode 100644 a                                                                                                                  
Switched to a new branch 'dev'                                                                                                         
M       a                                                                                                                              
Switched to branch 'master'                                                                                                            
3 in work                                                                                                                              
diff --git a/a b/a                                                                                                                     
index d35137c..ee9231a 100644                                                                                                          
--- a/a                                                                                                                                
+++ b/a                                                                                                                                
@@ -1 +1 @@                                                                                                                            
-2 in index                                                                                                                            
+3 in work                                                                                                                             
diff --git a/a b/a
index d00491f..ee9231a 100644                                                                                                          
--- a/a                                                                                                                                
+++ b/a                                                                                                                                
@@ -1 +1 @@
-1
+3 in work
$

This is what I ment by  the line "if C1=C0, then: W1=W0 and I1=I0;"

... am I missing something?


>  * Because "the command refuses to checkout another branch under
>    this and that condition" does not have its own section, the
>    description of "-m" needs to say it as a background information
>    to explain in what situation the option may be useful.  It can be
>    moved to the main "'git checkout' <branch>" part and it may make
>    the result read easier.

I 100% agree that the git checkout' <branch> should mention that the command might not complete in some cases, and hopefully describe when. A normal user (me) learning the command tries to first understand the simpler usage before going below and learning the action of the options.

> "in order to preserve your modifications in context" is correct
>   and sufficient description

:((( this is one of the points I considered "vague"... what is "context"? "parent commit" or "parent commit AND index" or "index"? the reader starts to asks theirself too much questions, whose aswers requires an educated guess that should ideally not be necessary when reading a man page....
Maybe I'm to much mathematically minded, but few clean lines of pseudocode explain everything without any doubt.


>    If we allowed such a checkout and then you did "git commit -a",
>    you will end up reverting the state between X0 (contents in your
>    original branch) and X2 (contents in the new branch), even though
>    the change you wanted to make was only the difference between X0
>    and X1.
>    ...

OK I understand your motivations, in your example the contents would have been preserved by checkout, but a shallow user could be then "overchange" by mistake. 

> 
> Also, if you did "git add X" and then "checkout <branch>", unless
> the version in the index at path X match either your original branch
> or the branch you are checking out, the command will stop you, 

... disagree (or misunderstand), if X0=X2 and index = X1 (work) then checkout does not fail, an example would be the example above with 
echo '2 in index'>a; replaced by echo '3 in work'>a.

$ echo '1'>a; git init; git add a; git commit -a -m '1';git checkout -b dev;echo '3 in work'>a;git add a; echo '3 in work'>a; git checkout master; cat a; git diff; git diff HEAD 
Initialized empty Git repository in /home/xxx/git-test13/.git/
[master (root-commit) f8d39d9] 1
 1 file changed, 1 insertion(+)
 create mode 100644 a
Switched to a new branch 'dev'
M       a
Switched to branch 'master'
3 in work
diff --git a/a b/a
index d00491f..ee9231a 100644
--- a/a
+++ b/a
@@ -1 +1 @@
-1
+3 in work
$


... again, sorry if I'm stupidly missing a point or I'm too much irreverent. Any suggestion of references on that would be very welcome.

ric 

PS, BTW, updated in your glossary my statement would be

For each path,  denote by
C0  = its content in the head commit before checkout
I0   = its content in the index before checkout
W0 = its content in the working tree before checkout
C1 = its content in the head commit of the target branch <branch>
W1= its content in working tree after checkout <branch> successfully completed
I1  = its content in index after checkout <branch> successfully completed
then:
if C0=W0=I0,          then: W1=I1=C1;
if C1=I0,                 then: W1=W0 and I1=C1=I0;
if C1=C0,                then: W1=W0 and I1=I0;
otherwise: abort
