From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit
 notes
Date: Tue, 28 Jul 2009 19:18:14 -0700
Message-ID: <7vskgg1bbt.fsf@alter.siamese.dyndns.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907272026.46150.johan@herland.net> <20090727183517.GN11191@spearce.org>
 <200907280343.56586.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVykW-0005EK-EM
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZG2CSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 22:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZG2CSV
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:18:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZG2CSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 22:18:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 77F0C17E25;
	Tue, 28 Jul 2009 22:18:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A35D617E23; Tue,
 28 Jul 2009 22:18:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15B87282-7BE6-11DE-804A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124293>

Johan Herland <johan@herland.net> writes:

> +External data format::
> +	The data content for the note was already supplied by a prior
> +	`blob` command.  The frontend just needs to connect it to the
> +	commit that is to be annotated.
> ++
> +....
> +	'N' SP <dataref> SP <committish> LF
> +....
> ++
> +Here `<dataref>` can be either a mark reference (`:<idnum>`)
> +set by a prior `blob` command, or a full 40-byte SHA-1 of an
> +existing Git blob object.
> +
> +Inline data format::
> +	The data content for the note has not been supplied yet.
> +	The frontend wants to supply it as part of this modify
> +	command.
> ++
> +....
> +	'N' SP 'inline' SP <committish> LF
> +	data
> +....
> ++
> +See below for a detailed description of the `data` command.
> +
> +In both formats `<committish>` is any of the commit specification
> +expressions also accepted by `from` (see above).

Doesn't this make fast-import language incapable of add notes to anything
other than commits?  As far as I remember, there is no such limitation in
the underlying data structure on git notes, even though the git-notes
sample Porcelain might have such a restriction.

We recently hit a similar unintended limitation that we regret in the
fast-import language, didn't we?

Although personally I do not think it is a big deal if we cannot tag or
add notes to trees, I am pointing it out in case other people care.
