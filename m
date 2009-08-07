From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: parse_commit_text encoding fix
Date: Fri, 7 Aug 2009 02:41:05 +0200
Message-ID: <200908070241.07372.jnareb@gmail.com>
References: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com> <1249198944-19630-1-git-send-email-zfuzesi@eaglet.hu> <7viqh43vz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 02:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZDWP-0004w3-Kd
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 02:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323AbZHGAlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 20:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbZHGAlR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 20:41:17 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:50698 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbZHGAlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 20:41:17 -0400
Received: by fxm28 with SMTP id 28so1072540fxm.17
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GkRYtLXc1O1cCEEnl/HxBZfCxj0EUVU6voD4pLvMfsc=;
        b=nbaG+WcGWe989JQtendwqN4RA5UCtT931HKN2sZUS0wl8h7FCiSNrxK6n4bmASaUvh
         ggjmeITrG/XPvNazhh5JITrD++vBvcILekamS1f8JpGkDhHYL5o5KL468C2sMkzprMze
         ljnTDjP2PrA/Ei9rBL4YeHDLSX4/TnWbE0HZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GE/yy4vzMjioPzYH6/o9zUfvoGZqr4inTEVcMYn8vl6HyLLQywG7a40SV3kQLt2I4R
         Q65iDb4NEEbHq3IHB58XnzsVhShMkVrZcIiBNtgDtNxuyT1sMLcjVWDSHHuz3pArDVD1
         tscPuJeOJGupgaPZxq/w399l74ZesT17jzuu4=
Received: by 10.102.218.2 with SMTP id q2mr3051mug.74.1249605676964;
        Thu, 06 Aug 2009 17:41:16 -0700 (PDT)
Received: from ?192.168.1.13? (abwt158.neoplus.adsl.tpnet.pl [83.8.243.158])
        by mx.google.com with ESMTPS id 12sm2468849muq.22.2009.08.06.17.41.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 17:41:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqh43vz3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125147>

On Tue, 4 Aug 2009, Junio C Hamano wrote:
> Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu> writes:
>=20
> > Call to_utf8 when parsing author and committer names, otherwise the=
y will appear
> > with bad encoding if they written by using chop_and_escape_str.
> >
> > Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
> > ---
>=20
> Thanks, Zolt=C3=A1n.
>=20
> We should be able to set up a script that scrapes the output to test =
this
> kind of thing.  We may not want to have a test pattern that matches t=
oo
> strictly for the current structure and appearance of the output
> (e.g. counting nested <div>s, presentation styles and such), but if w=
e can
> robustly scrape off HTML tags (e.g. "elinks -dump") and check the
> remaining payload, it might be enough.
>=20
> Jakub what do you think?  I suspect that scraping approach may turn o=
ut to
> be too fragile for tests to be worth doing, but I am just throwing ou=
t a
> thought.

=46irst, I'd like to have existing t9500-gitweb-standalone-no-errors.sh
be about Perl errors and warning only, as it is now.  Anything outside
this should IMVHO be put in separate test.

Second, for checking whether gitweb handles non US-ASCII input correctl=
y
we don't need HTML scrapping or parsing.  We can simply check if we hav=
e
correct string in output... and (after Zolt=C3=A1n F=C3=BCzesi example)=
 that we
don't have incorrect one.  For example if we have 'xxx=C3=B3xxx' in inp=
ut,
then there is 'xxx=C3=B3xxx' in output, and that all match againts 'xxx=
=2Exxx'
matches 'xxx=C3=B3xxx'.

--=20
Jakub Narebski
Poland
