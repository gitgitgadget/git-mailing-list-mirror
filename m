From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t2200, t7004: Avoid glob pattern that also matches
 files
Date: Thu, 19 Mar 2009 13:34:31 -0700
Message-ID: <7vd4cd8d60.fsf@gitster.siamese.dyndns.org>
References: <cover.1237410682.git.j6t@kdbg.org>
 <3827d7fab3e9e233a0ac528b84ab2d6a36658365.1237410682.git.j6t@kdbg.org>
 <7v7i2mbap2.fsf@gitster.siamese.dyndns.org> <200903192052.43162.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOyJ-0003oG-QW
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbZCSUej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbZCSUei
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:34:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbZCSUei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:34:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FD3B7FEE;
	Thu, 19 Mar 2009 16:34:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AEF577FED; Thu,
 19 Mar 2009 16:34:32 -0400 (EDT)
In-Reply-To: <200903192052.43162.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu, 19 Mar 2009 20:52:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C0D2B7A-14C5-11DE-95A9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113825>

Johannes Sixt <j6t@kdbg.org> writes:

> No, it is still useful. There is a difference if I say
>
>    git add "*a*"
>
> from bash or from Windows's CMD. The latter passes the argument to git with 
> the dquotes; the startup code removes them and does not expand the wildcard. 
> But if bash invokes the command, bash removes the quotes, so that the startup 
> code only sees *a* and does the expansion.

I can only say "yuck" :-<.

>> > In t2200, not all names that the test case is interested in exist as
>> > files at the time when 'git ls-files' is invoked. git expands "path?" to
>> > only the subset of files the exist, and only that subset was listed, so
>> > that the test failed.  We now list all interesting paths explicitly.
>>
>> But that conversion misses the whole point of that particular test,
>> doesn't it?  It wants to see path2 that was unmerged and existed only in
>> the index but not in the work tree has disappeared, while the similarly
>> unmerged path1 resolved after "add -u".  IOW, you are not testing that
>> "add -u" notices a removal of path2 from the work tree anymore.
>
> I see. Then I'll just add path2 to the list, OK? It still passes the test.

Yeah, as we are not passing --error-unmatch to the command, it should be
the right thing to do.
