From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 01 Mar 2015 19:10:06 -0800
Message-ID: <xmqqioekf629.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
	<CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
	<xmqqwq30fhbg.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.2.02.1503011707040.12474@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Mon Mar 02 04:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSGkM-0007OC-9i
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 04:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbbCBDKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 22:10:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751781AbbCBDKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 22:10:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 710973C47F;
	Sun,  1 Mar 2015 22:10:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qz2HOMnaIT0MQbRlWXMwE/PDzhk=; b=OTfYIt
	wxPl9qtdjUizaxRLPBBzIYT8Z3WKuUkWJ/j6UVP4POHrIpYSvWCgioorAn3cqIIh
	Dk2mgXkbLZgVkW17WC8OuNuUy6wNFRDciQ1g4XwTuqHSnSGmfTGigWCUp8WQsm4T
	dSYrnOgfJQyD7ZF/MuqXi8OipFhlz3QnXdELc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S6eXkcR+TiQ45D6fn9r/jcZjNBf/tBM5
	jJDECNPL04jp1Ni1mehSmt+dILnAuAI5RqK9cKhwEjmXTjE5IONm3Pft7gtMxhFP
	lXUfHEmjJGrq/1WtIrWUJT3r3iHwBeqTWCD8pudKb087zBmECU/OQ0NmfY7jDyhf
	ngezxewf+lU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 686393C47E;
	Sun,  1 Mar 2015 22:10:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0C9E3C47D;
	Sun,  1 Mar 2015 22:10:07 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1503011707040.12474@nftneq.ynat.uz> (David
	Lang's message of "Sun, 1 Mar 2015 17:09:12 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A16E7518-C089-11E4-9FB5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264575>

David Lang <david@lang.hm> writes:

> how would these approaches be affected by a client that is pulling
> from different remotes into one local repository? For example, pulling
> from the main kernel repo and from the -stable repo.
>
> David Lang

As I said in $gmane/264000, which the above came from:

    Note that the above would work if and only if we accept that it
    is OK to send objects between the remote tracking branches the
    fetcher has (i.e. the objects it last fetched from the server)
    and the current tips of branches the server has, without
    optimizing by taking into account that some commits in that set
    may have already been obtained by the fetcher from a
    third-party.

The scheme tries go gain by reducing the ref advertisement cost by
sacrificing the optimization opportunity when you fetch from updated
Linus's tree after having fetched from a recent next tree, the
latter of which may have contained a lot of objects that went to the
Linus's tree since you fetched from Linus's the last time.  The
current protocol, by negotiating what you have (including the
objects you obtained from sideways via 'next') with the Linus's
tree, allows the server to compute a minimum packfile customized
just for you.  By trading that off with "everybody that follow this
repository will get the same set of packfiles in sequence trickled
into his repository" model, it would instead allow the server to
prepare these packfiles thousands of clients that follow Linus's
tree will want only once.

The client-server pair may want to have a negociation mechanism
(e.g. "I may have many objects I fetched from sideways, give me
minimum pack that is customized for me by spending cycles---I am
willing to wait until you finish computing it" vs "I am just
following along and not doing anything fancy, just give me the same
thing as everybody else") to select what optimization they want to
use.
