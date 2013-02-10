From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent
 parents
Date: Sun, 10 Feb 2013 14:38:46 -0800
Message-ID: <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
 <20130210210229.GB2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fYI-0003Fm-SM
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab3BJWiw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 17:38:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760Ab3BJWiv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2013 17:38:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C8EC8EA;
	Sun, 10 Feb 2013 17:38:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FNwdXkJihbRc
	1/d6bjwKIUC2IYs=; b=UPDw9yODR66KEeZGp9nuFXkierlFo9BmqE0I7O2yBO1t
	NdXEDotcdsRNmy/ir8XA2A7xN6r1Iy90LF8W31ju4mAonSHizYQc71DfVZ/GrcIy
	wx+67XbbWEs3FWdZbxgPLTfhC3rhJjWrYqljArmi65XSoq/q7uDS4C7qOTHTNgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OVEl3v
	upekbhqfmFi9xGi3EJTVfk1PjUXtQXTJGCZf0RnRzHbhVnkJKxBvbfVRN+Lh/Lz4
	UgtISUFL7I0LS5FkeuN0FZIUrnlOUG4FokxtABBkkcaARpaRE7a7dYnat4cKuoDu
	Qn6Jm7MY2fYD6rB6eHdjvC2zFxnfPWVmT/7Q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B9AC8E4;
	Sun, 10 Feb 2013 17:38:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A68C4C8CC; Sun, 10 Feb 2013
 17:38:48 -0500 (EST)
In-Reply-To: <20130210210229.GB2270@serenity.lan> (John Keeping's message of
 "Sun, 10 Feb 2013 21:02:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A31E2C9C-73D2-11E2-B8DC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215960>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Feb 10, 2013 at 11:30:39AM -0800, Junio C Hamano wrote:
> ...
>> Is it correct to say that this essentially re-does 656197ad3805
>> (graph.c: infinite loop in git whatchanged --graph -m, 2009-07-25)
>> in a slightly different way, in that Micha=C5=82's original fix also
>> protected against the case where graph->state is flipped to
>> GRAPH_PADDING by graph_next_line() that returns false, but with your
>> fixup, the code knows it never happens (i.e. when graph_next_line()
>> returns false, graph->state is always in the GRAPH_PADDING state),
>> and the only thing we need to be careful about is when graph->state
>> is already in the PADDING state upon entry to this function?
>
> Yes, although I wonder if we can end up in POST_MERGE or COLLAPSING
> state here as well.  The check in the loop guards against that becaus=
e
> those will eventually end up as PADDING.
>
> As far as I can see, this is okay because we have called
> graph_show_remainder() at the end of outputting a commit, even when w=
e
> end up outputting the same (merge) commit more than once.  But someon=
e
> more familiar with the graph code might want to comment here.

More importantly, that kind of thought process needs to be
documented in the log message; that will help people to diagnose the
cause of the problem if they later find that this patch made an
incorrect assumption while simplifying the code.
