From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] bisect: fix reading more than one path in
 "$GIT_DIR/BISECT_NAMES"
Date: Mon, 30 Mar 2009 00:59:16 -0700
Message-ID: <7vocvjh25n.fsf@gitster.siamese.dyndns.org>
References: <20090329114457.c6fca0fe.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCQW-0007Mx-Hc
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbZC3H7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbZC3H7a
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:59:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZC3H73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:59:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A998A6D72;
	Mon, 30 Mar 2009 03:59:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B37DA6D6F; Mon,
 30 Mar 2009 03:59:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0802D36-1D00-11DE-8768-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115100>

Christian Couder <chriscool@tuxfamily.org> writes:

> The implementation of "read_bisect_paths" worked with only one
> path in each line of "$GIT_DIR/BISECT_NAMES", but the paths are all
> stored on one line by "git-bisect.sh".
>
> So we have to process all the paths that may be on each line.

This is "oops, the previous one is broken", for a series that was not yet
'next' worthy, so I squashed the fix and rebuilt the topic, together with
your other patches.

The series now looks like this:

  $ git log --oneline --boundary master..cc/bisect-filter
  b54809a bisect--helper: string output variables together with "&&"
  fd5a6a8 rev-list: pass "int flags" as last argument of "show_bisect_vars"
  e2c52e1 t6030: test bisecting with paths
  56fac26 bisect: use "bisect--helper" and remove "filter_skipped" function
  650bafa bisect: implement "read_bisect_paths" to read paths in "$GIT_DIR/BISECT_NAMES"
  a79b083 bisect--helper: implement "git bisect--helper"
  29adb27 quote: add "sq_dequote_to_argv" to put unwrapped args in an argv array
  ccc12f5 quote: implement "sq_dequote_many" to unwrap many args in one string
  a292c81 rev-list: call new "filter_skip" function
  58f0b66 rev-list: pass "revs" to "show_bisect_vars"
  41440cf rev-list: make "show_bisect_vars" non static
  a650efd rev-list: move code to show bisect vars into its own function
  2bc0667 rev-list: move bisect related code into its own file
  7cc17b8 rev-list: make "bisect_list" variable local to "cmd_rev_list"
  52ffe77 refs: add "for_each_bisect_ref" function
  -89fbda2 Merge branch 'maint'

I've tweaked a few patches before applying, but they all looked basically
sane.  Unless I hear from other people in a few days , I'd say we merge it
to 'next' and start cooking it.

Thanks.
