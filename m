From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 14:52:45 -0700
Message-ID: <xmqqob7rw1xt.fsf@gitster.dls.corp.google.com>
References: <20130915080830.GA30465@redhat.com>
	<xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
	<20130917164226.GB20672@redhat.com>
	<xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
	<20130917172829.GA21121@redhat.com>
	<xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
	<20130917201401.GA22000@redhat.com>
	<20130917201604.GA22008@redhat.com>
	<20130917201828.GC16860@sigill.intra.peff.net>
	<20130917203807.GA22059@redhat.com>
	<20130917205615.GA20178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3CX-0003GI-SZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab3IQVwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 17:52:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab3IQVws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D2D430BE;
	Tue, 17 Sep 2013 21:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RlO67LBhlBlSM0T3Ab0ekr8vsy0=; b=rZousx
	LChn7zLXizGwWSmVhtNtJ4eTs0wzzzQcxx6Se5kqK/zENMwGjolWFNXDHqtps3iL
	EqYgVPJMh91xOtv/EQuXSfSBquU01+QuPtk2wUUQzVMyHOrcM38Oy/4LFvzkGyqX
	A6bfbKEtSLlKsafJ7ijdL3x9e+ufTPOZEN8VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fTkHWvdtRMrIshCMWln+sOTnTcSZqYVF
	exYglNLw1JRM3/aX4PULbbHzfW1NgSERgJ/vxJpyHOdJ06d9UDpJNM8/YWkKlZOB
	uJX5YWn60VuumCZVoFK/hrK+r9q0gCPnJJRRwTraSZat07QbsPZLjT+Ms9PHigrr
	8M/QJBTXoW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CFD3430BC;
	Tue, 17 Sep 2013 21:52:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A25B1430BB;
	Tue, 17 Sep 2013 21:52:47 +0000 (UTC)
In-Reply-To: <20130917205615.GA20178@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Sep 2013 16:56:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D9D7744-1FE3-11E3-BDBD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234934>

Jeff King <peff@peff.net> writes:

> I am mostly thinking of the problems we had with the "kup" tool, which
> expected stability across diffs that would be signed by both kernel.org.
> But as far as I know, they do not use patch-id. More details in case you
> are curious (including me arguing that we should not care, and it is
> kup's problem!) are here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/192331/focus=192424
>
> rerere is mentioned in that thread, but I believe that it does its own
> hash, and does not rely on patch-id.

It does not.  The reason rerere is relevant in that thread but is
not directly relevant here is because the thread is about changing
the diff algorithm, hence changing the common-sequence matches
between preimage and postimage, resulting in a different shape of
the conflicted section.  The hash rerere does still depends on the
patch text, but it is restricted to the conflicted region, so
whatever we do in patch-id will not affect it.  Also the rerere
database is not keyed by pathname (a conflict in _any_ file as long
as they have the same ours/theirs conflicted text is recognised as
the same conflict we have already seen), so changing the orderfile
would not affect it at all.
