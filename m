From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc.linkedobjectdir discussion
Date: Tue, 24 Feb 2015 14:26:08 -0800
Message-ID: <xmqqsidvosjj.fsf@gitster.dls.corp.google.com>
References: <CAFwrLX7AVbhbP-Ha3Vag+7o5a-8fSaQxxx+z0DRurdzY-pBwkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Entriken <fulldecent@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:26:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNvt-0004We-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbbBXW0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:26:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbbBXW0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 17:26:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 559313BB83;
	Tue, 24 Feb 2015 17:26:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jr6o5u6ELCIUsb2CJ03Dx9+4CVA=; b=ocJFkg
	AXZeEymntQWEUrfXo8zmruqKZ82y0RKpDdcgQmfVRlPRgOmcAN4I2vHEqZXoyA2m
	MgD0+VlRxRE69DBY54gMj89hAxJa5ZPFT/srWPYxS8jd1iVQ29nfeX8X0L1+JM7I
	G18LZpWmYExq6AevMcYlAgYSpK3LZAMIzVDKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vokMxj+b70xd04Qxt51V5RxKi4YDn9jS
	fM4lvNHSTPdh7pyNM8JW/UonkFbTX63c9lO+Oz1J3yJ93jGbg7ogzLdkC6XioKe5
	KCXaXD64yFCQ0bKGKV/I3Ir6SEcur5xRceIMe5P8L03BJp+aawIXihWjKTnLRJq5
	tgSgUsQOU/I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C3813BB82;
	Tue, 24 Feb 2015 17:26:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA1F43BB6E;
	Tue, 24 Feb 2015 17:26:09 -0500 (EST)
In-Reply-To: <CAFwrLX7AVbhbP-Ha3Vag+7o5a-8fSaQxxx+z0DRurdzY-pBwkQ@mail.gmail.com>
	(Will Entriken's message of "Tue, 24 Feb 2015 16:56:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21E81DDA-BC74-11E4-A64F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264355>

Will Entriken <fulldecent@gmail.com> writes:

> USAGE - CACHE HIT:
> During another pull or clone on a different working directory, git
> will find the required object in LINKEDOBJECTDIR and hard link into
> the active repo's object store.

What happens when the necessary objects are in a packfile, mixed
with other objects that this repository does not need but may be
necessary for other repositories?

> USAGE - DELETING:
> Whenever deleting an object, git will stat the file to see to see if
> its link count is 2, if so, both copies are deleted.

This is totally unworkable if you ever pack your repository.  And
packing loose objects is a lot more efficient way to reduce your
disk footprint than sharing the object store among a handful of
repositories.
