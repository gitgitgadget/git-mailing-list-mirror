From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Update git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt
Date: Sun, 04 Nov 2007 00:43:53 -0700
Message-ID: <7vd4uqtpza.fsf@gitster.siamese.dyndns.org>
References: <1194043193-29601-1-git-send-email-madcoder@debian.org>
	<1194043193-29601-2-git-send-email-madcoder@debian.org>
	<1194043193-29601-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioa9t-0006EB-K4
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 08:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbXKDHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 02:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXKDHoF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 02:44:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57773 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbXKDHoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 02:44:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D11E22EF;
	Sun,  4 Nov 2007 02:44:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 48A5690E26;
	Sun,  4 Nov 2007 02:44:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63358>

Pierre Habouzit <madcoder@debian.org> writes:

> If you set OPTIONS_SPEC, git-sh-setups uses git-rev-parse --parseopt
> automatically.
>
> It also diverts usage to re-exec $0 with the -h option as parse-options.c
> will catch that.
>
> PARSEOPT_OPTS can also be used to pass options git git-rev-parse --parseopt
> mode (like --keep-dashdash).
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ...
> +if test -n "$OPTIONS_SPEC"; then
> +	usage() {
> +		exec "$0" -h
> +	}
> +
> +	eval `echo "$OPTIONS_SPEC" | git rev-parse --parseopt $PARSEOPT_OPTS -- "$@" || echo exit $?`

I do not quite get why you use $PARSEOPT_OPTS without setting
any yourself, which means that the users can screw themselves by
having something random and insane in their environments.

Trust me that this kind of backdoor, especially when the
intended uses of the backdoor is not documented well, will be
abused by (perhaps clueless, perhaps curious, perhaps fearless)
users and you will get blamed.

So I'd rather (1) first find out what _you_ wanted to use this
backdoor for, (2) see if that is a useful feature to share with
others instead of keeping that to yourself, and (3) if so to
have a much narrower interface to allow such an option that
cannot be abused.

The same comment applies to the git-clone one which has a
similar invocation of "rev-parse --parseopt" because it cannot
source git-sh-setup.
