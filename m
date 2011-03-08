From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH v2] blame: honor core.abbrevguard
Date: Tue, 08 Mar 2011 10:38:16 +0900
Message-ID: <1299548296.1467.18.camel@leonhard>
References: <1299472540-6066-1-git-send-email-namhyung@gmail.com>
	 <1299475335-8436-1-git-send-email-namhyung@gmail.com>
	 <7vipvuzau2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwlsg-00023v-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 02:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab1CHBiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 20:38:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48574 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab1CHBiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 20:38:20 -0500
Received: by pwi15 with SMTP id 15so851164pwi.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 17:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=1C/A67bO7OuPhFkPiNPRXdV81wJHGKnYjdjNRimQTig=;
        b=pmzPxUyfwskHQVKNAoKkf1sNNSUa2aGDEQBZwmr/s+BSewXeFV+A/uWsQd2iqw4Jzq
         jF9oEW1yfUbF0qSxhTgXcYwfDZZXHclLdZOokAySp78sIftWQVZ409+sP1xT2840pm6l
         cDp8FVdjeGqiueLZoRkGjJ5s9UfFh2naWp70w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qnVftcbnEyjRHmFsizm6N4hgJyr5IScj6/wR+W71LsBz2NCYXSbhmF5orcP6OjtYha
         mQ4gBn0NWDTmVJatcABCsH0j2wcD97v8DxMAsY+jC55LJycpm2SNOgaYQ3HJJnRAoY8Z
         F/D8BKjyOstIXy0Wft2nnXYNi/iliDrC2jcJ8=
Received: by 10.142.192.9 with SMTP id p9mr573829wff.120.1299548300265;
        Mon, 07 Mar 2011 17:38:20 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id z8sm267871wfj.1.2011.03.07.17.38.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 17:38:19 -0800 (PST)
In-Reply-To: <7vipvuzau2.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168630>

Hi,

2011-03-07 (=EC=9B=94), 16:59 -0800, Junio C Hamano:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > Commit 72a5b561 ("core.abbrevguard: Ensure short object names stay
> > unique a bit longer") introduced this config variable to make objec=
t
> > name unambiguously. Use it.
> >
> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> > ---
> > v2:
> >  - re-init 'length' in every loop
>=20
> In this codepath, we only aim to make sure that the shortened object =
name
> is of the same length.  By choosing hardcoded 8, the original clearly
> declares that we do not _care_ about the uniqueness.
>=20

Just out of curiousity, where did the number come from? I guess
DEFAULT_ABBREV + '^' ?


> The abbrev-guard that adds to the length that ensures the uniqueness =
in
> the particular repository has a very different semantics.  It only ma=
kes
> sense if you add to a length that you know would make the object name=
s
> minimally unique.  Adding it to hardcoded 8 does not make it less
> ambiguous the same way as the configuration variable intends to do.
>=20
> So I am not entirely happy with this patch.
>=20
> Besides, when OUTPUT_LONG_OBJECT_NAME is specified, the value this
> variable holds is _not_ "uniq_length", so the name of the variable is=
 not
> quite correct.  We colloquially call the object name "sha1" in the co=
de,
> so "sha1_length" would be a better name for it.
>=20

OK. I was not happy with the name, too. :)


> If we _were_ to do a change that uses the configuration variable, I w=
ould
> imagine that it would be a part of a change that makes sure that the
> shortened object names in the output actually uniquely identify the
> commits.  It would involve find_unique_abbrev() for as many commits a=
s the
> number of lines in the blamed range at most (and at that point the ab=
brev
> guard would automatically taken into account because find_unique_abbr=
ev()
> already does so) before calling "output()"; I suspect that find_align=
ment()
> is the right function to do so, as that is where the column alignment
> logic all happens.
>=20
> It would probably need to be introduced as a new feature, with its ow=
n
> command line option, similar to -l option that forces the full 40-hex
> output.
>=20

Looks Great. How about -u/--unique? I'm also thinking about --abbrev
too, isn't it useful at all?


> So thanks for a patch, but I don't think we would want to take it in =
the
> current shape.

Thanks for your kindly comment.


--=20
Regards,
Namhyung Kim
