From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 16:46:41 -0500
Message-ID: <20100828214641.GA5515@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcin Cieslak <saper@saper.info>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 23:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTIP-0002Od-8w
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0H1VuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 17:50:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63736 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0H1VuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 17:50:24 -0400
Received: by gyd8 with SMTP id 8so1561765gyd.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=46xU/lM8ZOneRo9CBl0K29AW+HwB2lc67jKVPPhzvGw=;
        b=vMRawdX3VJjHLFk1U7p2/TE0DeB7Kwv9GQmQdK02HsbJS+Qyd2jUUytXRqnGZbHlrE
         qdF5HL/gs5IGrmVaWwFwUpp4Fs+J1QshkxIWeIaDDQ6YzN3oKwFnPAncnJlK9ddx6Rwg
         Gju/MXfGCCoPSYqfcbVhCGduu0X9yz+6HvSqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PzwzsYt5PPscT23K13UNrehesJcQ4sIWF+Hk/e0sOIOjVtE3aW7JFPKOWWcsaoehq+
         LYY94L+YdIKaR3c3dl/rKRajZ+NuUjo3LXdowU1GLv0Grp1kcdi6nkP2jghZlGd8WoAW
         jN4/LVgmQFSZ2OjNQku6bxM+mxDWms3R0OicM=
Received: by 10.150.228.1 with SMTP id a1mr3409114ybh.441.1283032108370;
        Sat, 28 Aug 2010 14:48:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm5721805ybk.13.2010.08.28.14.48.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 14:48:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154659>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Well, this is fun. It turns out that reverting 107880a makes it work,
> i.e. you need to set LC_CTYPE since reading *.mo files in a
> locale-awere manner involved character classification.
>=20
> But as 107880a explains doing so broke other parts of Git.
>=20
> I'll have to think about how to solve that, one way obviously would b=
e
> to fix up our vsnprintf() invocation, but there may be others like it
> that I haven't spotted.

In case you remember: why did vsnprintf() fail in that example?  If I
understand what C99 says correctly (a big if), then

 printf("%s\n", some_nonsense_string);

should always just work.

ltrace indicates that something is wacky about the format string.

 vsnprintf("Author: ", 143, "%s: %.*s%.*s\n", 0xbf8b5738) =3D -1

The regexes in http-backend are lc_collate- (but probably not lc_ctype-=
)
sensitive.  I am not sure how to go about exhaustively tracking down
ctype-dependencies.
