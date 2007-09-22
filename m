From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 01:32:38 -0700
Message-ID: <7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0Py-0002dS-J9
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbXIVIcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 04:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXIVIcp
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:32:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbXIVIco (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:32:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D46E138664;
	Sat, 22 Sep 2007 04:33:02 -0400 (EDT)
In-Reply-To: <20070922035434.GA99140@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Sat, 22 Sep 2007 07:54:34 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58921>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> OK, you're right.  Especially if /bin/sh from Solaris and OpenBSD
> are working and they are not Bash.  But I would not tell that
> the shell is broken now -- I had not seen the POSIX specification.
> Does it specifies how the shell should work in this case?

I have always been assuming it to be the case (this construct is
not my invention but is an old school idiom I just inherited
from my mentor) and never looked at the spec recently, but I
re-read it just to make sure.  The answer is yes.

Visit http://www.opengroup.org/onlinepubs/000095399/ and follow
"Shell and Utilities volume (XCU)" and then "Case conditional
construct".

    Exit Status

    The exit status of case shall be zero if no patterns are
    matched. Otherwise, the exit status shall be the exit status of
    the last command executed in the compound-list.

So, as David suggests, if

        false
        case Ultra in
        Super) false ;;
        Hyper) true ;;
        esac && echo case returned ok

does not say "case returned ok", then the shell has a bit of
problem.
