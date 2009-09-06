From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 06 Sep 2009 13:36:19 -0700
Message-ID: <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
 <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
 <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
 <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 22:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkOTs-0007Oy-Fs
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 22:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758376AbZIFUg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758314AbZIFUg3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 16:36:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZIFUg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 16:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CDA280D6;
	Sun,  6 Sep 2009 16:36:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNJlgCbAfaXqB7Ua32eQo0usEc0=; b=iyY7Dv
	gSFaD8jR7AKoppDz2X44Edacti0384yHtXx6goG4vgJCMnBHESPK2T9N18DAQEqG
	nWKgdh04erhDDGkrP050sC6I2SG/vYgk21j17dc3JBSs2H5Rmg7rQePlowpGOSVI
	oTz7NGCumfTroM4nxOoNqrONBbb3lbNib9O9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Orz5VGhq9bT+QVsaqo4nriKhSBqfIrij
	ZAGjdiMAhvCSBq44JAZoAOh/szfYrRGrHX0Pr67fSm4hu6drk3Ii8ZbXKRcBRxv3
	Fmou0yR3V9u+lexT2hwUi7cOnFEZS/YwCmHCKDyuPlhvNxDjGmJj4vPZv+7r69y/
	2CA30CbHA1E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E75280D5;
	Sun,  6 Sep 2009 16:36:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DF57280D4; Sun,  6 Sep
 2009 16:36:21 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 6 Sep 2009 12\:54\:23 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3EE36BA-9B24-11DE-B5EC-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127867>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 6 Sep 2009, Junio C Hamano wrote:
>...
>>  * traverse_trees() takes a callback from the caller in info->fn().  It
>>    feeds the callback the entries with the same name most of the time, but
>>    that is not a guarantee, and the bug we are seeing is coming from a
>>    caller, unpack_trees_callback(), assuming it.
>
> This is the level I'm looking at. In fact, I'm going to cheat. I'm not 
> going to do it when we call info->fn(), I'm going to do it _before_ the 
> call, and have a special "find conflicts" phase inside traverse_trees() 
> itself.
>
> That way, any traverse_trees() user will see the conflicts exactly like 
> they used to, because I'm just going to add a special "find conflicts" 
> phase there that does the right thing. It's a hack, but it's a "useful" 
> hack, and it at least avoids being the current "it can't work for the 
> special case" thing.
> ...
> I think I have a good solution, give me half an hour to actually get it to 
> work.

Thanks.

The reason I brought up adding the "candidate for the earliest name"
interface to the function was to avoid a case where the index has

    blob "t"
    blob "t-f"

and all the trees being merged have

    blob "t-f"
    tree "t"

in which case the "Are we supposed to look at the index too?" logic in
unpack_callback() may not catch the "t-f" entry from the index when the
first callback from traverse_trees() feeds it "t-f".  It would notice that
the entry at o->pos is "t".  When that happens, I did not think of a clean
way to avoid the codepath from emitting "t" as "only exists in the index".
With the "candidate" addition, traverse_trees() could say "You asked me
that I may have to return 't' to you, and here are the entries from all
the trees." before giving "t-f" back.

Other than that, I think find_conflicts() phase in the traverse_trees()
makes sense.
