From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v6 0/5] Reroll patches against v1.8.3.1
Date: Wed, 26 Jun 2013 11:37:09 +0400
Message-ID: <20130626073423.GA23688@ashu.dyn1.rarus.ru>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
 <cover.1372149305.git.Alex.Crezoff@gmail.com>
 <7vppva2dod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 09:37:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrkI4-0000uZ-SX
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 09:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3FZHhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 03:37:14 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51656 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3FZHhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 03:37:13 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so1318439lbd.32
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z0z+FbZMfkwJU4DyYvkK8RlcnW8B8t8bqvoy020rkMM=;
        b=zQUGm3uz9I7SDPOscqINZyuKmi8sAAHAewyAkHlZ9+3z+6OaNaIV+ck7fG0sL6XlAo
         uhKU6CgIb9OB7oXxqa7wV4PiG8iyw/KP/qERryMg0q5FOoXNZyFbBpM1nTNcSHCbd7RK
         A+qviOvaDaERH+BhYav/I5uVmJIhcyz0kSC6W/kh5jX09klUh4sRr+xPecE+YZjl+8Po
         7hJ8ZbiyuyGYJfT/M0gtXy52qHoXrKgtw366GTcNRBKUNaTZY741mT00wQ1KTFd2eN2G
         iY7LhwuPesWvWYUJGtE9OQx96l+h8i2yFWVn7diTgblAqU10Ghoe0EfiY/s0xKszBAT5
         s22A==
X-Received: by 10.152.5.6 with SMTP id o6mr1260520lao.48.1372232231605;
        Wed, 26 Jun 2013 00:37:11 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id u1sm10248236lag.5.2013.06.26.00.37.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 00:37:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vppva2dod.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229033>

On Tue, Jun 25, 2013 at 12:28:02PM -0700, Junio C Hamano wrote:
> Alexey Shumkin <Alex.Crezoff@gmail.com> writes:
>=20
> > 4. [PATCH v6 4/5] pretty: Add failing tests: --format output should=
 honor logOutputEncoding
> > 	iso8859-5 encoding reverted back to cp1251 encoding (as it was in =
v4 series)
>=20
> Thanks for a reroll, but why this change?
>=20
> The reason I asked you to avoid 8859-5 is because our test do not
> use that encoding and I do not want to add new dependency to people
> when they run test.  cp1251 shares exactly the same issue, doesn't
> it?  So in that sense, this change does not make anything better.
>=20
> That is why I asked you if the breakage you are trying to
> demonstrate about non-ASCII non-UTF8 encoding was specific to
> Cyrillic/Russian.  I do not recall seeing your answer, but what is
> the right thing to do depend on it.
>=20
>  - If the answer is yes, then we would need to add dependency either
>    way, and 8859-5 is just as fine as cp1251.
>=20
>  - If the breakage is not specific to Cyrillic, it should be
>    reproducible using 8859-1 (latin-1), and our tests already depend
>    on 8859-1, so we wouldn't be adding new dependencies on people.
>=20

I suppose you've missed my answer somehow. It was:
---8<---
> Alexey Shumkin <Alex.Crezoff@gmail.com> writes:
>=20
> > @@ -19,7 +23,8 @@ add_file () {
> >  			echo "$name" >"$name" &&
> >  			git add "$name" &&
> >  			test_tick &&
> > -			git commit -m "Add $name" || exit
> > +			msg_added_iso88595=3D$(echo "Add $name ($added $name)" | iconv =
-f utf-8 -t iso88595) &&
> > +			git -c 'i18n.commitEncoding=3Diso88595' commit -m "$msg_added_i=
so88595"
>=20
> Hmph.  Do we know 8859-5 is available or do these need to be
> protected with prereq?
Opps, this encoding is absent even in my Cygwin box :)
Actually, previuosly, there was a Windows-1251 encoding,
you said we'd prefer to limit different encodings used in tests,
And I've made an attempt to avoid this but I'm way off the mark.

>=20
> Can these tests be done with 8859-1 i.e. something we already depend
> on, by changing that $added message to latin-1, or is there something
> very Russian specific breakage we want to test here?
Well, actually, most popular Russian 8-bit codepages are Windows-1251 (=
aka cp1251) and KOI8-R.
Cygwin (as a "Linux box on Windows") uses cp1251.
Iconv cannot even convert Russian messages from cp1251(or UTF-8) to lat=
in1.
It fails.
  $ echo "=EA=EE=EC=EC=E8=F2" | LANG=3D iconv -t latin1 -f UTF-8=20
  iconv: illegal input sequence at position 0
("=EA=EE=EC=EC=E8=F2" is a "commit" in Russian)

>=20
> If the former, please redo this entire patch (not just t4041) with
> 8859-1.
>=20
> If there is some Russian specific breakage you cannot demonstrate
> with 8859-1, then please explain it in the log message.
Well, it's not a "Russian specific". It's "codepage conversion" specifi=
c,
but I cannot use latin1 codepage because I do not know any language tha=
t
uses iso8859-1/latin1 codepage (as German, Spanish, for example) to
write a commit message in it.
If someone can do the same with latin1, I'd be happy.
>=20
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.s=
h
> > index d32e65e..36e4cc0 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > ...
> > -# usage: test_format name format_string <expected_output
> > +# usage: test_format [failure] name format_string <expected_output
> >  test_format () {
> > +	local must_fail=3D0
>=20
> This breaks tests for non-bash users.  "local" is not even in POSIX.
---8<---

But today I've taken a look to Cygwin's locales more closely and found
out that I've used incorrect encoding name (`iso88595` instead of "cano=
nic"
`iso-8859-5` that Cygwin has and "understands")

Nevertheless, as I've already said that is not a Russian locale specifi=
c
issue.
The problem in tests for me now is a language (that uses iso-8859-1
encoding) I do not speak or even write ;)

--=20
Alexey Shumkin
