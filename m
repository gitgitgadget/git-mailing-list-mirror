From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Strbuf documentation: document most functions
Date: Tue, 03 Jun 2008 17:41:38 +0200
Message-ID: <48456632.9040103@lsrfire.ath.cx>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Yeo-0000zI-AQ
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 17:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYFCPlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYFCPlt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 11:41:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:36187 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbYFCPls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 11:41:48 -0400
Received: from [10.0.1.200] (p57B7F0F7.dip.t-dialin.net [87.183.240.247])
	by india601.server4you.de (Postfix) with ESMTPSA id C65DC2F8055;
	Tue,  3 Jun 2008 17:41:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83676>

Miklos Vajna schrieb:
> Actually this is a bit of request for help, I haven't figured out wha=
t
> strbuf_expand() does [...]

It can be used to expand a format string containing placeholders.  To
that end, it parses the string and calls the specified function for
every percent sign found.

The callback function is given a pointer to the character after the '%'
and a pointer to the struct strbuf.  It is expected to add the expanded
version of the placeholder to the strbuf, e.g. to add a newline
character if the letter 'n' appears after a '%'.  The function returns
the length of the placeholder recognized and strbuf_expand skips over i=
t.

All other characters (non-percent and not skipped ones) are copied
verbatim to the strbuf.  If the callback returned zero, meaning that th=
e
placeholder is unknown, then the percent sign is copied, too.

In order to facilitate caching and to make it possible to give
parameters to the callback, strbuf_expand passes a context pointer,
which can be used by the programmer of the callback as she sees fit.

You can see it in action in pretty.c, where it expands --pretty=3Dforma=
t:
placeholder strings.  The callback may be a bit heavy for a first
encounter, though. ;-)

Ren=E9
