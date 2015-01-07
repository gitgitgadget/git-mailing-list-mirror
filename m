From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Wed, 07 Jan 2015 08:14:00 -0800
Message-ID: <xmqqegr6lgaf.fsf@gitster.dls.corp.google.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
	<xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
	<A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com>
	<CALKQrge3yEfmi26HMbckyw_ONRXUWtZGvz=SqqYaL2sqJaHbUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8tFR-0001NH-If
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 17:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbbAGQOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 11:14:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753709AbbAGQOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 11:14:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B98292B0;
	Wed,  7 Jan 2015 11:14:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLu1M9K6vtjQrmLJShqIJuV3fSo=; b=nhCaZ7
	3rssyLFnlfTg3UTRHtCQbCDZbjNfUDvuEMPQuPX+wCQlv7WCJPnANXKba5OCru89
	34kM1WTuSyyP+H89Ji4640QT0sVYKz5yoBdmsG5hR7ygBD/ZTegu9v0yih8Sn11c
	lRCu1yJBjXRtc1pXshTml8yq9G4xSzjAv9PBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9Pwm3Ea1qBSH+8O0/Gg9nz9h5N1TE+H
	vRAg/kOYzN9FMxPlLgRUbpZXwUqGtMgWT/a3Cb7G8AkiZesJ/UPVRzEUIu6h35RO
	igzXrRv2ARxIzzVFyd98E6CQPKpOYtV0SGwNnN6txrxyEW4jaNOTHXtvP25hIrFe
	m6ujl0ICnXM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF96C292AD;
	Wed,  7 Jan 2015 11:14:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05368292A8;
	Wed,  7 Jan 2015 11:14:02 -0500 (EST)
In-Reply-To: <CALKQrge3yEfmi26HMbckyw_ONRXUWtZGvz=SqqYaL2sqJaHbUg@mail.gmail.com>
	(Johan Herland's message of "Wed, 7 Jan 2015 01:28:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31AB9D26-9688-11E4-B735-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262135>

Johan Herland <johan@herland.net> writes:

> Alternatively (or additionally), for issue (2), we could add a
> --disable-ref-safety option to 'git notes', to explicitly disable the
> safety checks for "experimental" use.

I actually would rather prefer to see a proper plumbing use
supported, either by a new "git notes-plumb" subcommand or "git
notes --<some option>" that gives the scriptors a stable interface
to the low-level machinery without enforcing any Policy that belongs
to the Porcelain layer.  At the very least, the plumbing should:

 - disable anything that introduces potential ambiguity, e.g. DWIMs
   done by expand_notes_ref(), but not limited to it.

 - lift any restrictions based on policy, e.g. "where can notes
   trees live" (again, but not limited to this).
