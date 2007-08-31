From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 07:52:08 -0700
Message-ID: <7vveav21uv.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robert Newson" <robert.newson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 16:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR7r7-0005uc-3h
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 16:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbXHaOwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbXHaOwN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 10:52:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbXHaOwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 10:52:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 31BD912B216;
	Fri, 31 Aug 2007 10:52:32 -0400 (EDT)
In-Reply-To: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	(Robert Newson's message of "Fri, 31 Aug 2007 13:58:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57170>

"Robert Newson" <robert.newson@gmail.com> writes:

> The latest head of git gives me this when doing most operations, this
> also happens with the rc7 experimental Debian package. It's annoying
> because it prints this line hundreds of times for each call to 'log',
> for example
>
> "Use of uninitialized value in string eq at blah/git/git-svn line 826."
>
> and this fixes it;

Curious.  I wonder how can it trigger.

Presimably, that while (<$fh>) loop is reading from git-log, and
the first line would look like "commit [0-9a-f]{40}" and will
set $hash, do "next".  Which means the variable should have been
initialized by the time the part that complains about string eq
(which I think is "if ($c && $c eq $hash)" comparison) is
reached.
