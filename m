From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Tue, 12 Apr 2016 09:07:30 -0700
Message-ID: <xmqqd1pustdp.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
	<20160411184535-mutt-send-email-mst@redhat.com>
	<xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
	<20160411225222-mutt-send-email-mst@redhat.com>
	<vpqr3ebnc9w.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0qp-00034O-9p
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbcDLQHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:07:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965232AbcDLQHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:07:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EC49534D3;
	Tue, 12 Apr 2016 12:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pG0FUhdU6NCDDp2gZFsiBN280QE=; b=kilk4i
	sxub9i9aOjNMmd5D3poWtc+XQThmprIHZVkSs58fSDMuCi9HAunFMQHMafWcpPh7
	76+cvTvQZXaJd/BqHKwnPxOwEtIUCMqOnA1ZhnEMoSgkqeliuNIRpejsGkWji6GN
	a+cOJaMN3FWIsnzJ8cCwxfnIoPvj6/E3bxd84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhybOWsKrwo28a4cM0Q4XUCJi9LzUzAY
	y6/36LW8G6EFIuXgoU1ZK19Vg46myeKmfCmz7k7eCR/DenNfoKUs9xlE8DhIfzFY
	fxvwBdXI0kD07Q87W6EUwRUlAd5aGwLOFQDanwcHg5OKR1aM+d6ZRlNZ2T8nkl8z
	xcIuV+KHbss=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24FDB534D2;
	Tue, 12 Apr 2016 12:07:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 84D72534D1;
	Tue, 12 Apr 2016 12:07:31 -0400 (EDT)
In-Reply-To: <vpqr3ebnc9w.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	11 Apr 2016 22:03:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A95D627C-00C8-11E6-894B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291273>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> Interesting. An empty commit would be rather easy to create on any
>> branch, not just the current one, using git-commit-tree.
>
> This "modify a branch without checking-it out" makes me think of "git
> notes". It may make sense to teach "git rebase -i" to look for notes in
> rebased commits and append them to the commit message when applying.
> Just an idea, not necessarily a good one ;-).

Yeah that may actually fly well, as a note is designed to attach to
an exact commit, not to a branch, so that feels more natural.

As to the "use commit-tree", well, personally I am not interested in
a solution that can work well in my workflow ONLY if I further script
it.  That's half-solution and unless that half is done very well,
I'd rather do a full solution better.

	Note: this is a continuation of "I personally would not use
	it, even though other people might" discussion.

I was also wondering if I should just script around filter-branch,
if all I am futzing with is the data in the trailer block, doing the
munging of the trailer block with interpret-trailers, naturally.

In any case, a recent occasion that I had to do something related to
this topic may illustrate the boundary of requirements:

    Two developers, Michael and David, are involved.  David sends a
    24-patch series, some of which were written by Michael and
    others by David.  The in-body "From:" lines are set right and
    the resulting patches record authorship correctly.

    Michael reminds David that patches authored by Michael still
    need to be signed-off by David.  David sends a single message
    "those by Michael in this series are signed off by me".

    Michael also says that he reviewed all patches authored by
    David, i.e. "Add Acked-by Michael to all patches in this series
    authored by David".

Now this is an extreme case where a simple "OK I received an
e-mailed Ack, so I can rely on the subject line matching to mark it
to be squashed" approach will never work (i.e. if we were automating
it I'd expect that the script in DSL to the automation machinery to
take at last as many (conceptual) bits as the above problem
description).
