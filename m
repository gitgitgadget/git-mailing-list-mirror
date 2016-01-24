From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Sun, 24 Jan 2016 14:05:36 -0800
Message-ID: <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<20160119191234.GA17562@sigill.intra.peff.net>
	<xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
	<20160120002606.GA9359@glandium.org>
	<xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
	<DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:06:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNSoC-00081S-Np
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 23:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbcAXWFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 17:05:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756165AbcAXWFj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 17:05:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6138F3E381;
	Sun, 24 Jan 2016 17:05:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8lLfwzc5XQVOnGdXgjvfhTpiCJE=; b=Tx3Z/Y
	rk02xI+oevG54D35cLlSIQJoM26Kz3vvfeIstlihZqnpgSthy5XAoRApmAoAUWk8
	ijpleiAfaWg4hlYv2JLQ0zEINpIuQXXOkkKgO5AV8itgXg/6eTlgnK2L4r0sUk7A
	fRFtbm15J8iyAggxtHQT0HqJOHJOOrmXAlmM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=seRg+YckE36pDFvNXUj7XHjq+S9WAWQU
	VmDpjupQx47Dyi7ZtWOPaIJP6+ZIkprI5YL24uEkv6k9qu71UydUjG0ECjTlrUyF
	5lg6955VoddQdKNYRsGBFxrxdssZAjgq1v5aA8DvsMbzkc5zgZawHdDL2m0Ad+NG
	tKmw7ujFQIA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 490823E380;
	Sun, 24 Jan 2016 17:05:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BAEA3E37E;
	Sun, 24 Jan 2016 17:05:37 -0500 (EST)
In-Reply-To: <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 24 Jan 2016 12:03:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99660164-C2E6-11E5-9365-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284696>

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, but I am confused by all of the above.
>
> We write the thing out with write_entry(), possibly applying smudge
> filters and eol conversion to the "git" representation to create the
> "working tree" representation in this codepath, right?  The resulting
> file matches what the user's configuration told us to produce.
>
> Until the working tree file is changed by somebody after the above
> happens, we shouldn't have to check the contents of the file to see
> if there is a difference.  By definition, that has to match the
> contents expected to be there by Git.
>
> The only case I can think of that the above does not hold is when
> the smuge/clean and the eol conversion are not a correct round-trip
> operation pairs, but that would be a misconfiguration.  Otherwise,
> we'd be _always_ comparing the contents without relying on the
> cached stat info for any paths whose in-core and working tree
> representations are different, not just those that are configured
> with misbehaving smudge/clean pair, no?

To put it differently, if a blob stored at path has CRLF line
endings and .gitattributes is changed after the fact to say that it
must have LF line endings, we should treat it as a broken transitory
state.  There may have to be a way to "fix" an already "wrong" blob
in the index that is milder than "rm --cached && add .", but I do
not think write_entry(), which is shared by all the normal codepaths
that writes out to the working tree, is the best place to do so, if
doing so forces the contents of the paths to be always re-checked,
just in case the user is in such a broken transitory state.
