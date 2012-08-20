From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] parseopt: do not translate empty help string
Date: Mon, 20 Aug 2012 22:10:33 +0200
Message-ID: <87obm5jpdy.fsf@thomas.inf.ethz.ch>
References: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch>
	<7vboi5jrn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3YJ9-0002BI-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab2HTUKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 16:10:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:32453 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab2HTUKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 16:10:36 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 20 Aug
 2012 22:10:30 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 20 Aug
 2012 22:10:33 +0200
In-Reply-To: <7vboi5jrn1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Aug 2012 12:21:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203871>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The gettext .po files have a header, but it looks like the translation
>> specification for an empty string.  This results in _("") actually
>> returning that header.
>
> Thanks; this is a tricky bit to catch and makes me wonder where else
> we have a similar breakage.
>
> Perhaps we would want to do this instead?  I dunno.
>
>  gettext.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git i/gettext.h w/gettext.h
> index 57ba8bb..376297b 100644
> --- i/gettext.h
> +++ w/gettext.h
> @@ -44,6 +44,8 @@ extern int use_gettext_poison(void);
>  
>  static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>  {
> +	if (!*msgid)
> +		return "";
>  	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
>  }

Oh, I forgot that we actually had a wrapper instead of the usual _.
Yes, I think that would be the better solution to guard against this.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
