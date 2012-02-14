From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 23:14:22 -0800
Message-ID: <7vpqdh999t.fsf@alter.siamese.dyndns.org>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
 <m339aivn4z.fsf@localhost.localdomain>
 <20120214075439.14f1d2b7@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 08:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxCav-0007oc-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 08:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab2BNHO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 02:14:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552Ab2BNHOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 02:14:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D957F99;
	Tue, 14 Feb 2012 02:14:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=prf40Gcu0mKxrYpPpa0be4ZOboA=; b=L79AEb
	82p0a7XpQLEcm2e+8pizBfkdHtmv1zymj+ywsiMHvM+fKpGOeSfI3PwsgyA4Db/o
	jMPM/m63A9hTU0++LKqNc+Hom97x0Jnxnnwm2qECyn6TU8HnTr4zRC/p9RlH1JOC
	akblAGsu4QwL0EuakhFL2Zgy+AhN9vuHn23Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKXrRCWp1Naa/Ykht9SlTnZuJCb/qjgt
	fZcUNm09wAFgAuCZ+TaUHp7YTOflYRQppL9NOVl8CV/kmuIG4kzBlDH1xxXV29n2
	b73Mkuwz1k8oaTGkB9FOmRczdsNDWzQ/LhnkkSDiXJON4IDhrnNTn7TgFuF/2bAs
	qe7OLBZM7e8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 157837F98;
	Tue, 14 Feb 2012 02:14:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96E567F97; Tue, 14 Feb 2012
 02:14:23 -0500 (EST)
In-Reply-To: <20120214075439.14f1d2b7@mkiedrowicz.ivo.pl> (Michal
 Kiedrowicz's message of "Tue, 14 Feb 2012 07:54:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 858D8D68-56DB-11E1-B5E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190706>

Michal Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> I just started to wonder if we couldn't use output from Jeff's
> diff-highlight for gitweb.

That could be a sensible approach, but

> We could tech diff-highlight to produce diffs
> marked with -{} and +{} (this is the notation used by Jeff in one of his
> recent patches) or something like this and then just convert that into
> HTML markup.

this implementation strategy would not work well, given that the payload
can contain arbitrary letter sequence (e.g. a Perl script that wants be
explicit when writing a hashref literal write +{...}  to disambiguate it
from a block).  If you are going to modularize diff-highlight and reuse
it, it needs to learn how to talk HTML to properly escape the payload.
