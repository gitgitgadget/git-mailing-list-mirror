From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Fri, 17 Sep 2010 11:23:13 -0600
Message-ID: <AANLkTinMQ49hPPatgCmxZW6PbU_N8963-XuV3k5f29E2@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
 <1284670403-90716-2-git-send-email-patnotz@gmail.com> <AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
 <AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
 <AANLkTin52McRcJcNocSGMxA7PUCiygSwQTHc1SWcMeOk@mail.gmail.com>
 <AANLkTikbd-RQtRQWta+_Ogdicsz-1gFLnXaDYzh3wAfG@mail.gmail.com> <AANLkTinfgZMuap+hiji3zH6fL4aOS-FrfgxPJfVE1xO6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oweey-0003V4-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab0IQRXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 13:23:35 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50399 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab0IQRXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 13:23:34 -0400
Received: by ewy23 with SMTP id 23so1093607ewy.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j2djhzJtpSM/ZTUrP1EXlO39Z4t1hqApEyBKXwdkByI=;
        b=OunyhIwBFoHN3VIZSFQiOhJfcwWnJWEGZceqFit9mLOb9vDxHNKShUPenTVZoCn1lg
         EAiXSCqOkTtldWgojXN9HPG2kDhGubSNVuopUabrePurG7qyLICDGrLm1Y5+auuaiiiS
         fcVgZNGWNYG23+vyJUSBPvx4KtuNUZABVqU2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GdnTydzo3DHCjIsqvPdVKxexEWCR03MGwagSdooeAXALIh+ZH1vWIALa8EHOgOxVI0
         0JONJr6icBCbStKr/cf+lGCKYr7zXVf+f1XQecF8zdFbQsvI2AXLHuHaJ+BvabuiByNo
         HDi7OaMtQlcupK8XZEGFGAuL4FC4IxTvPQy4k=
Received: by 10.239.132.71 with SMTP id 7mr226844hbq.182.1284744213248; Fri,
 17 Sep 2010 10:23:33 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Fri, 17 Sep 2010 10:23:13 -0700 (PDT)
In-Reply-To: <AANLkTinfgZMuap+hiji3zH6fL4aOS-FrfgxPJfVE1xO6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156403>

=46or anyone who care, this warning was actually emitted by the version
of GCC that ships with MacOS 10.5: i686-apple-darwin9-gcc-4.0.1 (GCC)
4.0.1 (Apple Inc. build 5493).

GCC 4.4.4 does *not* git this warning.

Sorry for the confusion, my IDE was using a different $PATH than my she=
ll.


On Thu, Sep 16, 2010 at 7:13 PM, Pat Notz <patnotz@gmail.com> wrote:
> On Thu, Sep 16, 2010 at 7:04 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> On Fri, Sep 17, 2010 at 10:32 AM, Pat Notz <patnotz@gmail.com> wrote=
:
>>>> I don't see any case that "size" can be used uninitialized. Maybe =
the
>>>> compiler was confused by
>>>>
>>>> if (!check_index ||
>>>> =A0 =A0(buf =3D read_skip_worktree_file_from_index(fname, &size)) =
=3D=3D NULL)
>>>> =A0 =A0 =A0 =A0return -1;
>>>>
>>>
>>> No, line 245: if(size=3D=3D0)
>>
>> The only chance for that line to be executed is read_skip_*() is
>> executed and returns non-NULL buf. read_skip*() returns a non-NULL
>> buffer at the end of function and does set size right before
>> returning.
>>
>> To me it looks like a false alarm. But again, no objection to the pa=
tch.
>
> I agree that it's a false alarm which is why I wasn't too interested
> in looking into it very deeply. =A0Just looking to keep the code warn=
ing
> free is all.
>
>> --
>> Duy
>>
>
