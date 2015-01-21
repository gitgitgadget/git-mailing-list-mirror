From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: collect some Makefile variables instead of directly assignment
Date: Wed, 21 Jan 2015 01:23:31 -0800
Message-ID: <xmqqzj9cwkq4.fsf@gitster.dls.corp.google.com>
References: <1421830161-27623-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrVk-0006ng-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbAUJXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:23:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbbAUJXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:23:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F8E126EFA;
	Wed, 21 Jan 2015 04:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/knbBqvZqiKpoVowzS6+jqwbov0=; b=cEBatM
	zUQCLl3l+xYFTQ63X/jwkkxfesnFkqEQGsPandjg2q7HFngv/LUfhmdOljYW1/d0
	gv3nV3POc2c5K5xUUxgmzBeGwuNugpQalcoDv7ZubCKnL90gIsb1Kk9+kHJp6ybc
	/BtdNSpjC3O4x2/IbE4QFF7rpnU6SyoSr2LEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLTzVLTOqEL/fdBO8uQfcvrrZeQZdPY2
	vbFhlA8yWxwvOhm7h8chEISQwkMRgaHExKHjfBr4WgYBErNkUPmNBiig9Zo+dkVo
	9lLP3TDydVZ9mN/mkngz1TB0insIyrsTb0seCkvMSxUKq8+rn9dfrG7iTP947dyr
	dagcoN1eMT4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 772A626EF8;
	Wed, 21 Jan 2015 04:23:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F10DA26EF4;
	Wed, 21 Jan 2015 04:23:32 -0500 (EST)
In-Reply-To: <1421830161-27623-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 21 Jan 2015 14:49:21 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2B5CF790-A14F-11E4-A794-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262726>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Some of Makefile variables as TEST_PROGRAMS_NEED_X and BUILTIN_OBJS filled
> directly by hand, let's collect it with the standard functions of 'make' util.

I am not sure if we want to do this.

$(wildcard) is a double-edged sword.  It will grab any file that
matches on the filesystem, not just the ones we want to include in
the Git source set.  I often have a file called test-something and
I'd prefer not to see such a random thing included in the build,
only because the filename matches some pattern.

While "we consider anything with a name that match the pattern we
say matter (e.g. test-*.c or builtin/*.c) as part of the source set"
is sometimes handy (it allows us to be lazy), it risks surprising
unsuspecting users.

So I dunno.
