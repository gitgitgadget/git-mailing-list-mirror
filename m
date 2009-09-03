From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] git-config: Parse config files leniently
Date: Thu, 03 Sep 2009 09:41:49 +0200
Message-ID: <4A9F733D.5050205@drmicha.warpmail.net>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org> <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net> <7vab1cfr6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 09:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj6xZ-0006nC-U2
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 09:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbZICHmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 03:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZICHmA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 03:42:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56590 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbZICHmA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2009 03:42:00 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway2.messagingengine.com (Postfix) with ESMTP id B860759BD1;
	Thu,  3 Sep 2009 03:42:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Sep 2009 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=w6uG84KltrXJJ3SvOX+FDGtr044=; b=cg7C4Z9VeWo04VD/i/OMooXoIILSzRGff2+Oyd6N8LyI/plzFJdhzHOTmAznDaiXnE8v2u5R72sn9xj7Hi0ev7oIpQfOj22By2bDX56dmRZPLW2vO5v+7KM7DQPR84jyyeBWTII3wFpPr8hTOoZI2ngQhVI3pxIssgiXXxp9bXM=
X-Sasl-enc: ZX94SAQYVDT9J0Kud4GQn5ji7esH/U/1/3yu08jkepwk 1251963721
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 066B2493E8;
	Thu,  3 Sep 2009 03:42:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <7vab1cfr6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127642>

Junio C Hamano venit, vidit, dixit 03.09.2009 09:00:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, git config dies as soon as there is a parsing error. This is
>> especially unfortunate in case a user tries to correct config mistakes
>> using git config -e.
>>
>> Instead, issue a warning only and treat the rest of the line as a
>> comment (ignore it). This benefits not only git config -e users but
>> also everyone else.
> 
> This changes the behaviour enough to break t3200-branch.sh, test #52.
> 
> The test stuffs an invalid (but not syntactically incorrect) value used by
> "git branch" in the configuration and tries to make sure that "git branch"
> diagnoses the breakage, but it does not fail anymore with your patch.
> 
> There are probably other breakages as well (e.g. t5304-prune.sh, test #5)
> but if you trace "git branch" under the debugger in the trash directory
> left after running t3200 with -i, it should be pretty obvious that your
> patch is utterly bogus.  get_value() can return negative result after
> diagnosing a semantic problem with the value, and that is different from a
> syntax error that you would try to recover and continue, pretending you
> can ignore the remainder of the line as if it is a comment.
> 
> Why was I CC'ed, if the patch wasn't even self tested?

Because
- not CC'ing you would have meant culling you from the existing CC,
- we've discussed v1 of this patch before,
- I asked in this patch (v2) whether to go for an alternative.

Since "git config -e" for broken config is not my itch at all, but the
reporter's, I'll stop my efforts after this response.

Michael
