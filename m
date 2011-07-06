From: Junio C Hamano <gitster@pobox.com>
Subject: Re: generation numbers
Date: Wed, 06 Jul 2011 16:22:23 -0700
Message-ID: <7viprfhu4w.fsf@alter.siamese.dyndns.org>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net> <20110706065623.GB14164@elie>
 <20110706070311.GA3790@sigill.intra.peff.net>
 <m3mxgr4has.fsf_-_@localhost.localdomain> <20110706150103.GA2693@thunk.org>
 <20110706181200.GD17978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 07 01:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QebQN-0005vE-PR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 01:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab1GFXW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 19:22:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab1GFXWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 19:22:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65A285681;
	Wed,  6 Jul 2011 19:22:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fuNKQroD27hXdBiGGzAhSCfU/78=; b=M1kr4O
	5Q97uv2LHGLr+p9AnwuCLAm2IqOFeyIGTOu78HCr4RRv1YnMLilwfZDLpY7bbZ/9
	fejkTF+/csXkv1NJinRXZCyGejbrIRXJ4fHMKjln0YOD/rFAbJPtvnHuDNo7AKQk
	8VX+F/gs8VSLoJYuuqD6wWNGRDRD5uEGH3rnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UjXt3y9Bj22LryteZpv04r6xU5UV48ZN
	TT01LEEJgoBtdU081/Ulv6REdOn7Z6YY7o6JKazqPS29OdERw/KvkXeNkCVBZl9+
	eyDbWZxlk7ArSle8FMNpxb1IiyXZFbAubUz7lM2Pys8NeMrDbDaE/JtKpPZ5N0br
	yodz0pHSSjU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B5235680;
	Wed,  6 Jul 2011 19:22:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A45EB567B; Wed,  6 Jul 2011
 19:22:24 -0400 (EDT)
In-Reply-To: <20110706181200.GD17978@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Jul 2011 14:12:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE70E28C-A826-11E0-A901-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176735>

Jeff King <peff@peff.net> writes:

> Yeah, that would be fine. With a sorted list of binary sha1s and 32-bit
> generation numbers, you're talking about 24 bytes per commit. Or a 6
> megabyte cache for linux-2.6.
>
> You'd probably want to be a little clever with updates. If I have
> calculated the generation number of every commit, and then do "git
> commit; git tag --contains HEAD", you probably don't want to rewrite the
> entire cache. You could probably journal a fixed number of entries in an
> unsorted file (or even in a parallel directory structure to loose
> objects), and then periodically write out the whole sorted list when the
> journal gets too big. Or choose a more clever data structure that can do
> in-place updates.

As to the low level implementation detail I agree everything you said, but
I have been wondering how the generation number should intereact with
grafts and replaces. It certainly would be safest whenever you change
grafts (which should be a rare event anyway).
