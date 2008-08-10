From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sun, 10 Aug 2008 11:52:33 -0700
Message-ID: <7vej4w3dou.fsf@gitster.siamese.dyndns.org>
References: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org>
 <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Aug 10 20:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSG4x-0008ES-NC
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYHJSwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbYHJSwk
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:52:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbYHJSwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:52:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC64A5A61E;
	Sun, 10 Aug 2008 14:52:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 468F05A61C; Sun, 10 Aug 2008 14:52:35 -0400 (EDT)
In-Reply-To: <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sun, 10 Aug 2008 11:35:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8115A5C0-670D-11DD-B6B1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91876>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On Aug 10, 2008, at 3:01 AM, Junio C Hamano wrote:
>>-		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
>>+		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
>
> This is also what add_reflog_for_walk() does, but that function tries to resolve
> the argv[i] part first, without doing the dwim_log().
>
> Perhaps we can also ...

Sorry, I do not understand what you meant by the above comment.

 - "This is also what add_reflog_for_walk() does" -- I take it you mean
   the use of dwim_log() instead of dwim_ref()?

 - "... but that function tries to resolve the argv[i] part first" -- do
   you mean the resolve_ref("HEAD"...) call inside "if (!*branch)"
   codepath?

   That one serves different purposes than "delete HEAD@{42}".  It is
   about showing "@{42}" --- in order to show reflog for "the current
   branch", it figures out the current branch by resolving "HEAD".

In any case, what confuses me is I cannot tell if you do or do not have
issues that I did not think of with the "s/dwim_ref/dwim_log/" change.
Are you saying "no that cannot be a correct fix; see the way dwim_log() is
used in add_reflog_for_walk() -- it does more than your one-liner"?

By the way, I think the idea of "Perhaps we can also..." part is good.
