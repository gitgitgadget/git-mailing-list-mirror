From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Mon, 08 Jul 2013 09:40:18 -0700
Message-ID: <7v61wl0zv1.fsf@alter.siamese.dyndns.org>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707100949.GC19143@sigill.intra.peff.net>
	<7vtxk645vp.fsf@alter.siamese.dyndns.org>
	<CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
	<CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
	<CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 18:40:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwEUD-0005Ge-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 18:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3GHQkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 12:40:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab3GHQkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 12:40:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 175A32E5CE;
	Mon,  8 Jul 2013 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLdwVNK0ic1WlgWNvIlxtzX6Oxc=; b=EeyM+C
	s/e6Fx0kkwO2ldeJ8PL4nCOf4ksd4Ss76f2bUEvk+e0A+vQ4u+hHigykH6KOOCKK
	wGoOXHBtPjJLMMrhEVj8vT3mJSW+B+SDayvPixVXPtgkxWpZG83GT4eKg3IXujVG
	8rzMfuyen/htrR+iUJxxCoh8UhNzIbqAJ7vhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQY/PMhTrK5uMg5fF6dcUMT6vqKOiIwf
	6wxpZQdosi4QURj3yPFyiKDzSDP+WARPRM904t3TJJHZT17jplU2FFIqOBqTPM0H
	Wxp85gob0VJUi+1Qyg8Pv621CyfZy9SelCQdeQYnT3AggdTwc9dgrbNlsdslQ2a0
	s/1NmqxRjnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DC892E5CC;
	Mon,  8 Jul 2013 16:40:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F36B2E5C9;
	Mon,  8 Jul 2013 16:40:19 +0000 (UTC)
In-Reply-To: <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 8 Jul 2013 20:13:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13850472-E7ED-11E2-B0EF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229876>

Duy Nguyen <pclouds@gmail.com> writes:

> There's also syntax sharing. I don't think each command should have
> its own syntax. f-e-r already has %(objectsize). If we plan to have a
> common syntax, perhaps %(disk-size) should be %(objectsize:disk) or
> something. Adding formatting to cat-file --batch from scratch could be
> another big chunk of code (that also comes with bugs, usually) and may
> or may not be compatible with the common syntax because of some
> oversight. --batch-cols=... or --batch-disk-size would be simpler, but
> we might never be able to remove that code.

True, but cat-file being a low-level plumbing, I actually am not all
that convinced that it should even know the custom formatting.
Configurability and customizability may look always good, but that
is true only until one realizes that they come with associated cost.
