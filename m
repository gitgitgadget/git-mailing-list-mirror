From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule: replace duplicated code with a
 module_list function
Date: Fri, 22 Aug 2008 17:08:42 -0700
Message-ID: <7v8wuo619x.fsf@gitster.siamese.dyndns.org>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
 <7vpro064qz.fsf@gitster.siamese.dyndns.org> <48AF533E.9020102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:09:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWghV-0003I0-Ey
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095AbYHWAIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYHWAIt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:08:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYHWAIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:08:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCEA36914D;
	Fri, 22 Aug 2008 20:08:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1F6066914C; Fri, 22 Aug 2008 20:08:43 -0400 (EDT)
In-Reply-To: <48AF533E.9020102@gmail.com> (Mark Levedahl's message of "Fri,
 22 Aug 2008 20:01:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A85E2EE2-70A7-11DD-8339-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93407>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Actually, this was by design, not mistake, though we did not discuss
> this at all. I'm not sure what the semantics would / should be: first
> of all, some part of "$@" is the command to be executed in each
> submodule, and as written "$@" in its entirety is what is used. Also,
> as written and documented, foreach operates in each checked out
> submodule, not a subset. I guess the basic questions are:
> a)  What specific option or options to git ls-files makes sense here?
> b) How do we distinguish the ls-files options from the command to be
> executed?

Ah, I was blind.  For (a) I do not see any need for "option" but
pathspecs; and (b) I agree is a real problem.  We of course could do
something like:

    $ git submodule foreach -c 'your command here' your pathspec here
