From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 10:58:10 -0800
Message-ID: <xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Lee Hopkins <leerhop@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 19:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJSda-0000Si-VO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 19:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaB1S6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 13:58:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbaB1S6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 13:58:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC446FC1F;
	Fri, 28 Feb 2014 13:58:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sq+guCH9tLVPtTtJzxNseq+Lpl4=; b=w6AK7o
	xmMaSMY/JmYraGTcEdVTbO3hDyCLr9dqsDsmMo2stksgJs1eimXUh70Gb5OLUUfJ
	abYrHl2Sf9jANvYtlGb9KSHSpeHflOPwUS8rKN6IjgHm5sR+Y921VSHI1GtC3/W1
	ug+Pg/ttc2QYFXOp3Yico74CJjKt4uvd3IgNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b0MgjyNW46Ax9R+VpJpLDcEI6O9cBUJz
	WhW46aIGB89E/00943rbHhjXNC9w9UX5vGoIbp3+tqEl8P0szSYOf779znN4m1i1
	aRgtUxdmF5PVotvV2T07RdAhIIbs4hgwWNepRbXdoUwqmSDOEgoPxwpCgGfl8M2w
	ENIxaTmmPnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A6EF6FC1E;
	Fri, 28 Feb 2014 13:58:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22F4F6FC19;
	Fri, 28 Feb 2014 13:58:13 -0500 (EST)
In-Reply-To: <5310959D.709@gmail.com> (Karsten Blees's message of "Fri, 28 Feb
	2014 14:56:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 460F6C68-A0AA-11E3-9723-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243003>

Karsten Blees <karsten.blees@gmail.com> writes:

>> If you are on a case-insensitive filesystem, or work on a cross-platform
>> project, ensure that you avoid ambiguous refs. Problem solved.
>> 
>
> So its OK to lose data if you accidentally use an ambiguous ref? I
> cannot believe you actually meant that.

I think he meant what he said: "you avoid ambiguous refs".  He did
not say "it is not Git's business to help you doing so".

I think it is prudent to warn in the end-user facing layer (read: do
not touch refs.c to implement something like that) when the user
creates "refs/heads/Next" when there already is "refs/heads/next",
and I further think it would make sense to do so even on case
sensitive platforms.

We warn ambiguous refs across refs hierarchies (e.g. if you have
refs/heads/next and refs/tags/next) with core.warnAmbiguousRefs; I
do not think it is a stretch to either introduce a new configuration
core.warnCaseInsensitiveRefs (auto-detected at the same place as we
auto-detect core.ignorecase) or use the same core.warnAmbiguousRefs
to trigger a warning upon seeing both "refs/heads/next" and
"refs/heads/Next".
