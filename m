From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Clear To: field for every mail
Date: Mon, 04 Oct 2010 00:09:31 -0700
Message-ID: <7v7hhya0yc.fsf@alter.siamese.dyndns.org>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com
To: Viresh KUMAR <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fBF-0000rd-7q
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab0JDHJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:09:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab0JDHJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:09:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09C12DBAAA;
	Mon,  4 Oct 2010 03:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zgP7+FUG+hi3KvvHLCyxkOwWHr0=; b=hYjPfXtibqgxfflL5qHYbHu
	5wi30be5fJ/IlBD35VgR2PnSiUruR5bVZZHsMcSHgpkABmyA8V0ilgaOpe9wedyj
	vrTQdXDBrFDmFlzApOH7/jfPxJ8F8rnhmnzC0jprgbPpDOSdNidnyMqASBn6y1SF
	voG1ZZh9lr4Jdfa50wZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BYYipt2gbdaIycXleCFOi5xjRwcO021J9nLvfJE8Vzv9gRlbN
	9D+U67tfuZA/9w+quptnrZWYrGN6m/lgwHRorQSg1IBKQ3fzmLILVeyvvpA0crKd
	EgNA8zVJR/NNAl9ICHVFCr6uLYpVMIJzvKsmkbpDEVkxa6jcunMb+Wm4ck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF1CDBAA5;
	Mon,  4 Oct 2010 03:09:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14486DBAA3; Mon,  4 Oct
 2010 03:09:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58DF2F34-CF86-11DF-8E61-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157994>

Viresh KUMAR <viresh.kumar@st.com> writes:

> While sending multiple patches with a single git-send-email command,
> To: field is not cleared after every mail. This patch clears To: field
> after every patch sent.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Tested-by: Viresh Kumar <viresh.kumar@st.com>
> ---

Heh, are people who send patches with only S-o-b by your definition not
testing their patches at all ;-)?  As far as I can tell, your patch
applied to 'next' will break t9001 rather badly.

I agree there is a bug that you are trying to address in the series by
Stephen that keeps adding To: address that is read from an earlier output
of format-patch created with its --to option, but I do not think this is a
right fix.  Have you tested sending a series with a plain format-patch
output without extraneous To:, Cc: and such headers?

A normal send-email session takes the recipient address from either --to
or interactively upfront, and then use those addresses kept in @to
variable in the loop, repeatedly.  I do not see anything in your patch to
avoid losing these addresses.
