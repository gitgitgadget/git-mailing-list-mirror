From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the requirement opaquelocktoken uri scheme
Date: Thu, 18 Dec 2008 23:32:51 -0800
Message-ID: <7vljucbows.fsf@gitster.siamese.dyndns.org>
References: <1229651491-23060-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Fri Dec 19 08:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDZsP-0006yV-Lo
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 08:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbYLSHdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 02:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbYLSHdA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 02:33:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYLSHc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 02:32:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 144871AA0E;
	Fri, 19 Dec 2008 02:32:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2C481AA08; Fri,
 19 Dec 2008 02:32:53 -0500 (EST)
In-Reply-To: <1229651491-23060-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Fri, 19 Dec 2008 04:51:31 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 41570958-CD9F-11DD-A6C9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103552>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> Server can use any URI for token by rfc 4918 section 6.5 paragraph five
>
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>

Could you give a bit more high-level background information behind this
patch?

I can make a guess without knowing much about DAV that this might be...

  The program flow of pushing over http is:

   - call lock_remote() to issue a DAV_LOCK request to the server to lock
     info/refs and branch refs being pushed into; handle_new_lock_ctx() is
     used to parse its response to populate "struct remote_lock" that is
     returned from lock_remote();

   - send objects;

   - call unlock_remote() to drop the lock.

  The handle_new_lock_ctx() function assumed that the server will use a
  lock token in opaquelocktoken URI scheme, which may have been an Ok
  assumption under RFC 2518, but under RFC 4918 which obsoletes the older
  standard it is not necessarily true.

  This resulted in push failure (often resulted in "xxxxx" error message)
  when talking to a server that does not use opaquelocktoken URI scheme.

But I shouldn't have to guess or write the commit log message for you.

Giving a bit higher level background is important for people who may have
seen the error message (so filling in the "xxxxx" blank in the above
hypothetical commit log message is *important*) to find your message and
try your commit to see if it fixes the issue for them.
