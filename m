From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for displaying latest tags
Date: Thu, 23 Jul 2015 11:01:32 -0700
Message-ID: <xmqqd1zipxc3.fsf@gitster.dls.corp.google.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
	<xmqqbnf4rohs.fsf@gitster.dls.corp.google.com>
	<xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
	<55B0B667.6000103@drmicha.warpmail.net>
	<CA+P7+xpasr7gOYiSsdAyCgh6+D8nYQf9vuEhRna8k7HWMu1Rcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Halil =?utf-8?B?w5Z6dMO8?= =?utf-8?B?cms=?= 
	<halilozturk55@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKoN-0002at-O8
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbbGWSBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 14:01:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36185 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbGWSBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 14:01:35 -0400
Received: by pachj5 with SMTP id hj5so161325533pac.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2jaQRQsLJgUptoFUR9Bth6coGbK7HgpagayZtxJwENM=;
        b=IUekSGGyrAoPFk5VVtshF3dlAAQiZaPT+r/6eA0KwB61EEsM36fgpWMpKRgZsBVzSI
         sTYZpgBxle8s5Ua3JVxcWeXo7VM6F/asxvoN1PGGTLlLI3IxCF9DyazsgAIBBe0XfjY3
         iPsptHsPixiH62IUtxKVeAui7bRMBqlRMLwj0vPtgzg0X218nwdrjmlxZ0tI/MsCz7P0
         oSARvI54kvFlsvMnlE2re0nIKALWFobuqMsO2Wc5beR/uiG+tXBddZSihXy/QCrYacdy
         R5ZN26DdQrH5hH04XpM3QHCbyr18SM3G7h8vVijDDaOQY0oBoXa1yd7VghAN4aMw3qT1
         I2Qg==
X-Received: by 10.66.222.103 with SMTP id ql7mr20773096pac.144.1437674494422;
        Thu, 23 Jul 2015 11:01:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id e8sm10177874pdm.13.2015.07.23.11.01.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 11:01:33 -0700 (PDT)
In-Reply-To: <CA+P7+xpasr7gOYiSsdAyCgh6+D8nYQf9vuEhRna8k7HWMu1Rcg@mail.gmail.com>
	(Jacob Keller's message of "Thu, 23 Jul 2015 10:21:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274516>

Jacob Keller <jacob.keller@gmail.com> writes:

> Yep, that's pretty much how a build system I've had to use does it.
> Sadly, this is quite slow, and I'm not sure if doing it built into the
> tag via for-each-ref would be faster?

Is the description in "git for-each-ref --help" somehow unreadable?

       An example directly producing formatted text. Show the most
       recent 3 tagged commits:

           #!/bin/sh

           git for-each-ref --count=3 --sort='-*authordate' \
           --format='From: %(*authorname) %(*authoremail)
           Subject: %(*subject)
           Date: %(*authordate)
           Ref: %(*refname)

           %(*body)
           ' 'refs/tags'

If you only need the name of the ref, you can use a lot simpler
format string, e.g.

    git for-each-ref --count=3 --sort='-*authordate' \
      --format='%(refname:short)' refs/tags

    git for-each-ref --count=3 --sort='-taggerdate' \
      --format='%(refname:short)' refs/tags
