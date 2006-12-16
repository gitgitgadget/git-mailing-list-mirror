X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetch fails with error code 128
Date: Sat, 16 Dec 2006 22:12:55 +0000
Message-ID: <200612162212.57771.andyparkins@gmail.com>
References: <200612142308.45376.andyparkins@gmail.com> <200612150946.14439.andyparkins@gmail.com> <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 22:15:58 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=of1oQtwzHyjUYjr5JcGmmmGs57xOvGopR+fD8HSr/DgsQB25Orf9KBvu0rFiUjiB8ZV5AHqyoFElJ85R7Cz8j9X5ZSfwWa35Etzu812ZJ4uPreiytEGOEs9s1GW8SvOOldy/1eQxYsF1ls2AAlVfSEtHWWZjP1NlMpde0I/5uAw=
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34648>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvhot-000377-PQ for gcvg-git@gmane.org; Sat, 16 Dec
 2006 23:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422660AbWLPWPt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWLPWPt
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 17:15:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:8280 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1422660AbWLPWPs (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 17:15:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1165870uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 14:15:47 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr3844680ugj.1166307346764; Sat, 16
 Dec 2006 14:15:46 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 30sm6655656ugf.2006.12.16.14.15.45; Sat, 16 Dec
 2006 14:15:46 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006, December 15 21:55, Junio C Hamano wrote:

> Thanks --- very much appreciated.  When it comes to
> inter-repository object transfer, we take compatibility very
> seriously.

Okay.  Before I started bisecting I thought I'd do some other experiments.  
Having tested fetch from remote and a fetch from local and finding the same 
results, I've done all the tests locally.

So; here goes.  I've got these directories:

 linux-partial/   (this is every patch from v1.0.0 to v2.1.63)
 linux-full/      (this is every patch from v1.0.0 to v2.5.75)

linux-partial/ is the one I reported the original error on, later I confirmed 
that the same error happened with a local fetch from linux-full.  I cloned 
both of these.

 linux-partial-clone/  (made with git clone linux-partial linux-partial-clone)
 linux-full-clone/     (made with git clone linux-full linux-full-clone)

Tests:
 - A fetch from linux-full to linux-partial, this one failed with error 128
 - A fetch from linux-full-clone to linux-partial, this one failed with
   error 128
 - A fetch from linux-full to linux-partial-clone, this one succeeded
 - A fetch from linux-full-clone to linux-partial-clone, this one succeeded
   (unsurprisingly)

Next I ran git-prune in linux-partial.  The fetch then succeeded.  Bizarre.

So, the strange result is that it is a difference in the destination directory 
that is triggering the error, and whatever that fault is is fixed by 
git-cloning that destination repository, or git-pruning the destination.

Unfortunately I've now lost my test case, because the prune fixed it.  Bah.  
Oh well, this fault can be marked "on hold until I get it to fail again".



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
