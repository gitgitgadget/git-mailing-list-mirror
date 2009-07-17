From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] mailinfo: allow e-mail files as input
Date: Fri, 17 Jul 2009 12:54:09 -0700
Message-ID: <7vtz1b3x26.fsf@alter.siamese.dyndns.org>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
 <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr> <20090717190601.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 21:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRtVn-0002dM-9P
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 21:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZGQTyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZGQTyX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 15:54:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbZGQTyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 15:54:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 704D87EEA;
	Fri, 17 Jul 2009 15:54:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 553E77EE7; Fri,
 17 Jul 2009 15:54:12 -0400 (EDT)
In-Reply-To: <20090717190601.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 17 Jul 2009 19\:06\:01 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9ED80ED0-730B-11DE-BB8B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123484>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>>  OPTIONS
>>  -------
>> -<mbox>|<Maildir>...::
>> -	The list of mailbox files to read patches from. If you do not
>> +<mbox>|<Maildir>...|<email>...::
>> +	The list of mailbox files or email to read patches from. If you do not
>>  	supply this argument, the command reads from the standard input.
>>  	If you supply directories, they will be treated as Maildirs.
>>  
>
> I wasn't following the discussion closely, and at first I didn't understand this change to the documentation, because it doesn't say how <mbox> and <email> are different. I'm afraid many readers of the documentation don't understand it either.

I could tell _you_ that I prefer to see people go back to the list archive
instead of saying "I wasn't following", but I cannot say that to readers
of the documentation after this patch is applied.  After re-reading the
above, you are right---it is unclear.

> Why does this description have ... in it? If I'm reading it correctly, the code in check_patch_format function checks only the first file.

Good eyes.

This actually is an issue with the Guiseppe's multi-format support patch
in that we assume that the command line input are of uniform type, check
only $1 and assume $2 and subsequent are suitable to be fed to the same
splitter.

I do not think it is necessary to allow mixed input.  We certainly could,
but why bother?  It is not a sensible nor common thing to do.

Also the documentation said we take only one mbox or multiple Maildirs,
but in reality we can take multiple mboxes just fine, so <mbox> should
have had "..." at the end (we could lose the ellipses from all of them for
brevity).  Oh, and it should list the other formats Giuseppe added.

    <mbox>|<maildir>|<email>::

	    One or more of the same type of mail source to read e-mails
            from.  A directory is taken as a mailbox in the maildir
            format.  A file is taken as UNIX mbox, StGit patch series
            file, or a single piece of e-mail in RFC2822 format.
