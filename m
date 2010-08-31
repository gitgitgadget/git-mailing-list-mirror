From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Tue, 31 Aug 2010 17:45:17 -0500
Message-ID: <20100831224517.GB6747@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-8-git-send-email-avarab@gmail.com>
 <20100831151800.GG2315@burratino>
 <AANLkTi=+oGVx_T_-0T0RTqe+rV4QwQakjXUXKk8tddFL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 00:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqZbr-0004Ek-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 00:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab0HaWrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 18:47:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38791 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab0HaWrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 18:47:14 -0400
Received: by qyk36 with SMTP id 36so1440437qyk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8o4EoXICJDJTiDoCqyHYPJ6hPLLAMoIoHUwkjE77m60=;
        b=gdzARXjBJsCZwf9tNe9zzIHpFYC2TSsVDcfi7bMGZ0nx9RvbT/Xm+At03WAWgs1vTB
         h6Pj1rlXkdCoMlHHJUyfsea8hyrX0lMDt0fQcJbiF8GGH1Yj8cPwMvmhAFNy8zi4EdvW
         XKVIDxkjBljH7cMfusSr4OE4zElJWNWwqGFIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Pq6X9X5JbCGg19zA0vXEmcwaaFGaYG1nHk4XbJyRGUlJ+LUyng8agLDFGYVbNeYPwV
         AscSVmaD1yFtceMCTkv8K1nGvBv/5xjrj0shA7lggLl8ChUT/GFhOp0sHhk84/QU6xsj
         dDBopxw50SuKov8NY8cLCdERu6/W9+9FATPqo=
Received: by 10.229.224.146 with SMTP id io18mr4656490qcb.171.1283294829726;
        Tue, 31 Aug 2010 15:47:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t18sm10285541qco.44.2010.08.31.15.47.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 15:47:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=+oGVx_T_-0T0RTqe+rV4QwQakjXUXKk8tddFL@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154991>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Aug 31, 2010 at 15:18, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Aside, not about this patch: glibc printf can be very convenient for
>> translators, because of format strings like "%4$s". =C2=A0Do other c=
ommon
>> platforms like FreeBSD and Mingw have something similar?
>
> I certainly hope so. I was planning on documenting its usage,
> Johannes?

Sorry, my knowledge was just outdated.  It's in posix[1] now, which
I think means we can expect it to be in any recent libc.

Unfortunately msys uses newlib 1.9.0 afaict, from 2001.  The %4$s
support was introduced[2] to newlib by Eric Blake on 2007-04-25.

[1] http://www.opengroup.org/onlinepubs/9699919799/functions/printf.htm=
l#tag_16_159_03
[2] http://sourceware.org/cgi-bin/cvsweb.cgi/src/newlib/libc/stdio/vfpr=
intf.c?cvsroot=3Dsrc
