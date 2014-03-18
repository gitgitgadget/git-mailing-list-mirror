From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 12:00:48 +0700
Message-ID: <CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <20140318045050.GB8240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 06:01:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPm9u-0002pX-HK
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 06:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaCRFBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 01:01:19 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:33524 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaCRFBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 01:01:18 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so6258888qaq.8
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SPTIVMAGeI6cX73vjkMZjsxy4KZbwSwq9rq+a6xQB/I=;
        b=q63S4DCHWON4JG4N5I1wWiqII+sSYcjl4XvAfxUee6d0l3XxGKCx7j/8C2AwI53GXZ
         4uL831PBsYFABGMTYG5muSdG0XPG+PESGfUIEcjQCNMfHnZfzKI9rYnRR1A8QFtf3vyX
         SB8UIBUpcrdQHin4A4YvmHFLLKnsCG0i4DDjvrddT1BlCIhtWD+LisjymXMQT6hlASnY
         otkZ+4d8yntfxaZWudaUP71wHxZliRhOn4YPoCFfWKPapflPwu7jZhDEpERTJqj2Kuc+
         oekLWUmKVKZggBeaP7gBQJp8UQnGcm7umbDd0cSg60j6xu1MHV2Teiw3nt2as9ODr3zN
         n+lA==
X-Received: by 10.140.21.164 with SMTP id 33mr23429065qgl.78.1395118878251;
 Mon, 17 Mar 2014 22:01:18 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Mon, 17 Mar 2014 22:00:48 -0700 (PDT)
In-Reply-To: <20140318045050.GB8240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244329>

On Tue, Mar 18, 2014 at 11:50 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> As explained in the previous commit, current aggressive settings
>> --depth=3D250 --window=3D250 could slow down repository access
>> significantly. Notice that people usually work on recent history onl=
y,
>> we could keep recent history more loosely packed, so that repo acces=
s
>> is fast most of the time while the pack file remains small.
>
> One thing I have not seen is real-world timings showing the slowdown
> based on --depth. Did I miss them, or are we just making assumptions
> based on one old case from 2009 (that, AFAIK does not have real numbe=
rs,
> just speculation)? Has anyone measured the effect of bumping the delt=
a
> cache size (and its hash implementation)?

David tested it with git-blame [1]. I should probably run some tests
too (I don't remember if I tested some operations last time).

http://thread.gmane.org/gmane.comp.version-control.git/242277/focus=3D2=
42435

>> git.git is not a great repo to test it because its size is modest bu=
t
>> so are my laptop's cpu and memory, so here are the timings and pack
>> sizes
>>
>>             size  time
>> old aggr.   36MB  5m51
>> new aggr.   37MB  6m13
>> repack -adf 48MB  1m12
>
> I am not clear on what these times mean. It looks like the new code i=
s
> slower _and_ bigger. Can you explain them?

That's right :) The upside is faster operations, which is complely
missed here. The good thing from those numbers is pack size does not
increase much (the upper limit would be repack -adf with default
settings).
--=20
Duy
