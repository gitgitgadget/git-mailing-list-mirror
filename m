From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Mon, 07 Dec 2009 11:07:59 +0100
Message-ID: <vpqws0zcd1c.fsf@bauges.imag.fr>
References: <1259784061-25143-1-git-send-email-y>
	<7vljhj4wv0.fsf@alter.siamese.dyndns.org>
	<vpqhbs4dkjr.fsf@bauges.imag.fr>
	<7vk4wz9rbt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 11:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHaYv-0001KW-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 11:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934976AbZLGKLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 05:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934967AbZLGKLF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 05:11:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:42845 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934964AbZLGKLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 05:11:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nB7A7xEN022755
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Dec 2009 11:07:59 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NHaVb-0005sK-Jl; Mon, 07 Dec 2009 11:07:59 +0100
In-Reply-To: <7vk4wz9rbt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 06 Dec 2009 23\:27\:34 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 Dec 2009 11:08:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134731>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
> The second round still had a few compilation warnings (turned to errors in
> my environment) so I fixed them up somewhat.

Thanks. For some reasons, I had CFLAGS=-g and I didn't see the
warnings :-(

> I stopped before getting a
> clean compile, though---you will still get:
>
>   sha1_name.c: In function 'get_sha1_with_mode_1':
>   sha1_name.c:956: error: 'object_name' may be used uninitialized in this function

This one is strange. I don't git it with gcc 4.4, even with -Wall
-Werror. And indeed, object_name is initialized when !gently, which is
precisely when we use it.

I did

-               char *object_name;
+               char *object_name = NULL;

to make sure the warning goes away on your machine, but I don't
understand what's going on.

>  cache.h     |    4 ++--
>  sha1_name.c |    2 +-

Squashed into v3, together with initialisation of object_name, and two
s/int/unsigned/ to please gcc -Wextra.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
