From: Junio C Hamano <gitster@pobox.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 03 Sep 2008 21:25:13 -0700
Message-ID: <7vhc8w8rme.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
 <7vljy88u0m.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809032157200.21167@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 06:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb6QN-0005fG-UW
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 06:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbYIDEZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 00:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYIDEZV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 00:25:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYIDEZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 00:25:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 31E605BB29;
	Thu,  4 Sep 2008 00:25:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69A815BB27; Thu,  4 Sep 2008 00:25:16 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0809032157200.21167@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Wed, 3 Sep 2008 21:58:08 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B55682A-7A39-11DD-8616-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94890>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Wed, 3 Sep 2008, Junio C Hamano wrote:
> ...
>> Ah, ok.  I should have noticed that setlinebuf() was outside POSIX (it is
>> not usable on older BSDs either).
>>
>> Let's see if we can replace it with setvbuf() which is POSIX.
>
> This fixes the problem. on both OS's.

By the way, have you actually exercised the codepath, or does your above
"fixes" mean "compiles"?

I knew it would compile on a system with POSIX setvbuf(), but I was unsure
about the size argument.  I know for glibc giving <NULL, 0> would be
equivalent to setlinebuf(), but POSIX itself leaves what exactly happens
to the size argument quite vague, saying only "otherwise [when buf is a
null pointer], size may determine the size of a buffer allocated by the
setvbuf() function."  Does size=0 mean it allocates very little, and while
it tries to line buffer the output, because the buffer is so small that it
fails to buffer an entire line causing early flushing of the stream?
