From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] git-fetch: Limit automated tag following to only fetched objects
Date: Fri, 09 Nov 2007 14:26:20 -0800
Message-ID: <7v7ikrrr77.fsf@gitster.siamese.dyndns.org>
References: <20071109110631.GG19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcJG-0000rP-7V
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbXKIW01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbXKIW01
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:26:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54849 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXKIW01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:26:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EE4BF2FB;
	Fri,  9 Nov 2007 17:26:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DA3F593C98;
	Fri,  9 Nov 2007 17:26:43 -0500 (EST)
In-Reply-To: <20071109110631.GG19368@spearce.org> (Shawn O. Pearce's message
	of "Fri, 9 Nov 2007 06:06:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64265>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We now redefine the rule to be: "tags are fetched if they refer
> to an object that was just transferred; that is an object that is
> new to your repository".  This rule is quite simple to understand,
> you only get a tag if you just got the object it refers to.

In other words, if I do this:

	git fetch git-gui master

(which should not follow any tags) when your master is a bit
ahead of a new tag in git-gui I do not have, and then
immediately afterwards if I do:

	git fetch git-gui

I will not get the new tag followed?

If that is what the patch does, it feels like a regression.

The intended behaviour was "when tag following is enabled, they
are followed if they refer to an object that is reachable from
your existing refs".

But this is quite expensive to compute.  If a tag points at a
blob that is contained inside a commit that is reachable from a
ref, we would need to grep "git rev-list --objects -all" output
to find it out.  I do not offhand recall what the scripted
version did, but I would not be surprised if as an approximation
we did the auto-following by "does the pointee exist" check.

What "random behaviour" are you trying to fix? 
