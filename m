From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push --confirm ?
Date: Sat, 12 Sep 2009 17:41:23 -0700
Message-ID: <7vvdjn8ymk.fsf@alter.siamese.dyndns.org>
References: <1252777897.2974.24.camel@localhost.localdomain>
 <20090912184342.GB20561@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 02:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmdA3-00020x-Ff
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 02:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbZIMAlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 20:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZIMAlj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 20:41:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbZIMAli (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 20:41:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3642C4EF0E;
	Sat, 12 Sep 2009 20:41:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6jYx+a8C4jPm+MwcvGoI7wohn0E=; b=Ji1UgDjMrSvf4TM6ngtwvj9
	NGK8x73wOcKqkY2SwL6vYCwHF8GPTXQvS6Ql04pOjuJ/rH7HDhLcUW1qF5uBSfE1
	sDcJjTTKkxyRzrMMJo++ZaNbdYTAmLVPOWYWitbR+SxDtoiThl3FIePUR3dqDlTJ
	8EDEWbszI1pcF9rqaO1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=h2YtlVm89e73XZ4FgfS6XDfR2FdXIuACLdTD9V58CwVOEGFgT
	hxW/oW57xp62A5hV0yjrt2GfvixygGCJhC0+dBHoA9x4p/HLbO605E4ICC0NzzRM
	YkMRuqtmHR3UjucrXNg/MVqrss1dV+E5eLK4pBre2VxGT46BcV7wRCOR0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEFC64EF0B;
	Sat, 12 Sep 2009 20:41:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39A434EF09; Sat, 12 Sep 2009
 20:41:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30F10B40-9FFE-11DE-84D4-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128321>

Jeff King <peff@peff.net> writes:

> But what _would_ be useful is doing it atomically. You can certainly do
> all three of those steps from within one "git push" invocation, and I
> think that is enough without any protocol changes. The protocol already
> sends for each ref a line like:
>
>   <old-sha1> <new-sha1> <ref>
>
> and receive-pack will not proceed with the update unless the <old-sha1>
> matches what is about to be changed.

Be careful that using that information and doing things in one session
won't give you atomicity in the sense that it may still fail after you
said "yes that is what I want to push, really" to the confirmation
question.

It does save you an extra connection, compared to separate invocations
without and then with --dry-run, so it still is a plus.

I do not think this is an unreasonable option to have.  Just please don't
justify this change based on atomicity argument, but justify it as a mere
convenience feature.
