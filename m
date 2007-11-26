From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Making ce_path_match() more useful by accepting globs
Date: Sun, 25 Nov 2007 16:48:08 -0800
Message-ID: <7vhcj9j0hj.fsf@gitster.siamese.dyndns.org>
References: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org>
	<20071126001114.GA10286@steel.home>
	<7vlk8lj1b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 01:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwS9M-0007pa-SI
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 01:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbXKZAsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 19:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbXKZAsP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 19:48:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60514 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbXKZAsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 19:48:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C35C02EF;
	Sun, 25 Nov 2007 19:48:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AA1B99C92;
	Sun, 25 Nov 2007 19:48:32 -0500 (EST)
In-Reply-To: <7vlk8lj1b7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 25 Nov 2007 16:30:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66032>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Junio C Hamano, Sun, Nov 25, 2007 19:03:12 +0100:
>>> Currently ce_path_match() only uses "the leading directory" match, and
>>> does not understand file globs.  These do not work:
>>> 
>>>    git diff-files 't/*.sh'
>>>    git diff-index HEAD 'xdiff/*.c'
>>>    git update-index -g 'Documentation/howto/*.txt'
>>
>> How should my scripts handle files with "*" in names?
> ...
> Having said that, I would think that quoting the meta from fnmatch(3)
> like this:
>
> 	git ls-files 'such-\*-a-file'
>
> would work fine, just like
>
> 	ls such-\*-a-file
>
> would.

Yup.  I just did:

	$ >M\*kefile
        $ git add 'M\*kefile'
        $ git ls-files 'M\*kefile'
        M*kefile
        $ git ls-files 'M*kefile'
        M*kefile
        Makefile
