From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Fri, 29 Jan 2016 09:34:27 -0800
Message-ID: <xmqqlh78jnmk.fsf@gitster.mtv.corp.google.com>
References: <20160128225123.GA20045@dcvr.yhbt.net>
	<20160128235339.GB10308@sigill.intra.peff.net>
	<20160129003816.GA26200@dcvr.yhbt.net>
	<xmqqpowljcn1.fsf@gitster.mtv.corp.google.com>
	<20160129034748.GA21125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 18:34:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPCwO-0008IT-5D
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 18:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbcA2Reb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 12:34:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756577AbcA2Rea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 12:34:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 944263E265;
	Fri, 29 Jan 2016 12:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7B6KJSxG4XqtokjuIhhZGxT4JKE=; b=rg2vQo
	kqqXMBxwOpWScGLVryTxKbPSDNgtqhCyWtf50uZJKMH3yXqSFNXi0W0wjdY8rG1U
	VGkVmXUL4/gJfMf8Dn5YBzx/2POnlf1xqkvu7A9PJShJU+ajtq/z4TLgY0vfMEud
	+73r2/khBLcHWmceLQKWptVnHrmO42OSADxyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtjdnKACmKR8aG7JQoKHo5kjVKtF0DM7
	tsX7pD1TEEbQD/Sw0IicIjn8v+h5YX900RdGrktzg+qoCAHoYg2Gf5lYE2H5o4Ci
	GHjtrGYCFn4j+4dUZJSgBLpel6QeVQAMwUHivSTx/eDLwB9sljEHpmF/WEYYIgZc
	2X+2ENiMJiA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B1513E264;
	Fri, 29 Jan 2016 12:34:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C511B3E263;
	Fri, 29 Jan 2016 12:34:28 -0500 (EST)
In-Reply-To: <20160129034748.GA21125@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Jan 2016 22:47:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C7C1F1C-C6AE-11E5-930E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285079>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 28, 2016 at 07:19:30PM -0800, Junio C Hamano wrote:
>
>> I just reviewed the output that are protected by CONNECT_VERBOSE;
>> they look somewhere between pure debugging aid (like the protocol
>> dump that are shown by "fetch -vv") and progress display, and at
>> least to me they are much closer to the latter than the former, in
>> the sense that they are not _so_ annoying as the protocol dump that
>> are clearly not meant for the end users, and that they say "I am
>> looking up this host's address", "Now connecting to this host:port",
>> etc.
>> 
>> So, I personally find this addtional output not _too_ bad if we give
>> it with "fetch -v" (not limiting to "fetch -vv").
>
> Yeah, I do not feel that strongly, and am OK if it is attached to a
> single "-v". I don't think we make any promises about scraping stderr,
> so it is really just about end-user experience.  It is mostly just my
> gut feeling on what I'd expect based on other parts of git (especially
> "fetch -vv" in other circumstances).

Yeah, after re-reading the messages in this thread, I realize that I
missed the fact that you do consider these CONNECT_VERBOSE messages
as debugging aid and from that point of view "fetch -v" that shows
these messagse in addition to what you get from "fetch" may be a bad
idea.

But after inspecting what CONNECT_VERBOSE would add to the output, I
am inclined to say that, especially if some of these steps can
exhibit multi-second stalls, they fall more into the "progress
indicator" (aka "do not worry, we are not stuck, be patient")
category than "debugging aid" category.  The former includes
"remote: Counting objects..." that is shown by default (you need to
give --quiet to squelch).  So I think it is OK to show the
CONNECT_VERBOSE messages with "fetch -v"; if somebody feels strongly
that these messages should be shown unless --quiet is given, I might
even be persuaded to agree, but I am not that somebody, so...
