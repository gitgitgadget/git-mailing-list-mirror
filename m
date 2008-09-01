From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] checkout --conflict=<style>: recreate merge in a
 non-default style
Date: Mon, 01 Sep 2008 03:39:07 -0700
Message-ID: <7vhc90w3p0.fsf@gitster.siamese.dyndns.org>
References: <7v4p501j2y.fsf@gitster.siamese.dyndns.org>
 <48BB9F45.4070509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6ph-0008M7-NF
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYIAKjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYIAKjO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:39:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYIAKjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:39:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6737C5BF77;
	Mon,  1 Sep 2008 06:39:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BB8C15BF5E; Mon,  1 Sep 2008 06:39:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37EE753C-7812-11DD-BF34-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94569>

Johannes Sixt <j.sixt@viscovery.net> writes:

> If --conflict is basically the same as --merge, couldn't we then pass
> style argument to --merge or omit it to get the default style?

I originally was thinking about doing it that way, but the option parsing
would become somewhat hairly.

    $ git checkout --merge=diff3 foo
    $ git checkout --merge diff3 foo
    $ git checkout --merge diff3

The first one is clearly "switch to branch 'foo'; simple 2-way read-tree
may find the changes in my working tree conflicting and refuse, so use
3-way merge to resolve such conflicts and express the conflicts in diff3
style".

The third one is "switch to branch 'diff3'; don't barf on conflicting
working tree changes; 3-way merge them".

What about the second one?  Is it "switch to 'foo', express conflicts in
diff3 style", or "checkout path foo from tree-ish diff3"?

It is the former, but that is only because the latter is an error (-m is
defined only for checking things out of the index).  That is not something
parse-options can easily/cleanly do.
