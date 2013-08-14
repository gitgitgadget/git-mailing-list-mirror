From: Junio C Hamano <gitster@pobox.com>
Subject: Re: duplicate objects in packfile
Date: Wed, 14 Aug 2013 11:29:24 -0700
Message-ID: <7v4nast9bv.fsf@alter.siamese.dyndns.org>
References: <20130814181718.GA7911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9fp8-0005eH-BD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab3HNS33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:29:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932991Ab3HNS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:29:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13EC3376DD;
	Wed, 14 Aug 2013 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fkxyEutwNPys4ja0pMPb93vYIdw=; b=RpL8uE
	opuewLQSZtPPXWh4keqVt33CvbUhh/jMM3fH3Q38JgRmdniWST3tc1YlycQR+2I7
	ejbPIsfGRT8fJIl4PHN/GTSobLS11YRD+xFJ/SJLQU5YYnSv32G43rA6yDAMhbX8
	vzxbTD1SDBhS8PzAxzrdtfHWGJwBjMkNk8gdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtXcmgERJV0hpXd1971eryZc3Is1NtWT
	aF9VNy3B9+YCVDxoIoXw2xbXeBaBQvP9L3g/8BNUbNicIlT+GQUGEsYLVCb3FaCt
	R9Iex/KTblIGEcIHKyADsEBqR0/83dTIsoAi2UnqlPgcsw3M+Cn8razmnFpD7cNQ
	s2nMh82BA+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 068AC376DC;
	Wed, 14 Aug 2013 18:29:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DDD1376DB;
	Wed, 14 Aug 2013 18:29:26 +0000 (UTC)
In-Reply-To: <20130814181718.GA7911@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 Aug 2013 14:17:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 730A689E-050F-11E3-A325-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232307>

Jeff King <peff@peff.net> writes:

> lookup does not.  It hits an assert() that can only be triggered in the
> face of duplicate objects. For example:
>
>   $ git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
>   commit
>
>   $ GIT_USE_LOOKUP=1 git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
>   git: sha1-lookup.c:222: sha1_entry_pos: Assertion `lov < hiv' failed.
>   Aborted

Older versions of JGit used to put duplicate objects in a pack, and
IIRC Shawn declared that a bug in the packer and fixed it, so from
that point of view, I think rejecting is probably the right thing,
even though I think warning and continuing is also acceptable and
indeed may be better.
