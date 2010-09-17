From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Fri, 17 Sep 2010 11:04:09 +1000
Message-ID: <AANLkTikbd-RQtRQWta+_Ogdicsz-1gFLnXaDYzh3wAfG@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
	<1284670403-90716-2-git-send-email-patnotz@gmail.com>
	<AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
	<AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
	<AANLkTin52McRcJcNocSGMxA7PUCiygSwQTHc1SWcMeOk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 03:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwPNB-0004Z2-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 03:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0IQBEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 21:04:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61052 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362Ab0IQBEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 21:04:10 -0400
Received: by wwb39 with SMTP id 39so164130wwb.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UlJ6pRlOpOla02Oop+dBKK/6WWXtFzRteqLdxrKAHAo=;
        b=sWXQK60BTmkwcumgV9MJTfiTvF+harOgdACyJq24UQRWo1S/8K8/17Z3SeHqvaQvll
         dDmaiSwjHCeT0fspPxhIOs/d/8iXdofoXc4UB6nbJRZCsBQJAeogFBk2+bIRyzv3hlCW
         GqSY8LgHrAsfVUXU9KgZR/+ZU+pvNuUes4Oxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k4GMBI2TCeVwx5D2FouCmkubuSqbaIaiJbLin5SxHOIX2uVxE5naELzeBCyJ9HHY1h
         wAojRZsqQJOHUWL/3ZbKwaCPFgQPG0Gz+D8EajNGVDTPag6lTZvPvZoI/FQcm4RRFn7N
         5cgAkDH535tt0n8wtjyb6+p19i1A/pqk+/uSs=
Received: by 10.216.164.199 with SMTP id c49mr3426259wel.107.1284685449424;
 Thu, 16 Sep 2010 18:04:09 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Thu, 16 Sep 2010 18:04:09 -0700 (PDT)
In-Reply-To: <AANLkTin52McRcJcNocSGMxA7PUCiygSwQTHc1SWcMeOk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156365>

On Fri, Sep 17, 2010 at 10:32 AM, Pat Notz <patnotz@gmail.com> wrote:
>> I don't see any case that "size" can be used uninitialized. Maybe th=
e
>> compiler was confused by
>>
>> if (!check_index ||
>> =C2=A0 =C2=A0(buf =3D read_skip_worktree_file_from_index(fname, &siz=
e)) =3D=3D NULL)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>>
>
> No, line 245: if(size=3D=3D0)

The only chance for that line to be executed is read_skip_*() is
executed and returns non-NULL buf. read_skip*() returns a non-NULL
buffer at the end of function and does set size right before
returning.

To me it looks like a false alarm. But again, no objection to the patch=
=2E
--=20
Duy
