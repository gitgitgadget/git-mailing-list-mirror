From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow --quiet option to git remote, particularly for
 `git remote update`
Date: Sat, 05 Dec 2009 18:04:14 -0800
Message-ID: <7vd42soo2p.fsf@alter.siamese.dyndns.org>
References: <1260057623-28960-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 03:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH6UM-0007tc-0C
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 03:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbZLFCE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 21:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbZLFCE0
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 21:04:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbZLFCET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 21:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DFE285B7E;
	Sat,  5 Dec 2009 21:04:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TdaawT0+TF6ttf0TaDHbV+pJhY=; b=UrbbLJ
	4fW2yNcimqSP7MKQmHwgE5vgNA05K+3uisfL2ulmsaCAthUdYatRzcFvnrWOHI/p
	kw9ax35k/Mhe7skd2LlPVzGAEASmmruQyE0xx5rLVjWjKqVyvehMDneNZ6OVKXEC
	4SuxObYm8soowVVDlUCk9lgTiSSoK/1n8RsEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+P76nV9m1wJr7PTkV8VwuQSEE8OC8tr
	DdxDtVpVM0nSxBuMlGajm39LHVNJ4mVjfb8o2vtGeu80vj5GG/S0jQK2CfjTrm6M
	/qNDiy50G6N2u+OkYQ39brO0k9b1P1i2mfrAdktGy4ocmdPV7asIrLZjFLBjIw1I
	kuXdfsU9pbQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F9B385B7C;
	Sat,  5 Dec 2009 21:04:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8071E85B73; Sat,  5 Dec
 2009 21:04:16 -0500 (EST)
In-Reply-To: <1260057623-28960-1-git-send-email-alex@chmrr.net> (Alex
 Vandiver's message of "Sat\,  5 Dec 2009 19\:00\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA8D5F4A-E20B-11DE-835D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134642>

Alex Vandiver <alex@chmrr.net> writes:

> Signed-off-by: Alex Vandiver <alex@chmrr.net>

Sounds good as it makes the behaviour consistent with the underlying "git
fetch".

> ...
>  	"git remote prune [-n | --dry-run] <name>",
> -	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
> +	"git remote [-v | --verbose] [-q | --quiet] update [-p | --prune] [group]",

We say "<name>" everywhere else except for "update" we call the parameter
"group" or "remote" using different typography.  It is not the fault of
your patch, but has been this way since 1918278 (Allow git-remote to
update named groups of remotes, 2007-02-20).

Three issues to consider:

 - shouldn't we use the same typography, i.e. <group>?

 - should we say <name> _if_ we are not going to say <group>|<remote>?

 - should we keep it as <group>|<remote> to make it clear that only this
   subcommand allows the group nickname?

The first two are easy and I expect the answers to be both yes.  The third
one needs some studying and further thought.

 - is "remote update" the only one that takes group nickname?

 - should "remote update" the only one? e.g. does "remote prune" also
   take group? if not, shouldn't it?
