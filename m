From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 07:56:44 -0800
Message-ID: <7vboc6mzpf.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 16:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0a2L-0007YC-MD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 16:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3A3P4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 10:56:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab3A3P4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 10:56:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB0F2B5A0;
	Wed, 30 Jan 2013 10:56:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R691NgBRPI2OMuhvZI8og2w9Hw0=; b=rECJbx
	aSTy05zyW6Z5eZJYTc+vKKvzL6fN0DqeMY6u+eqGNymJ+P0AJc64TdyfljN2bZnU
	VlWJq5j8u2UwA3iYXVN0m/sKxHdJ7DkWpmrt+9KNfvPGoYJhA89koMiOibgPs6zs
	ezOyxtWC1snUqJmYDqU2m8jTJEEHYUDOL7hW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QpiUxsUVRMRd73cQ9y+8zcpIcSik9gWR
	uI30WR1dYgLG8aQD2aZ3cWGA5X1P22k0zSVNZZB8VHyx0XiZV7+4V62V+PAsBTzV
	b07mb/TIt4nIUcFh8Dqm1bKi/nkaZtOpdu+iIMvsenT1VOJvmtHik1rDzZAZAYdp
	r//LGQTRIh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0317B59F;
	Wed, 30 Jan 2013 10:56:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C6EFB598; Wed, 30 Jan 2013
 10:56:46 -0500 (EST)
In-Reply-To: <20130130071209.GD11147@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Jan 2013 02:12:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A634EFC8-6AF5-11E2-935A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215026>

Jeff King <peff@peff.net> writes:

>>From this:
>
>> Then it will be very natural for the extension data that store the
>> commit metainfo to name objects in the pack the .idx file describes
>> by the offset in the SHA-1 table.
>
> I guess your argument is that putting it all in the same file makes it
> more natural for there to be a data dependency.

It is more about the "I am torn on this one" I mentioned earlier.

It would be more "logical" if this weren't tied to a particular
pack, as the properties of a commit you record in this series do not
depend on which pack the commit is in, and such a repository-global
file by definition cannot be inside anybody's .idx.

But if we split the information into separate pieces and store one
piece per .idx for implementation reasons, it is crazy not to at
least consider it a longer term goal to put it inside .idx file.

Of course, it is more convenient to store this kind of things in a
separate file while experimenting and improving the mechanism, but I
do not think we want to see each packfile in a repository comes with
47 auxiliary files with different suffixes 5 years down the road.
