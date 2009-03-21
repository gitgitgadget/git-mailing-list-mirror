From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export.c: add default case to avoid crash
 on corrupt repo
Date: Sat, 21 Mar 2009 16:54:06 -0700
Message-ID: <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
References: <1237675051-6688-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlB2X-0006nu-4Q
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbZCUXyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbZCUXyP
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:54:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147AbZCUXyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:54:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5A9B876F;
	Sat, 21 Mar 2009 19:54:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08F86876C; Sat,
 21 Mar 2009 19:54:07 -0400 (EDT)
In-Reply-To: <1237675051-6688-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Sat, 21 Mar 2009 22:37:31 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93F9822C-1673-11DE-8308-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114102>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> This small issue was discovered by Benjamin Kramers Clang-runs on the
> git code-base. If a tag object points to an object that is not a commit
> or a blob, an invalid pointer is dereferenced in the code that followed.

A tag can point at anything, so this is not an issue about "crash on a
_corrupt_ repository".

I am not very familiar with this program, but the codepath involved should
be prepared to _see_ any type of object instead of dying.

What to do after _seeing_ a type of object is a different matter.  It
appears that there is no way to feed a tree object to fast-import, but I
think the fast-import language can represent a tag that points at another
tag just fine.  So the best you can do is perhaps to issue a warning
"skipping a tag that points at a tree object" and impoement a proper
handling of a tag that points at a tag.
