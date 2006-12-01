X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 21:04:37 +0000
Message-ID: <200612012104.39897.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612011917.19252.andyparkins@gmail.com> <20061201193802.GI18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 21:07:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eaFJWRYSiczMRtGdNburrX2tVJM1Tlg+beuuk8KVTckTEzJ/ezLejn4fYlHuKmZb/xah+NOlDxGU6ezkSW3pw72JAxfMkD8KL0f281OU1b5ipWk6EbNuYSUaK1mJmOZ/9G5r8ntlBMdy2hRXjDJXmwCxKmTHegXZaVaDz6JKHxs=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201193802.GI18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32966>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqFbY-00085X-OG for gcvg-git@gmane.org; Fri, 01 Dec
 2006 22:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161413AbWLAVH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 16:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWLAVH3
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 16:07:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4981 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161413AbWLAVH2
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 16:07:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2534180uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 13:07:22 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr7931567ugm.1165007242558; Fri, 01
 Dec 2006 13:07:22 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id b35sm22321178ugd.2006.12.01.13.07.21; Fri, 01 Dec
 2006 13:07:21 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006, December 01 19:38, Martin Waitz wrote:

> On Fri, Dec 01, 2006 at 07:17:17PM +0000, Andy Parkins wrote:
> > In fact, why should the submodule commits be even visible in the
> > supermodule?  That tree->submodule commit is sufficient; there isn't
> > any need to view submodule history in the supermodule.
>
> Well, but there is a need for a common object traversal.
> You need that when sending all objects between two supermodule versions
> and also when you determine which objects are still reachable.

No you don't; when traversing the supermodule history you will come across 
trees that have submodule commit hashes in them, that is all the other end 
needs to know.  If it wants it can then connect to the submodule and clone 
submodule to submodule.  The whole operation doesn't have to be done in the 
supermodule though.

> The easiest way to implement the common object traversal is to have all
> objects in one object repository.

That's true; but is it the right way?  I really really think the submodule 
objects should be in the submodule itself.

> It may be possible to use two object stores and still do the common
> object traversal but I do not think that gives you any benefits.

There is one benefit - you can git-clone the submodule just as you would if it 
were not a submodule.  In fact, from the submodule's point of view it knows 
nothing about the supermodule.

> You still don't have a totally separated repository then, because
> you can't do a reachability analysis in the submodule repository alone.

I'm going to guess by reachability analysis, you mean that the submodule 
doesn't know that some of it's commits are referenced by the supermodule.  As 
I suggested elsewhere in the thread, that's easily fixed by making a 
refs/supermodule/commitXXXX file for each supermodule commit that references 
as particular submodule commit.  Then you can git-prune, git-fsck whenever 
you want.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
