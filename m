From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] limit the usage of the default remote "origin" to
 the minimum
Date: Tue, 29 Apr 2008 14:56:24 -0700
Message-ID: <7vwsmg5nqv.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
 <20080429193536.GA19340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	srb@cuci.nl
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:57:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxpH-0000Tf-Kb
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYD2V4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYD2V4h
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:56:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbYD2V4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:56:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49C133827;
	Tue, 29 Apr 2008 17:56:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5D9EA3823; Tue, 29 Apr 2008 17:56:26 -0400 (EDT)
In-Reply-To: <20080429193536.GA19340@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Apr 2008 15:35:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22BE502A-1637-11DD-BEAC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80751>

Jeff King <peff@peff.net> writes:

> ... The principle of "remove defaults from code, and
> put them into the automatically generated config file" makes sense to
> me. It gives users an easy place to look to understand and change such
> behavior. So even without the rest of the patches, I think this is an
> improvement.

If the removal of defaults do not break expectations of users of an
existing repository, I'd agree.  Is it the case, or the lack of default
that is supposed to be there now suddenly makes the tool do unexpected
things?

>> Patch 4 is a reworking of my previous patch.  Instead of having "git
>> push" push to "all mirrors plus the magic origin branch", it will
>> push to "all remotes having a push refspec".  In the future, this
>> will always include the origin branch because of patch 2, while
>> right now the origin branch is still used if no remote has a
>> push refspec (for backwards compatibility -- more discussion in the
>> patch log message).

Didn't we already have this discussion and don't we already have a way to
define a remote that you can use to push to more than one places?

>> This patch may cause incompatibilities to be warned about in
>> the release notes.  Luckily, these incompatibilities only affect
>> users that already know their way in .git/config, because no porcelain
>> command creates push refspecs.

"Knowledgeable people all _can_ work around the change" does not change
the fact that you are forcing existing users unnecessary change to their
configurations.  Why does this patch need to break existing users setups?

> ... I
> assume people still with ancient .git/remotes files? Are those actually
> deprecated?

No.

Neither .git/branches.  When you interact with hundreds of remote
repositories, one interesting branch per each, like akpm does, the format
of one-file-per-remote is far easier and simpler to work with.
