From: Junio C Hamano <gitster@pobox.com>
Subject: "add -p" breakage
Date: Wed, 06 Apr 2011 13:09:09 -0700
Message-ID: <7v4o6bi1lm.fsf_-_@alter.siamese.dyndns.org>
References: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
 <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com>
 <7voc4ji23p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnaud Lacombe <lacombar@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Z2a-0003UO-U0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 22:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab1DFUJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 16:09:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab1DFUJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 16:09:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60727492F;
	Wed,  6 Apr 2011 16:11:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UW5xnst5eLAwU1L6+mhz+A+yy90=; b=xr2Yrs
	CXkZ4Q4l8RRSeelLz1zq+Tj3xhtPduX8M12ioDThRhDM8L3o9w57agmKRT+Pxgew
	S1+9/xQq/rHeANUhGmoIACkBxuCZeQbHlawoQM2gATPSAo74UStvyq0X9vUEI2YW
	aVG+JjQVJTULU343xLwpAqQr4XwUq/hs2bJMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/ZR8ZQyLWtvIOQDEGrjDf5ua9GjNpPQ
	d8ilCrqlJ7zfr64ztwmUI43pLn3UGair+UUBEuiAsORUZ7OCCBFvgBDSDtdHJNRP
	hUkV6WJJBf4Chwm9JiXh4fWiLCZr7oOFTKqhQ/mla2ItoJ2W/z84Ed9BjlWGYM3l
	O5Gic9c1wgo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D9F3492E;
	Wed,  6 Apr 2011 16:11:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D23C492D; Wed,  6 Apr 2011
 16:11:05 -0400 (EDT)
In-Reply-To: <7voc4ji23p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Apr 2011 12:58:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0381AE0A-608A-11E0-94BE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171014>

Junio C Hamano <gitster@pobox.com> writes:

> Arnaud Lacombe <lacombar@gmail.com> writes:
>
>> This commit introduces a regression when editing splithunks using "git
>> add -p". Reverting the patch fix the regression.
>
> Thanks for a report.  I don't have a time to look at this now; help from
> "add -p" people would be appreciated.
>
> I have a suspicion that the symptom may be a bug in "add -p" exposed by
> the change; "add -p" which used to count the patch lines carefully itself,
> but was modified to use 'apply --recount' in more recent versions.

Sorry, not that one, but what "add -p" used to carefully do but punts
these days is to combine adjacent hunks correctly.  I suspect that
laziness is coming back and haunt us, and if that is the case, we should
fix it there, and should not work it around by breaking the normal patch
application codepath.
