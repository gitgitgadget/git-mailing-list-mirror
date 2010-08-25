From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/32] cache-tree: ignore CE_REMOVE entries in verify_cache()
Date: Wed, 25 Aug 2010 10:23:44 +1000
Message-ID: <AANLkTi=P-PoBWwDbfGs7v1BTwvJ7uwfe7hd7A+Y7M361@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-4-git-send-email-pclouds@gmail.com>
	<20100824231536.GE2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 02:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo3mT-0006A7-5z
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 02:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab0HYAXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 20:23:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50352 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab0HYAXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 20:23:46 -0400
Received: by wyb35 with SMTP id 35so1167260wyb.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b8XUZUnzVnm33AMvAng+8d1YYP1mtRuHmdpcqhzghbo=;
        b=v2IoNhn/6Zfx1aQmxqb7MXR/PqyRqkpI6huYAByUZqFlyIdK9T+SGEbdsT5LfSzJL8
         Una+Z7df9e1DSCM4vBLBaNEmYgadusgC3ifqi6IQr32iak3nfea5/E3P8qEKwgWrTpTQ
         NMmKWXQB0mi600mvy4UsBspvqAudwQcSEgC/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GBegiTgLXDFvHWmQV9yuF8KuFy5ndxY30eCs7p0TeTrkK0kvNhr30YjRi5xgSJOrAU
         heBKT8bkpcoogD5SVi629xuVQA8uvfhM8vNH1SYMiZcQlxRfzqo93SaY8bdT4BHB0Wuk
         /MOBQ67uLbpLl6aqTEFCxS/cPZC4yaK06SaQw=
Received: by 10.227.153.208 with SMTP id l16mr6654779wbw.57.1282695824909;
 Tue, 24 Aug 2010 17:23:44 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 17:23:44 -0700 (PDT)
In-Reply-To: <20100824231536.GE2376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154386>

On Wed, Aug 25, 2010 at 9:15 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **cac=
he,
>> =C2=A0 =C2=A0 =C2=A0 funny =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < entries; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cache_entry =
*ce =3D cache[i];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ce->ce_flags & CE_RE=
MOVE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ce_stage(ce) ||=
 (ce->ce_flags & CE_INTENT_TO_ADD)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (10 < ++funny) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "...\n");
>
> In other words, this teaches internal write-tree callers to ignore
> unmerged and intent-to-add entries marked with CE_REMOVE.
>
> Why? =C2=A0When does this come up?

I was lazy. In patch 26, upload-narrow-merge do three way merge and
drop staged entries within narrow tree (this is at server side,
conflicts within narrow tree will be handled at client side later).
Instead of removing staged entries, I mark them CE_REMOVE.
--=20
Duy
