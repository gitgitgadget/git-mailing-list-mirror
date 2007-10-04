From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 04 Oct 2007 06:14:51 -0700
Message-ID: <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<20071004125641.GE15339@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQXt-0001iL-Gm
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXJDNPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbXJDNPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:15:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:41345 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbXJDNPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 09:15:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 69DEC1411A4;
	Thu,  4 Oct 2007 09:15:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AD0BC14103D;
	Thu,  4 Oct 2007 09:15:19 -0400 (EDT)
In-Reply-To: <20071004125641.GE15339@genesis.frugalware.org> (Miklos Vajna's
	message of "Thu, 4 Oct 2007 14:56:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59950>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Oct 04, 2007 at 02:27:41PM +0200, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>> Why do we have the option "--cached" and not "--index"?
>
> according to glossary.txt, 'cache' is an obsolete for 'index'. probably
> this is the reason
>
> probably cache.h will be never renamed to index.h, i don't know if diff
> --cached will be ever renamed to diff --index

Probably never.

Some commands support both --index and --cached and have
different meanings.  For them,

 * --index means work on both index and work tree;
 * --cached means work only on index and ignore work tree.

In the case of "diff --cached", the latter is exactly what's
happening.  We do not say "git diff-index --index $commit"
because "git diff-index" (and by extension, when you give only
one commit to "git diff" as parameter) is all about a commit vs
your uncommitted changes, so having you say "--index" is just
silly.  "git diff --cached" is just a shorthand for "git diff
--cached HEAD".  Because --cached would make sense to no other
form of diff, its presense by definition means you are talking
about the one-tree form of diff i.e. compare a commit with your
uncommitted changes.

An example of a command that supports both is "git apply".
Actually it is an extreme case in that it allows "no index" form
of operation, so it has "git apply", "git apply --cached", and
"git apply --index".  The --cached would only apply to index
without touching work tree, the --index would apply to both
index and work tree.
