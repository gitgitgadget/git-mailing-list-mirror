From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 12:44:03 -0800
Message-ID: <7vobikqelo.fsf@alter.siamese.dyndns.org>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
 <7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
 <CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
 <CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
 <7vhaoctg6i.fsf@alter.siamese.dyndns.org>
 <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5Xl-0004GQ-3G
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab2KZUoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:44:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756368Ab2KZUoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:44:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4687DA642;
	Mon, 26 Nov 2012 15:44:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+wNPRyHbGqXSbJtg5puCexQoUz0=; b=itk3CL
	apRFLnBImrGEHm8dRZOV5bjxF7S2/kxyhSJtXvPrXpfV0Y5kz4ILQ+QNnH9zejnm
	4o7hrpNEniUo2Tt04KkSpMYd516iTqPRj64GdQ0iiIJbHENjBFVQ2CW9KmtAh54V
	x/y1C6YqChnhnVn1QTT7w4DG4m7+zQtbaF3ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPMSzv5YoKbaoRm/2/owGT1Bzvx41ttj
	7FGsHn97CyWAAPXYWzhTDlaxp3ixMY7Wk50H6jg7OxQmN8xv3yZ6VHz70MsK+/N1
	3x2G1PWMrlLa/pHQ5gsHig6SXeJ392SIL+nX4bPZFC4/C1/4Vsktrhf2kyAGf7D7
	F5HfdEuMp6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DCCEA641;
	Mon, 26 Nov 2012 15:44:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5735AA63D; Mon, 26 Nov 2012
 15:44:06 -0500 (EST)
In-Reply-To: <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 26 Nov 2012 21:04:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05443D94-380A-11E2-866A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210484>

Antoine Pelisse <apelisse@gmail.com> writes:

>> I am not sure I follow the above, but anyway, I think the patch does
>> is safe because (1) future "fast-export" will not refer to these
>> pruned objects in its output (we have decided that these pruned
>> objects are not used anywhere in the history so nobody will refer to
>> them) and (2) we still need to increment the id number so that later
>> objects in the marks file get assigned the same id number as they
>> were assigned originally (otherwise we will not name these objects
>> consistently when we later talk about them).
>
> I fully agree on (1), not so much on (2) though.
> ...
> Both "commit mark :2" and "commit mark :3" end up being marked :2.
> Any tool like git-remote-hg that is using a mapping from mark <-> hg changeset
> could then fail.

Yeah, I think I agree that you would need to make sure that the
other side does not use the revision marked with :2, once you retire
the object you originally marked with :2 by pruning.  Shouldn't the
second export show :1 and :3 but not :2?  It feels like a bug in the
exporter to me that the mark number is reused in such a case.
