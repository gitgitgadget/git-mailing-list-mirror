From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: never skip files included in index
Date: Sun, 11 Oct 2009 15:22:05 -0700
Message-ID: <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
 <20091011191440.GA2532@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 00:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx6pC-0001Mo-PR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 00:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZJKWW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbZJKWW4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 18:22:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZJKWW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 18:22:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47D7A7424D;
	Sun, 11 Oct 2009 18:22:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=v3HMtGRySSilA0hi1nBNBt83IFU=; b=Z0QV13xQOdPaCO+3Z6tnYT9
	5c4SyO1nwd02XLjyRvryM2R47M1/oxwyEpBDdqTVNECgqY3JYvkMuoM89+1Mhlt/
	ZVX/UjSeg71d+72C5SnHim4OrvzlLODDQHaPhPkigrvdL7LsSE6SzYkLJbQ+G7Ea
	Dy2TWXuDv6hxcpJ72bSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=W2dSodsII5WsN7TSoKGFH0MCkk8FF6OfzCw6J2zvX3+ncD2JF
	GxG/Ghd3eDQKOXTJeYwLiYMKA6xzYbTg+qxzWY15qcQW8ewd6O5OWJLcmkAETQN+
	GaVtHKjS32r3A4Rx5DFeuDTBJU8I+4FJBBmGgJPe8F+TR0qOwlw0pRxkn0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 195107424B;
	Sun, 11 Oct 2009 18:22:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFFC87424A; Sun, 11 Oct 2009
 18:22:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85120536-B6B4-11DE-A676-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129962>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 11, 2009 at 11:52:10AM -0700, Junio C Hamano wrote:
>
>> Thanks.
>> 
>> The change looks innocent enough and I do not expect to see any unexpected
>> regressions from it, but it is a bit too late for 1.6.5 cycle, so let's
>> queue this fix and aim for 1.6.5.1.
>
> I think this patch is good to apply, as there is no conceivable reason
> to even look at excludes when listing modified files.
>
> But this triggered my spider sense; shouldn't --exclude-standard simply
> be a no-op for ls-files when we are not listing untracked files? And
> bisecting, it seems that it is a very old regression caused by 63d285c
> (per-directory-exclude: lazily read .gitignore files, 2007-11-29).
>
> I don't know if it is worth fixing now or not. It does seem a bit
> inconsistent to me (since everything else is very clear that .gitignore
> is only about untracked files), but nobody seems to have been
> complaining for the last two years (and they may have, in fact, been
> coding to the new behavior).

This is one of those moments when I feel very blessed to have competent
and diligent people around me ;-)

I think you are right; that we shouldn't filter the output with gitignore
entries when showing what is _in_ the index.
