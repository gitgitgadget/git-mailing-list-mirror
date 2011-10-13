From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] http_init: accept separate URL parameter
Date: Thu, 13 Oct 2011 09:26:55 +0200
Message-ID: <4E9692BF.8040705@drmicha.warpmail.net>
References: <4E95FDC8.5030009@drmicha.warpmail.net> <20111012214316.GA4393@sigill.intra.peff.net> <20111012214610.GA4578@sigill.intra.peff.net> <7vk4897s4c.fsf@alter.siamese.dyndns.org> <20111012224625.GA11408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REFh3-0004Ur-FC
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab1JMH1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:27:00 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36059 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751564Ab1JMH07 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 03:26:59 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D7F9B222EE;
	Thu, 13 Oct 2011 03:26:58 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 13 Oct 2011 03:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=C/k4rTWto6uvIiei43xLCo
	md6Zc=; b=iqkGSgAcUcFTjz3hzUf6fKLpkNE/TmbidfxYtc1XUWZHkmWb+c/Jl1
	N7VGUN6vZ4tKVQnVeBxa92w06rNeBvssOjDIXLR6rdBAxZ3/GF9W4yT3BHY6o3VV
	Ljgw2T/22G+JnT3iqBINshcKAZeLkivUi3SXmKRYbj6xXMBzcyakk=
X-Sasl-enc: U8Xo39pP9qDN7WDgIdCv3ZI4TZoQkUGqJdnBUVQeSIRm 1318490818
Received: from localhost.localdomain (p54859303.dip0.t-ipconnect.de [84.133.147.3])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D74D4483410;
	Thu, 13 Oct 2011 03:26:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111012224625.GA11408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183446>

Jeff King venit, vidit, dixit 13.10.2011 00:46:
> On Wed, Oct 12, 2011 at 03:38:27PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> On Wed, Oct 12, 2011 at 05:43:16PM -0400, Jeff King wrote:
>>> ...
>>>> Instead, let's just add a separate URL parameter to
>>>> http_init, and all three callsites can pass in the
>>>> appropriate information.
>>>>
>>>> Signed-off-by: Jeff King <peff@peff.net>
>>>
>>> Sorry, I forgot to mention: this is meant to go on top of the
>>> http-auth-keyring topic.
>>
>> Hmm, of course the patch was written to help http-auth-keyring topic, but
>> wouldn't this be an improvement that is general enough?  I.e. it could
>> even go to the bottom of the topic, no?
> 
> Yes, it could, and probably should. I suspect it might need some
> rebasing to do that.
> 
> I'm going to float some other possible designs for the topic as soon as
> I put enough polish on them. So I'll try to move this down when I
> re-roll.  In the meantime, if you want to throw it on top, great. If you
> want to ignore it until then, no problem. :)
> 
> -Peff

Thanks, Jeff.

To clarify:

Without http-auth-keyring, this helps in the sense that git reads the
username from a user@host URL and asks for the password only. When using
GIT_ASKPASS or such, the askpass helper is called with "Password:" only.

With (parts of) http-auth-keyring, the askpass helper is called with
"Password for:user@host", which helps the user identify the request, and
which helps helpers such as ksshaskpass to store the password with a
meaningful key in a wallet.

I'm not sure whether it's feasible/worth taking these bits of
http-auth-keyring (improved prompt) out and apply them early. That is,
I'm sure it's worth it (it would alleviate the need for credential
helpers for some users at least), I haven't looked at feasibility ;)

Michael
