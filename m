From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in
 favor of --force
Date: Tue, 07 Jul 2015 20:43:55 -0400
Message-ID: <559C724B.8090708@gmail.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>	<1436203860-846-24-git-send-email-sunshine@sunshineco.com> <xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 02:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdT4-0001AI-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbbGHAoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:44:02 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34861 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbbGHAoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:44:00 -0400
Received: by qget71 with SMTP id t71so92916141qge.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=27o6VOI8sEbBU7MeO8sMBP3/nqu6GJUv9OIvG84Peck=;
        b=s0gaaLzr8vRqpdMtS1T8Trz/ffAHXEgyqAUxHgrRojsQecKmk/Snu5R9RZrABjwXQP
         yNjp66oB6dt2m2+AUCcVUdrJqNoM9uD0FHT88SHd+YslDy3bo5Noda3jSqjXqhhqOCvS
         mcXJwve+tldUcB1HDeZbsw8hz+Jk0HYf4qAf4rILPaWDKmKUDSS11oSkuth77GtiH4Mb
         LaHx6BLTIupUP1jiu2OKmAmpph8A4aN89DSxrkN7z7JnQR21dg0vEsdCH7TvTUpSWqme
         fnKHApLULkWEyjWTtw42gSXf1POGjxcYg5uPZ9iib0xkIlN513OsR5b8xtorNGT9hFPe
         s2wQ==
X-Received: by 10.55.21.141 with SMTP id 13mr11281759qkv.101.1436316239391;
        Tue, 07 Jul 2015 17:43:59 -0700 (PDT)
Received: from marklaptop.lan (pool-96-255-220-63.washdc.fios.verizon.net. [96.255.220.63])
        by smtp.gmail.com with ESMTPSA id h133sm251622qhc.46.2015.07.07.17.43.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 17:43:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273620>

On 07/06/2015 03:40 PM, Junio C Hamano wrote:
> If you are extending the history of some branch, then you would want 
> to be on that branch. Why would you want to have another worktree that 
> will get into a confusing state once you create that commit on the 
> checked out branch in this newly created worktree? Wasn't the whole 
> point of making the primary repository aware of the secondary 
> worktrees via the "linked checkout" mechanism because that confusion 
> was the biggest sore point of the old contrib/workdir implementation? 

The only issue I have with git-new-workdir is that git-gc in one 
worktree is unaware of what is in use in another so can prune things 
away. The linked worktrees here nicely solve that problem.

The main use I have of maintaining multiple checkouts of one branch is 
for testing / analysis (where said tests can take days to weeks to run). 
Disallowing use of git's normal mechanism of tracking what is checked 
out in each such tree forces use of another system to do so, just 
imposing different difficulties for this use case. I note that 1) code 
must be ADDED to git to prevent such duplicate checkouts which otherwise 
cause no difficulty to git itself, and 2) adding those checks requires 
additional work to avoid the fallout. I have yet to hear what the upside 
of such a restriction is, I only see downsides.

Mark
