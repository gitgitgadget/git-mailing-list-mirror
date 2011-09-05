From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Mon, 05 Sep 2011 16:17:46 +0200
Message-ID: <4E64DA0A.8090202@drmicha.warpmail.net>
References: <20110903105723.GA16304@tin.tmux.org> <1315067656-2846-1-git-send-email-drizzd@aon.at> <1315067656-2846-4-git-send-email-drizzd@aon.at> <7v62l7crpg.fsf@alter.siamese.dyndns.org> <4E6494F7.7010101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	tobiasu@tmux.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 05 16:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Zzp-0007Xm-4g
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 16:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab1IEORv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 10:17:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47428 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392Ab1IEORu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 10:17:50 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7CAF424A74;
	Mon,  5 Sep 2011 10:17:49 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 05 Sep 2011 10:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=FmWAHAuTD6bvJYzE5Ff3JI
	u9EpQ=; b=nd8XkD/aTX0gXYQVchvMlCeLEX9HthRkG23vW4ao/FPjx/mr0qJQ9d
	5ACLHK8COfE3GGOF6CKGoDMzKFyD+u5x/iHjKz04yX/gQ/8ykFpVkQ0WaOj6JWYM
	NsIJU26AhKVpWbiZPfOLGGtTjngKIP1mclAFbpOz8SZqATaNd16rk=
X-Sasl-enc: 0Fu5ra+tCdJF9689+54V5FhiWkKtGQ4nCSV9ua8r1ewr 1315232269
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91E9B4135E6;
	Mon,  5 Sep 2011 10:17:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E6494F7.7010101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180745>

Michael J Gruber venit, vidit, dixit 05.09.2011 11:23:
> Junio C Hamano venit, vidit, dixit 05.09.2011 10:35:
>> Hmm, with this whole series merged to 'pu', I somehow am getting this
>> error:
>>
>> $ make -j8 \
>>     DEFAULT_TEST_TARGET=prove \
>>     GIT_PROVE_OPTS=-j8 \
>>     T=t5541-http-push.sh test
>> *** prove ***
>> t5541-http-push.sh .. All 1 subtests passed 
>>
>> Test Summary Report
>> -------------------
>> t5541-http-push.sh (Wstat: 0 Tests: 1 Failed: 0)
>>   Parse errors: No plan found in TAP output
>> Files=1, Tests=1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.06 cusr  0.01 csys =  0.09 CPU)
>> Result: FAIL
>> make[1]: *** [prove] Error 1
>> make[1]: Leaving directory `/srv/project/git/git.git/t'
>> make: *** [test] Error 2
>>
>> Without prove (drop "DEFAULT_TEST_TARGET=prove" from the command line),
>> I do not see the breakage.
>>
>> *** t5541-http-push.sh ***
>> ok 1 - set up terminal for tests
>> # passed all 1 test(s)
>> 1..1 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
>> make aggregate-results
>> make[3]: Entering directory `/srv/project/git/git.git/t'
>> for f in test-results/t*-*.counts; do \
>>                 echo "$f"; \
>>         done | '/bin/sh' ./aggregate-results.sh
>> fixed   0
>> success 1
>> failed  0
>> broken  0
>> total   1
>>
> 
> Being cc'ed makes me feel guilty but I don't know what for... Anyway, in
> case you need more test points, with pu at v1.7.7-rc0-315-g55af6ac  and
> prove I get:
> 
> *** prove ***
> t5541-http-push.sh .. skipped: Network testing disabled (define
> GIT_TEST_HTTPD to enable)
> Files=1, Tests=0,  0 wallclock secs ( 0.04 usr  0.01 sys +  0.00 cusr
> 0.02 csys =  0.07 CPU)
> Result: NOTESTS
> 
> Patch 3/3 does not apply (am) to pu but leaves neither changes nor
> conflicts in my wt. -3 gives a conflict which I don't know how to
> resolve without digging further, see below.
> 
> Michael
> 
> The conflict in send-pack.c is simple, but what about:
...

OK, I resolved this now, and am getting the same error as you, and am
stumped. But for me, 1/3 introduces that problem already. In fact, the hunk

--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -5,6 +5,7 @@

 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh

suffices to trigger the problem. The test run in lib-terminal increases
the count but the output is lost. Patch upcoming.


Michael
