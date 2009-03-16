From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] make the ST_{C,M}TIME_NSEC macros more function like
Date: Mon, 16 Mar 2009 00:12:50 -0700
Message-ID: <7vhc1ux7nx.fsf@gitster.siamese.dyndns.org>
References: <cover.1237115791.git.barvik@broadpark.no>
 <cover.1237115791.git.barvik@broadpark.no>
 <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
 <7v4oxu7dyn.fsf@gitster.siamese.dyndns.org> <86tz5u1m7i.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Mar 16 08:14:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj72G-0007jh-8q
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 08:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbZCPHM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 03:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbZCPHM7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 03:12:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZCPHM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 03:12:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F2932A2D77;
	Mon, 16 Mar 2009 03:12:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A9A4CA2D76; Mon,
 16 Mar 2009 03:12:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF586DA6-11F9-11DE-B14F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113312>

Kjetil Barvik <barvik@broadpark.no> writes:

>     [...] in C or Pascal, calling a function with a large structure as
>     an argument will cause the entire structure to be copied,
>     potentially causing serious performance degradation, and mutations
>     to the structure are invisible to the caller. [...]
>
>   So in my eyes it make more sense to be consistent and take the address
>   of all struct like objects (&st in this case) for all arguments to
>   "function-like" things.

Notice the "mutations to the structure are invisible to the caller" part.
The call site of st_ctime_nsec(st) can be sure that st won't be modified,
without checking the definition of the function.

Which is actually a nice property.  When st_ctime_nsec(st) is implemented as
a macro, you _could_ write it in such a way to mutate what is in st, but
the implementation does not do so, and will be unlikely to in the future,
so I think writing it as if it is a function that receives a structure by
value will help readers of the calling code.

And the readability is what we should optimize for when picking from two
ways to write it, and when the generated code is the same.
