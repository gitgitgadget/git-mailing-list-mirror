X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 22:40:57 +0100
Message-ID: <200610292240.57443.jnareb@gmail.com>
References: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com> <200610292219.21823.jnareb@gmail.com> <4d8e3fd30610291329n7fe59873r87cbee9ccbd4b720@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 21:41:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FQ+mDDGTe9PmeEhx8r5jiH1guwcVUVq+/Z5uWBwMnMgGWYHz/Kf/Mk7v+USQM9f+9/5yhDlouv4GHDxh5EHUD60n3ffp2ng0j0qfrP7e8n9BG8Wiv+en5AjV03YAqlwGQfULTEkLWg4rl97KIvNgs2gDAYsh1sQoy3NFcDXP/Ts=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30610291329n7fe59873r87cbee9ccbd4b720@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30464>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeIOu-0004Fy-1W for gcvg-git@gmane.org; Sun, 29 Oct
 2006 22:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030343AbWJ2Vk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 16:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWJ2Vk7
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 16:40:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:42719 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030343AbWJ2Vk7
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 16:40:59 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1015918ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 13:40:57 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr3098177ugh; Sun, 29 Oct 2006
 13:40:56 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 50sm2091011ugb.2006.10.29.13.40.56; Sun, 29 Oct
 2006 13:40:56 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:
> On 10/29/06, Jakub Narebski <jnareb@gmail.com> wrote:
[...]
>> pull = fetch + merge, so if you pull when you are on your local 'master'
>> branch (and 'master' branch is first in the .git/remotes/origin file I think)
>> you would fetch remote 'master' into local 'origin' and merge what you
>> have in 'origin' into your 'master' (or merge remote 'master' into
>> your local 'master' if you want to think like that).
> 
> So in this case, there is a difference between doing my local
> development under master or myownlocalbranch. Right?
> I mean, if I do my own development under master and I pull, the master
> branch will include origin and my local changes. Corret?
> While if I work in my local branch the datas are not modified with a
> pull, because pull will update only the local copy of the remote
> branch. Correct?

To be more exact (sorry for the confusion) "git pull" means first do
the "git fetch", i.e. update local 'tracking' branches with the contents
of remote branches. For ordinary clone this means:

    remote (origin)  | local
   ------------------+------------------
    master           | origin
    next             | next
    ...              | ...

For --use-separate-remote this means

   remote (origin)   | local
  -------------------+-------------------
   master            | refs/remotes/origin/master
   next              | refs/remotes/origin/next
   ...               | ...

Then it does "merge". It takes the remote branch from first Pull: line in
remotes/origin file, or first in remote.origin.fetch configuration variable,
and merges it with _current_ branch.

So if you always work on local branches, and newer want to merge
automatically, you probably should use "git fetch" for fetching changes.


What is not obvious (and is PITA for first-timers) that to merge
some <sidebranch> into your <branch>, it is simplest to first switch
to <branch> using
  git checkout <branch>
and then merge <sidebranch> using
  git pull . <sidebranch>
(where '.' means local repository).

HTH
-- 
Jakub Narebski
