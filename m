From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Thu, 23 May 2013 17:31:54 +0200
Message-ID: <519E366A.5040504@drmicha.warpmail.net>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org> <519C7431.8050208@drmicha.warpmail.net> <7vy5b7j7kc.fsf@alter.siamese.dyndns.org> <519DEA50.4030407@drmicha.warpmail.net> <7vr4gxhi8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 17:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXUj-0007Py-CZ
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759514Ab3EWPbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:31:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38485 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754876Ab3EWPbw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 11:31:52 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2E44020F2A;
	Thu, 23 May 2013 11:31:45 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 23 May 2013 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=mr7Cm7We4X9JwKWp878snr
	piEUY=; b=XWSfInZs+Aq2I17fBzc0FZ0U1Ty9EkfkRlgwBu346yZXo01hqNrFzy
	Fz5/Ioc4Iklqh0XXgF4IN9v5AqWP0Jd4X+R4etAESyrGCHsF/5CFWx0U+HSvG023
	EOSvnk+rmIY3gF96M+TjlrxQFMxX1ann8HJPGTbfSBCtMEgveQqKw=
X-Sasl-enc: G+eGKN8AyC2fU8i2S2tQ0VmYE/zRFTPzGy6aewcdOYkL 1369323104
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 74F882001B7;
	Thu, 23 May 2013 11:31:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <7vr4gxhi8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225262>

Junio C Hamano venit, vidit, dixit 23.05.2013 16:40:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Didn't you have concerns about storing the context in the object struct?
>> I can't quite judge how much of an issue this can be for fsck and such.
>> I don't want to increase the memory footprint unnecessarily, of course.
> 
> Yes. I thought I had a weather-balloon patch to fsck to use its own
> so that we have something to fall back on if it turns out to be a
> problem (and also so that anybody can see how big the difference is),
> but I highly suspect that any user of object-array other than what
> you are changing in the series wants to use the slim variant, which
> suggests that the information does not belong there.
> 
>> Other than that, the mechanism was still up for discussion (separate
>> "show" attribute or a config) given that the default behavior for
>> showing blobs is not to change.
> 
> My understanding was that the series as-is (not the implementation
> but the external interface) makes us honor what the user tells us
> better, without changing the behaviour for people who don't instruct
> us to do anything differently, so I thought it was a good place to
> stop at.
> 
> The 'show attribute or config' discussion would/should involve the
> possibility of flipping the default, no?  After all, I was getting
> the impression, especially from the "config", that this was "If we
> had known better when we introduced textconv, we would have defined
> it to apply in any situation where you would want a textual form of
> a blob, not limited to diff" kind of thing.
> 
> That is a much longer term thing and my impression was that it can
> built later on top of the series (once its implementation settles).
> 
> So, yes, thanks for pointing out these two points. The bloat in the
> object array element I do care today, the feature and the interface
> I do not think we have to worry about them today to hold the series
> back.

Well, if we decide "showing blobs with textconv is fundamentally
different from showing diffs with textconv" then "--textconv" should not
apply any textconv filters on blobs unless the user has specified them
using a separate attribute (different from "diff").

Therefore, I hesitate introducing the behavior of the current series.
For me, it would introduce something of a "mixed beast".

I wouldn't hesitate introducing "textconv on by default for blobs the
same as for diffs", but that would change existing behavior and the
opposition is strong, for a good reason :)

So, since that one isn't possible, I'm leaning towards the other
extreme: treat the blob and diff case completely separately in the sense
that different attributes are used. Then, even with "--textconv" there
wouldn't be any blob filtering (show/grep) unless the user specified so
using an attribute different from "diff".

I'd rather try out the latter before having the "mixed beast" trickle
down too much, even both its change in behavior and the one from the
attribute version do not show up in daily use until you specify
"--textconv" explicitly.

Michael
