From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Sun, 25 Nov 2012 21:35:38 -0800
Message-ID: <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin>
 <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
 <20121121194810.GE16280@sigill.intra.peff.net>
 <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 06:35:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcrML-0003hP-TN
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 06:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab2KZFfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 00:35:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab2KZFfl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 00:35:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E38AE5C;
	Mon, 26 Nov 2012 00:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=flqmwYshkAZmmb1L3cYCEOb8OVQ=; b=WBNfhE
	q1o+O7ngcuA2ZNmR3cMJtn0rS51tbjkqHB8vvFXxctkXmdMeivKOYJmpPS5QnWT+
	sn9cEq6oE3Zbd9oVp46XsX4lCN7zGqw52vrJ+4GrYEnqfOsosAMz0iYzxh7ill0K
	ueHw7ij36B836RaHtFpngNdeh6iAKWqqFLr9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hD1oYMCJUDxFuEd52aBTBcfVDryeE+nW
	gpYj+D8+yLkdG1A7xozp6evjkLeqJqiRBHezAEhwSHj0h3bTQJDuWuToZKlbingq
	jdHTIgt1VqRaQsowVY+Ue8zHrc9ezZHNF0+gpWDjecO2CeIvlgRGF99ChaptJ5RW
	4IcQiXweyVw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E92BBAE5B;
	Mon, 26 Nov 2012 00:35:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BB8FAE59; Mon, 26 Nov 2012
 00:35:40 -0500 (EST)
In-Reply-To: <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 22 Nov 2012 01:28:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D291A30-378B-11E2-944C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210416>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Nov 21, 2012 at 8:48 PM, Jeff King <peff@peff.net> wrote:
> ...
> I would like to understand that that even means. What behavior is
> currently broken?

I do not know if this is the same as what Peff was referring to, but
I found this message in the discussion thread during my absense.

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 16:17:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>

(which is $gmane/208946) that says:

	Note that

		$ git branch foo master~1
		$ git fast-export foo master~1..master

	still does not update the "foo" ref, but a partial fix is better
	than no fix.
