From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] svn-fe: allow svnadmin instead of svnrdump in svn
 helper
Date: Wed, 6 Jul 2011 06:28:17 -0500
Message-ID: <20110706112817.GN15682@elie>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
 <1309884350-13415-3-git-send-email-divanorama@gmail.com>
 <CALkWK0=Lqg4vMOdD8zah5RM3GOkBorJ80kBfs4BHEjZrG+rNVg@mail.gmail.com>
 <CA+gfSn-mX-Uny1dy=1Xwo42r_pTYosWJibNGafV=sLrsmc-e+A@mail.gmail.com>
 <CALkWK0=UKvvVVeRKcMq1L5ywV0WcAn4BNvEeQuTTZtZAmubanA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQHM-0002cM-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab1GFL2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:28:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62614 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab1GFL2X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:28:23 -0400
Received: by iyb12 with SMTP id 12so6000278iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C4G9rpVyjyEuMi+e9pDcGrnzlVWpQ1COgItoRwq8x8k=;
        b=WAf0AvANOjKRMjeDhSk1WFoq9l0Wrd/d13EGR4g0Bs+JACGxIjmhlNGpTTGBUkuSXw
         moXQzb7gsq5u4ePbKoGYRHnpwa77bWxzGWWFwKpyRpZnnUDbIXSHxvAV+zFawOO0on5x
         y5UJkYAosVapu76MiN2I6IqmsM9VVONiUITNo=
Received: by 10.42.77.74 with SMTP id h10mr9675639ick.85.1309951702256;
        Wed, 06 Jul 2011 04:28:22 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id my4sm4820979ibb.37.2011.07.06.04.28.19
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 04:28:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=UKvvVVeRKcMq1L5ywV0WcAn4BNvEeQuTTZtZAmubanA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176692>

Ramkumar Ramachandra wrote:
> Dmitry Ivankov writes:

>> Hm, I don't see much differences.
>> Data format is the same SVN-fs-dump-format-version: 3. In my case I
>> observe following differences:
>> - svnadmin writes sha1 checksums along with md5 ones
>> - hashtable dumps can have different elements dump order
>> - svnrdump sets Prop-delta: true for empty props
>> - text deltas can be encoded differently (does it affect svn:ann?)
>> My svnadmin is version 1.6.16 (r1073529)
>> svnrdump is from r1135490
>>
>> Anything else I'm missing in a simple dump of a repository root?
>
> Yes, those are the differences.

Are the differences documented somewhere (e.g., the svnbook)?

>>> I saw this '--username', '--password' in other patches too. =C2=A0I=
'm
>>> probably missing context, but I'm curious to know why this is requi=
red
>>> and what you're planning to do to fix it in the future.
[...]
>> It's a placeholder for quick local patch if anyone wants to test a
>> repo with permissions.

I suspect it snuck in from tests with the cvs2svn repository. :)

Do you know another small repository that's entertaining to test with?

>> In future it should be allowed to configure credentials in
>> corresponding remote section of git.config

Yep, something along those lines sounds sensible.  In the short term,
I think there's been some talk of a configuration option to override
the svnrdump command; that could be used to pass credentials.

Inspired by the old HTTP convention, I tried

	svn log http://Guest:@cvs2svn.tigris.org/svn/cvs2svn

and

	svn log http://Guest:pass@cvs2svn.tigris.org/svn/cvs2svn

but alas, neither works.
