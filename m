From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Making ce_path_match() more useful by accepting globs
Date: Sun, 25 Nov 2007 16:30:20 -0800
Message-ID: <7vlk8lj1b7.fsf@gitster.siamese.dyndns.org>
References: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org>
	<20071126001114.GA10286@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 01:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwRs7-00047P-J0
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 01:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbXKZAa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbXKZAa3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 19:30:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40404 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbXKZAa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 19:30:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F2D9B2EF;
	Sun, 25 Nov 2007 19:30:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7727299C76;
	Sun, 25 Nov 2007 19:30:46 -0500 (EST)
In-Reply-To: <20071126001114.GA10286@steel.home> (Alex Riesen's message of
	"Mon, 26 Nov 2007 01:11:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66031>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sun, Nov 25, 2007 19:03:12 +0100:
>> Currently ce_path_match() only uses "the leading directory" match, and
>> does not understand file globs.  These do not work:
>> 
>>    git diff-files 't/*.sh'
>>    git diff-index HEAD 'xdiff/*.c'
>>    git update-index -g 'Documentation/howto/*.txt'
>
> How should my scripts handle files with "*" in names?

We DO NOT CARE.

Why?

How would you handle such files from the command line session without
git?  "ls such-*-a-file" will also show such-silly-a-file as well.

IOW, the user is shooting in the foot --- and at that point I am not all
that interested in helping him.

Having said that, I would think that quoting the meta from fnmatch(3)
like this:

	git ls-files 'such-\*-a-file'

would work fine, just like

	ls such-\*-a-file

would.

If "ls such-*-a-file" reports only one file,

	git ls-files 'such-*-a-file'

would also report that file as well.

So in practice I do not see a problem.
