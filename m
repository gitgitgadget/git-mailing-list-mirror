From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 10:51:07 -0700
Message-ID: <7v1ua9f3lg.fsf@alter.siamese.dyndns.org>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
	<516D93C4.1000100@lsrfire.ath.cx>
	<7v61zml0ow.fsf@alter.siamese.dyndns.org>
	<516DBE2E.4060201@lsrfire.ath.cx>
	<7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
	<7vli8hhgmn.fsf@alter.siamese.dyndns.org>
	<20130417063942.GA27703@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 19:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USWVo-0001KJ-9W
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 19:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966332Ab3DQRvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 13:51:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965391Ab3DQRvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 13:51:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 695ED14A89;
	Wed, 17 Apr 2013 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1psvHs7EBW74H3M+XvsEGFGwiSE=; b=BmsiZ0FjxGzfm69FfPEv
	3Nd6jKcCwElp3uz9Tsh1V3uNO7LGvKXSmLRDPlGDzOAF9uXkCQ6L1KOpRG2m37L+
	kgcZoJAIONNlxyCkDVtrb1RxowKhyhkkJuiJLCSjX4wB1ajVkMjtxt5E1S1zUJuT
	KVNGITfeF5HH7f1fiCydHww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=h3RMKpq1QrVsvT6w0tJ1jGN6NH7liCDTGYiUPTYbt87acM
	NEuDvyK30g1iUVUDQNGAuK2BhBNQzzrrPt6I8ofINY1HCIVtiVHu/VZxDhXHYH2O
	usOKDMuO+81virKMIwOt4mdjbB1HFWA3pod7BbP+HBBPkfANgRNRwNsslw/N0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D4F014A88;
	Wed, 17 Apr 2013 17:51:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7EC514A86;
	Wed, 17 Apr 2013 17:51:08 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6277B5C6-A787-11E2-95CC-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221556>

Jeff King <peff@peff.net> writes:

> What about sane_ident_split in builtin/commit.c? It explicitly rejects a
> NULL date. The logic in determine_author_info is a little hard to follow
> (it assembles the ident line with fmt_ident and then reparses it), but I
> believe it should be catching a bogus line from "commit -c", or from
> GIT_AUTHOR_DATE in the environment.

Yeah, you are of course right. I noticed that "fmt_ident then parse"
sequence a bit funny, too. It seems to manually parse to prepare
what it feeds fmt_ident.

> As a side note, when determine_author_info sees a bogus ident, it
> appears to just silently ignore it, which is probably a bad thing.

True, too.
