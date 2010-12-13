From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk.git master branch
Date: Sun, 12 Dec 2010 23:40:51 -0800
Message-ID: <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Alexandre Erwin Ittner <alexandre@ittner.com.br>
X-From: git-owner@vger.kernel.org Mon Dec 13 08:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS31x-0002dn-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 08:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab0LMHlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 02:41:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0LMHlC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 02:41:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A16BA273F;
	Mon, 13 Dec 2010 02:41:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39gM24tyqAw2jJtt2M4TVymypKw=; b=EJrWhn
	KL6kgM8bFednoPzdFDgEExI0OIIjAwb/G5NTdT0+SuIxS9UOZHD4pUXCuAWuOSIX
	3YEIT2H7d4Q0JguqfiVN6aWfXxueN/JI3P1NrIrZPKCc8o3nToc9El8a2zMSCqpM
	WzaOQ+Tx5OgMzfu964NCnLr+v/hdQZwi1b0BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IOm8E8pMF6dO4z+UAZbZQzvWNHvgNZkG
	zLM4VKx82bpa+RnarP5LvyKN7V33dqV9ijjIyB2K6asBPHZmKeWj9JHfJsjYmEdH
	Zc9AfQOCMxuwDR+iTUaz580nXhPtylhWfTYrOUwp84GvJm/LMcfWgKBnytIiSPuc
	GP1TFnTWrQA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F7DC2727;
	Mon, 13 Dec 2010 02:41:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AE442726; Mon, 13 Dec 2010
 02:41:18 -0500 (EST)
In-Reply-To: <7v7hfe74ea.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Dec 2010 19\:11\:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 623868B0-068C-11E0-91C3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163521>

Junio C Hamano <gitster@pobox.com> writes:

> My _preferred_ outcome is to see that naming the input "po/pt_br.po" and
> using the output "po/pt_br.msg" is the BCP, but I'd like somebody to find
> out what the accepted practice would be in the Tcl land first.

I still don't know what the BCP is in the Tcl community (didn't have time
to check, dealing with other topics), but I'll tentatively apply this on
top of queue Alexandre's patch and merge the result in 'pu'.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 12 Dec 2010 23:27:21 -0800
Subject: [PATCH] Rename po/pt_BR.po to po/pt_br.po

The "msgfmt --tcl pt_BR.po" (at least on my box, GNU gettext 0.17) command
generates pt_BR.msg, i.e. the country part gets downcased.  The resulting
runtime (i.e. Tcl i18n) happily reads from pt_br.msg when run with the
runtime locale set with LANG=pt_BR and/or LC_ALL=pt_BR so it seems to be
the expected behaviour.

However, we seem to expect that the resulting file to be named pt_BR.msg,
and try to generate and install it.

Currently our Makefile uses $(wildcard po/*.po) to grab the source PO
files, expects them to produce $(subst .po,.msg,$(ALL_POFILES)), and its
dependency rule is set to use "%.msg : %.po" pattern, all of which need
to be adjusted with downcasing from po to msg files; the poor-man's msgfmt
script also needs to learn the same downcasing.

Compared to that, renaming the input file to use lowercase countryname
throughout the toolchain seems to be a lot cleaner solution to this
glitch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 po/{pt_BR.po => pt_br.po} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename po/{pt_BR.po => pt_br.po} (100%)

diff --git a/po/pt_BR.po b/po/pt_br.po
similarity index 100%
rename from po/pt_BR.po
rename to po/pt_br.po
