From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Fri, 26 Apr 2013 13:59:08 +0200
Message-ID: <517A6C0C.1020506@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net> <043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net> <7vwqrtjmtx.fsf@alter.siamese.dyndns.org> <5177AE7F.1040400@drmicha.warpmail.net> <7vehdzesr9.fsf@alter.siamese.dyndns.org> <vpqwqrrolpl.fsf@grenoble-inp.fr> <7v38ufdaih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 13:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVhIz-000823-CW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 13:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab3DZL7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 07:59:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57757 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387Ab3DZL7D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 07:59:03 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 964C720A52;
	Fri, 26 Apr 2013 07:59:02 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 26 Apr 2013 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=E1evX8kC3ajlQ8OlsDkejj
	/9s1s=; b=gnJ7EITz5NyLm97ls5RYUuZ3zSMFVtEb/DQT6jQ5ejyY3YxIWxA5Nu
	QRJbQSnpx5LTulppCtnQo89CsAj/o8zjWX/v4zcKw4odCTJnfYqtNTZNWENwsonn
	fogm5NgGgULYMntIka5u9FoI7p7bSGbyvP4IZdp3Ha0nRXBGXAtz8=
X-Sasl-enc: 3cWjd9kgzYlyQPRd5DvSgiZMwhXL2K7ELaxvgzuU3HKi 1366977542
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B47942001CB;
	Fri, 26 Apr 2013 07:59:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7v38ufdaih.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222528>

Junio C Hamano venit, vidit, dixit 24.04.2013 20:55:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Grepping through the binary, on the other hand, can very well make
>> sense, like:
>>
>> $ git grep foo
>> file.txt: some instance of foo
>> binary file bar.bin matches

BTW, textconv does not have to be slow - just use textconv-cache.

> Yes, 
> 
> I am moderately negative on making it the default, mostly because it
> goes against established expectations, but I did not mean to say
> that an ability to pass blob contents through textconv before
> running grep should not exist.  It would be a good option to have.

I'm still looking for a way to at least treat "git grep" and "git show
blob" the same way. I understand that I cannot convince you to change
the default here. The two options that I see are:

- Implement the --textconv option but leave the default as is. I did
that for "git grep" already (just drop 7/7) but it seems to be
cumbersome for "git show blob". I have to recheck.

- Implement a new attribute "show" analogous to "diff" which applies to
the blob case ("git grep" is a blob case, and so is "git show blob")
which can specify a "show" driver, which is like a "diff" driver but
understands textconv and cachetextconv options only.
Here, the default would be "--textconv" in any case, but unless you
specify a "show" attribute and driver there is no change in current
behavior.

The second case is a bit like clean/smudge, so, alternatively, one could
add a textconv and cachetextconv option to "filter" rather than
introducing "show". I'm not sure how much the textconv machinery needs
to change, though.

Michael
