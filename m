From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote.c: silently tolerate single-level keys like
 remote.default
Date: Fri, 24 Apr 2009 09:19:12 -0700
Message-ID: <7vzle6dny7.fsf@gitster.siamese.dyndns.org>
References: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxO93-00084u-1q
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920AbZDXQTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbZDXQTT
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:19:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819AbZDXQTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:19:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9249DAD824;
	Fri, 24 Apr 2009 12:19:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7E6F1AD823; Fri,
 24 Apr 2009 12:19:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8D65368-30EB-11DE-8A9F-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117464>

Johannes Sixt <j6t@kdbg.org> writes:

> If the config file contains a section like this:
>
>     [remote]
>             default = foo
>
> (it should be '[remotes]') then commands like
>
>     git status
>     git checkout
>     git branch -v
>
> fail even though they are not obviously related to remotes. (These commands
> write "ahead, behind" information and, therefore, access the configuration
> of remotes.)
>
> Typos in configuration keys usually do not hurt because they never match
> in look-ups. But this case is different: it does match, but it does not
> have the expected format. With this patch this situation is treated more
> like a typo.

I agree with the patch text, but we should realize that this is not
"silently tolerating typos".  The existing per-remote variables such as
url, proxy, fetch, etc. are defined to be, eh, per-remote, and by
definition require three-level syntax.  There is nothing that prevents us
from actually fixing the stupid mistake that is "remotes.default = foo"
and make it "remote.default = foo".

To avoid confusion, we might want to deprecate remotes.default and make it
remotegroup.default or something like that, though.
