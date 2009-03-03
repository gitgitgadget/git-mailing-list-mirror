From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 02:09:37 -0500
Message-ID: <20090303070937.GB30609@coredump.intra.peff.net>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOme-00064F-EN
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbZCCHJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbZCCHJr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:09:47 -0500
Received: from peff.net ([208.65.91.99]:35277 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbZCCHJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:09:46 -0500
Received: (qmail 13029 invoked by uid 107); 3 Mar 2009 07:09:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 02:09:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 02:09:37 -0500
Content-Disposition: inline
In-Reply-To: <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112007>

On Mon, Mar 02, 2009 at 10:50:46PM -0800, Junio C Hamano wrote:

>  I am not at all convinced that the use case people would for whatever
>  reason do not want to "ssh-in, create and then push from here" is limited
>  to "your own playpen in your $HOME", but it certainly limits the
>  complexity and the scope of the damage.

If you are going to limit it in that way, wouldn't it be better to do it
entirely client-side? As in, "git push --create remote" will literally
do:

    ssh remote_host "mkdir -p remote_dir && cd remote_dir && git init --bare"

? Then you don't have to care about whether the remote side is recent
enough to support this, and there are no potential security issues; git
is merely saving you from typing the commands you could have done
yourself.

> +test_expect_success 'push into nonexisting repository' '
> +	this=$(git rev-parse B) &&
> +	git push "file://$(pwd)/not-here.git" B:refs/heads/master &&
> +	that=$(GIT_DIR=not-here.git git rev-parse HEAD) &&
> +	test "$this" = "$that"
> +'

I think a feature like this needs to be triggered manually via
"--create" or similar. Otherwise a typo on a regular push will be very
confusing as your pushes appear to go nowhere. Though I suppose most
regular pushes happen using a configured remote, in which case it is not
as much of an issue.

-Peff
