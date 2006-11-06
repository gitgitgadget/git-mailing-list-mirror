X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: If merging that is really fast forwarding creates new commit [Was:
 Re: how to show log for only one branch]
Date: Mon, 06 Nov 2006 21:00:07 +0800
Message-ID: <454F31D7.1030202@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 13:02:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=k1LkslOZ8rsESQ97dn5atQVcZp/fj5WJfbUfVWYSDEKuBw65YqOr/8HXQbAcn0C8R9SdZ5LvPRHFmwMBhwUw1dW5QtUMHFPUfk4oWYPuSZVdN+UNJ/HeArvDtzFRiYaqnNQuoVcvF0cfgQjue2SqFPjvRkZBQCTf++hXGzEN3mI=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31010>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh46D-0003Nx-Dg for gcvg-git@gmane.org; Mon, 06 Nov
 2006 14:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753023AbWKFNBK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 08:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbWKFNBJ
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 08:01:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:30585 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1753023AbWKFNBI
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 08:01:08 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1039556wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 05:01:07 -0800 (PST)
Received: by 10.90.31.19 with SMTP id e19mr414855age.1162818067366; Mon, 06
 Nov 2006 05:01:07 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 44sm5511392wri.2006.11.06.05.01.05; Mon, 06 Nov 2006 05:01:06 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Thanks to Junio for his patient explanation about branches in git, I find 
there is a subtle difference between GIT and regular VCS that can be easily
neglected by newbies.

I realize that git is a *content tracker*, it only creates commit object
when the corresponding tree is really modified, git records content merging
but not usual merging operation, that's why git is called a content tracker.
This explains why a merging that is really a fast forwarding doesn't create
any new commit.

This feature is different from many regular VCS like CVS and Subversion and
confuses newbies that come from them: mainline doesn't make sense too much,
'git log' shows many logs from other branches. In git, a branch is almost a
tag, you can't get the *track* of a branch(It's a pity reflog is only for
local purpose). I am used to one-trunk-and-more-side-branches way, every
branches are isolated clearly, git makes me very confused at the beginning.


Then, what bad *logical* problem will happen if a merging that is really a 
fast forwarding creates a new commit?

If we throw away all compatibility, efficiency, memory and disk consumption
problems,
(1) we can get the track of a branch without reflog because HEAD^1 is
always the tip of target branch(or working branch usually) before merging.

(2) with the track, branch mechanism in git is possibly easier to understand,
especially for newbies from CVS or Subversion, I really like git's light 
weight, simple but powerful design and great efficiency, but I am really
surprised that 'git log' shows logs from other branches and a side branch can 
become part of main line suddenly.

A revision graph represents fast forwarding style merging like this:

             (fast forwarding)
  ---- a ............ * ------> master
        \            /
         b----------c -----> test         (three commits with three trees)

can be changed to:

  ---- a (tree_1) ----------- d (tree_3) ------> master
        \                    /
         b (tree_2) ------- c (tree_3) ----> test
(four commits with three trees, it's normal as more than one way can reach 
Rome :-)


I don't think I am smarter than any people in this mailing list, in fact
I am confused very much by GIT's branches at the beginning. There must
be many problems I haven't realized, I am very curious about them, any
