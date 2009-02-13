From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date  with -f
Date: Thu, 12 Feb 2009 22:22:38 -0800
Message-ID: <7vd4dmg8k1.fsf@gitster.siamese.dyndns.org>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
 <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902122202r25e2e320m19810097cbb54225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 07:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXrTF-0005a3-20
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbZBMGWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbZBMGWt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:22:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZBMGWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:22:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A6DA8988B5;
	Fri, 13 Feb 2009 01:22:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 12F89988B2; Fri,
 13 Feb 2009 01:22:39 -0500 (EST)
In-Reply-To: <bd6139dc0902122202r25e2e320m19810097cbb54225@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri, 13 Feb 2009 07:02:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA46AD1E-F996-11DD-BABC-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109710>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Feb 13, 2009 at 02:32, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> So my suggestion would be to add --force (or -f) like your patch does, and
>> also detect --whitespace=$option given from the command line, and if it is
>> fix (or its synonym "strip"), automatically enable --force, perhaps as a
>> follow up patch, or in the same patch.
>
> The patch to do so would be fairly trivial I think? That is, add
> 'force_rebase=t' in the --whitespace=... part. Is that change small
> enough to be a single patch, or should it be a follow-up since the
> first patch is a-means-to-an-end for the second one?

I thought I left it up to you ;-).

I do not think of a practical purpose of "git rebase -f" without other
options that actively modify the tree each commit records (e.g. the "fix
whitespace" option), perhaps other than to pretend that you committed them
later than you actually did.  A patch that implements --force alone is
harder to justify, because it is unclear what good it does.  It is
especially true if you make --whitespace=fix imply that behaviour.

One more thing.  I kept saying "detect --whitespace=fix (or its synonym
strip)" because people can have "apply.whitespace = fix" in their
configuration file for use with "git am", and countermand the
configuration with "git rebase --whitespace=warn".  Such a usage should
not imply --force.
