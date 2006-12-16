X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 17:32:10 +0100
Message-ID: <200612161732.11746.jnareb@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <em0fpq$45b$1@sea.gmane.org> <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 16:32:25 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=OtxsKZ3Z0YtdCqexGldPAuDMymv5Xqa7E27Byh5i5AIrZ1SfLdQqX4jO9YEe1CDcKhlI9Kgy8Si2jGa3FfGeVCCmIhSnlzR4AkSZik+r8NyxN3ZB+IXCoyRpFiwQXPEL6LEH+mTQuwC/IqX6bhVKD+1Tis0GaJDWjsQROZ9Jb3k=
User-Agent: KMail/1.9.3
In-Reply-To: <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34624>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvcSR-0003wz-D5 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 17:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161160AbWLPQcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWLPQcQ
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 11:32:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:17420 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161160AbWLPQcP (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 11:32:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1115384uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 08:32:14 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr1948608ugi.1166286733151; Sat, 16
 Dec 2006 08:32:13 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id q40sm6234679ugc.2006.12.16.08.32.12; Sat, 16 Dec
 2006 08:32:12 -0800 (PST)
To: "Torgil Svensson" <torgil.svensson@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Torgil Svensson wrote:
> On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> All fine, but this does not and I think cannot protect us from the
>> fact that we can have <sha1 of tree/blob> which doesn't match
>> <sha1 of commit>.
> 
> True, that will be a real problem. Unless we have a bug in git, do you
> see a scenario in which this is likely to happen?

Well, I just rather have than <sha1 of tree/blob> the definition
of sparse checkout (for example subdirectory name, or file name,
or glob pattern).

Besides you need the name of directory (for tree) or file (for blob),
otherwise you would have no way to update it when submodule advances
version, and you want to use new submodule version. And if you have
that, you don't need <sha1 of tree/blob> in repository, in link object.
You might want it in the index, for performance reasons, though.
 
>> I think it would be better to have sparse/partial checkout first.
>> But that is just my idea. Because with <sha1 of tree/blob> which
>> is not sha1 of commit tree you might loose (I think) the ability
>> to merge, for example your changes to submodule with upstream.
> 
> That's correct. I also want a sparse/partial checkout but I don't want
> the full submodule path. I'm also perfectly fine (for my current
> use-cases) with not being able to merge upstream unless we're tracking
> the commit tree (here, we might not want to specify the tree SHA1).

With sparse (for example defined by 'src/*.h') or partial (for example
defined by 'Documentation/') checkout you should be able to merge
upstream... unless conflicts are in the not checked out part.

> I'm not trying to impose a technically fragile solution here [I don't
> believe it is, but I'm not the most competent to say that either], I'm
> trying to find solutions for my use cases and I had problems adapting
> them to the current suggestion.

Have you read  http://git.or.cz/gitwiki/SubprojectSupport on GitWiki?
Have you tested the experimental submodule support (proof of concept)
  http://git.admingilde.org/tali/git.git/module2
by Martin Waitz?

-- 
Jakub Narebski
