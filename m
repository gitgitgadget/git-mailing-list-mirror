From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Build in gettext poison feature unconditionally
Date: Mon, 20 Aug 2012 22:24:04 -0700
Message-ID: <20120821052404.GB55686@mannheim-rule.local>
References: <1345523970-14914-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7IG4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 07:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gwA-0006pM-PG
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 07:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab2HUFX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 01:23:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51841 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2HUFX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 01:23:27 -0400
Received: by pbbrr13 with SMTP id rr13so7967523pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aTajts7vijNZSUGtfRiDxWOk4Uw0TMTd3Zmb1LLxcJM=;
        b=yqRQpAclgd8zCHaZ4GGAC1mmLtlsACX9/jbQFvVwGICKR5eLALHKTXPtn7QJrfA15Y
         RwIdJ8L2Fy43YVA5/52M9vZjUx78+Hm2nFCC93dm/5izyFVJ087HcEoOuh0dfwD9si6Y
         RZZfpL7R9IwVIq3guGoZ5aWWDNyuJuuEe0KnWuLszyGQ/md3QsvrQYW9S2EeZSlQ4VV7
         aWLEuuNqidjm7+S6ExOaCiS9yTwkzY2TYCyO+VudORJoNfWBiSETBsptz2qKbG1j89xH
         W6GjvQOveal99TZSxFeAWQdxVl3XEty5Cqa0vLYOPzQfHrtzSPYAqEEfMhCJ8ELw35av
         kfBA==
Received: by 10.68.138.166 with SMTP id qr6mr40478814pbb.69.1345526607172;
        Mon, 20 Aug 2012 22:23:27 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id io1sm658950pbc.67.2012.08.20.22.23.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 22:23:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345523970-14914-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203937>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The runtime cost should be small. "gcc -O2" inlines _() and
> use_gettext_poison(). But even if it does not, performance should not
> be impacted as _() calls are usually not on critical path. If some of
> them are, we better fix there as gettext() may or may not be cheap
> anyway.

That seems reasonable to me.  The increase in code size of a commonly
inlined function and the extra "if" in a common if not
performance-critical codepath is annoying (and I'd prefer to keep
use_gettext_poison() un-inlined), but in any event the cost would go
away once the translation-based implementation of poison lands.

[...]
>  I don't know the story behind this compile-time switch. The series [=
1]
>  that introduces it does not say much.

I think it was just paranoia about performance regressions.

>  This at least makes it easier for me to run poison tests instead of
>  building another binary, if I remember it. Next step could be make
>  "make test" run both normal and poison modes, but I'm not sure how t=
o
>  do it nicely yet.

Yes, that would be nice (or perhaps a mode to run most tests in
the current locale and rerun test assertions that use a test_i18n*
helper or C_LOCALE_OUTPUT prerequisite in the C locale).

Hope that helps,
Jonathan
