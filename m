From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-checkout: improve error messages, detect
 ambiguities.
Date: Wed, 23 Jul 2008 16:04:08 -0700
Message-ID: <7v7ibc9p93.fsf@gitster.siamese.dyndns.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-2-git-send-email-madcoder@debian.org>
 <1216808133-31919-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnOZ-00077Y-UM
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYGWXES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYGWXES
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:04:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbYGWXER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:04:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5F6338746;
	Wed, 23 Jul 2008 19:04:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3CB8938745; Wed, 23 Jul 2008 19:04:09 -0400 (EDT)
In-Reply-To: <1216808133-31919-3-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Wed, 23 Jul 2008 12:15:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB795D1C-590B-11DD-874D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89799>

Pierre Habouzit <madcoder@debian.org> writes:

> The patch is twofold: it moves the option consistency checks just under
> the parse_options call so that it doesn't get in the way of the tree
> reference vs. pathspecs desambiguation.

I think this goes a bit too far.

Even if you have a file called 'master' tracked in your project, when you
say:

    $ git checkout master

that's almost always branch switching.  Forcing "git checkout master --"
disambiguation for such a common case is simply a wrong thing to do from
the usability point of view.

So how about (obviously we are interested only in the case without
disambiguating '--' here):

    (3-1) if there is only one token left and if it is a rev, that's the
          branch to check out or commit to detach to.

    (3-2) otherwise the user might have mistyped one of the paths, so help
          avoiding by making sure the first token is unambiguously either
          a rev or a path (but not both).
