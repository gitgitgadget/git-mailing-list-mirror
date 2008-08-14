From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Split out merge_recursive() to merge-recursive.c
Date: Wed, 13 Aug 2008 20:17:02 -0700
Message-ID: <7vabfggua9.fsf@gitster.siamese.dyndns.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 05:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTTLu-0007pD-Gx
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 05:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYHNDRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 23:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYHNDRP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 23:17:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYHNDRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 23:17:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 94290586D1;
	Wed, 13 Aug 2008 23:17:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B697E586CD; Wed, 13 Aug 2008 23:17:09 -0400 (EDT)
In-Reply-To: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Tue, 12 Aug 2008 18:45:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D74A232-69AF-11DD-AE26-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92310>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Move most of the of code from builtin-merge-recursive.c to a new file
> merge-recursive.c and introduce merge_recursive_setup() in there so that
> builtin-merge-recursive and other builtins call it.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Mon, Aug 11, 2008 at 04:27:01PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>  (1) move bulk of code from builtin-merge-recursive.c to a new file
>>      merge-recursive.c and introduce merge_recursive_helper() in there
>>      so
>>      that both of you and cmd_merge_recursive() itself can call it;
>
> Something like this?

Hmm, I think callers except "git merge" implementation should not be even
using the "recursive" variant, so in that sense, I do not think you would
need to expose anything but merge_trees().  But the new file is called
merge-recursive.c not merge-trees.c, and in any case, builtin-merge.c
needs to link to the recursive one, so this split is Ok.  Exposure of
make_virtual_commit() somewhat feels dirty, and I tend to agree that the
pure "three-tree merge with rename detection" (aka merge_trees()) should
operate on three trees, not commits, though.
