From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Tue, 12 Apr 2016 13:00:25 -0700
Message-ID: <xmqqy48ippgm.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
	<20160411184535-mutt-send-email-mst@redhat.com>
	<xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
	<20160411225222-mutt-send-email-mst@redhat.com>
	<vpqr3ebnc9w.fsf@anie.imag.fr>
	<xmqqd1pustdp.fsf@gitster.mtv.corp.google.com>
	<20160412190904-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq4UD-0007IM-6h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 22:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbcDLUA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 16:00:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756753AbcDLUA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 16:00:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0284A556A6;
	Tue, 12 Apr 2016 16:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/jzXtppF3kfDpVXDN+8gVS9z68o=; b=xhHVo+
	rg0E9AqcWiwiQ7jUNnnbOx6drVEtu6Nl4+zIFEqM53G6jL4TGZSV+bBX5TjAlfHY
	YiYJOmZK4GJNweLNPOOWuJWMY3+5fpIGzBYWhQQzvCQo2YW6l/DwnwDmLive5HTM
	FYOmfLilRyjkbwr+Tf1ugrZTgWYnqgKzKKh68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5Te0sp+pU5tYs1vy80g5L3iZvPFqeBj
	XvemSJKUpwbTXycTeEdp20EKVtuYr+mkzrqtFTQlZHP0Hdb5f/IXNAqfW84r40bS
	507DZlb5Ily1v/hinuADh1Wd4K7CMDtLK0YghyNJ2C84QjBhgMMkFz2S2SVpnD8I
	i/fRqmN6qZg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E334B556A5;
	Tue, 12 Apr 2016 16:00:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 488B5556A2;
	Tue, 12 Apr 2016 16:00:26 -0400 (EDT)
In-Reply-To: <20160412190904-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Tue, 12 Apr 2016 19:33:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32F8324E-00E9-11E6-99C5-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291291>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> As to the "use commit-tree", well, personally I am not interested in
>> a solution that can work well in my workflow ONLY if I further script
>> it.  That's half-solution and unless that half is done very well,
>> I'd rather do a full solution better.
>
> Absolutely. But that's not what I meant. I will add a flag to git-ack to
> select a branch and use commit-tree to put the ack commit there
> *internally*. Would this do everything you need? How do you select
> a branch? Automatically or do you remember the mapping from topic
> to branch name?
> ...
> For first part, that is less common but also happens
> (for example I get "for patches 1,7 and 23 in series: ACK") -
> I would do git ack -s
> to store David's signoff, then tag just messages by David
> (probably just using limit ~b From:\ David in mutt)
> and pipe them to git ack -r.
>
> Does this sound user-friendly enough? What would you do
> differently?

Because my workflow is I usually comment on and review many topics
without applying them to anywhere, by the time I start applying
patches, I often know which one got Acked and Reviewed already.

So for them the workflow would be

 0. Think which maintenance track the topic should be based on.

 1. Fork

    $ git checkout -b <new topic> maint-<appropriate track>

 2. In my MUA, pipe the message into this pipeline

    Meta/add-by -r peff@ -a Tsirkin | git am -s3c

where the "add-by" script (found in 'todo') expands the given names
using .mailmap and appends appropriate trailers (the latter should
eventually be updated to use interpret-trailers when the tool
matures, but I did not think it was there yet when I last updated
the "add-by" script).

So for a use case where I work off of my MUA, I have no use for your
"git ack".
