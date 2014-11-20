From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Thu, 20 Nov 2014 10:42:16 +0100
Message-ID: <546DB778.2000000@drmicha.warpmail.net>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>	<20141119191502.GC9908@peff.net> <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 10:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrOFv-0006hl-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 10:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbaKTJmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 04:42:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41547 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757030AbaKTJmS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 04:42:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id F1847209C0
	for <git@vger.kernel.org>; Thu, 20 Nov 2014 04:42:17 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 20 Nov 2014 04:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=VlW5xcJqBt1OY4YRX/Ieh7
	ZBi0Q=; b=hUQ6X11nX0kOelrtIeyx16czBxS5zTKVuABLN3wKnYuKP8f6r+9E1q
	Dl0kOVj2J3Kq1B+/5dGvA8vWTrQb5oWPxiPZd2UsrWADM21OdZcPIc0vndtq9mlt
	hGV3xGpZWnBd5J3g7feQUExf8xE+2yLe+XRjrf0NELwcdjKGZrPbU=
X-Sasl-enc: RyciIWBn3JvR1s4OLhMQi639h4cd5WkinBoaqrw93Dk9 1416476537
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 55EBF680157;
	Thu, 20 Nov 2014 04:42:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb am 19.11.2014 um 22:43:
> Jeff King <peff@peff.net> writes:
> 
>> Typically I keep a very neat .gitignore file and just use "git add .",
>> which _does_ ignore those files. The real problem here is that git
>> cannot tell the difference between "the user explicitly asked for
>> foo.aux, so we should complain" and "oops, foo.aux got caught in a shell
>> expansion".
> 
> Yup.  I also find myself doing "git cmd -- \*.ext" to let Git, not
> my shell, handle the patterns.

That is the correct way, of course.

>> I almost wonder if skipping ignored files should _always_ be a warning,
>> not a hard error. I guess that has unpleasant side effects for scripts
>> which call "git add XXX" and check the exit code, who may be
>> unpleasantly surprised that they missed out on some content.
>>
>> Perhaps we could do a hybrid: add the files that were not ignored, but
>> then still exit non-zero. Careful scripts need to check the exit status
>> of "git add" anyway, and sloppy humans with over-broad wildcards
>> typically do not care about the exit status.
> 
> ;-)
> 

You can simply say "Michael" in your last subclause above :)

I'm wondering whether that behaviour change (without --ignore-errors) is
OK - I don't mind, but hey, I usually don't.

I think it all comes down to the fact whether specifying an ignored file
on the command line is considered an error or only "possibly a user
error" we should dwim around. "git add" being plumbing, I'm somehow
hesitant to change behaviour unless git is asked to ignore error. And if
I'm hesitant already... oh wait. git add is declared porcelain? I would
not have guessed without looking it up.

Michael
