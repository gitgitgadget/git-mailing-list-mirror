From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 5 May 2011 09:41:47 +0200
Message-ID: <20110505094147.22e3d158@mkiedrowicz>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
	<4DC2418E.4070006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 09:42:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtCH-0001yy-JM
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab1EEHl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 03:41:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44248 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1EEHlv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 03:41:51 -0400
Received: by wwa36 with SMTP id 36so2053124wwa.1
        for <git@vger.kernel.org>; Thu, 05 May 2011 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Fjo154QBEctLh8hHGG536JPyRkgdITyBNAone/Rae6E=;
        b=dW+33Fn5+ax8+CaTiM5kpaieRV8a9G1FP07cgB3JUsLM2mWA5y8fd6XzMGr6UMSU/f
         8djwBrJ+89Bs/8TS8LCRxSSkzbalPDQCuvCRC+mG9mthtRXBh3o3bguUUrlbNZ2qWopb
         AdNf4bzTbVPZGkRENmNYOibpmkjQsdQrF0rRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Pt7E7AnCFzAcELg7nkKGUWakM/5yF+Spm/YVK4nb449IilXQ3p1gGivsnxlOG+uaC7
         ArAGcktf3h1DJMg4PLGmbF6U9KO8itCdVyvYHwGHDEz8wtGs2Ue5nMSa4Q8Q54zzCv+b
         0lVTw9rgHK0W7+dlHmph9HgTmnlPDhnVMnb5w=
Received: by 10.227.7.18 with SMTP id b18mr2156449wbb.103.1304581310031;
        Thu, 05 May 2011 00:41:50 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id o23sm1166775wbc.44.2011.05.05.00.41.49
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 00:41:49 -0700 (PDT)
In-Reply-To: <4DC2418E.4070006@viscovery.net>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172811>

On 05.05.2011 08:19:58 +0200 Johannes Sixt <j.sixt@viscovery.net> wrote=
:

> Am 5/5/2011 0:00, schrieb Micha=C5=82 Kiedrowicz:
> > +# Define NO_LIBPCRE if you do not have libpcre installed.
> > git-grep cannot use +# Perl-compatible regexes.
>=20
> For what purpose are you adding Perl-regex when git-grep cannot use
> them?
>=20
> ...
>=20
> Oh! You mean to say "..., but git-grep cannot use Perl-compatible
> regexes _in this case_".
>=20
> ;)
>=20
> This repeats in patch 5/5.

I took this from NO_CURL and NO_EXPAT descriptions:

	 Define NO_CURL if you do not have libcurl installed.
	 git-http-pull and git-http-push are not built, and you
	 cannot use http:// and https:// transports.

	Define NO_EXPAT if you do not have expat installed.
	git-http-push is not built, and you cannot push using
	http:// and https:// transports.

But I can reword it :).

>=20
> > +#ifdef NO_LIBPCRE
> > +static void compile_pcre_regexp(struct grep_pat *p, struct
> > grep_opt *opt) +{
> > +	die("cannot use Perl-compatible regexes when libpcre is
> > not compiled in");
>=20
> This is such a terminus technicus. Wouldn't it be much easier to read
> for Joe User if this were merely:
>=20
> 	die("Perl-compatible regexes not supported");

I can argue. My message says why they aren't available, while your
proposition leaves Joe without a clue :). But I'm not that much attache=
d
to it, I can change it.

>=20
> Also, wouldn't it be nicer to die already when the --perl-regexp
> option is detected? Then you could make these functions dummies that
> behave as if nothing was matched.
>=20

I prefer to die() at lowest possible level in case someone wants to use
these functions in another way (e.g. from revision-walking code).

But I can abstract these calls to die_pcre_not_supported() to not
repeat die() message.

> > +}
> > +
> > +static int pcrematch(struct grep_pat *p, char *line, char *eol,
> > +		regmatch_t *match, int eflags)
> > +{
> > +	die("cannot use Perl-compatible regexes when libpcre is
> > not compiled in"); +}
> > +
> > +static void free_pcre_regexp(struct grep_pat *p)
> > +{
> > +	die("cannot use Perl-compatible regexes when libpcre is
> > not compiled in"); +}
>=20
> -- Hannes

Thanks for comments :)
