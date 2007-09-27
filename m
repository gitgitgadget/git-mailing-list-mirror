From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] This exports the update() function from builtin-add.c as
Date: Thu, 27 Sep 2007 12:50:09 -0700
Message-ID: <7vlkarubv2.fsf@gitster.siamese.dyndns.org>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
	<1190868632-29287-2-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0709271245570.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IazNe-0000GJ-W2
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760020AbXI0TuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760109AbXI0TuT
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:50:19 -0400
Received: from rune.pobox.com ([208.210.124.79]:55208 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759616AbXI0TuR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 15:50:17 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 497D413D33A;
	Thu, 27 Sep 2007 15:50:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 664C2139679;
	Thu, 27 Sep 2007 15:50:33 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709271245570.28395@racer.site> (Johannes
	Schindelin's message of "Thu, 27 Sep 2007 12:47:09 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59324>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 27 Sep 2007, Kristian H=C3=B8gsberg wrote:
>
>>  builtin-add.c |    8 ++++----
>>  commit.h      |    2 ++
>
> Maybe move it to read-cache.c, just after "add_file_to_index()"?  And=
=20
> expose it via cache.h, not commit.h?

Hmmmmmmmm.  read-cache.c has been one of the lowest level files
that define atomic operations, similar to sha1_file.c, and this
function is much more porcelain-ish molecule operation.  I'd
rather not.

What other useful molecules would we have and/or need to have by
splitting existing standalone commands?  rerere() is another,
and probably we would need to rip the --with-tree bit from
ls-files out to make it usable from builtin-commit.

I do not think we would want to go to the "one file per
function" extreme, either.  Can we have a new file that hold
these helper functions for porcelains?
