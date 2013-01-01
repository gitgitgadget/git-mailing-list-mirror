From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Tue, 01 Jan 2013 14:24:46 -0800
Message-ID: <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqAHF-0005IR-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3AAWYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:24:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab3AAWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:24:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2A52A5F6;
	Tue,  1 Jan 2013 17:24:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZjDeAVRMLZrvsucmWViFFUXEnVg=; b=cTzFvT
	70rJy9n3nce1ewrjW9W/WuSxcc8+n8bOg2z12+EhoXJPXVNDfESCLxdO+EdZwsA+
	KD61AS+EpKaqkqM4WLeAy/ag0s9m+9KltaKiS/9OHL6blqzFAuPQIqrljSOOlzGH
	3OSvZjvwiMZPgGfK93jtp5D2fsUYO6vNZNxaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxzMjOGjO5R6KfR5uJLJ3aiFo3yBoZaa
	mQ9Jy5Z6hvwXmY1SzX8OYYlrj/8CVHCjG6xexjnp7RzFLelWi3v0cTvghgmweWDb
	rEpYG9aeEtcql3ruaOB4zdb51vo6rUAtkQWqUnLkpmDkLwQitF9JlO8HV2tDLxh+
	NY6a1wQpGG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3C6FA5F5;
	Tue,  1 Jan 2013 17:24:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 418F8A5F3; Tue,  1 Jan 2013
 17:24:48 -0500 (EST)
In-Reply-To: <20121229205154.GA21058@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 29 Dec 2012 15:51:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D649EBE-5462-11E2-A5C5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212461>

Jeff King <peff@peff.net> writes:

> So I think we need to update twoway_merge to recognize unmerged entries,
> which gives us two options:
>
>   1. Reject the merge.
>
>   2. Throw away the current unmerged entry in favor of the "new" entry
>      (when old and new are the same, of course; otherwise we would
>      reject).
>
> I think (2) is the right thing.

As "--reset" in "read-tree --reset -u A B" is a way to say "we know
we are based on A and we want to go to B no matter what", I agree we
should not reject the merge.

With -m instead of --reset, I am not sure what the right semantics
should be, though.
