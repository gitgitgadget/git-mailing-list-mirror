From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 22:21:37 -0700
Message-ID: <7vab1osc2m.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
 <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
 <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
 <20090825021223.GE1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:22:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfoU2-0002s0-Uo
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbZHYFWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbZHYFWF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:22:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbZHYFWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 01:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEFCA37C8A;
	Tue, 25 Aug 2009 01:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eYYcVPbW9K5GwFKn8rPdrh6SOVY=; b=iHJfFy
	eLs4wSEtwJpkgXKqVjiKHpChMTHrVoQe/s+fwBw8nACFBfWusPic3PuY8lCJobz4
	E59Bq+CI55jkoZBE48vmiqe6kBwLp4Yz4uxvGBJWFcch4sH9Zu1CpLIbegGiIcnh
	wQh8YZiItp++/oiBocRSPr3Q7+OTzYuqhsHsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCu5tUpw1Q5l8HezOnc7VkE5wVoYExPy
	iS3PoPdUBdaAHhKATBSWXGz30z39hI0kiQR7AfE7HutU1F1RIZAYP0cp/adQL1nx
	ohpRaMG3iroVjJJM7fhW4yjg4/cI0WsMXvw9d6ofMcY86RGz1JZWPb1J1YFwxk3+
	QkRPsy5dDb0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C5B637C87;
	Tue, 25 Aug 2009 01:21:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1726837C86; Tue, 25 Aug 2009
 01:21:39 -0400 (EDT)
In-Reply-To: <20090825021223.GE1033@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 24 Aug 2009 19\:12\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30CE347E-9137-11DE-AD80-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127005>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We aren't quite at the 50k ref stage yet, but we're starting to
> consider that some of our repositories have a ton of refs, and
> that the initial advertisement for either fetch or push is horrid.
>
> Since the refs are immutable I could actually teach the JGit
> daemon to hide them from JGit's receive-pack, thus cutting down the
> advertisement on push, but the refs exist so you can literally say:

What do you mean "refs are immutable"?

Do you mean "In the particular application, Gerrit, the server knows that
certain refs will never move nor get deleted, once they are created"?  If
so, then I would understand, but otherwise what you are describing is not
git anymore ;-)

And I think it is probably worth thinking things through to find a way to
take advantage of that knowledge.

Even though refs under refs/changes/ hierarchy may have that property, the
client won't know what's available unless you advertise it in some way.

You could assume some offline measure outside the git protocol exists for
clients to find out about them, and protocol extension could say "I do not
want to hear about refs that match these globs during this exchange,
because I have learnt about them offline", and the server could skip
advertisement.

>   git fetch --uploadpack='git upload-pack --ref refs/changes/88/4488/2' URL refs/changes/88/4488/2
>
> Personally I'd prefer extending the protocol, because making the
> end user supply information twice is stupid.

In the upload-pack protocol, the server talks first, so it is rather hard
to shoehorn a request from a client to ask "I know about refs/changes/*
hiearchy, so don't talk about them".

I however think it is entirely reasonable to have a server side
configuration that tells upload-pack not to advertise refs/changes/*
hierarchy but still remembers they are OUR_REF.  In send_ref() in
upload-pack.c, you'd do something like (I know, I know, you'd be doing
an equivalent of this in jgit):

	static const char *capabilities = "multi_ack ...";
	struct object *o = parse_object(sha1);
	int skip_advertisement = exclude_ref_from_advertisement(refname);

	if (!o)
		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));

	if (!skip_advertisement) {
		if (capabilities)
			packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
				0, capabilities);
		else
			packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
		capabilities = NULL;
	}

	if (!(o->flags & OUR_REF)) {
		o->flags |= OUR_REF;
		nr_our_refs++;
	}
	if (o->type == OBJ_TAG) {
		o = deref_tag(o, refname, 0);
		if (o && !skip_advertisement)
			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
	}
	return 0;

Doing it this way, receive_needs() will allow refs/changes/88/4488/2 to be
requested, because that is what send_ref() saw and marked as OUR_REF.  It
was just not sent to the client.  And get_common_commits() will behave the
same with or without this abbreviated advertisement,

Of course, the client side cannot grab everything with refs/*:refs/remotes/*
wildcard refspecs from such a server, but I think that can be considered a
feature.
