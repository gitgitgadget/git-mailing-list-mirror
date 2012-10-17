From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Wed, 17 Oct 2012 19:26:57 +0700
Message-ID: <CACsJy8D3WteqsQN_1UxYyE8ADZom6T4Udo8W=hCqiAn+W4K8vQ@mail.gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-3-git-send-email-pclouds@gmail.com> <507AB73D.8010406@lsrfire.ath.cx>
 <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com>
 <507AC543.2020402@lsrfire.ath.cx> <20121014142624.GA992@do> <507E9FDE.7080706@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 14:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOSip-0003bE-Mu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 14:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab2JQM13 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 08:27:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51394 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327Ab2JQM12 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2012 08:27:28 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7322129oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GXoYhRQHLYQBuX2Chz+n3QuwJBXY7PN++GxeYY36uv4=;
        b=N3HxulSB+cU+PCQUBLKiPq+Fpjqi9X3+1q/v5L+Xi5O4Mcls8Qm/ChcMrZwtcdKVZ4
         9uzxiAaYo9r23mXj78SyuHh0d+sBCRlknPoRIhAD0JPiCWrLsVwNxH9M38iAYJYzm/Dd
         O+KE/p+T19DKMhKMGf0gR7Cwz9jmNFGjVqPAeaeWyyZ82oVv6wGD36eFYE6P1zgcrhBW
         gGSK7sZMXC7il1wXuNrI1ppV80t//gSyuWsME5WdRuvDcw0kX93xKf763UJ9affXeLIa
         4bTrZXxE/y+FhYJavYRawaPiS3Hk9EkdfM4O/WdlPaT0sn2aIh+D1lecfHwRXAnf7U6o
         Q/2w==
Received: by 10.182.69.50 with SMTP id b18mr14995796obu.75.1350476847630; Wed,
 17 Oct 2012 05:27:27 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Wed, 17 Oct 2012 05:26:57 -0700 (PDT)
In-Reply-To: <507E9FDE.7080706@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207914>

On Wed, Oct 17, 2012 at 7:09 PM, "Jan H. Sch=C3=B6nherr"
<schnhrr@cs.tu-berlin.de> wrote:
>>  const unsigned char sane_ctype[256] =3D {
>> -     0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,         /*   0=
=2E. 15 */
>> -     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,         /*  16=
=2E. 31 */
>> +     X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,         /*   0=
=2E. 15 */
>> +     X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,         /*  16=
=2E. 31 */
>
> "Normal" isspace() also includes vertical tab (11) and form-feed (12)=
 as
> white-space characters. Is there a reason, why they are not included =
here?

I'm not sure. They were not classified as spaces in the very first
version in 4546738 (Unlocalized isspace and friends - 2005-10-13).
Maybe Linus had a reason to do so.

>> +#define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPAC=
E | \
>> +             GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
>> +             GIT_PATHSPEC_MAGIC))
>
> "Normal" isprint() only includes space (32) from the white-space char=
acters.
> The other white-space characters are not considered printable.
>
> Do we want to stay close to the "original", or not?

We do. I followed [1] but obvious missed the last sentence in "print"
description: "No characters specified for the keyword cntrl shall be
specified". Thanks for catching. I'll fix it soon.

[1] http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap07.=
html
--=20
Duy
