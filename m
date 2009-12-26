From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does smart-http need git-daemon-export-ok?
Date: Sat, 26 Dec 2009 09:33:46 -0800
Message-ID: <7vk4w963np.fsf@alter.siamese.dyndns.org>
References: <905315640912260821k2fb149b3je69dbea5463afaa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, "J.H." <warthog9@kernel.org>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 18:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOaWr-0004OI-DO
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 18:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZLZReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZLZReH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 12:34:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZLZReG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 12:34:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77A61AA915;
	Sat, 26 Dec 2009 12:34:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eMDZpmKsV6pBit4HW8NxcjttMeo=; b=m3+1iN
	i+iallN5T8RdsU0auoxwckK2u6QvQCdUPf32Z21E9Ig6H7mMXm0ZXQHuGu2UbK3k
	m86sN2/+hs1FiPSmOUl+KPWo5GkrQN2MsfoiMk9H5zrtCIYjVdRY7QyPGP4j1iRg
	6CpCvpj93PzGJ7XLL5fpCe3XXkKX58zniLyDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LF5jlPKhjP4u2B4Obea9nQU30sPHXP71
	ZuZvIHmlmocOXdhvYWfby2uCSiQ9qmj8hxmtaWuqVYyVpuy+uS68koP8QuXLeank
	XIQgFFUG2gNoOubCIlMMTPjjCsljzbeTwW1+1cHn8GwdDGcYg9UBAOk9onq7ZvXR
	Y9s39xBdtys=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19C62AA914;
	Sat, 26 Dec 2009 12:33:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65525AA913; Sat, 26 Dec 2009
 12:33:48 -0500 (EST)
In-Reply-To: <905315640912260821k2fb149b3je69dbea5463afaa3@mail.gmail.com>
 (Tarmigan's message of "Sat\, 26 Dec 2009 11\:21\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7D81852-F244-11DE-8732-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135692>

Tarmigan <tarmigan+git@gmail.com> writes:

> Should the git-http-backend check something like git-daemon-export-ok
> before serving a repository?

I'd agree that it would make sense to have a way to mark individual
repository for (or not for) export.

In "native" case, the chain of events are: client talks to the daemon, the
daemon checks and decides to (or not to) export, and it runs upload-pack.

In "smart http" case, http-backend is one half of what corresponds to the
daemon (the other half being your http server configuration), and it is
more flexible and git specific half, so I'd say it would make sense to
implement the check that honors the same git-daemon-export-ok flag file in
it.
