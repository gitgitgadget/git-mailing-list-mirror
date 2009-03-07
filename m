From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been
 added
Date: Sat, 07 Mar 2009 13:49:57 -0800
Message-ID: <7vd4ctm29m.fsf@gitster.siamese.dyndns.org>
References: <49B266B0.4020304@gmail.com>
 <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg4Qh-0001PM-8p
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbZCGVuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbZCGVuH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:50:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbZCGVuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:50:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13F8E9F434;
	Sat,  7 Mar 2009 16:50:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EBE149F431; Sat,
  7 Mar 2009 16:49:58 -0500 (EST)
In-Reply-To: <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
 (Tay Ray Chuan's message of "Sun, 8 Mar 2009 04:49:13 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E93DC54E-0B61-11DE-A2AB-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112590>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Calling a fill function repeatedly won't break behaviour, because fill
> functions (those that are currently defined in git) are designed to be
> called repeatedly. But it's just useless to call the same fill
> function repeatedly without any reason.
>
> So should I still address the "THIS and THAT breakages"?

Your above explanation is good, but it was given after I asked ;-).
Making unnecessary call repeatedly counts as a breakage your patch fixes,
right?

I didn't look at the callers of add_fill_function(), but "fill" takes a
callback data and different invocation of add_fill_function() could be
passing different callback data.  In such a case, doesn't it feel wrong to
omit the "duplicated" calls to register the fill callback?  Your patch
makes me suspect that it _might_ be better to fix the callers not to call
the function repeatedly when they know they only want one-shot invocation.
