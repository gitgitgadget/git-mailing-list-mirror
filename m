X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 10:33:05 +0100
Message-ID: <456FF6D1.4040500@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <200612010849.11176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:33:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612010849.11176.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32880>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4li-0005sR-KB for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759287AbWLAJdP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759286AbWLAJdO
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:33:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57737 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1759287AbWLAJdO (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:33:14 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 0E2FE6BCC2; Fri,  1 Dec 2006 10:33:09 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Thursday 2006 November 30 18:57, Andreas Ericsson wrote:
> 
> (agree with everything in your mail)
> 
>> The only problem I'm seeing atm is that the supermodule somehow has to
>> mark whatever commits it's using from the submodule inside the submodule
>> repo so that they effectively become un-prunable, otherwise the
>> supermodule may some day find itself with a history that it can't restore.
> 
> What about submodule/.git/refs/supermodule/commit12345678, where "12345678" is 
> the hash of the supermodule commit?  This gives a convenient route in the 
> submodule to which commit contains that commit from the submodule; but 
> doesn't write anything into the submodule repository itself.  It's just a tag 
> with a different intent.
> 

True, but this makes one repo of the submodule special. Let's say you 
have this layout

mozilla/.git
mozilla/openssl/.git
mozilla/xlat/.git

Now, we can be reasonably sure that the 'xlat' repo is something the 
mozilla core team can push to, or at least we can consider the core repo 
owners an official "vendor" of tags for the submodule repo. I'm fairly 
certain openssl authors won't be too happy with allowing the thousands 
of projects using its code to push tags to its official repo though.

Now that I think about it more, I realize this is completely irrelevant 
as the ui can create the tags in the submodule with info only from the 
the supermodule, which means the submodule repo will only be special if 
it's connected to the supermodule. We just need a command for creating 
those tags in the submodule repo so people who use the same submodule 
code for several projects can use the alternates mechanism effectively.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
