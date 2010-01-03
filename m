From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 12:49:15 -0800
Message-ID: <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
 <7v637nzky0.fsf@alter.siamese.dyndns.org>
 <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 21:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRXQZ-0004xi-TA
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 21:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0ACUuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299Ab0ACUuI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 15:50:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0ACUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 15:50:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 670848D0FC;
	Sun,  3 Jan 2010 15:50:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RddG2Fufw6lyWhKvPuB2lzHYl30=; b=cL/neE
	Pt79g82DI2av5aXhO+4eT6pQhy8zq2TtDjlU6pWvDzHa5fzWlZOYr804Aygz0hNG
	3zhpwXuvb5bkNrsTcz4C3K93SIXKUsQHme4yj/cySfZvicr2KQ3QVxcOrCaFm1lP
	w+tx+3Vjx/UJPXYdEqZEWYL2xelkDXFADUv0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Te2H3MZIy5l5AW2hR7UlvPhwC2i2JpAR
	z18213gb45jdGNUORkvVGFL9aKwHGhCUj4B2Mx8DfFauFVBm+lKWvlIkxzJvN2DA
	Wo8cS1a+SP2kDmu8O0b2/uW3nPCYlp04JxH276Us6n6gKCf9SqSBJb+2Gt04WmBd
	aBNiFX+VPdA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 185618D0FA;
	Sun,  3 Jan 2010 15:50:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7830D8D0F3; Sun,  3 Jan
 2010 15:49:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 3 Jan 2010 11\:32\:24 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F020ECE-F8A9-11DE-A477-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136083>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Which means that if you put /usr/xpg4/bin before other paths in your PATH, 
> you'll totally break such systems, because now you get the (inferior) 
> tools in xpg4 before the preferred tools in /usr/local. Or - this also 
> happens - people end up installing their own versions in $HOME/bin, 
> because the system admin is uncaring or incompetent.

The build allows you to define SANE_TOOL_PATH ("the tools found in here
are saner than the ones in /usr/bin or /bin" is what it means) and we
insert it just in front of /usr/bin or /bin in the original PATH (see
git_brokne_path_fix in git-sh-setup.sh).

I would call this the right thing (TM) or the best workaround we could do
under the constraints, depending on the mood.
