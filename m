From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Tue, 06 Mar 2012 13:41:30 -0800 (PST)
Message-ID: <m31up5tnjw.fsf@localhost.localdomain>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
	<f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
	<7vhay1se0g.fsf@alter.siamese.dyndns.org>
	<87y5rdzbpb.fsf@thomas.inf.ethz.ch>
	<7vr4x5qvgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S528d-0006kG-0V
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948Ab2CFVld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:41:33 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47189 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab2CFVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:41:32 -0500
Received: by eekc41 with SMTP id c41so2077631eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8ESX0D73g2tW2PJBNgmusJ85X6FZiuc2z6EWLnXfRxA=;
        b=PhviqktF9stPURamwwTEAisx30dVfd/3Bha6x4mPPuogy/pBoddGsuQuX7InS8/Zkz
         8gZVVnLYpqBrVPGMia+MrkAStVoJk7dlWr+LfRFp0HDFHH1JFa8kwYtSSh0qiHoZhx1w
         PU0isEowVVWFYxQbz+vgNS276EJgvD6F3y3eflkoSbZRkESIBqetNSxDAMsiH7rhMGph
         vXKiIU5bvlPXCGi7ihOucUhdc59MnuCqEO5RUox+DXcZeT0quNc0Fp6w9Maib8EunVU6
         /2wnAcxPDVaa0e8J6al+UnUfkIRMfjVLmRReyy1Tt2Rpqp9XQuTar9OIbol3ghemR5U1
         GIfQ==
Received: by 10.213.35.65 with SMTP id o1mr32091ebd.128.1331070091507;
        Tue, 06 Mar 2012 13:41:31 -0800 (PST)
Received: from localhost.localdomain (abwf76.neoplus.adsl.tpnet.pl. [83.8.229.76])
        by mx.google.com with ESMTPS id y11sm17908816eem.3.2012.03.06.13.41.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 13:41:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q26LfQg6008335;
	Tue, 6 Mar 2012 22:41:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q26LfNHk008329;
	Tue, 6 Mar 2012 22:41:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vr4x5qvgd.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192400>

Junio C Hamano <gitster@pobox.com> writes:
> Thomas Rast <trast@inf.ethz.ch> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>
>>> I am getting this (probably unrelated to this patch), by the way:
>>>
>>> $ make perf
>>> make -C t/perf/ all
>>> make[1]: Entering directory `/srv/project/git/git.git/t/perf'
>>> rm -rf test-results
>>> ./run
>>> ...
>>> perf 4 - grep --cached, expensive regex: 1 2 3 ok
>>> # passed all 4 test(s)
>>> 1..4
>>> Can't locate Git.pm in @INC (@INC contains: /etc/perl ...) at ./aggregate.perl line 5.
>>> BEGIN failed--compilation aborted at ./aggregate.perl line 5.
>>
>> It would seem that you are not installing Git.pm as part of your normal
>> installation?
> 
> I actually am installing it in a quite vanilla way.
> 
> I think our installation procedure places Git.pm in git specific
> perl library path where a simple invocation of "perl" that is
> git-unaware will not look into, and we make sure that our scripts
> still find the matching version of Git.pm by having "use lib" at the
> beginning that points at the right directory.
> 
> But of course, this from a command line would not work:
> 
> 	$ perl -MGit
> 
> I do not expect it to, and for the ease of testing new versions, I
> prefer it not to work.
> 
> In any case, you should be able to do anything under t/ _before_
> installing, so relying on having Git.pm in normal @INC is a double
> no-no.

Thomas, take a look at how it is solved in 't/t9700/test.pl', used by
't/t9700-perl-git.sh':

  use lib (split(/:/, $ENV{GITPERLLIB}));

-- 
Jakub Narebski
