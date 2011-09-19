From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 14:38:41 -0700
Message-ID: <7vsjns8b6m.fsf@alter.siamese.dyndns.org>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
 <20110919195335.GA31930@sigill.intra.peff.net>
 <20110919201804.GB31930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dieter@schoen.or.at, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lY9-0004b4-Cg
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 23:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258Ab1ISVio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 17:38:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab1ISVio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 17:38:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB0C5631;
	Mon, 19 Sep 2011 17:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m5WWrZwqyu0GJUVKBusprS4PNoY=; b=jT8NHw
	oT7QOUfF4YjGS1m2cm/20uR3XbJQivnPGKXYlZ0kz1IVVPQdeO0mCnul6R9DImG4
	Xd1qtmSostf6v44dwDrLjVLcRKhyT4BIFFYcAD0sVH/daSQ0/MeUseXJ0+fm82GG
	sgoAnQzeHFsp9NrNDzT0lUBW625MzAerxHMg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LivQqcK+k+EM968v8rrt0I6Q4sHAM8Yx
	YAVbnIt1UiIA2ZrXBug2K8NBPO5+xxd6wdgBKktTPzZV6KOJ1BgZ3yAfdfS6k20Z
	knsrheh+9ywyd/1OSnFE9cXEj3fx0YqWLvkoYwkg89OUg1gY6dVuRjcp7TAbm2in
	dAGTiMfwtUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9358D5630;
	Mon, 19 Sep 2011 17:38:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AFFE5625; Mon, 19 Sep 2011
 17:38:43 -0400 (EDT)
In-Reply-To: <20110919201804.GB31930@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 16:18:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF1F03EC-E307-11E0-9328-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181710>

Jeff King <peff@peff.net> writes:

> I was tempted to just drop this section entirely. It's mostly redundant
> with the DESCRIPTION section, and any extra details could be folded in
> there. The most useful bit is the "what do you do when there is
> corruption". But that should perhaps get its own section, if somebody
> feels like writing something more detailed (I thought we had a guide
> somewhere, but I couldn't find it).

Yeah, I've been thinking about making it an error to give refs to fsck, as
I do not think the use cases for feature justifies the possible confusion
it may cause.

One possible use case might be when your repository is corrupt, and does
not pass "git fsck" (without any argument).  In such a case, if you are
lucky and your disk corrupted objects only reachable from a recent topic
branch, you might find that this command:

	$ git fsck master next ...list other topics here...

still succeeds, so that you can figure out which topic makes such a
limited fsck fail when it is listed on the command line, judge its
importance and resurrect what you can from there, before nuking it to
bring the repository back in health so that you can recreate the topic.
