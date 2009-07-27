From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] request-pull with diff body itself
Date: Mon, 27 Jul 2009 13:46:59 -0700
Message-ID: <7vws5tg8fw.fsf@alter.siamese.dyndns.org>
References: <20090727195357.GE17942@lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 22:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVX6L-0002G4-LZ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 22:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbZG0UrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbZG0UrH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 16:47:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbZG0UrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 16:47:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B36C1675A;
	Mon, 27 Jul 2009 16:47:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 670A916758; Mon,
 27 Jul 2009 16:47:02 -0400 (EDT)
In-Reply-To: <20090727195357.GE17942@lenovo> (Cyrill Gorcunov's message of
 "Mon\, 27 Jul 2009 23\:53\:57 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4BC5FA0-7AEE-11DE-864B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124190>

Cyrill Gorcunov <gorcunov@gmail.com> writes:

> Here is rfc in a sake of having ability to produce
> diff body in small series of changes in request-pull.
> we could use ">>" here and append diff by hands but
> adding "-p" option seems more comfortable.
>
> Dunno, just a thought.

I think this is a useful thing to add, as I think I've seen some
request-pull actually made with the patch text, most likely by hand.

>  git shortlog ^$baserev $headrev
>  git diff -M --stat --summary $merge_base $headrev
> +
> +if [ "$usediff" = "yes" ]; then
> +	echo "---"
> +	git diff -M -p $merge_base $headrev
> +fi

You can just use a single "git diff" invocation here,

	git diff -M --stat --summary $usediff $merge_base $headrev

and set up "$usediff" to be either empty or -p in the option parsing part.
