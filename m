From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Sun, 28 Aug 2011 16:37:04 +0200
Message-ID: <4E5A5290.4050005@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxglb-0000BA-Qf
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab1H1OzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:55:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58835 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644Ab1H1OzD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:55:03 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1DA0620EB7;
	Sun, 28 Aug 2011 10:55:03 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 28 Aug 2011 10:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qBReASkOsEEpklkGhJSdyQ
	pc/0c=; b=qUx4fKUvI0ikgsZXEASn9RlXJbwz1cr/m+V3iO8Q1Ny+rHGpjzmvS+
	U7ion1SIyv/zpIrCgdntK5F832AruSShKiKQdGndqJVXWmJmjzzbYgYMfB8uhib9
	7vfH60JpKM3tCMzUq9d4QKPbBJtFBHMM02rJ5AvzMh9tNkJWHjotI=
X-Sasl-enc: /26bwNu30vhP9rToh5qwMESRIGQE2drPJdV77lurb2g4 1314543302
Received: from localhost.localdomain (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 21D7DA00252;
	Sun, 28 Aug 2011 10:55:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180276>

Junio C Hamano venit, vidit, dixit 26.08.2011 19:43:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, there is no way to invoke the list mode explicitly.
> 
> ..., without giving -v to force verbose output.
> 
>> Introduce a --list option which invokes the list mode. This will be
>> beneficial for invoking list mode with pattern matching, which otherwise
>> would be interpreted as branch creation.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
> 
>> @@ -20,7 +20,8 @@ DESCRIPTION
>>  
>>  With no arguments, existing branches are listed and the current branch will
>>  be highlighted with an asterisk.  Option `-r` causes the remote-tracking
>> -branches to be listed, and option `-a` shows both.
>> +branches to be listed, and option `-a` shows both. This list mode is also
>> +activated by the `--list` and `-v` options (see below).
> 
> Very good to mention "and -v" here ;-)
> 
>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>> index 6b7c118..61e095c 100755
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -32,6 +32,20 @@ test_expect_success 'git branch shows local branches' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'git branch --list shows local branches' '
>> +	git branch --list >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +cat >expect <<'EOF'
>> +  branch-one
>> +  branch-two
>> +EOF
>> +test_expect_success 'git branch --list pattern shows matching local branches' '
>> +	git branch --list branch* >actual &&
>> +	test_cmp expect actual
>> +'
>> +
> 
> Could we have a test to check the code you updated to sanity check the
> combination of options as well? I suspect the reason your initial round
> botched the "branch -v -m foo" without realizing may be because we do not
> cover the error checking.

Currently, "-m -d" is forbidden", but "-m -v" is "-m", same for "-d -v".
Do we want to keep it like that? Probably. I'll add the tests to 4/5.

Michael
