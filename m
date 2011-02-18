From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 09:02:23 +0100
Message-ID: <4D5E278F.2010509@drmicha.warpmail.net>
References: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net> <536855b39d0ab5bb657ee6117a7e7c6bb0de0027.1297928549.git.git@drmicha.warpmail.net> <20110218041609.GA12348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 09:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqLLS-00038F-1m
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 09:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab1BRIFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 03:05:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49287 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752519Ab1BRIFe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 03:05:34 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B82EF20D13;
	Fri, 18 Feb 2011 03:05:33 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 18 Feb 2011 03:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fXSowgpNqIkC0SYGGU1+C2bmG7g=; b=pZfTVTjILLHVLE1HHI8dTCIsIezYK+s8Y3cRsnZXLft6XxflOG5woJRJOy251xSGQS+JRplm9VDarj3kfvSArkJR3J0neDDqMY/qtvlqMbIByTz5lnt/lvLk+xsDICjzaSisNZOBRrUkk+T0I7lnxkteKtBkMwwCpEBfSrKfPyU=
X-Sasl-enc: cqOStX/2xIMHylvj7w6iplRvL7Vpv2FYJWhyN/IyUmG9 1298016333
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 066D54012B7;
	Fri, 18 Feb 2011 03:05:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110218041609.GA12348@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167183>

Jeff King venit, vidit, dixit 18.02.2011 05:16:
> On Thu, Feb 17, 2011 at 08:44:42AM +0100, Michael J Gruber wrote:
> 
>> --- a/builtin/patch-id.c
>> +++ b/builtin/patch-id.c
>> @@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
>>  			p += 7;
>>  		else if (!memcmp(line, "From ", 5))
>>  			p += 5;
>> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
>> +			continue;
> 
> Wow, that's pretty obscure. I wonder if the test should be factored out
> into line_is_no_newline_at_end_of_file() (or surely there is some more
> sensible name), and used by both apply and patch-id. Along with a nice
> comment (which I see apply already has) describing what in the world the
> magic number 12 means.

So, where do you suggest it should go? As far as I can see, we have two
places reading these markers (the above builtins) and two places writing
them (diff.c, xdiff/xutils.c), at least for git-core. (git-gui's
diff.tcl has its own strict check etc.)

I would opt for putting a more detailed explanation in the commit
message (reasoning + ref. to apply.c) rather then trying to factor this.

After all, our code is largely undocumented as far as inline
documentation goes (it has frustrated me a few times), and the more
comprehensive documentation are the commit messages which git blame
points you to.

Michael
