X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Question on multi-level git repository heiarchy.
Date: Fri, 27 Oct 2006 16:31:47 +0100
Message-ID: <200610271631.49803.andyparkins@gmail.com>
References: <45419529.3010207@candelatech.com> <20061027052517.GB29057@spearce.org> <4542120E.1050903@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 15:54:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WQK5nGb1u+ZfNSU9OXCX1Me7AlBdnQbCNjFr6+4bS4PVCF5SzvqbKmx793fWyvWzKzI5ZJQh1WMZMEX6qytOuM/ScUh6Y2/v3LlkEw8XH44Zt6O3BADqjFSDZMnkE+xLUa68hpOzRb/NfFzjtxMXmTS3nO/KeDavN0cqzwIUaRI=
User-Agent: KMail/1.9.5
In-Reply-To: <4542120E.1050903@candelatech.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30333>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdTiG-00086X-KV for gcvg-git@gmane.org; Fri, 27 Oct
 2006 17:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752274AbWJ0Pdh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbWJ0Pdh
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 11:33:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:51981 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752302AbWJ0Pdg
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 11:33:36 -0400
Received: by ug-out-1314.google.com with SMTP id 32so710977ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 08:33:34 -0700 (PDT)
Received: by 10.67.30.6 with SMTP id h6mr5121636ugj; Fri, 27 Oct 2006
 08:33:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k30sm724675ugc.2006.10.27.08.33.27; Fri, 27 Oct 2006 08:33:28 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 October 27 15:05, Ben Greear wrote:

> I want to synchronize the entire git repo, including all branches.  How
> would I go
> about doing that?

That happens anyway.  "git pull" is actually a fetch + a merge.  Personally I 
recommend never doing a "git pull" without arguments.  Instead:

First, update every "Pull:" line from .git/remotes/origin
 $ git fetch
Now manually merge one of the (now locally stored) upstream trees into your 
working tree.
 $ git pull . upstream-tree

> Is there any way to recover my currently mangled tree on the
> workstation, or do I need
> to start fresh there?  If I start fresh, do I re-clone, or is there some
> better way to get

I'm relatively new to git; my experience is that there is very little that 
can't be undone.  Exactly what sort of mangling has happened to your tree?

If you've got yourself in a real state, I suggest editing .git/remotes/origin 
to pull the upstream trees to some newly named branches (maybe just 
add "new/" to the front of them).  Treat those as read-only (i.e. don't check 
them out), and start comparing branches.  "gitk --all" is incredibly useful 
for this.

Make yourself a new branch for your own work based off a new/upstream branch  
(git checkout -b fixthings new/upstream), then use git-cherry-pick to pull 
your patches out of your mangled tree to build up a branch with your changes 
on it.

Now, you can delete all the branches that you think are mangled and (if you 
really want to), rename all the new/ refs back to whatever they started as.

> the synchronization that I want?

I am going to guess that you've fallen for the same thing I did at first: 
confusing "git pull" with "git fetch"; "git pull" can get you in 
trouble, "git fetch" probably won't.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
