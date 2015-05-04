From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 04 May 2015 14:03:31 -0700
Message-ID: <xmqqegmwrr6k.fsf@gitster.dls.corp.google.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 23:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNWh-0005FT-Iw
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbbEDVDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:03:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752498AbbEDVDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:03:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAE34EB6B;
	Mon,  4 May 2015 17:03:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rG8B7jHEw6srLbXIasMNV90eJ2U=; b=NEVEjD
	ujaA5SPOtZvtlCv7p5g2W1NPYYkJ0xbL2XovNjaHbr8sHngXBAwBvSb9AIZkOsE5
	l+mXAdNlNfjah9dLCptZBbzzMs2VuDgumzZl4FY3QHECTyyae302aBxvjIpCXLKT
	+Ol2vjv6Q3OJSLI54BK/dctuvmiwAs8HmIcc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=krOY0wk3TjEQ3szqJ8vbLeM+vVS695tI
	EjEhyyerIvDHITxjZgl1yULh9GbEFegKh6fBNjG6AWcrfluAPqOvHyRLyaKIh+/b
	m0Auj2CNsPyB1Nb+R7oenxGOr8Jt1o5cj6MIR8YTIv8N6y45zsKsktKv8TL7ZOop
	6E7iX8v+XGQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32AD84EB69;
	Mon,  4 May 2015 17:03:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96C5A4EB67;
	Mon,  4 May 2015 17:03:32 -0400 (EDT)
In-Reply-To: <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	(Robert Dailey's message of "Mon, 4 May 2015 10:05:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05A4F6A8-F2A1-11E4-985A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268353>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> For #1, do you recommend adding a 3rd setting for `diff.submodule`
> config? Something like "full-log" or something? Or an entirely new
> config? I noticed that in diff.h, the DIFF_OPT flags already consume
> 31 bits. If this is a 32-bit flag, there is only 1 bit left. If we go
> with a 3rd setting for `diff.submodule` I think this might consume the
> last bit.

Unless you are using opts->touched_flags infrastructure to do funky
defaulting dance, there is really nothing that forces you to use a
bit from the flag word for your new feature.  diff_options have many
standalone int fields that are used for either boolean or a small
enum (e.g. degraded_cc_to_c) and it is perfectly fine to use a new
such field.
