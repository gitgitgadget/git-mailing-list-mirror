From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 13:23:10 -0800
Message-ID: <xmqqoadich4x.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
	<567985A8.2020301@alum.mit.edu> <4689734.cEcQ2vR0aQ@mfick1-lnx>
	<6263203.WlZuyGWxlh@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBUOs-0006Wr-8f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 22:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbbLVVXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 16:23:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbbLVVXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 16:23:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CC493651B;
	Tue, 22 Dec 2015 16:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HyGfnar6QQ9tRzBycAzy1Sc7WsU=; b=aRxC2i
	+FwXdgPz/pM840Kmdv6Gh568fRLP+0A3Ivt4wLFZdsRhzTEpfqoHnQ3B6prjxUca
	ELaKYXpKncIHXXtzb1nR5sd41AWhnjwxBsXEV4m0lYKnAjYf1Km8bl39PSVDx1Mf
	Cs6ZZBAoUS3CfZ5HUWgJzxlDFVUR+JAabvy8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HMeZ4F8rpNmT1GdEVNLMQl4x3tC7c2IB
	nRPHe2pvDRsBWHaDmWDxKnrp7SOlwNn0fTmdae7dcOQA/52plnl9+ISCExcWA1Pe
	JkBjrtCL7ldsFbTSXlm5vIFYHNGADDL9NvdGkLRm+UxLGO6ylbxeWy8vFv83DFYm
	eyd3OdsHWOw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 632473651A;
	Tue, 22 Dec 2015 16:23:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D1A5836519;
	Tue, 22 Dec 2015 16:23:11 -0500 (EST)
In-Reply-To: <6263203.WlZuyGWxlh@mfick1-lnx> (Martin Fick's message of "Tue,
	22 Dec 2015 13:56:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 345D3A7A-A8F2-11E5-B39F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282909>

Martin Fick <mfick@codeaurora.org> writes:

> ...  What if we added
> a leading slash for absolute references? Then I could do
> something like:
>
> /HEAD
> /refs/heads/master
> /refs/tags/v1.0.0
> /refs/remotes/origin/master

Yeah, that is one way to allow a tool to be absolutely certain there
is no funny DWIMmery going on.

> This is a long term idea, but it might make sense to
> consider it now just for the sake of storing refs, it would
> eliminate the need for the ".." notation for "refs/..HEAD".

I do not see how the absolute notation has anything to do with
eliminating "the need for the '..' notation" at all, though.

The funny "..HEAD" was brought up only because Shawn wanted to omit
a single level of dereferencing of a tree object, so that the
top-level tree for his ref backend would have "heads/", "tags/", etc.
in it, and because "HEAD" is not next to "heads/" and "tags/", it
needed some funny notation to avoid squatting on "HEAD" that should
mean "refs/HEAD" in the notation.

> Now if we could only figure out a way to tell plumbing that
> something is a SHA, not a ref? :)

You do not need :) there; I think we discussed something along that
line in the past few weeks (see the list archive).
