From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: heed --abbrev-commit option
Date: Fri, 26 Mar 2010 12:32:32 -0700
Message-ID: <7vk4sylvzj.fsf@alter.siamese.dyndns.org>
References: <4BA76BDF.6060106@drmicha.warpmail.net>
 <b1b0f22cf3dc6d67f6094e761a1b7402b1471e97.1269264868.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFGx-0002ir-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0CZTcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:32:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0CZTcm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:32:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3957BA52CD;
	Fri, 26 Mar 2010 15:32:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3+V5I9moYL01R3TxtEdrC1RanE4=; b=mHPRxHzy7QifN5HuDqcTK9c
	Vgy8aOJ/KF+BGQqvtwwRNSk0l4CF1C6NKlYkxRkxUr0K4lDEx7Vwt3nqDQLIgjZY
	pY8qZjCKzR7vXDmvTKtPa+pHDOY63/VWtDhuxiLux15I+txMVHq0HDVDqmhnhUBP
	d1hd3oSEoqA0L6Bn3Tb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HsAifv7rdqtw0Cy0/lzJLyYXt9Qf313oWXvZXmlF2dE0sFw0H
	YAflxFBLhx97ULhy/HlD16qkA/tEI31yZBEJfiC3984PDpoP+0qgE8pFeufVBQZa
	4hrbpxmdWtmkfhJRvXk/2yeptKceXORabGyPtKe71Agy2ro/oyYTvLXpgw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60EFCA52C8;
	Fri, 26 Mar 2010 15:32:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD332A52C0; Fri, 26 Mar
 2010 15:32:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55A621F6-390E-11DF-BDB4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143269>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, rev-list has a default of "0" for abbrev which means that
> switching on abbreviations with --abbrev-commit has no visible effect,
> even though the option is documented.

Hmm, I actually think this was deliberate.  rev-list is designed to be a
low level machinery for getting full object names, and in that context,
setting the default abbreviation length to "don't abbreviate" gave us some
safety, with additional safety of requiring a separate --abbrev-commit
option to affect the main "show the commit object names" codepath (the
latter of which would not likely to change).  The caller sets explicitly
how long an output it wants (see git-rebase--interactive for an example).

Having said that, I don't think this would break existing scripts, so
let's queue it and see what happens.
