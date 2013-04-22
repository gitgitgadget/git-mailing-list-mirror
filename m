From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Mon, 22 Apr 2013 12:29:10 +0200
Message-ID: <517510F6.7040301@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net> <20130420040643.GB24970@sigill.intra.peff.net> <51729A6D.3030501@drmicha.warpmail.net> <20130421033710.GA18890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 12:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUDzi-0006La-5u
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 12:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab3DVK3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 06:29:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34835 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab3DVK3D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 06:29:03 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6C8BD20A13;
	Mon, 22 Apr 2013 06:29:02 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 22 Apr 2013 06:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hmq5Ssrdt0044BadjuwlyV
	QYhwk=; b=XMlrIAmv1UrwUnp5a2bol1UjoFRIQbEPSrVp9KNjqyN6l56baCZDJJ
	NMK3Ul/BnXTbVZAbuskhlEIA0YNtVGt1d1nrO93ug8Svr4zfwTfx0UCScu7sH+aq
	aKtkXJlivT5piOVHcP+ypLMBLnha33GYqfd/8ZTXNHZyIOfqicCqk=
X-Sasl-enc: 4plDtijovi8UMqwVFS9AiNFZ2Eo/OiAwvgcylVniczwr 1366626542
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C453D200060;
	Mon, 22 Apr 2013 06:29:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130421033710.GA18890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222005>

Jeff King venit, vidit, dixit 21.04.2013 05:37:
> On Sat, Apr 20, 2013 at 03:38:53PM +0200, Michael J Gruber wrote:
> 
>>> Wait, this does the opposite of the last patch. If we do want to do
>>> this, shouldn't the last one have been an "expect_failure"?
>>
>> The last patch just documents the status quo, which is not a bug per se.
>> Therefore, no failure, but change in the definition of "success".
> 
> IMHO, the series is easier to review if you it does not go back and
> forth. If you have one patch that says "X is the right behavior", and
> then another patch that flips it to say "Y is the right behavior", the
> reviewer would read each in sequence and want to be convinced by your
> arguments for X and Y. But you probably cannot make a good argument for
> X if you are trying to end up at Y. :)
> 
> So I'd much rather see the test introduced with the desired end
> behavior, marked as expect_failure, and the commit message contain an
> argument about why Y is a good thing (and squashing the tests in with
> the actual fix is often even better, because the fix itself would want
> to contain the same argument).
> 
> Just my two cents as a reviewer.
> 
>> My reasoning is twofold:
>>
>> - consistency between "git show commit" and "git show blob"
> 
> I'm not sure I agree with this line of reasoning. "git show commit" is
> showing a diff, not the file contents; textconv has always been about
> munging the contents to produce a textual diff. It may be reasonable to
> extend its definition to "this is the preferred human view of this
> content, and that happens to be what you would want to produce a diff".
> But I do not think it is necessarily inconsistent not to apply it for
> the blob case.
> 
>> - "git show" is a user facing command, and as such should produce output
>> consumable by humans; whereas "git cat-file" is plumbing and should
>> produce raw data unless told otherwise (-p, --textconv).
> 
> That holds if the textconv is the only (or best) human-readable version
> of the file. And maybe that is reasonable. But is it possible that
> somebody uses "textconv" to produce a better diff of some already
> human-readable format? For example, imagine I define a textconv for XML
> files that normalizes the formatting to make diffs less noisy. When I am
> not looking at a diff, what is the best human-readable version? The
> original, or the normalized one? I'm not sure.
> 
> Note that I'm somewhat playing devil's advocate here. For the cases
> where I have used textconv in the real world, I think I would probably
> prefer seeing the converted contents, and I am happy to call it user
> error if I use "git show HEAD:foo.jpg >bar.jpg" accidentally. But I also
> want to make sure we are not regressing somebody else unnecessarily.

Yes, the thing is that textconv helps diff by converting content (to
text) before the (textual) diff. So it's somehow a double-faced beast.

It's clearly activated by a "diff" attribute; so that would be a strong
argument against my patch, at least against defaulting to --textconv for
blobs.

OTOH, textconv does have this aspect of converting text to a form
digestable by humans (pre-diff, granted), which is the argument for
defaulting to --textconv in porcellain.

We could use a separate attribute "show" in addition to "diff", but I
don't think it's worth going there, unless there is a strong use case
for "diff-specific textconv" which one would not want to apply when
showing just the content.

Michael
