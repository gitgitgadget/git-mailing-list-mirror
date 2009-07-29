From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 00:09:09 -0700
Message-ID: <7vab2oynhm.fsf@alter.siamese.dyndns.org>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vljm84htf.fsf@alter.siamese.dyndns.org>
 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 09:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW3Hx-0006sD-Pq
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 09:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZG2HJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZG2HJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 03:09:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbZG2HJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 03:09:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78B8315EFD;
	Wed, 29 Jul 2009 03:09:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E41515EFC; Wed, 29 Jul 2009
 03:09:10 -0400 (EDT)
In-Reply-To: <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
 (Giuseppe Bilotta's message of "Wed\, 29 Jul 2009 08\:33\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9B37C60-7C0E-11DE-BD28-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124315>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Actually, one thing that I've been thinking about doing is to adjust
> the new lines to match the kind of whitespace change the context line
> underwent. Example: if all the context lines had the change 4 spaces
> -> tab, it would be nice to have the new lines undergo the same
> change. However, this is going to be rather hard to implement.

Doing so will be actively wrong.

In the case of "whitespace=fix", it is justifiable to update ws broken
context lines while applying a ws corrected patch to a ws broken target,
and it also is justifiable not to update context lines while applying a ws
broken patch to a ws corrected target, because it is clear which one has
the correct whitespace layout (i.e. output of ws_fix_copy() by definition
is the correct outcome).  But in your example, it is not clear if the
layout using 4 spaces is correct or the one with a tab.  The tool should
refrain from guessing in such a case.
