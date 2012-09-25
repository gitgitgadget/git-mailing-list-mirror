From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
Date: Tue, 25 Sep 2012 09:40:39 -0700
Message-ID: <7vhaqmvywo.fsf@alter.siamese.dyndns.org>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <vpqvcf2ruyv.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 25 18:41:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGYC7-0001a1-M5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2IYQk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 12:40:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757486Ab2IYQkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 12:40:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A64E9878;
	Tue, 25 Sep 2012 12:40:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3jWz5bbRCwWnRhoxKMJZo4R9rqw=; b=MBRUxx
	IVq4ApRMT6RZQIeZj1W+F9Pcro7xE4U6QlYYLEGKKvfdRoSYeUvslq2ADTv5ZrAE
	sOv4zQNZiJDIJ/bUtQKNUaNVieKbnkcfBmWHJE0X/aaug5yHbZXeOSE99rlk69Qp
	N1LkhjcwAk/xS6GKfHRrWzF+oTR6RHKl4NjLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nM3kC0BSn0PvcQ5ngmVi+aMUBWuKxu/n
	CDbx8oN7TiG1fXHOXSqgaAzJGtIXoA/qdg6/rV9UZtpuIDu4CO0ON0m/r3Vy0hmZ
	FfqdQlrAR5KMpDWmM9oZMiIXljYmaBK8D0ykJZRF5tPZE3p8cULD2/e7uD4aUgke
	QETkHZYWe/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBA969877;
	Tue, 25 Sep 2012 12:40:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 515899876; Tue, 25 Sep 2012
 12:40:41 -0400 (EDT)
In-Reply-To: <vpqvcf2ruyv.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 25 Sep 2012 17:19:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE60D8DE-072F-11E2-B024-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206365>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> We've talked off and on about extending the --pretty=format specifiers
>> to something more flexible. There's also been talk recently of more
>> flexible commit-filtering (e.g., grepping individual notes).
>
> Mercurial has a similar thing, which can be a source of inspiration:
>
> http://www.selenic.com/hg/help/revsets
>
> On the one hand, if find it a bit overkill to have a full language for
> this, but on the other hand, it allows expressing easily and explicitely
> boolean operators.
>
> I would find
>
>   git log 'grep(foo) or grep(bar)'
>
> very intuitive and elegant,...

You have to be careful with "grep", though.  It would be unclear
what "and" there would mean if you replaced your "or" with.

Peff's earlier examples e.g.

  git log --lua-filter='
    return
      author().name.match("Junio") &&
      note("p4").match("1234567")
  '

  git log --lua-filter='return subject().len > 100'

are clearly good ones that illustrate the power of filtering.
