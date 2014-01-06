From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 15:18:54 -0500
Message-ID: <20140106201854.GA28162@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GdY-0002ks-TW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbaAFUS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:18:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:56074 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754620AbaAFUS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:18:56 -0500
Received: (qmail 15875 invoked by uid 102); 6 Jan 2014 20:18:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 14:18:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 15:18:54 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240057>

On Mon, Jan 06, 2014 at 12:06:51PM -0800, Junio C Hamano wrote:

> Unless you set @{u} to this new configuration, in which case the
> choice becomes dynamic depending on the current branch, but
> 
>  - if that is the only sane choice based on the current branch, why
>    not use that as the default without having to set the
>    configuration?
> 
>  - Or if that is still insufficient, don't we need branch.*.forkedFrom
>    that is different from branch.*.merge, so that different branches
>    you want to show "format-patch" output can have different
>    reference points?

Yeah, I had similar thoughts. I personally use "branch.*.merge" as
"forkedFrom", and it seems like we are going that way anyway with things
like "git rebase" and "git merge" defaulting to upstream. But then there
is "git push -u" and "push.default = upstream", which treats the
upstream config as something else entirely.

So it seems like there is already some confusion, and either way we go,
thisis making it worse to some degree (I do not blame Ram, but rather he
has stumbled into a hidden sand pit that we have been building for the
past few years... :).

I wonder if it is too late to try to clarify this dual usage. It kind of
seems like the push config is "this is the place I publish to". Which,
in many workflows, just so happens to be the exact same as the place you
forked from. Could we introduce a new branch.*.pushupstream variable
that falls back to branch.*.merge? Or is that just throwing more fuel on
the fire (more sand in the pit in my analogy, I guess).

I admit I haven't thought it through yet, though. And even if it does
work, it may throw a slight monkey wrench in the proposed push.default
transition.

-Peff
