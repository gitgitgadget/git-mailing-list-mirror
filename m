From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build in merge
Date: Mon, 07 Jul 2008 18:05:43 -0700
Message-ID: <7vskulxk0o.fsf@gitster.siamese.dyndns.org>
References: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org>
 <1215474140-11220-1-git-send-email-vmiklos@frugalware.org>
 <7v63rhz03x.fsf@gitster.siamese.dyndns.org>
 <20080708010007.GA10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1fU-000365-DM
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYGHBF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbYGHBF6
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:05:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbYGHBF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:05:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28FE026FE7;
	Mon,  7 Jul 2008 21:05:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C8D126FE6; Mon,  7 Jul 2008 21:05:51 -0400 (EDT)
In-Reply-To: <20080708010007.GA10347@genesis.frugalware.org> (Miklos Vajna's
 message of "Tue, 8 Jul 2008 03:00:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04D9A922-4C8A-11DD-8536-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87678>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I could imagine the following situations:
>
> 1) A project has code in a repo, some documentation and po files.
>
> The first two can be merged with builtin strategies, the later probably
> needs a custom merge driver.

Per-path merge is probably better handled with custom ll-merge driver
anyway.  See gitattributes(5).

> 2) Someone is not happy with the current recursive strategy and writes
> from scratch a new one. He/she puts it to pull.twohead, so it will be
> tried before recursive.

That is fine.

> To sum up: I am not sure what would be the benefit of being able to
> specify flags for strategies. However, if we want so, it would be good
> to discuss how it should be done.

It wasn't *me* ;-) who wanted to add these "flags".

I think it does not matter what "my-strategy" does unless "-s my-strategy"
(or pull.twohead) is explicitly given by the user, and at that time,
DEFAULT_* options should not matter.  It probably is Ok to allow fast
forward and trivial merges to them.  We'll see.

>> The part that records which strategies were specified from the command
>> line *in what order* via "-s foo" switches should remain list of pointers
>> into "struct strategy", which is called "struct strategy **use_strategies"
>> in the code and corresponds to the $use_strategies variable in the
>> scripted version.  The order of these is important, as that defines in
>> which order the strategies are tried [*1*].  If you go route (1), these
>> pointers will all be pointing at elements in all_strategies[]; with route
>> (2) they may be pointing at either all_strageties[] element or
>> user_strategies[] element.
>
> I see the problem, I lost the order at the moment.

That's Ok.  See the other patch on top of your previous one.
