From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Mon, 30 Jul 2007 21:36:47 -0700
Message-ID: <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
References: <11858309261111-git-send-email-krh@redhat.com>
	<11858309311728-git-send-email-krh@redhat.com>
	<11858309322006-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFjU4-0007fS-ID
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969023AbXGaEgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 00:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761722AbXGaEgw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:36:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41623 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968198AbXGaEgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 00:36:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731043650.SBBG23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 00:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W4cp1X00K1kojtg0000000; Tue, 31 Jul 2007 00:36:50 -0400
In-Reply-To: <11858309322006-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 30 Jul 2007 17:28:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54320>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> +static void inline strbuf_grow(struct strbuf *sb, size_t extra)
> +{
> +	while (sb->alloc < sb->len + extra)
>  		sb->alloc =3D sb->alloc * 3 / 2 + 16;
> +	sb->buf =3D xrealloc(sb->buf, sb->alloc);
> +}

Somehow this while () loop to compute the growth factor bothers
me but that is probably a minor detail.

> +void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
> +{
> +	char one_line[2048];
> +	va_list args;
> +	int len;

Such a nice abstraction so far, and then at the highest level of
callchain we have this hardcoded limit?
