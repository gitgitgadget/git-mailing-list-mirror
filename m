From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 07:55:25 +0100
Message-ID: <531032DD.9000904@viscovery.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com> <20140228053703.GA32556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:55:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHM4-0007Ss-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaB1Gz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:55:28 -0500
Received: from so.liwest.at ([212.33.55.19]:59650 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaB1Gz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:55:28 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WJHLy-0006fP-1M; Fri, 28 Feb 2014 07:55:26 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B9E9A16613;
	Fri, 28 Feb 2014 07:55:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140228053703.GA32556@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242895>

Am 2/28/2014 6:37, schrieb Jeff King:
> On Fri, Feb 28, 2014 at 12:04:18PM +0900, Brian Gesiak wrote:
> 
>> No test asserts that "git branch -u refs/heads/my-branch my-branch"
>> emits a warning. Add a test that does so.
> 
> For an operation like "git branch foo origin" where setting up the
> tracking is a side effect, a warning makes sense. But the sole purpose
> of the command above is to set the upstream, and we didn't do it; should
> this warning actually be upgraded to an error?
> 
>> +test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
>> +	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
>> +	cat >expected <<EOF &&
>> +warning: Not setting branch my13 as its own upstream.
>> +EOF
>> +	test_cmp expected actual
>> +'
> 
> This should use test_i18ncmp, as the string you are matching is
> internationalized.

More generally, stderr output shouldn't be tested with test_cmp or
test_i18ncmp at all, but with grep and test_i18ngrep. The reason is that
when you run the test with 'sh -x t3200* -v -i', the trace output is also
in stderr, and the test_cmp/test_i18ncmp fails due to the unexpected extra
text.

-- Hannes
