From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote.c: drop "remote" pointer from "struct branch"
Date: Tue, 31 Mar 2015 15:29:48 -0700
Message-ID: <xmqq384kpzqb.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173555.GB18912@peff.net>
	<xmqqvbhgq4ci.fsf@gitster.dls.corp.google.com>
	<20150331222431.GB31948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:30:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4fd-0002et-81
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbbCaW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:29:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753640AbbCaW3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:29:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4C8445AC9;
	Tue, 31 Mar 2015 18:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yaLgT/o2Ak1P2jNTR9ffrLsl0Mg=; b=a8P+le
	CQ3/O5wRdSA6gYYgCWCPzAOaPfkItfKO5bhgXnx4DPMuI7QZb3n6JviN6KBLn7Vy
	WwqBSsnTqxLZrE0vldSsbPftySVpDi7IDfNymPsRC6Ut6B0F9KZ9UDg0u8eYEBJP
	/ZGtoMnXcswLsLE5U1BxeuVElerkwAfX6xv8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S02j1IJJo4bVj2s+/9N8paK4RY+/wpyY
	e2x/ATOoIWonyth1s/y/kGuRdFCbgaI67ShjwSV99/WHzkagDd3WQqdthdkmge90
	egJd4qmnxGkplUchPJuxGX4tvW4ZKVShwAq8WLFweHe5HTImMHO0ZMclEtVfpMzi
	IqgrXJ0k7V4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E64445AC7;
	Tue, 31 Mar 2015 18:29:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07E7245ABB;
	Tue, 31 Mar 2015 18:29:49 -0400 (EDT)
In-Reply-To: <20150331222431.GB31948@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 18:24:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 719414F0-D7F5-11E4-ADEE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266569>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2015 at 01:50:05PM -0700, Junio C Hamano wrote:
>
>> it first looked somewhat unnatural that you kept the name with which
>> you need to trigger a search for the structure, instead of keeping
>> the structure, one of whose field is its name already.
> ...
> That is the reason I was trying to explain above. Though I suppose you
> could argue that remote_name suffers the same question (i.e., would we
> ever set it to "origin"?)

Well, another would be that by keeping remote_name and making remote
on-demand, we may still have to keep all the defined branches in
core but we do not have to instanciate all the remotes, if each
branch only knows the remote_name.  A single look-up may be cheap
but that is not a good reason to do one-per-each-branch if we do not
need to.

> It is much worse for pushremotes, which can come from
> branch.*.pushremote, remote.pushdefault, branch.*.remote, or "origin".
>
> I'll try to re-word the commit message.

Thanks.
