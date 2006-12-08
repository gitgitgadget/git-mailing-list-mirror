X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 10:43:06 +0100
Message-ID: <200612081043.07192.jnareb@gmail.com>
References: <45708A56.3040508@drzeus.cx> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 09:41:03 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EvirSoZj/DP1vdxnQFiX7PKrasKGbqxRjP5gwXGlms0f8eHws+WyUKEaPxf/J/ICT8sg9nPb9A8z232sPVJEBwYczrmn5LfeadLvp8C+jIhCFLnerau0PWy06UnxOPCDAuMSvlhP3LVSOGYqN9MBdJjuMzA1WEV876MD1lOuqC0=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33675>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GscDz-0003ZA-9T for gcvg-git@gmane.org; Fri, 08 Dec
 2006 10:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425291AbWLHJk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 04:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425292AbWLHJk4
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 04:40:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:11773 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425291AbWLHJkz (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 04:40:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so713864uga for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 01:40:54 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr4859716ugl.1165570853949; Fri, 08
 Dec 2006 01:40:53 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 28sm2035447ugc.2006.12.08.01.40.53; Fri, 08 Dec
 2006 01:40:53 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
[...] 
> For example, if the git "refs/heads/" (or tags) directory hasn't changed 
> in the last two months, we should probably set any ref-relative gitweb 
> pages to have a caching timeout of a day or two. In contrast, if it's 
> changed in the last hour, maybe we should only cache it for five minutes.
> 
> Jakub: any way to make gitweb set the "expires" fields _much_ more 
> aggressively. I think we should at least have the ability to set a basic 
> rules like
> 
>  - a _minimum_ of five minutes regardless of anything else
> 
>    We might even tweak this based on loadaverage, and it might be 
>    worthwhile to add a randomization, to make sure that you don't get into 
>    situations where everything webpage needs to be recalculated at once.

I think the minimum expires (or minimum _additional_ expires: as of now
giweb only does expires +1d for explicit hash requests) should depend on
how often project changes. How often there are pushes to kernel.org?
 
>  - if refs/ directories are old, raise the minimum by the age of the refs
> 
>    If it's more than an hour old, raise it to ten minutes. If it's more 
>    than a day, raise it to an hour. If it's more than a month old, raise 
>    it to a day. And if it's more than half a year, it's some historical 
>    archive like linux-history, and should probably default to a week or 
>    more.

What about packed refs?

We can certainly raise expires for tags (tags objects), as they should not
usually change.
 
>  - infinite for stuff that isn't ref-related.

As sha1 is not changeable, everything that is accessed by explicit 
sha1 (hash), or by explicit sha1 (hash_base) plus pathname (file_name)
should have effectively infinite expires.


Every caching would need some temporary memory, or temporary disk space.
And perhaps mod_perl specific caching would be useful here...

P.S. I have added Pasky to Cc:, as he manages http://repo.or.cz public
git repository hosting (much smaller than kernel.org and I think under less
load: but also I think withour kernel.org resources).
-- 
Jakub Narebski
