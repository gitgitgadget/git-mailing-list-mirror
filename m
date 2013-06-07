From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/18] Change style of some regular expressions to make them clearer
Date: Thu, 06 Jun 2013 19:30:10 -0700
Message-ID: <7vbo7iwt3h.fsf@alter.siamese.dyndns.org>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQvWJ8RRsqKEMooV_AntTBZ1Pi=WA_1LFU955J+9jDzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 04:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkmRY-0000ze-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 04:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3FGCaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 22:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab3FGCaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 22:30:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55F7918DDA;
	Fri,  7 Jun 2013 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F9NbN6ZgZGwv44789diOvLbEbZY=; b=QaPUqu
	VQWLs44ZSdUXH7ZxA+v5Pwz1ZS8LjK4S5M7FQq7bk/63txQVcR4l/KBtr93pYINB
	vOaHduf5TXPV/XB3a+kOIOFJ3rJFaY/cqUkSS8HRg4yFAJxpiVIyLbN/+sZmMLrA
	TWK7hSXpGrY12pANM7DIZ+QmrkgmtxinZtCLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9e2wyQt5hb51Kl/GGaLrzyGAvO6McJ/
	wuX8bP59LnsYs5vRbg/BxrmF3LIPVkHLUu8+F5fKgkTTT/cb4NlRUU09ivyEupSC
	47mPXSCa3npU4M6DAzl4gb+26nl1TLbApBEDOzknEco1ohdzcgBzIFIY0V08UOUF
	B8htnXd1Suw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BEC318DD8;
	Fri,  7 Jun 2013 02:30:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF52B18DD2;
	Fri,  7 Jun 2013 02:30:11 +0000 (UTC)
In-Reply-To: <CAPig+cQvWJ8RRsqKEMooV_AntTBZ1Pi=WA_1LFU955J+9jDzTg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 6 Jun 2013 21:54:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DBBF9AE-CF1A-11E2-B692-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226580>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -                       if (my ($child, $parents) = $line =~ m/^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>> -                               foreach my $parent (split(' ', $parents)) {
>> +                       if (my ($child, $parents) = $line =~ /^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>> +                               foreach my $parent (split(/ /, $parents)) {
>
> This is a behavior-altering change. split(' ',...) is handled as a
> special case[*1*] which strips leading whitespace and then splits on
> /\s+/ (run of whitespace). Changing it to split(/ /,...) makes it
> match only a single space (rather than a run of whitespace).

I initially had the same reaction, but this is reading the output of
the "rev-list --parents" command, whose fields are separated by one
SP each, so there is indeed no behaviour change.
