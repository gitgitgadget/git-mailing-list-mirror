X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 10:38:27 +0000
Message-ID: <200612011038.29193.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612010849.11176.andyparkins@gmail.com> <456FF6D1.4040500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 10:38:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H4W7LTvDbCREe6hyVDiEHqQXEcCqSVBEY/XXlGQfCFaAw9QehqBcg/djQH0uly/lQWtpp2YovYWFFsFSXlwz7//eUW19pBi/V0DrfFh3WfOkRO2H9JoGLENTbkH1R7YV5ke7uuc2ccTv851pXuExWSepGZRpesXm7rp2KMbmcvA=
User-Agent: KMail/1.9.5
In-Reply-To: <456FF6D1.4040500@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32886>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq5n2-0004wz-07 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936135AbWLAKif (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936187AbWLAKif
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:38:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:41793 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936135AbWLAKie
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:38:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2382889uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 02:38:33 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr7029771ugm.1164969513547; Fri, 01
 Dec 2006 02:38:33 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k2sm18654448ugf.2006.12.01.02.38.32; Fri, 01 Dec 2006 02:38:32 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 09:33, Andreas Ericsson wrote:

> True, but this makes one repo of the submodule special. Let's say you
> have this layout

In a way, but it's information that doesn't need to be transmitted.

> mozilla/.git
> mozilla/openssl/.git
> mozilla/xlat/.git
>
> Now, we can be reasonably sure that the 'xlat' repo is something the
> mozilla core team can push to, or at least we can consider the core repo
> owners an official "vendor" of tags for the submodule repo. I'm fairly
> certain openssl authors won't be too happy with allowing the thousands
> of projects using its code to push tags to its official repo though.

No need, when cloning a supermodule, it will make those special tags 
automatically in the submodule repo.  They are only there to prevent prune 
from destroying those referenced commits after all.  If the submodule is 
cloned directly, they aren't needed anyway, and those objects won't be part 
of the dependency chain so wouldn't be downloaded.

> Now that I think about it more, I realize this is completely irrelevant
> as the ui can create the tags in the submodule with info only from the
> the supermodule, which means the submodule repo will only be special if
> it's connected to the supermodule. We just need a command for creating
> those tags in the submodule repo so people who use the same submodule
> code for several projects can use the alternates mechanism effectively.

Is that even necessary?  git-clone of a supermodule will make those tags 
automatically.  If a submodule was alternative-cloned into a different 
supermodule, well then THAT supermodule would make the right tags for itself.  
Ah, I think I see what you mean now though, a method would be needed for 
creating those tags if we managed to manually get a submodule repository in 
to the supermodule - then supermodule-clone wouldn't have run.  Perhaps they 
could be checked for at commit time and recreated then?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
