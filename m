From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of git rev-parse
Date: Tue, 14 Jul 2009 02:07:55 -0700
Message-ID: <7vvdlvhbtg.fsf@alter.siamese.dyndns.org>
References: <4A5C31CF.2090204@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdzc-0003FP-9n
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 11:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbZGNJIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbZGNJIA
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 05:08:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZGNJH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 05:07:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1145C138F;
	Tue, 14 Jul 2009 05:07:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 68F14138E; Tue,
 14 Jul 2009 05:07:56 -0400 (EDT)
In-Reply-To: <4A5C31CF.2090204@ubicom.com> (Yakup Akbay's message of "Tue\,
 14 Jul 2009 10\:20\:47 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D37FBDC6-7055-11DE-BDBC-BF7EB3670A22-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123233>

Yakup Akbay <yakbay@ubicom.com> writes:

> Then I've tried
>
>    $ git rev-parse -'hi, this is a test!'
>
> the output is:
>
>    -hi, this is a test!
>
> Is this an expected behavior?

Absolutely.  rev-parse was originally written as a way for Porcelain
scripts to sift parameters into four different categories.

 * options and non-options (that's two)

 * args meant for rev-list and others (that's another two)

Multiplying two x two gives you four combinations.

Because you are not giving options like --revs-only, --no-revs, --flags,
nor --no-flags, rev-parse outputs everything.  You can try these:

$ git rev-parse --no-flags -'Hi'
$ git rev-parse --no-revs HEAD
$ git rev-parse --flags --no-revs -Hi HEAD

> Another questions is, usage is printed if you omit the commit id in
> git rev-list (E.g. `git rev-list -2`). Is there a reason why HEAD is
> not taken as the default?

The reason is because that is the way it has been, that is the way it is,
and changing it will break existing behaviour and scripts.  In other
words, it is a historical accident without any deep logic.

Besides, "git rev-list" is a plumbing and didn't necessarily want a
user-friendliness niceties such as "defaulting to X when nothing is
given".
