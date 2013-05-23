From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Thu, 23 May 2013 07:40:29 -0700
Message-ID: <7vr4gxhi8y.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<519C7431.8050208@drmicha.warpmail.net>
	<7vy5b7j7kc.fsf@alter.siamese.dyndns.org>
	<519DEA50.4030407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 23 16:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfWh2-0001uA-QK
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 16:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281Ab3EWOkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 10:40:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758967Ab3EWOkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 10:40:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4981920B97;
	Thu, 23 May 2013 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCPPu90zXh18yWKw20ThuGAE04A=; b=gEw44u
	bfYjfx8RsyuSewKD9+yPUbsGA6t2eN3vERmneebeEo0kPq+NOVfXAEdQPsJIVMWv
	ZTmpCgoGDtz7TZteb+ac/Oya4XHV7alqbnXIssBDbMczsr4/x2JUu/7BUy8qGFE2
	NF+gAGOpA//dwlvolFlEkeq0fSLQXurvc6LVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJTaIhwJheUMbtwlWFN0RnKwcMKeccrq
	V7BukQtfFqnSQz9MiWgYl0+2WqEjSLyjmYc66gTFD/bN+fTYJRjnrwGqOJ3z45in
	AMh5XOu3jJ0ze1PzVlVoYq4OX1LXsyC6J/MzM4Wx0DlEdkoTWVrMXhVkakKHqc8N
	c9iSFkVx+7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D4120B96;
	Thu, 23 May 2013 14:40:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A58BD20B94;
	Thu, 23 May 2013 14:40:30 +0000 (UTC)
In-Reply-To: <519DEA50.4030407@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 23 May 2013 12:07:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7A2ABDC-C3B6-11E2-A4B0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225251>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Didn't you have concerns about storing the context in the object struct?
> I can't quite judge how much of an issue this can be for fsck and such.
> I don't want to increase the memory footprint unnecessarily, of course.

Yes. I thought I had a weather-balloon patch to fsck to use its own
so that we have something to fall back on if it turns out to be a
problem (and also so that anybody can see how big the difference is),
but I highly suspect that any user of object-array other than what
you are changing in the series wants to use the slim variant, which
suggests that the information does not belong there.

> Other than that, the mechanism was still up for discussion (separate
> "show" attribute or a config) given that the default behavior for
> showing blobs is not to change.

My understanding was that the series as-is (not the implementation
but the external interface) makes us honor what the user tells us
better, without changing the behaviour for people who don't instruct
us to do anything differently, so I thought it was a good place to
stop at.

The 'show attribute or config' discussion would/should involve the
possibility of flipping the default, no?  After all, I was getting
the impression, especially from the "config", that this was "If we
had known better when we introduced textconv, we would have defined
it to apply in any situation where you would want a textual form of
a blob, not limited to diff" kind of thing.

That is a much longer term thing and my impression was that it can
built later on top of the series (once its implementation settles).

So, yes, thanks for pointing out these two points. The bloat in the
object array element I do care today, the feature and the interface
I do not think we have to worry about them today to hold the series
back.
