From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 12:51:52 +0200
Message-ID: <vpqbpbc4lh3.fsf@bauges.imag.fr>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
	<7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
	<0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
	<20100615095452.GA32624@sigill.intra.peff.net>
	<192517e06785fed4fa799bee9a11ae28@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: bonneta <bonneta@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 12:52:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOTkU-0003lR-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 12:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab0FOKv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 06:51:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55157 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab0FOKv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 06:51:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FAhqvF006269
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 12:43:52 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOTkG-0001L9-VQ; Tue, 15 Jun 2010 12:51:53 +0200
In-Reply-To: <192517e06785fed4fa799bee9a11ae28@ensimag.fr> (bonneta@ensimag.fr's message of "Tue\, 15 Jun 2010 12\:32\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 12:43:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FAhqvF006269
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277203435.01291@1ibrkASm7s2FZeXsn54hAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149170>

bonneta <bonneta@ensimag.fr> writes:

> But we have to do:
> textconv_object(read_from, null_sha1, &buf.buf, (unsigned long *)
> &buf.len))
> where buf.len is size_t.
>
> Is that ok?

I don't think it fixes the problem. You're assuming sizeof(unsigned
long) == sizeof(size_t), otherwise, textconv_object will write the
incorrect number of bytes at the given adress.

If you have to use this pass-by-adress, you want

size_t buf_len; /* textconv_object needs a last parameter of type
                   (size_t *) */
textconv_object(..., &buf_len); /* <-- no cast here */
buf.len = buf_len; /* This is a cast, but not a pointer cast. The
                      compiler will do the actual conversion if
                      needed (while pointer casts are just a matter of
                      typing, the generate no code). */

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
