From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] cvsimport: fix the parsing of uppercase config options
Date: Sun, 28 Nov 2010 20:30:17 +0100
Message-ID: <4CF2ADC9.8020504@drmicha.warpmail.net>
References: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net> <ad36bc3f6a00c5f7bc643be3f97aa2bcfda990ff.1290697830.git.git@drmicha.warpmail.net> <7vwrnznueh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 20:29:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmwZ-0007Aq-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab0K1T3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:29:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39534 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950Ab0K1T3p (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 14:29:45 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7E3FF739;
	Sun, 28 Nov 2010 14:29:45 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 28 Nov 2010 14:29:45 -0500
X-Sasl-enc: YEpZEQSkmGBSV47bQFLEEwSAZAkiuyNvlvPaReFax0My 1290972585
Received: from localhost.localdomain (p5485894A.dip0.t-ipconnect.de [84.133.137.74])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D6C0F406B41;
	Sun, 28 Nov 2010 14:29:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7vwrnznueh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162350>

Junio C Hamano venit, vidit, dixit 27.11.2010 07:38:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The current code leads to
>>
>> fatal: bad config value for 'cvsimport.r' in .git/config
>>
>> for a standard use case with cvsimport.r set:
>>
>> cvsimport sets internal variables by checking the config for each
>> possible command line option. The problem is that config items are case
>> insensitive, so config.r and config.R are the same. The ugly error is
>> due to that fact that cvsimport expects a bool for -R (and thus
>> config.R) but a remote name for -r (and thus config.r).
>>
>> Fix this by making cvsimport expect the config item "cvsimport.RR"
>> for the command line option "-R" etc.
> 
> I do not think this is "fixing" per-se.  Isn't it more like "We didn't
> have a way to use the configuration file to specify uppercase option; now
> we do thanks to this patch, and here is how"?

It is a fix because the the existing code base checks for "cvsimport.r"
in order to set "opt_r" and for "cvsimport.R" in order to set "opt_R"
(etc). That is, it sets "opt_R" from a config variable which should have
nothing to do with it (cvsimport.r=cvsimport.R).

In the case when R expects a boolean you'll notice because "config get
--bool" will die, but if both "x" and "X" expect the same type then you
set defaults for "opt_x" and "opt_X" from the single "cvsimport.x".

> And the "here is how" workaround, while it may be a reasonable way out, is
> so obscure that it needs to be documented, no?  Ahh, that is what [3/3] is.

Yes, 3/3. Should I squash this with 2?

> The $ckey change from 1/3 needs to be done here, I think.

Yes, sorry, this was an "add -p" related oversight on my side. I'll resend.

Michael
