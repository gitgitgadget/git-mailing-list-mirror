From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Inline functions (Re: [PATCH/RFC v7 1/2] Add infrastructure for
 translating Git with gettext)
Date: Sat, 5 Jun 2010 15:16:53 -0500
Message-ID: <20100605201652.GA5652@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605030059.GB2019@progeny.tock>
 <AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
 <20100605033849.GB2252@progeny.tock>
 <AANLkTim3PcoLrYb46Bh3tK7Ir3v-K0EQ0czPaD5DIIOK@mail.gmail.com>
 <20100605185926.GA5273@progeny.tock>
 <AANLkTilRqVaVV5q-7NrserSDr0t4L1D_j8rNIWxtMYe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 22:17:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKznf-0002uB-VY
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 22:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab0FEUQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 16:16:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35359 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab0FEUQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 16:16:54 -0400
Received: by iwn37 with SMTP id 37so2156773iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CMptCIM6TOohRJMbnqbkqZkMQH1UlAcvIgP88rgd9aU=;
        b=a7eVIHAcpjsj3U9MAy2DQ8j23w7liMUYR8u/+15uQ8/UIlcO/+iconwJO0RXaLKeJc
         COpG/vFtFRWqpiNmzu/zZ+KztD+o9jc3DxX8jYa6l2LfDzhhLmdRXsvyUnJw79SjjCho
         CkgyIJslVTUadvijORc6oN3JuxR0bWonerRiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gC36byglhZr6JGIlNZIF1vB2WzUuKIIeEwAliged409ypvDB+rXjocrwvpzTE9BVIW
         dmnJJzOmvMuF3/me2gXmVv18CuyAPgFmrZ5vNxPRZuhGp3DMpBt5mqlshX6AR5WbxRvt
         PfCU8ZD1Dosm6fzCadJR654rxQBr3wAgkHgKI=
Received: by 10.231.119.102 with SMTP id y38mr2455796ibq.135.1275769014069;
        Sat, 05 Jun 2010 13:16:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm11920380ibg.15.2010.06.05.13.16.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 13:16:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilRqVaVV5q-7NrserSDr0t4L1D_j8rNIWxtMYe1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148493>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> As an aside, I'd appreciate a document pointer, what are the
> implications here exactly?

Oh, good point!  I clean forgot to provide that.

"static inline" functions are just like macros, except each argument
is evaluated exactly once and the arguments are typechecked.

In the older dialect, what I was suggesting would be written as
follows:

 #ifdef NO_GETTEXT
 #define git_setup_gettext() do { } while(0)
 #else
 extern void git_setup_gettext(void);
 #endif

The feature has been part of GCC and various compilers for a long time
now.  It was finally officially adopted when the C99 standard came
out.  It "degrades gracefully" in that the Makefile will define inline
to nothing on those very old compilers known not to support it, making
these into static functions (which is kind of ugly but with most
optimizers it tends to produce the same result).

GCC documentation:

  http://gcc.gnu.org/onlinedocs/gcc/Inline.html

C99 documentation (see the "most current draft" of the revised C99
and navigate with PDF bookmarks to Language =E2=86=92 Declarations =E2=86=
=92
=46unction specifiers =E2=86=92 Semantics):

  http://www.open-std.org/jtc1/sc22/wg14/www/projects#9899

More important than all that is how the construct gets used and why.
=46or this, see SECTION 2 item 2 ("Ifdefs are ugly") of
linux-2.6/Documentation/SubmittingPatches[1]: and take a look at some
of the surrounding code (maybe include/linux/kernel.h would be
analogous) for examples.

Hope that helps,
Jonathan

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f=3DDocumentation/SubmittingPatches
