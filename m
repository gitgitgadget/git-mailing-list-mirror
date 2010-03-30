From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: fix textconv error zombies
Date: Tue, 30 Mar 2010 14:46:10 -0700
Message-ID: <7vk4stv5y5.fsf@alter.siamese.dyndns.org>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <201003282023.00913.j6t@kdbg.org>
 <20100330163004.GC17763@coredump.intra.peff.net>
 <201003301936.03394.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:46:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwjGj-0001AI-25
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0C3Vqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 17:46:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0C3Vqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 17:46:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 185C5A6C17;
	Tue, 30 Mar 2010 17:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=catjufQLKXufV5B+LzYHdMR+Avs=; b=V9a080
	3mtvI6jtS4sEIvyTkWQj2s3KKAAEQms+B27lxLNPqeepBq+CT6KhyreXu2jqGe7g
	4Fnjp1hKZxxOWSRQCQPFDE7ADz/AU/0tP4wDi6ugtwwuDH8D0EMsjJhgOcZ9Jhjl
	Wl1IAkbpS51rgCKSTaBl4pu+qPuaaGqUprNY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iypAR7xmeIb2YJVcbT9mV7zuTLre5c4q
	GOA5QrqgIV/6mbDksH0cTvlDZgTLYKewOPRmxyMQVnUNUHQJdMeADKsxu26T8VGE
	REeVN1TQg2vFqXMflTJ7aMcBDckzlVkmaA0JebVB4RO5WiRTYmHN3jOZ8cw4Xl+x
	1KC6qnsNuQY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68369A6C10;
	Tue, 30 Mar 2010 17:46:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 907CCA6C09; Tue, 30 Mar
 2010 17:46:11 -0400 (EDT)
In-Reply-To: <201003301936.03394.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue\, 30 Mar 2010 19\:36\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE8EBD02-3C45-11DF-BA2F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143607>

Johannes Sixt <j6t@kdbg.org> writes:

> Thanks for your work, but I'm worried that in your version the close()
> call is not before the finish_command (but that's really not _that_
> important in this case).

Are you referring to this part in api-run-command.txt?

    This describes the arguments, redirections, and environment of a
    command to run in a sub-process.

    The caller:

    1. allocates and clears (memset(&chld, 0, sizeof(chld));) a
       struct child_process variable;
    2. initializes the members;
    3. calls start_command();
    4. processes the data;
    5. closes file descriptors (if necessary; see below);
    6. calls finish_command().

In "if necessary; see below", I tried to find something to help me judge
why you said "That's really not _that_ important in this case", but I
think I failed.  Perhaps we would want a bit more detailed discussion in
the document there?

The patch looks fine.  Thanks; will queue this one.
