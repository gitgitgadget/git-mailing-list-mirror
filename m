From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] avoid exponential regex match for java and objc function
 names
Date: Wed, 17 Jun 2009 18:04:57 +0200
Message-ID: <4A391429.4010706@gmail.com>
References: <20090617102332.GA32353@coredump.intra.peff.net>	 <1245248766-14867-1-git-send-email-bonzini@gnu.org>	 <9b18b3110906170846o5b3c3000r72506bf62765a044@mail.gmail.com>	 <20090617155603.GA14545@sigill.intra.peff.net> <9b18b3110906170900g778b3c8aie627fb45a4967eb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Paolo Bonzini <bonzini@gnu.org>,
	git@vger.kernel.org, gitster@pobox.com
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGxdk-0001PZ-7M
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbZFQQFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbZFQQFP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:05:15 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:57090 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbZFQQFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 12:05:13 -0400
Received: by ewy6 with SMTP id 6so635951ewy.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jNC6SnV+E1SPuqFvzlCdQqKP170o85Jx6ZQW1+ptcmk=;
        b=lMLRbU0GBrWrK/Jh3mTFKmGDFvk9q84H8kTdT2MGWuyYnCJiHzcQGWU1nzZ6f/RDUG
         e4B4nAMNmcEIkgORQgU6jLsYl/7RU6Pa5TrDGl4Zbf4+40LaFLX/YFnbsc3uuZjxUNMQ
         ihgmbGjTgbujM8gdWSispGsdJU6mufoYiwBlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VjlXoF6ha1Zoa8f6Jh3/lpW/jY0LPjJzb+a/OpqqAO+txODOziD4lDWJacJoervFSd
         WS5bSqTnxDcA9uLFVksUbh78GiEpth2tBFo1CQlnqxpikVxk6BxBEUWRF4qzKk+Abws1
         eGTOZ1SnfFlOafKMokMIK42y1eVmAvjrOYaFA=
Received: by 10.216.26.77 with SMTP id b55mr150693wea.101.1245254715058;
        Wed, 17 Jun 2009 09:05:15 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 28sm127056eyg.14.2009.06.17.09.05.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 09:05:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <9b18b3110906170900g778b3c8aie627fb45a4967eb2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121756>


> Ah ok. Im not familiar with the finer points of the POSIX engine, but
> PCRE and Perl's engine, and most similar engines are not true regular
> expression engines and thus benefit *greatly* from atomic matching if
> it is available.
> 
> Like the difference between heat-death performance (or stack
> overflow), and running instantly.

You can almost always fix the regex to avoid this, by ensuring that 
whenever you have (...)+ (or *) a suffix of the subexpression cannot be 
a prefix of the subexpression too.  This is what my patch did -- 
changing a bad regex to a nicely behaving one.

Paolo
