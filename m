From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib.sh: Allow running the test suite against
 installed git
Date: Sat, 14 Mar 2009 13:25:35 -0700
Message-ID: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
References: <1236959116-3334-1-git-send-email-git@drmicha.warpmail.net>
 <1236959116-3334-2-git-send-email-git@drmicha.warpmail.net>
 <1236959116-3334-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiaRv-0002ON-08
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbZCNUZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbZCNUZq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:25:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbZCNUZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:25:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69357661A;
	Sat, 14 Mar 2009 16:25:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC4B66617; Sat,
 14 Mar 2009 16:25:38 -0400 (EDT)
In-Reply-To: <1236959116-3334-3-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Fri, 13 Mar 2009 16:45:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49C25A64-10D6-11DE-836F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113259>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Introduce variables externalpath and externalexecpath such that the test
> suite can be run against a git which is installed at $externalpath with
> subcommands at $externalexecpath. externalpath defaults to the git.git
> checkout, externalexecpath defaults to $externalpath. Run the suite as
>
> externalpath=somepath externalexecpath=someotherpath make test
>
> but note that this requires and uses parts of a compiled git in the
> git.git checkout: test helpers, templates and perl libraries are taken
> from there.

While I like the end result this series tries to achieve, may I suggest a
few things?

 - This is like GIT_SKIP_TESTS and GIT_TEST_HTTPD in that extra
   environments affect how the tests are run.  It would be much easier to
   use if the new environment variables are named similarly, prefixed with
   GIT_, in all caps, and with underscores between words.

 - When externalpath is given but not externalexecpath, you can deduce the
   latter from the former by running "$externalpath/git --exec-path",
   which makes running the tests against an installed git even easier.
   For example, I keep many git installations under $HOME/git-snap-vX.Y.Z,
   and it would be great if your patch allowed me to say something like:

    $ GIT_TEST_INSTALLED=$HOME/git-snap-v1.4.4.4/bin/git make test
