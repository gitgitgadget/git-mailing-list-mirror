From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Re: git-am: fix maildir support regression: accept
 email file as patch
Date: Wed, 15 Jul 2009 19:30:31 -0700
Message-ID: <7vfxcxbbqw.fsf@alter.siamese.dyndns.org>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org> <7vfxcxcxg1.fsf@alter.siamese.dyndns.org> <20090716010001.GC12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGkF-00050D-Ug
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175AbZGPCai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757169AbZGPCai
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:30:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163AbZGPCai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:30:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D0D77201;
	Wed, 15 Jul 2009 22:30:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2CAD97200; Wed, 15 Jul 2009
 22:30:32 -0400 (EDT)
In-Reply-To: <20090716010001.GC12971@vidovic> (Nicolas Sebrecht's message of
 "Thu\, 16 Jul 2009 03\:00\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5B70D5C-71B0-11DE-ACA7-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123355>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> It is not about adding a new feature. It's about keeping compatibility
> with maildir. The current version _rejects_ good patches.

You almost gave me a heart attack.  I wondered if the detection code, like
it did when it saw a stgit series, saw that the parameter was a directory
(in which case the original code blindly took it as a maildir), and added
an extra check to see each file in that specified directory is a mbox or
begins with "From: ", and reject it otherwise.

If it were what Giuseppe's patch did, clearly that would have been a
breakage that rejects a good maildir.  So I looked at the code again.

A very early part of check_patch_format says "a directory?  we say it is
mbox (even though we should call it maildir) and let split_patches() call
git-mailsplit, as it knows how to deal with a maildir".

So I do not think there is any breakage that rejects good input with his
patch.

I am not opposed to add support for individual pieces of e-mail without
forcing them to be in Berkeley mbox format.  Not everybody uses mbox
format, and it is a logical thing to do.  Also I do not think the amount
of new code necessary to do so is excessive, nor such a change is risky
even late in a cycle after -rc0.

I however _do_ have issues with labeling other's patch that did not break
any documented behaviour as a regression, even if it is to get extra
attention to the issue.  That's not how we do things.
