From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] svn-fe: allow svnadmin instead of svnrdump in svn helper
Date: Wed, 6 Jul 2011 16:41:56 +0530
Message-ID: <CALkWK0=UKvvVVeRKcMq1L5ywV0WcAn4BNvEeQuTTZtZAmubanA@mail.gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
 <1309884350-13415-3-git-send-email-divanorama@gmail.com> <CALkWK0=Lqg4vMOdD8zah5RM3GOkBorJ80kBfs4BHEjZrG+rNVg@mail.gmail.com>
 <CA+gfSn-mX-Uny1dy=1Xwo42r_pTYosWJibNGafV=sLrsmc-e+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQ1q-0003po-9W
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab1GFLMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:12:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45318 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab1GFLMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:12:17 -0400
Received: by wwe5 with SMTP id 5so6835583wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q6pFFHMO2MZWScc3FNwPtQr6L9aYv/Xalb+t66FLtbU=;
        b=RAC+c4gQuoCQOwjFn5YvhHV6YRH3zLQF475GgtJvJPA0MpWU4O6nfDh0xIlANmP4Lu
         4valXjSUJIawBvuICJs1wuOolrAzo8J8dk9rn/YYcP+WNdv9WzmbO2qngjo+vcCry9bk
         BcJMWelAE/AycecLtMHaV3DmNm8J5Ex6ocZ94=
Received: by 10.216.60.72 with SMTP id t50mr1876285wec.92.1309950736083; Wed,
 06 Jul 2011 04:12:16 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:11:56 -0700 (PDT)
In-Reply-To: <CA+gfSn-mX-Uny1dy=1Xwo42r_pTYosWJibNGafV=sLrsmc-e+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176688>

Hi again,

Dmitry Ivankov writes:
> On Wed, Jul 6, 2011 at 4:12 PM, Ramkumar Ramachandra <artagnon@gmail.=
com> wrote:
>> svnrdump's output is not identical to svnadmin's output. =C2=A0You'd
>> perhaps want to document the differences, and the impact they might
>> have?
> Hm, I don't see much differences.
> Data format is the same SVN-fs-dump-format-version: 3. In my case I
> observe following differences:
> - svnadmin writes sha1 checksums along with md5 ones
> - hashtable dumps can have different elements dump order
> - svnrdump sets Prop-delta: true for empty props
> - text deltas can be encoded differently (does it affect svn:ann?)
> My svnadmin is version 1.6.16 (r1073529)
> svnrdump is from r1135490
>
> Anything else I'm missing in a simple dump of a repository root?

Yes, those are the differences.  Both of us know this, but an new
reader might naively assume that they are exactly the same -- that's
why I suggested that you document the fact somewhere.  Once you've
documented it, it's clear that these subtle differences have no impact
on how svn-fe deals with the streams.

>> I saw this '--username', '--password' in other patches too. =C2=A0I'=
m
>> probably missing context, but I'm curious to know why this is requir=
ed
>> and what you're planning to do to fix it in the future.
> For repos with no read restrictions this isn't necessary, like those
> in the test script supplied.
> It's a placeholder for quick local patch if anyone wants to test a
> repo with permissions.
> In future it should be allowed to configure credentials in
> corresponding remote section of git.config and
> pass all these options to helpers. Using ~/.subversion/ configuration
> is a valid option too.

I see.  However, I think you should just have one dedicated test for
testing credentials -- once that passes, you don't need to complicate
the other tests with information about credentials.  Try to test only
one aspect in each test; the report summarizing failed tests will make
more sense then.

Thanks.

-- Ram
