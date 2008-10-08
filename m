From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 RFC] rebase-i-p: test to exclude commits from todo
 based on its parents
Date: Wed, 08 Oct 2008 00:24:32 -0700
Message-ID: <7vmyhfr1lb.fsf@gitster.siamese.dyndns.org>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTQe-0002pg-LH
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbYJHHYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbYJHHYl
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:24:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYJHHYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:24:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68CB66C2AD;
	Wed,  8 Oct 2008 03:24:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB36F6C2A4; Wed,  8 Oct 2008 03:24:34 -0400 (EDT)
In-Reply-To: <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com> (Stephen Haberman's message of "Wed, 8 Oct 2008 01:41:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2AF8ADA6-950A-11DD-9DF0-C355E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97782>

Stephen Haberman <stephen@exigencecorp.com> writes:

> +# set up two branches like this:
> +#
> +# A1 - B1 - D1 - E1 - F1
> +#       \        /
> +#        -- C1 --
> ...
> +test_expect_success 'setup' '
> ...
> +'
> +
> +# Should result in:
> +#
> +# A1 - B1 - D2 - E2
> +#       \        /
> +#        -- C1 --
> +#
> +test_expect_success 'squash F1 into D1' '
> +	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
> +	test "$(git rev-parse HEAD^2)" = "$(git rev-parse branch)" &&
> +	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
> +	git tag E2
> +'

Very nicely written test sequence with pictures.  I wish all the tests
were written like this.

> +# Start with:
> +#
> +# A1 - B1 - D2 - E2
> +#  \
> +#   G1 ---- L1 ---- M1
> +#    \             /
> +#     H1 -- J1 -- K1
> +#      \         /
> +#        -- I1 --
> +#
> +# And rebase G1..M1 onto E3

I think s/E3/E2/ is what you meant.

If this is the first one in the series, you may want to mark these tests
with test_expect_failure and make a later patch that changes the behaviour
of rebase-i-p include updates to the test script to turn expect-failure
into expect-success.
