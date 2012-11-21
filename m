From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Tue, 20 Nov 2012 21:08:36 -0800
Message-ID: <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 06:08:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb2YS-00072m-7F
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 06:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab2KUFIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 00:08:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab2KUFIk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 00:08:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BCCA4D3;
	Wed, 21 Nov 2012 00:08:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kn20QidqvwY+gwUpICKDdDAeRM=; b=ykcO40
	OIilIINmEJK2IiAXANtdR3uMkyjBQoIpAZEhO3xGyrCgA+mFEymZmRAbnsinPddB
	p5JVFCDejVrLXwjbDIyv8MAWKQzK55Ujn0SKqBpP86flmEkv7oJOUPWCWz56mEu6
	PR4pDCKbP5dHdbDKPDSYro88eo11z+wUfak0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UIuS/OQWjFEGU6e9FhugTn2zoiPhRkTt
	0mP6va77ufuC6Kb9gVD2ivz1FdrlhWMeFaRJmsz+V7anazqnUFBvjrJ9n6lPdXSx
	f/zwKKr+scR4vHZFo4+C0tLKhxSdfKRvnGu3YAAYHLfx2cnIt3tuQZaHQT6xQx00
	9hBUPvQh3Vw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11E2A4D2;
	Wed, 21 Nov 2012 00:08:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 486A9A4CF; Wed, 21 Nov 2012
 00:08:38 -0500 (EST)
In-Reply-To: <20121121041735.GE4634@elie.Belkin> (Jonathan Nieder's message
 of "Tue, 20 Nov 2012 20:17:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8249632A-3399-11E2-92C8-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210136>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Never mind that others have said that that's not the current interface
> (I don't yet see why it would be a good interface after a transition,
> but maybe it would be).  Still, hopefully that clarifies the intended
> meaning.

Care to explain how the current interface is supposed to work, how
fast-export and transport-helper should interact with remote helpers
that adhere to the current interface, and how well/correctly the
current implementation of these pieces work?

What I am trying to get at is to see where the problem lies.  Felipe
sees bugs in the aggregated whole.  Is the root cause of the problems
he sees some breakages in the current interface?  Is the interface
designed right but the problem is that the implementation of the
transport-helper is buggy and driving fast-export incorrectly?  Or is
the implementation of the fast-export buggy and emitting wrong results,
even though the transport-helper is driving fast-export correctly?
Something else?

I see Felipe keeps repeating that there are bugs, and keeps posting
patches to change fast-export, but I haven't seen a concrete "No,
the reason why you see these problems is because you are not using
the interface correctly; the currrent interface is fine.  Here is
how you can fix your program" from "others".

With such a one-sided discussion, I've been having a hard time
convincing myself if Felipe's effort is making the interface better,
or just breaking it even more for existing remote helpers, only to
fit his world model better.

Help?
