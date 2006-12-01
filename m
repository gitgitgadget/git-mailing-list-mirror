X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:12:34 +0000
Message-ID: <200612011212.35656.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011102.17079.andyparkins@gmail.com> <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:12:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DFBCm1ciZkG6i8gjNZOqZKU0CR8c/+bK8ncfqkJL7e5sg1aZJ9rMoj+N0CGbu0n8T+XqHfPJKkdKa4xwtxQSwW8CAVyQhilPkATAOolDwVDwf8MplqnzEQVP3lyFjfV2TrsjaCspGV3SJdU8yNqEYhlMlDmkDi2v3cNzpE39OfY=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32909>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7G1-0002pH-N3 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030903AbWLAMMn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030907AbWLAMMm
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:12:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:45829 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030903AbWLAMMm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:12:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2403779uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 04:12:40 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr7156557ugm.1164975160502; Fri, 01
 Dec 2006 04:12:40 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id q40sm21622377ugc.2006.12.01.04.12.39; Fri, 01 Dec 2006 04:12:39
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 11:10, Sven Verdoolaege wrote:

> You were proposing to create an extra object containing some random value
> that is disconnected from the repo.

Right, I think I've finally understood what Martin (and you) are proposing.  
You want every commit in the submodule to be propagated up to the supermodule 
as well.  Okay.

I don't think it's right, but at least I understand.

It seems wrong because it's making commits in the supermodule that aren't 
commits to do with that project.  In my libxcb example; why should every 
project use libxcb in have to store the entire history of libxcb?  When 
examining the supermodule history, I won't care about how libxcb got to the 
state its in, and it's just noise in the supermodule history.  What if I use 
10 submodules, the supermodule history won't show you anything useful - it's 
just unrelated submodule commits.

It gets worse, this is why I was asking for more detail: this commit that 
you're storing in the supermodule.  It's the same commit as is in the 
submodule?  What would the parent commit of that commit be?  It has to be the 
same in both, because the commit-hash forces it to be.

The only possibility would be that it's NOT the same hash in both, because the 
parents in the supermodule are inapplicable to the submodule, and the parent 
in the submodule is independent from the supermodule.  That means you have to 
store two commits: one for the submodule commit and one for the supermodule 
commit.  So what are you going to write in the supermodule commit?  Answer: a 
submodule commit hash - exactly as I said.

> > Is that commit in the submodule or the supermodule?
>
> It's in BOTH.  That's why it's a *sub*module.

If it's in BOTH then the supermodule is a normal git repository.  You aren't 
tracking the submodule, you're just including it en masse.  Using semantics 
to justify a position isn't a very strong argument, calling it a "sub" module 
is just an easy bit of naming for us to hang the discussion on, it isn't 
necessarily a mathematical subset and superset.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
