From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve portability: Avoid SS constant as it is
 already defined
Date: Wed, 27 Aug 2008 12:17:12 -0700
Message-ID: <7vod3ep8sn.fsf@gitster.siamese.dyndns.org>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
 <1219858743-4476-2-git-send-email-sn_@gmx.net>
 <1219858743-4476-3-git-send-email-sn_@gmx.net>
 <7vwsi2p9qk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQXK-0001WM-W9
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYH0TRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbYH0TRW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:17:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbYH0TRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:17:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7526D63459;
	Wed, 27 Aug 2008 15:17:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 87C8163458; Wed, 27 Aug 2008 15:17:16 -0400 (EDT)
In-Reply-To: <7vwsi2p9qk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Aug 2008 11:56:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C531F68E-746C-11DD-9C87-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93927>

Junio C Hamano <gitster@pobox.com> writes:

> David Soria Parra <sn_@gmx.net> writes:
>
>> From: David Soria Parra <dsp@php.net>
>>
>> Constants that have the names of CPU registers are already defined
>> in OpenSolaris's sys/regset.h. This causes a warning as we try to
>> (re)define SS in ctype.c. So we just use another name.
>
> I do not mind this _particular_ workaround per-se, but I have to wonder
> what happens the next time some random other platform has "SP" defined in
> a random header file.

If we are doing an workaround, how about doing it this way instead?

 ctype.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git i/ctype.c w/ctype.c
index ee06eb7..d2bd38e 100644
--- i/ctype.c
+++ w/ctype.c
@@ -5,6 +5,11 @@
  */
 #include "cache.h"
 
+/* Just so that no insane platform contaminates the namespace with these symbols */
+#undef SS
+#undef AA
+#undef DD
+
 #define SS GIT_SPACE
 #define AA GIT_ALPHA
 #define DD GIT_DIGIT
