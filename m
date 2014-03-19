From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 19 Mar 2014 15:39:42 -0700
Message-ID: <xmqq8us524pd.fsf@gitster.dls.corp.google.com>
References: <20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<53183506.5080002@alum.mit.edu>
	<20140306155626.GB18519@sigill.intra.peff.net>
	<5318A537.4010400@alum.mit.edu>
	<20140306174803.GA30486@sigill.intra.peff.net>
	<08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
	<531904E1.6010606@alum.mit.edu>
	<xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0UnUGZb9hWyLS1vPJ6fh3QR-g_p5HNQk79Gqhs9YWi0A@mail.gmail.com>
	<20140307171936.GC23587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:39:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQP9L-0003WY-7z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 23:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbaCSWjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 18:39:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812AbaCSWjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 18:39:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B64743A0;
	Wed, 19 Mar 2014 18:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vbm+D//Ohjq7VKN30tZZrU4XMcM=; b=UJs7uq
	sgmUvJP6PEhYN6PSbLTXIbyhUkOG1w3n4HnrQBNZIl7REgJn6MlHV7BCCxH16q7l
	vKueKZnjwu9BZdAu2kvL9gsD2L1N6KZDrBEw9oGGtrKGI64I7ET4pD44tzcOoNcZ
	dwRh62zjud6nRLz0KxPq15587gdQY8uPs3jcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b++UZrU+NMNQDlE1LNZEtEtp7fuwEADS
	Rw96cQJ8/c+0ePJvvCqUSSs2MS2ivUpU9ptBp9MdLDKOA5Lsxsa5mEXSNjtKdQ69
	VGw2oG2zdSuqAqwuNe/hElIKNB4cUpHrrOizUb0HkJeeyWIn7lxYrcKEuA7PgEad
	1EmWhPOihRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C8207439E;
	Wed, 19 Mar 2014 18:39:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F5474398;
	Wed, 19 Mar 2014 18:39:44 -0400 (EDT)
In-Reply-To: <20140307171936.GC23587@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 7 Mar 2014 12:19:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E1CC30C-AFB7-11E3-934E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244505>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 07, 2014 at 08:08:37AM +0100, Christian Couder wrote:
>
>> > Be it graft or replace, I do not think we want to invite people to
>> > use these mechansims too lightly to locally rewrite their history
>> > willy-nilly without fixing their mistakes at the object layer with
>> > "commit --amend", "rebase", "bfg", etc. in the longer term.  So in
>> > that sense, adding a command to make it easy is not something I am
>> > enthusiastic about.
>> >
>> > On the other hand, if the user does need to use graft or replace
>> > (perhaps to prepare for casting the fixed history in stone with
>> > filter-branch), it would be good to help them avoid making mistakes
>> > while doing so and tool support may be a way to do so.
>> >
>> > So, ... I am of two minds.
> ...
> I do not think the features we are talking about are significantly more
> dangerous than "git replace" is in the first place. If we want to make
> people aware of the dangers, perhaps git-replace.1 is the right place to
> do it.

Sure.

So should we take the four-patch series for "git replace --edit"?
