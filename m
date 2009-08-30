From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Sun, 30 Aug 2009 13:01:11 -0700
Message-ID: <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
 <20090830095509.GB30922@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhqam-0002Yy-FO
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbZH3UB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbZH3UB1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:01:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZH3UB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:01:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62ED33D3BF;
	Sun, 30 Aug 2009 16:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vaFQ57K/CAW7XmjhA29eqsGlvL8=; b=mjo21btimdiPKS6iRX65H8q
	nTeszNiMRdD5nvT+chXPp256NuXhqvTrMW2SJGqBvaH7dr5VsaTKUweh/u0AydY5
	bASURMBlzC8U6c5qoD01xGC2bRviYSGJmu/zV5VjDemJ+kW77s9ZflReljMi1Jas
	11pN28/jYn8OPLaKyHHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Zenn3XFs2iTEey9C00IkWT3EbrEkDSmmFWWRbeq1eHjs8GYJD
	9vJXUBLm5Z0PMNMjK/pFMSJGzjlc4Ctvf1pTIW7ke8oPxa9a+66ZlORcEKlB9eWJ
	0IoYQFFOWRwW9VEZTho5ZwSH2RAp23BU7qUYfjZpPehXFPRQ9rAimwFyHs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C8A63D3BE;
	Sun, 30 Aug 2009 16:01:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E9BC93D3BD; Sun, 30 Aug 2009
 16:01:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4FFD22E-959F-11DE-97EB-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127424>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 29, 2009 at 03:34:45PM -0700, Junio C Hamano wrote:
>
>> I am slightly in favor of leaving the things as they are, as the error
>> message is quite clear.
>
> Hmm. Thinking about it a bit more, I think "add as empty content" is
> probably the best. It scares me a little because it is losing
> information during the stash, but consider it from the user's
> perspective.
> ...
> And all of this while they are trying to quickly switch contexts to
> whatever it was that caused them to stash in the first place.

Ok, then probably the "how about" patch would be a part of the right
solution.

One thing I noticed was that while unstashing without --index, we add full
contents to the index of new files.  I think it is because back then when
stash was written there was no other way, but now we have intent-to-add
and a way to stash such an entry, I think we should add only the intent to
add them in that codepath.

Of course we will not do this when unstashing with --index.
