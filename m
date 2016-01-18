From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] shortlog: match both "Author:" and "author" on stdin
Date: Mon, 18 Jan 2016 11:55:18 -0800
Message-ID: <xmqqwpr6d5nd.fsf@gitster.mtv.corp.google.com>
References: <20160115170627.GA20983@sigill.intra.peff.net>
	<20160115170823.GA21102@sigill.intra.peff.net>
	<20160118192621.GA981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFtd-0007XZ-6S
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbcARTzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:55:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754270AbcARTzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:55:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D1C2C3B2BD;
	Mon, 18 Jan 2016 14:55:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KJjkLErQfBczykGa+u3vR+uNk8=; b=HwkucG
	iz2ZZRCopVZKkNgKQvZ8zJLU55tuDe7236yyS6DStGzJhl0m+ave1TrpCVN7xJ0J
	EXXUGOHoXBRPemumnWEo9GCFGrnZ69cBWlAnF9fSp6rlz/ICGQiVNbJZp5ML/8We
	3cTFzlY0e2AXX3aU30h6Lscbo3ymtKihQKd98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SFHVIaS2iDn38N84MBLVrfhdLnSaObPo
	mcCI5p8mXJzEQFo6NT582s3vQfK9koakuhDS7O7NqTNk6uUDydMmavMogKSTWKpe
	bkrgO48s8ZpdPiBJnoiUnEy7QYcuDunzozTCNEYQEk6oB1bBHRzt2caQVDmY4SHG
	1iXQrw9ya9I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C99AD3B2BB;
	Mon, 18 Jan 2016 14:55:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4FF0B3B2BA;
	Mon, 18 Jan 2016 14:55:19 -0500 (EST)
In-Reply-To: <20160118192621.GA981@sigill.intra.peff.net> (Jeff King's message
	of "Mon, 18 Jan 2016 14:26:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66D7FF68-BE1D-11E5-84F0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284311>

Jeff King <peff@peff.net> writes:

> So it's not wrong, but it's perhaps more complicated than it needs to
> be. We could scrap this patch in favor of just:
>
>   if (!skip_prefix(author, "Author: ", &v) &&
>       !skip_prefix(author, "author ", &v))
>           continue;
>
> That is technically more strict (it does not take "author: ", which is
> accepted by the current code), but matches "git log" and "git log --raw"
> output, and misses nothing that git has ever generated. And it extends
> naturally to:
>
>   if (!skip_prefix(author, "Commit: ", &v) &&
>       !skip_prefix(author, "committer ", &v))
>           continue;

Yeah, I agree that the above long-hand would be more readable.
