From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 08:07:30 -0800
Message-ID: <7v7gmmvj5p.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
 <87bobzslke.fsf@lifelogs.com> <7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
 <87zjzjr5y4.fsf@lifelogs.com> <7vmwvjzkcs.fsf@alter.siamese.dyndns.org>
 <87sj5ariar.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2l3y-0007r7-3p
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3BEQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:07:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933Ab3BEQHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:07:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7A4AB0CA;
	Tue,  5 Feb 2013 11:07:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dg7sgCnEAdGMotgG5Q1t4Ki7HlQ=; b=Fharui
	oh6pPY9HEi6E7qzORu9Q139YFtT1xvB3UmOkwUPrzQxY55Bq5mQlozcy1rfs6fL7
	QMddvjNxNcnSv/vgrBEHH4H1OlA+vK2Bjn4Q56czTqeAkfX/AeMA3Y0i9JttHe3M
	Dhlvxcracb5ea7pyOJsnszs/RnXFXV3GbwPgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkinqC9riV/t6R29ffIPTrHPkMIxnTGh
	tLoorUkuJaOjAS77Hb5GIsAFGV3vcYDsvmqRbG9A51et9lHW80kbixlP9crrVfdY
	0YLYlurqq8Dzzf6VJKnjmuKgyIFZut6JtHGQeR8C63jLFkVc65uzjSYt4QVifxZw
	RSVXZEJxMU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC74B0C9;
	Tue,  5 Feb 2013 11:07:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CA19B0C6; Tue,  5 Feb 2013
 11:07:33 -0500 (EST)
In-Reply-To: <87sj5ariar.fsf@lifelogs.com> (Ted Zlatanov's message of "Tue,
 05 Feb 2013 08:39:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26CE87C2-6FAE-11E2-ACAD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215510>

Ted Zlatanov <tzz@lifelogs.com> writes:

> On Mon, 04 Feb 2013 16:15:47 -0800 Junio C Hamano <gitster@pobox.com> wrote: 
>
> JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>
>>> - do you want to support backslashed newlines?
>
> JCH> What for?  netrc/authinfo is not a line oriented file format at all,
> JCH> and
>
> JCH> 	machine k.org
> JCH> 	        	login me
> JCH>                         password mysecret
>
> JCH> is a single entry; you do not need backslash at the end of any line.
>
> Hmm. The parser I implemented only does single-line parsing, and I
> misunderstood the format to be single-line (partly because I have never
> seen anyone using the multi-line format you show).  Looking at
> Net::Netrc more carefully, it seems that the "machine" token is what
> defines an entry, so a new entry starts with a new line that contains a
> "machine" token.  Is that acceptable and does it match your
> understanding of the format?  It matches Net::Netrc, at least.

I thought I've given a more concrete outline than "I'll read
Net::Netrc and do whatever I think it does" in a separate message.

It would be better to read "man netrc" carefully at least once ;-)
