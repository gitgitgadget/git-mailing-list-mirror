X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 13:35:37 +0000
Message-ID: <200611281335.38728.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281029.11918.andyparkins@gmail.com> <ekh45n$rfc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 13:36:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MxUMmOXwyiGhenkn3lCAcH9wGXy0886GwK+ftz7b1RiS0TDU6GgZ38R/2cPagf+eMr2wWf2SiR6pEJbZEm/TUK9JbN2YiiZ5eSh23z1Ej0ONwpR74003mYm3V9fXbY19YdZQL2vGIrB1Hec3yjD34a6/Ms2f0zL6dS8WMQy7XR0=
User-Agent: KMail/1.9.5
In-Reply-To: <ekh45n$rfc$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32524>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp37l-000411-F7 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758671AbWK1Nfp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbWK1Nfp
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:35:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4146 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758671AbWK1Nfo
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:35:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1476252uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 05:35:43 -0800 (PST)
Received: by 10.67.99.1 with SMTP id b1mr1585513ugm.1164720942745; Tue, 28
 Nov 2006 05:35:42 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 50sm19441035ugb.2006.11.28.05.35.42; Tue, 28 Nov 2006 05:35:42 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 10:50, Jakub Narebski wrote:

> I think that the proper place for that would be supermodule _index_.
> The supermodule tree would have commit entry, and the index would have
> symbolic branch (and perhaps some infor about where to find refs for
> submodule).
>
> This I guess breaks index abstraction slightly, but on the other hand
> allows for tracking non-HEAD branch of submodule, and for submodule to
> not know about supermodule at all...

The reason I thought it would have to be HEAD at all times, is to prevent 
situations where the supermodule commit doesn't reflect the state of the 
current tree.

Let's imagine that we're doing non-HEAD tracking in the supermodule.
  supermodule
   +-------- libsubmodule1
   +-------- libsubmodule2
So, you do a "make" in supermodule; this of course will call make in each of 
the submodules.  You test the output and find that it's all working nicely.  
Time for a supermodule commit.  We want to freeze this working state.  You 
commit and tag "supermodule-rc1"

Unfortunately, during development, you've switched libsubmodule1 to 
branch "development", but supermodule isn't tracking libsubmodule1/HEAD it's 
tracking libsubmodule1/master.  Your supermodule commit doesn't capture a 
snapshot of the tree you're using.

Now you say to the mailing list "hey guys, can you test "supermodule-rc1"?  
They check it out, and find that everything is broken.  Why?  Because what 
you wanted to check in was libsubmodule@development, but what actually went 
in was libsubmodule@master.

I think I've talked myself into the position where it definitely has to be 
HEAD being tracked in the submodules; anything else is a disaster waiting to 
happen because commit doesn't check in your current tree.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
