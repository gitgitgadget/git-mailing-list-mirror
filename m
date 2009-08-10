From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Check return value of ftruncate call in http.c.  Remove
 possible mem leak
Date: Sun, 09 Aug 2009 18:54:29 -0700
Message-ID: <7vljls5t7u.fsf@alter.siamese.dyndns.org>
References: <1249709881-31334-1-git-send-email-jeff.lasslett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Lasslett <jeff.lasslett@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 03:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaK5z-00079o-OP
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbZHJByg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZHJByg
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:54:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbZHJByf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:54:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F28B323353;
	Sun,  9 Aug 2009 21:54:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EBC7523351; Sun,  9 Aug 2009
 21:54:30 -0400 (EDT)
In-Reply-To: <1249709881-31334-1-git-send-email-jeff.lasslett@gmail.com>
 (Jeff Lasslett's message of "Sat\,  8 Aug 2009 15\:38\:01 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C19925F6-8550-11DE-8234-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125398>

Jeff Lasslett <jeff.lasslett@gmail.com> writes:

> In new_http_object_request(), check ftruncate() call return value and
> handle possible errors.  Remove possible leak of mem pointed to by url.

Are you assuming that everybody is running libcurl 7.17.0 or later?
Before that version strings given to easy_setopt() were not copied and you
needed to keep them around.

I think freeing url is fine but you would probably need to then give
freq->url to easy_setopt(CURLOPT_URL) if you wanted to do so.
