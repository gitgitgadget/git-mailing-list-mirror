From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 18:52:18 -0700
Message-ID: <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 02:52:32 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vac0N-00065x-8V
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 02:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3J1BwZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 21:52:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab3J1BwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 21:52:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC3F40A68;
	Mon, 28 Oct 2013 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=10mUFox4QLeNGZfDLihttd+lizk=; b=e5pUVZ
	9bfYcR0+TjuuoNKgoFr2Q//eZSQkd8p9zJzC1XVKx3YxctokbNRzAKUrBvDmUNP2
	nVZ7ylt5P5KCc+XXxbOVExFh7rm9Bs4u8TYU/ZPuMUcAkt4Nix+jO3S5oZhIvr1g
	F4ULkj3IBsAZiMR7MZW1viOZ+uyUubFtQfT+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A92eJCOmHUw0G9Ce2iygCjjtnC+DNLPJ
	uowes5iH5v7Xnp7uSTfujQ+BnHvtnevOrAERysNCFUGIe2urj2qwGw+9YnTqestk
	e8Utm2GZjDZTs8yWNJFEKcGUtZIo0mSJPCW9ltyWkvvR0p4x5KsvtUMfGdX41fXQ
	c02K8GE7E/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BBC340A66;
	Mon, 28 Oct 2013 01:52:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0BCE40A64;
	Mon, 28 Oct 2013 01:52:21 +0000 (UTC)
In-Reply-To: <20131027013402.GA7146@leaf> (Josh Triplett's message of "Sun, 27
	Oct 2013 01:34:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 95B4CA4E-3F73-11E3-98EB-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236816>

There are unbound number of kinds of trailers people would want to
add, depending on their projects' needs.  We should not have to add
a specific support for a tailer like this one, before thinking
through to see if we can add generic support for adding arbitrary
trailers to avoid code and interface bloat.

Think of the existing --signoff as a historical mistake.  Such a
generic "adding arbitrary trailers" support, when done properly,
should be able to express what "--signoff" does, and we should be
able to redo "--signoff" as a special case of that generic "adding
arbitrary trailers" support, and at that point, "Fixes:" trailer the
kernel project wants to use should fall out as a natural consequence.
