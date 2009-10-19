From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 12:03:42 -0700
Message-ID: <7v7hur1a0h.fsf@alter.siamese.dyndns.org>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzxWR-000378-DV
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 21:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZJSTDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 15:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbZJSTDt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 15:03:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZJSTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 15:03:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B18B5FEBA;
	Mon, 19 Oct 2009 15:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zzDEse3o1Pf92HTqHIWvcPn5HSM=; b=gjlLDc2sV1joAZMZQh/x6hp
	sncEHUzIl54gX47HeJDUNrbtXkONn0Xxx/xVraUL0bzc+PVBRzHyjXbQQl/HTZii
	6U2i/tHXqKqzHqztd9ZBsQaKXe8xW1z6gVVmsEjRf8nkJoY4zU/gFPCkClweEMc5
	4V6+3NIkCa2ksqrJg8EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Uyr3vOjKQuirZa6W8unv28YTS2gS4qINcaON9h1qmcroWosBk
	UvKBfl9MN5OX5FzwUc2mOEhxaPWNB6x8TxnILPtQWZDvqG9RyzYYxmQoeNacKnXO
	AfQpQmyLB8PIuVz1WV/ttHiwm9/M62HzBICTZlAYrCMZu3IaCCLTMsBkrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D49E25FEB6;
	Mon, 19 Oct 2009 15:03:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4DEB5FEB5; Mon, 19 Oct
 2009 15:03:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22197C14-BCE2-11DE-B241-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130727>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 19 Oct 2009, Johannes Sixt wrote:
>
>> Sergio Callegari schrieb:
>> > Is there a means to have fsck to a truly full check on the sanity of a 
>> > repo?
>> 
>> git fsck --full
>> 
>> RTFM, please.
>
> Now, now.
>
> If you were to test a new filesystem, say, wonderfulfs, and wanted to 
> check its integrity, would you not just run "fsck-wonderfulfs" if that 
> exists, rather than reading the fantamagastic manual?  Would you not 
> expect that it Does The Right Thing?  Would you not expect that it 
> follows the Law Of Minimal Surprise?
>
> So FWIW I can see where Sergio is coming from.

Linus and other git developers from the early days trained their fingers
to type the command, every once in a while even without thinking, to check
the consistency of the repository back when the lower core part of the git
was still being developed.  Developers who wanted to make sure that git
correctly dealt with packfiles could deliberately trigger their creation
and checked them after they were created carefully, but loose objects are
the ones that are written by various commands from random codepaths.  It
made some technical sense to have a mode that checked only loose objects
from the debugging point of view for that reason.

    Side note.  I think the help description of --full option is wrong (or
    at least stale).  We always look at alternate object store these days
    since e15ef66 (fsck: check loose objects from alternate object stores
    by default, 2009-01-30).  It probably should read "check packed
    objects fully" or something.

The above paragraph is merely a historical background, and in this case
the "history" refers to early-to-mid 2005.  Even for git developers there
no longer is any reason to type "git fsck" in fear of some newly created
objects might be corrupt due to recent change to git these days.

The reason we did not make "--full" the default is probably we trust our
filesystems a bit too much.  At least, we trusted filesystems more than we
trusted the lower core part of git that was under development ;-)

Once a packfile is created and we always use it read-only, there didn't
seem to be much point in suspecting that the underlying filesystems or
disks may corrupt them in such a way that is not caught by the SHA-1
checksum over the entire packfile and per object checksum.  That trust in
the filesystems might have been a good tradeoff between fsck performance
and reliability on platforms git was initially developed on and for, but
it might not be true anymore as we run on more platforms these days.

It probably makes sense to ship 1.7.0 with a version of "fsck" in which
"--full" is the default; it would still accept "--full" but it would be a
no-op.  This would be a backward incompatible change, but the difference
is primarily about performance ("it takes a lot longer than before!"), and
not correctness, so we probably can live with it.  As I already said,
there is not much reason to run "fsck" every five minutes anymore to begin
with (unless your filesystem is so unreliable that it might eat one file
every five minutes, that is).

It probably is also a good idea to add a "--loose" option that does what
"fsck" currently does without "--full".  It is a good name because (1) to
people who do not know the internal of git, it means "check only loosely",
which would discourage them from running "fack" with that option to begin
with, and (2) to others, it exactly tells what the option makes the
command check.
