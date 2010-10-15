From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 10:49:00 +0000
Message-ID: <AANLkTi=YN41n-BnVNo3HsnxNxQNBX=Ev-upmM0N49uOZ@mail.gmail.com>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
	<20101015051750.GA21830@burratino>
	<AANLkTinBuAhLLUMLd6ZWtVFWCjnFAxYwVSo1Pkja7bT4@mail.gmail.com>
	<20101015060654.GD21830@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 12:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6hqZ-0002Cg-PM
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 12:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab0JOKtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 06:49:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46973 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab0JOKtD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 06:49:03 -0400
Received: by fxm4 with SMTP id 4so292744fxm.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sEZCDbeupoeeOtd7EheghrJLKZXDrWZ/gQm806Slk9U=;
        b=Zhv5I0E5Y3TORTUWIOTauME2IL3vj6HErFrY2fktqWSvHrau7rd9nS3lSttrSP92GG
         I0sPYINBu2I4zwZfn3RE5aH2DjuvbNJ6zNLDpLODIYDGNV8irEnnYjd4F5AXPEjQZzMs
         wP4I7P/wxcM/xzh5kSqkRgGeTZq7rb/TAe9sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vOiDK44tfvRtmfZPmZ7iD5iiEtf082rXR1VFJ3wkiAhtGk1e9U82xvFrwI4vjqfooS
         jeiyS+lv/OnlOConK/yZzVgBFScN14EcvJ0I3k6dRhgsrlkIWTkImxGH4YEuvT3PIHJT
         AAVigFtjfVgRgdzsY5JBvBW3TtUGhBWohCw38=
Received: by 10.103.199.6 with SMTP id b6mr172427muq.55.1287139740897; Fri, 15
 Oct 2010 03:49:00 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Fri, 15 Oct 2010 03:49:00 -0700 (PDT)
In-Reply-To: <20101015060654.GD21830@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159110>

On Fri, Oct 15, 2010 at 06:06, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Maybe something like this for configure.ac:
>>
>> =C2=A0 =C2=A0 AC_CHECK_LIB([c], [memchr],
>> =C2=A0 =C2=A0 [HAVE_MEMRCHR=3DYesPlease],
>> =C2=A0 =C2=A0 [HAVE_MEMRCHR=3D])
>> =C2=A0 =C2=A0 AC_SUBST(HAVE_MEMRCHR)
>>
>> And documentation with the other HAVE_* variables at the top of the
>> Makefile?
>
> Hmm, the BSDs and plan 9 have an memrchr() apparently. =C2=A0 Any ide=
a for
> taking advantage of that (the makefile support part) that's less ugly
> than this?

Check out my "Makefile & configure: add a NO_FNMATCH flag" and
"Makefile & configure: add a NO_FNMATCH_CASEFOLD flag" patches already
in pu.

Maybe it should be a NO_* flag since that's what we use when we expect
sanity, e.g. we have NO_REGEXP=3D, NO_CURL and NO_GETTEXT.

Then you just need NO_MEMRCHR=3DUnfortunatelyYes entries in the big
if/else block for those platforms that don't have it.

But memrchr() is a GNU extension so it should probably be a HAVE_*. I
don't know.

> If we miss a platform, that's no big deal. =C2=A0The 1-char-at-a-time
> loop is not so slow, and the "#define memrchr gitmemrchr" ensures
> that it would not conflict with the libc version.

Yup, probably best as a HAVE_*. In any case the autoconf probe I added
should work when memrchr is spelled properly.
