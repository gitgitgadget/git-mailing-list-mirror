From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Sat, 10 Jan 2009 12:37:09 -0800
Message-ID: <7vbpuex5hm.fsf@gitster.siamese.dyndns.org>
References: <4967D8F8.9070508@lsrfire.ath.cx>
 <4967DB4A.2000702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 10 21:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLkbT-00016Z-Iq
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 21:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbZAJUhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 15:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbZAJUhT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 15:37:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZAJUhR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 15:37:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C0961C324;
	Sat, 10 Jan 2009 15:37:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03F331C323; Sat,
 10 Jan 2009 15:37:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 786E9EA6-DF56-11DD-88AF-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105144>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Add the new flag "fixed" to struct grep_pat and set it if the pattern
> is doesn't contain any regex control characters in addition to if the
> flag -F/--fixed-strings was specified.
>
> This gives a nice speed up on msysgit, where regexec() seems to be
> extra slow.  Before (best of five runs):

Thanks, and...

>  static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
> -	int err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
> +	int err;
> +
> +	if (opt->fixed || is_fixed(p->pattern))
> +		p->fixed =3D 1;
> +	if (opt->regflags & REG_ICASE)
> +		p->fixed =3D 0;

=2E.. thanks again for being extra careful.  That's why I *love* your
patches.
