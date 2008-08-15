From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to human
 readable form
Date: Thu, 14 Aug 2008 20:46:21 -0400
Message-ID: <48A4D1DD.9060202@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <20080814223429.GC10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnTW-0005XI-Bp
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYHOAq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYHOAq1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:46:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:51801 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYHOAq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:46:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so803088wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=+WBK3TUoj1Ezr4h+ZvSVO/4o/TdabEZyTO7NY2owtu4=;
        b=gtmlRKheubKQKAUHAuUUZ3nK07fK8TooRmhNHi0izHQTTvaNjZZhcG9a6hqzBNy74O
         iw3tWSNSYuk+RpVEpKMId00vspha94IM6sIh6+m54DsiEsL/YFzRhIhoonKB1K69OfaG
         ZBmjpd4mz5WA61qwLwQkYZ2nRqB2S50qV5E24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=bZTASouUkbVEK+TRc9pILyNgJtFE/GZfWamyE5oDJ+cp4oExyErIG5UD9mFsVW5O+Y
         2tQL2/4sRJv0Rbn9iH1F3wa40QP8w0PUJ8AAxpxOpz4zgVntmb3CdNxNEBKeyNXTyRcs
         N/xhEfoiBC3Q2SgjVjC1YTCDG/Rnr+frTgoXE=
Received: by 10.90.104.20 with SMTP id b20mr2746635agc.63.1218761185205;
        Thu, 14 Aug 2008 17:46:25 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 10sm4569526wrl.11.2008.08.14.17.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 17:46:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814223429.GC10544@machine.or.cz>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92452>

Petr Baudis wrote:
> Frankly, I doubt this has too much value, and it complicates the code=
 _a
> lot_. If you can't fit your stuff into pretty column, it's better to
> just print whatever you have to and disrupt the columns instead of
> _failing_, isn't it?

Generally, the only reason for such a failure would be requesting
conflicting scale and maxlen values or requesting a maxlen which would
be too small to reasonably display any value, hence an empty string and
a number reporting how much more is necessary to get appropriate output=
=2E

In other words, a failure reports that you probably requested an
irrational number for maxlen.  It would probably be easier to understan=
d
if it were in terms of the numeric output rather than the entire string=
=2E
If I change it that way, then there shouldn't be an "irrational" positi=
ve
number to request, eliminating the need for these failures.

> Shouldn't pretty much all of this be documented in the code too?

Should I stuff this in comments in the header file, source file, or bot=
h?

> My point still stands - in case of binary units, we should always
> consistently use the i suffix. So having an example in the commit
> message that advertises "bps" is simply wrong when it should read "iB=
/s"
> (like it does with the current progress.c code).
>=20
> I may sound boring, but it seems to me that you're still ignoring my
> point quitly without proper counter-argumentation and I think it's an
> important want, and since it's so hard to keep things consistent acro=
ss
> the wide Git codebase, we should do all we can to keep it.

=46rom a consistency standpoint, I can certainly agree.  It's not hard =
to
implement.  I wanted to avoid pigeon-holeing, but to keep our reporting
consistent, using '*i' for all binaries works for me.

> Whitespace damage? Also at a lot of other places in your patch.

No damage.  It was indicated to me that 80-ish was the preferred width,=
 so
I was trying to follow that.  If that's not true in the C sources, I'll
bundle things up a bit more.

> Hmmm. We could have
>=20
> +        char *hr_prefixes[] =3D {
> +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi", NULL
> +	};
> +        char *hr_si_prefixes[] =3D {
> +		"", "k", "M", "G", "T", "P", "E", "Z", "Y", NULL
> +	};
>=20
> ;-)

Per previous, sounds good to me.

Overall, I was looking to create a generic function that could be used
across Git without making assumptions of the consumer.  Hence the maxle=
n,
scale, SI, and space configurability.

Thanks for the input, and I'll work up another draft.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
