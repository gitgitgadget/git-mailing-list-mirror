From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 04 Oct 2010 10:54:55 -0700
Message-ID: <7v8w2d972o.fsf@alter.siamese.dyndns.org>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
 <20101004093519.GN24884@burratino>
 <AANLkTimBzC7f7teH8Rriykg7o5kwX6mD2g2q-0yOXSiF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@netbsd.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pFt-0001hR-Gn
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab0JDRzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 13:55:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab0JDRzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 13:55:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF7FDBF34;
	Mon,  4 Oct 2010 13:55:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uOlgdq0Sfp4J
	P4Pfd6YG6JM0uOU=; b=LibSbwHJUSShsI++00hz8Z55AE5Z1B9kj3BuaLTjgqM1
	lWYSQzzBv0dy4Ab2KrgOs+HkxbxvIgXdelynS7Jo60VOFBcCkJROAHXOBND4QqWa
	SBhic8ByUYQlbAqZmtAs+C+T8KCx0LWj5n0wXHDsmH1l8609GrDmBu1wd8PaIXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EQs9gG
	IwBYg25UaSkMWzguPjj6RRux/MpGdXHU1IiYsYWMk2vNgjiXkBaUqH91PcFr8dVa
	XsA2lWXyHKYyI7QQVrjQlNX0FS9xErey7ThhgaMAO3nQkEFmOUPFxqbxrPJPDfa9
	CpMwqbLdlG5l0ATGkNZ6Dc9KPimBw1qh5fv+k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41DB0DBF31;
	Mon,  4 Oct 2010 13:55:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28F06DBF2B; Mon,  4 Oct
 2010 13:54:56 -0400 (EDT)
In-Reply-To: <AANLkTimBzC7f7teH8Rriykg7o5kwX6mD2g2q-0yOXSiF@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 4 Oct
 2010 09\:47\:43 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 839EF628-CFE0-11DF-841F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158075>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Oh it's a bug in NetBSD, sorry for not being explicit about that:
>
>     $ grep S_ISREG /usr/include/sys/stat.h
>     #define S_ISREG(m)      ((m & _S_IFMT) =3D=3D _S_IFREG)     /* re=
gular file */
>
>     $ grep S_ISREG /usr/include/linux/stat.h
>     #define S_ISREG(m)      (((m) & S_IFMT) =3D=3D S_IFREG)
>
> I.e. GCC sees `S_IFREG | 0644 & _S_IFMT' on NetBSD but `(S_IFREG |
> 0644) & _S_IFMT' on Linux.
>
> Since bitwise AND (&) has precedence over bitwise OR it's probably a
> logic error on NetBSD too, not just an annoying warning.

In that case, I'd prefer to work this around at the definition of
canon_mode(), like

    /*
     * extra ()-pair around S_ISREG() and friends to work around platfo=
rm
     * header with buggy definitions like
     * #define S_ISREG(x) ((x & _S_IFMT) =3D=3D _S_IFREG)
     */
    #define canon_mode(mode) \
    	(S_ISREG((mode)) ? (S_IFREG | ce_permissions(mode)) : \
        ...

instead of contaminating the calling sites.  Otherwise new calling site=
s
we will add in the future need to be aware of the same bug for no good
reason.
