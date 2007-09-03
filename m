From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 10:32:16 +0200
Message-ID: <vpqk5r8m9nz.fsf@bauges.imag.fr>
References: <20070902224213.GB431@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 10:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7WA-0005Fk-LH
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXICImm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXICImm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:42:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:42145 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbXICIml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:42:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l838g22s028411
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 10:42:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IS7M0-0001GS-M1; Mon, 03 Sep 2007 10:32:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IS7M0-0005sV-Jn; Mon, 03 Sep 2007 10:32:16 +0200
In-Reply-To: <20070902224213.GB431@artemis.corp> (Pierre Habouzit's message of "Mon\, 03 Sep 2007 00\:42\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Sep 2007 10:42:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57450>

Pierre Habouzit <madcoder@debian.org> writes:

>   First, and that's the most important one: the buffer is always NUL
> terminated, after its official "len". That means, in terms of strbuf
> API, that "alloc" is always greater or equal to len+1 to be able to
> store the ending NUL[1]. The advantages are obvious: you can pass the
> buffer to any legacy C string function without any fear of read
> overflow.

No overflow, but it's still potentially dangerous: if your strbuf
contains a '\0', you can't use any standard C string function.

For example, it would be very tempting to compare files with
"strcmp(buf1, buf2)", but that would just fail silently when the file
contains a '\0' byte.

I don't have a perfect solution, but having something explicit to say
"hey, I'm going to use a legacy C function" doesn't sound like a bad
idea.

>   The other shortcoming is that you cannot tell the buffer "Hey, it's
> very likely that you'll end up being _that_ long.

100% ACK on this point.

-- 
Matthieu
