From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Tue, 13 Nov 2007 17:41:39 -0800
Message-ID: <7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
References: <20071113102500.GA2767@sigill.intra.peff.net>
	<20071113113710.GC15880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is7Gb-0003gj-6K
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbXKNBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbXKNBlx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:41:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33394 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXKNBlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:41:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AAAF02F0;
	Tue, 13 Nov 2007 20:42:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C6799576E;
	Tue, 13 Nov 2007 20:42:08 -0500 (EST)
In-Reply-To: <20071113113710.GC15880@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 13 Nov 2007 06:37:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64943>

Jeff King <peff@peff.net> writes:

> This lets us show remote errors (e.g., a denied hook) along
> with the usual push output. ...

Yay!

> ... There are two drawbacks to this
> change:
>
>   1. cross-referencing the incoming status with the ref list
>      is worst case O(n^2) (where n = number of refs); this
>      can be fixed with a smarter implementation

Sure.

>   2. the status parsing is not foolproof. We get a line like
>
>          ng refs/heads/master arbitrary msg
>
>      which cannot be parsed unambiguously in the face of
>      refnames with spaces. We do a prefix-match so that
>      you will only run into problems if you have two refs,
>      one of which is a prefix match of the other, and the
>      longer having a space right after the prefix.

Is it really "arbitrary msg", or just a fixed set of strings?

Also I think we can rely on the order report-status extension
reports the per-ref result.  It gives back the information the
same order send-pack side supplies the head information, no?
