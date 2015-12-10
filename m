From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 15:44:56 -0800
Message-ID: <xmqqzixhg96v.fsf@gitster.mtv.corp.google.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
	<CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
	<CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
	<CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
	<20151210183426.GA27609@sigill.intra.peff.net>
	<xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
	<20151210204034.GA29055@sigill.intra.peff.net>
	<20151210213228.GB29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:45:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7AtU-0003nZ-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbbLJXpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:45:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753279AbbLJXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:44:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A257433A58;
	Thu, 10 Dec 2015 18:44:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ci+pjeRpLwdn1WhOCaFMG1M/Nz0=; b=aJ4646
	8KS1AvLNwPr2npZmrnXjIyiIZthrT5+Psu2Sm3N+avvyqNXBA+JV0jFpR/0ap0ZI
	mLmwzuD1ItbVQX0MAA5LIF9exKXNRC/rnuPsZ+k/p2DCsKHbM6SZCPFOVpt60wBw
	iaUylIuP3bY0Lw9y7h9oAzfCBizxaFXQLtcXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UqdOa7ThmXEPA0JpD6zvrfVfpaNRHKzk
	Qi6thme/ZEBINBEcy9bhRIOfLI+vHogCpdynzTG1dRkgE1BsuoxrLwlv2LbWdduS
	/QKUDRQQ6c9u2P9slDIrWkhVes6CCkPNWNcEedONZmd1zQGk/kA8b1+wVk66s6lU
	md9vf3hYFw4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 978C633A57;
	Thu, 10 Dec 2015 18:44:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC24133A56;
	Thu, 10 Dec 2015 18:44:57 -0500 (EST)
In-Reply-To: <20151210213228.GB29055@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Dec 2015 16:32:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0570FDA4-9F98-11E5-81ED-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282245>

Jeff King <peff@peff.net> writes:

> I don't think we want to pass down a "be strict" flag to the low-level
> code filling in default_{name,email}. We might be strict in one call,
> and non-strict in another within the same program. Worse, we actually
> call ident_default_name() even when we don't actually want the name (we
> could fix that, too, but it just adds more cases to the code).
>
> So here's my solution, which instead carries the "is it bogus" flag
> along with the default strings.
>
>   [1/3]: ident: make xgetpwuid_self() a static local helper
>   [2/3]: ident: keep a flag for bogus default_email
>   [3/3]: ident: loosen getpwuid error in non-strict mode

Thanks.  Looks sensible.
