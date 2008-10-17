From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --diff-filter=T does not list x changes
Date: Fri, 17 Oct 2008 01:29:09 -0700
Message-ID: <7v1vyfoca2.fsf@gitster.siamese.dyndns.org>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
 <20081016102201.GB20762@sigill.intra.peff.net>
 <7vhc7cq8uq.fsf@gitster.siamese.dyndns.org> <87ej2fvgv9.fsf@kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Fri Oct 17 10:31:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqkjP-0003GN-0Y
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYJQI3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 04:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYJQI3b
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 04:29:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYJQI3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 04:29:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A36A670401;
	Fri, 17 Oct 2008 04:29:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6E78770400; Fri, 17 Oct 2008 04:29:21 -0400 (EDT)
In-Reply-To: <87ej2fvgv9.fsf@kalibalik.dk> (Anders Melchiorsen's message of
 "Fri, 17 Oct 2008 09:08:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6DBD42A-9C25-11DD-8F72-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98458>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That documentation is quite loosely written. Typechange diff is what
>> T has always meant, and it never was about the executable bit. The
>> word "mode" in that sentence only means the upper bits
>> S_IFREG/S_IFLNK (iow, masked by S_IFMT).
>
> I hope you agree that this reading is not obvious from the
> documentation,...

Yup, didn't I already say that the documentation is buggy?

> How about adding a diff-filter=X for the executable bit?

I do not think it is a good idea for two reasons.  Backward compatibility
and sane design.

For one thing, "diff --name-status" never shows X, so you would introduce
an unnecessary inconsistency.  If you change "--name-status" to avoid
that, you would be breaking people's existing scripts that expect to see
"M" for such a change.

Even if you were forgiven by these people whose scripts are broken by your
change, you need to decide between "M" and "X" when both contents and
executable bit are changed.  The least surprising logic would probably be
to show "X" when _only_ executable bit is changed and show "M" when
contents changed (even when executable bit also did), but that feels quite
arbitrary.  And the other way around isn't any better.
