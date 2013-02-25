From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC/WIP PATCH 1/3] teach config parsing to read from strbuf
Date: Mon, 25 Feb 2013 18:29:10 +0100
Message-ID: <20130225172909.GA3483@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA1ry-0007xW-5g
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab3BYR3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:29:17 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:58535 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab3BYR3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:29:17 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UA1rS-00022a-Fc; Mon, 25 Feb 2013 18:29:10 +0100
Content-Disposition: inline
In-Reply-To: <7v4nh13plo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217066>

Hi Junio,

On Sun, Feb 24, 2013 at 09:54:43PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > diff --git a/config.c b/config.c
> > index aefd80b..f995e98 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -13,6 +13,9 @@
> >  typedef struct config_file {
> >  	struct config_file *prev;
> >  	FILE *f;
> > +	int is_strbuf;
> > +	struct strbuf *strbuf_contents;
> > +	int strbuf_pos;
> >  	const char *name;
> >  	int linenr;
> >  	int eof;
> 
> The idea to allow more kinds of sources specified for "config_file"
> structure is not bad per-se, but whenever you design an enhancement
> to something that currently supports only on thing to allow taking
> another kind, please consider what needs to be done by the next
> person who adds the third kind.  That would help catch design
> mistakes early.  For example, will the "string-list" (I am not
> saying use of string-list makes sense as the third kind; just as an
> example off the top of my head) source patch add
> 
> 	int is_string_list;
>         struct string_list *string_list_contents;
> 
> fields to this structure?  Sounds insane for at least two reasons:
> 
>  * if both is_strbuf and is_string_list are true, what should
>    happen?
> 
>  * is there a good reason to waste storage for the three fields your
>    patch adds when sring_list strage (or FILE * storage for that
>    matter) is used?
> 
> The helper functions like config_fgetc() and config_ftell() sounds
> like you are going in the right direction but may want to do the
> OO-in-C in a similar way transport.c does, keeping a pointer to a
> structure of methods, but I didn't read the remainder of this patch
> very carefully enough to comment further.

Thanks for taking a look. You suggestion sounds reasonable, I will
modify my patch accordingly.

Cheers Heiko
