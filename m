From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 03 Mar 2014 23:06:26 -0800
Message-ID: <53157B72.3000205@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>	<xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>	<531514D9.4000101@gmail.com> <xmqq4n3en7un.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:06:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKjR0-0004DE-9P
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 08:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbaCDHGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 02:06:34 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42290 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaCDHGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 02:06:33 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so4808591pbb.22
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 23:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PcdKHCzVsw2ZdtSxPXQFsTufcGd6wxrucI5X14tTX/w=;
        b=VMIwAxh7UOeb7dTl45ICx+EVwLz7u2+jVDCET5Ds7Zb2LSIPNC0ffe7fR6wMLqYcn1
         aY2BUbJ08jyapL9zKL4GhIfto4wx1kT3NsigdwaNsBuvmyBEiymseSMkrR1wYQaqLfVO
         h9KXBgPUwJRVXhRmadh5H1LOJrMLAMtlaxquaWDxUKxAZ1OVLW5xdagFGyRWqg3+Ey8u
         fWIKpTJU82WlfZBmygP79GBXNJ7vjREePanYZ2/vTebGz/Mq1hJ0U3oQ/+BFQEPXeBTI
         /8TK9sdh2uG0FbAtPfaG/w1rNnmVhxYOMf81gIKuT4aKY7G6IB2YJPi8sVt1MKrP2r2O
         lYKA==
X-Received: by 10.68.211.164 with SMTP id nd4mr24040205pbc.44.1393916792956;
        Mon, 03 Mar 2014 23:06:32 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id y9sm99417791pas.10.2014.03.03.23.06.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 23:06:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <xmqq4n3en7un.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243325>

On 3/3/2014 4:08 PM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobir@gmail.com> writes:
>
>> It might be that we are looking at different use cases, as you are
>> talking about whole test suits.
> I do not think so.

Good :)
I am trying to understand the use cases.  And make sure we are talking 
about the same ones.
I am not sure what are the use cases for GIT_SKIP_TESTS.

I think that while in it really nice when an interface allows to do new 
things, the main use case (or use cases) should be as easy and obvious 
in the first place.
If the target is the TDD use case I described, then it appears that a 
user needs to do double negation.  That is what concerns me.

> I do not see anything prevents you from saying
>
> 	GIT_SKIP_TESTS='t0000 !t0000.1 !t0000.4'
>
> to specify test-pieces in individual tests so that you can run the
> setup step (step .1) and the specific test (step .4) without running
> two tests in between.

While it could be done, it looks less obvious than this:

     GIT_TEST_ONLY='1 4' ./t0001-init.sh

What if we do what you proposed, but with GIT_RUN_TESTS?
If we want to have one interface, maybe, building on top of a "negation" 
(GIT_SKIP_TESTS) is not very good.
At the same time, GIT_TEST_ONLY is also too specific for a generic 
interface.
I could add GIT_RUN_TESTS and allow it to have all of the features, thus 
making GIT_SKIP_TESTS a working but deprecated tool.

Running specific tests:
     GIT_RUN_TESTS='t0000'
     GIT_RUN_TESTS='t0000.1 t0002'
     GIT_RUN_TESTS='1 3 7'

Negating some tests:
     GIT_RUN_TESTS='!t0000'
     GIT_RUN_TESTS='!t0000.1'
     GIT_RUN_TESTS='!1 !3 !7'

The above would work exactly as you described but with one less level of 
negation.  Default is everything, unless at least one positive pattern 
is given.

Later on range specification could added:
     GIT_RUN_TESTS='<11'

At least for now that would cover most use cases that I can think of 
that look reasonable.
