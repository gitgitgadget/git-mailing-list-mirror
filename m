From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Wed, 12 Dec 2007 11:07:40 -0800
Message-ID: <7v4pen91fn.fsf@gitster.siamese.dyndns.org>
References: <200712102332.53114.jnareb@gmail.com>
	<7vprxehrlv.fsf@gitster.siamese.dyndns.org>
	<200712120009.36560.jnareb@gmail.com>
	<200712121131.01471.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Wx8-0003Lu-L7
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbXLLTHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbXLLTHw
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:07:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbXLLTHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:07:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9ACD61E9;
	Wed, 12 Dec 2007 14:07:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6235061E7;
	Wed, 12 Dec 2007 14:07:43 -0500 (EST)
In-Reply-To: <200712121131.01471.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 12 Dec 2007 11:31:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68089>

Jakub Narebski <jnareb@gmail.com> writes:

> BTW. I have noticed something strange with current (after my two
> patches) diffstat code:
>
>  3606:[gitweb/web@git]# ./git diff-tree -C -C -r --stat gitweb/test~8 
>  0456a2ba58efb0e1d5f7421d5a8a2278e3b15ebc
>   .../test/file with spaces\tand\ttabs"              |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>  3607:[gitweb/web@git]# ./git diff-tree -C -C -r --numstat gitweb/test~8
>  0456a2ba58efb0e1d5f7421d5a8a2278e3b15ebc
>  3       1       gitweb/test/file with spaces    "gitweb/test/file with spaces\tand\ttabs"

If you are wondering about the lack of => in --stat when --numstat is
showing rename, there is nothing strange going on.  "filename scaling"
done in --stat happens way later than pprint_rename() in the current
code structure (essentially, it chomps at the last slash to keep the
long "path" fit within the given space).  --stat (not --numstat) is for
human consumption and showing longer part of the name of postimage is
more important if we do not have enough room, and most tools that enable
rename use --summary with --stat anyway, so the rename information for
such an oddball long path can be found out elsewhere in the output if
needed.
