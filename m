From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fast-import/fast-export
Date: Sat, 06 Mar 2010 11:02:56 -0800
Message-ID: <7v3a0di87z.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No16y-0004YU-7I
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab0CFTDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 14:03:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab0CFTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 14:03:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 752CB9F1D5;
	Sat,  6 Mar 2010 14:03:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=su7SdHTap1xdK/w0jzqvyD8bHG0=; b=WGtQtA
	TzRryy2ViYdkjLoF9qjlUy0vsDbjuGTrS8fet3A0d6TgCjuJQ5r98KO7lSn8QK5r
	wt4YThKbjo7a9/gAsM1TiZ5rGcBL4MeJxsn/IpkEcUn2jFC4cCeD33H0c+Qjczc5
	UnMsLRzMKf0e2AuYPO0u2mIfI1AadLvNWPBxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9ByHJDv4MbqI6FEPmGXuZ6TUYUN28hv
	MaV+q97wz/8M2/vZhXTd6vy+yg/Z+x/EDoIAuSlxYzbk8VwIsFkpEwvJ+LKZmgZb
	S4S+RODJj029739XBtSfK+hMwuD8vhF8iGRjxs7Q4bK5Z81TIsT8paV2S39ww3Px
	Oz8KL2nm+EA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D25B19F1D2;
	Sat,  6 Mar 2010 14:03:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8D69F1C7; Sat,  6 Mar
 2010 14:02:57 -0500 (EST)
In-Reply-To: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 6 Mar 2010 16\:02\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E6A94FBE-2952-11DF-B492-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sverre Rabbelier <srabbelier@gmail.com> writes:

> ;). To do this I think the best way to go forward is to implement the
> helper by hooking up a fast-import/fast-export frontend to libsvn.

Isn't fast-import designed to be used as a downstream side of a pipe that
is fed by an independent program you write (and may link with libsvn)?  It
wouldn't care what license that data producer program is distributed under.

On the fast-export side the issue should ideally be the same.  Your new
program that may link with libsvn reads from the datastream that comes
from the git repository via pipe as an independent process to propagate
the changes to the subversion side.

You may need to have/keep additional info on commits for roundtrip, but
that is between the part of your program that feeds fast-import and the
other part of your program that consumes the output from fast-export.
fast-import may need to be told to export mark, and you pick them up to
see what commits resulted on the git side from what you fed it, and later
use that information when reading from fast-export to propagate new things
back to subversion side.  No?
