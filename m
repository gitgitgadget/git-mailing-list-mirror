From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon, 07 Apr 2014 08:16:12 +0200
Message-ID: <534242AC.7030908@viscovery.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 08:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX2rM-0002jn-N3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 08:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbaDGGQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 02:16:41 -0400
Received: from so.liwest.at ([212.33.55.13]:56842 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654AbaDGGQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 02:16:40 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WX2qr-00010K-9i; Mon, 07 Apr 2014 08:16:13 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DEA1B16613;
	Mon,  7 Apr 2014 08:16:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245827>

Am 4/7/2014 1:34, schrieb Michael Haggerty:
> Because remove_lock_file() can be called any time by the signal
> handler, it is important that any lock_file objects that are in the
> lock_file_list are always in a valid state.  And since lock_file
> objects are often reused (but are never removed from lock_file_list),
> that means we have to be careful whenever mutating a lock_file object
> to always keep it in a well-defined state.
> ...
> So, instead of encoding part of the lock_file state in the filename
> field, add a new bit "LOCK_FLAGS_LOCKFILE_ACTIVE" to flags, and use
> this bit to distinguish between a lock_file object that is active
> vs. one that is inactive.  Be careful to set this bit only when
> filename really contains the name of a file that should be deleted on
> cleanup.

Since this flag is primarily for communication between the main code and a
signal handler, the only safe way is to define the flag as volatile
sig_atomic_t, not to make it a bit of a larger type!

-- Hannes
