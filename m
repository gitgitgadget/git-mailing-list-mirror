From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote helpers
Date: Thu, 22 Jan 2015 14:24:38 -0800
Message-ID: <xmqqh9visbbt.fsf@gitster.dls.corp.google.com>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
	<xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
	<20150122070301.GA18195@glandium.org>
	<xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
	<20150122080638.GA9546@glandium.org>
	<xmqqoapqu2h4.fsf@gitster.dls.corp.google.com>
	<20150122221330.GA31912@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 23:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQBD-0006ny-GR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbbAVWYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:24:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753235AbbAVWYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:24:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC39732855;
	Thu, 22 Jan 2015 17:24:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eiODmHfzwDf8lPMzLHGez0TPjKA=; b=PA/lS7
	gAEjLW80ghq6C3DanLCBD+fMPTHG+4XGdQUAZA5r9NMUGPCITAIUdup2zMJzbZoZ
	73eG3s2OQsFVpiaibaqjuk0fWv8MzpTrl46lF5fh44td0nuTnA/luzBzFbwyoGP7
	T8KrAqHiIAaUGng0vUO6zx8TF9KWh4mhrp6zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HgkxWfOITNONOp8TFoD4e24TSN4lk2L3
	ptXqbQUb4NRdloW0+JXpVdVPWWpo3vYiI801ocasnj+nZ8wYt6NSYW2B7yuBaben
	2GTXwXZzC3Qk11OGdqaiSu6BbFmzDp2tvYk+/zv7oC1iZQAQN4VGjv0RgFr3f5F1
	icng0MEd/L8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B229032854;
	Thu, 22 Jan 2015 17:24:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CFA932853;
	Thu, 22 Jan 2015 17:24:40 -0500 (EST)
In-Reply-To: <20150122221330.GA31912@glandium.org> (Mike Hommey's message of
	"Fri, 23 Jan 2015 07:13:30 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74CDB7CA-A285-11E4-997E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262879>

Mike Hommey <mh@glandium.org> writes:

> On Thu, Jan 22, 2015 at 09:52:55AM -0800, Junio C Hamano wrote:
>
>> Does the new code avoid regressions for them and if so how?  That is
>> what was needed in the justification.
>> 
>> For remote helpers that support the 'list' command, asking for a
>> symref and asking for a ref that the symref points at both work OK
>> and behave the same, and hopefully that would be true even when the
>> latter is a symref that points yet another ref, so dereferencing
>> only one level on our end when making a request, instead of letting
>> the remote side dereference, is not likely to cause regression.
>
> If I'm not mistaken, in that case with more than one level of symref,
> nothing would break more than it already is, the bug would only not be
> fixed for that case.

Yes, I think we are in agreement.  All is well.

> That said, does this theoretical double indirection actually
> happen in the wild?

With the proliferation of Git-using people and third-party tools
that work with Git, I think the value of asking that question has
diminished.  People do strange things.

And I do not think the patch under discussion does not introduce any
new theoretical funnies; it fixes one known case and leaves the rest
unfixed, without introducing any new breakage, which is perfectly
fine and exactly how we want to make progress.  If the unfixed one
has a real-world need to be fixed, somebody will raise hand, and if
they do not bother to even raise their hands, that is an indication
that it is not worth our time worrying about it.

The only thing we need to avoid, while making "one step at a time"
progress, is to paint ourselves to a corner we cannot get out of by
promising too much --- and I do not think the patch under discussion
does that, either.
