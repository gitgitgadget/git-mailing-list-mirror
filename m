From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Thu, 16 Sep 2010 19:13:06 -0600
Message-ID: <AANLkTinfgZMuap+hiji3zH6fL4aOS-FrfgxPJfVE1xO6@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
 <1284670403-90716-2-git-send-email-patnotz@gmail.com> <AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
 <AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
 <AANLkTin52McRcJcNocSGMxA7PUCiygSwQTHc1SWcMeOk@mail.gmail.com> <AANLkTikbd-RQtRQWta+_Ogdicsz-1gFLnXaDYzh3wAfG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 03:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwPWA-0007va-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 03:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0IQBN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 21:13:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab0IQBN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 21:13:27 -0400
Received: by bwz11 with SMTP id 11so2185243bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Tr1jj3tq3rerC5YZsog3JeANMIEyf0uJyouVZr8JYak=;
        b=ASlpAUz/NpYzsqXeWZZfuDcjFAksbb0FBVEFvbiJEfwqfeXnfSw6qKXC7HYAWBX3G1
         JKTxcxRMSJJxQlsMoV/KSlkod7jmCiOVxeXgiaDZv0VzJv34VH2iDdJXqlw0KKzmuvx2
         brf5QUvIzqfQNrgweMh+LDNDMhnzadW9deKlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SwNPp55MjAMolGy5EWpINZ6KPMuXPh15Wql+W3eJ2JY0o1OUYGRZ4Lno2rLr59shbz
         g5G5jQbdf7rM6jyXfyLp8+527/nIzfUBdi30tT5IVkwdmPYYqGpUO8mMRsL8hSELBcqb
         iCE0osV30K6KvNsKlP4uIoM6BjM1gjv21LDrE=
Received: by 10.239.187.72 with SMTP id k8mr210255hbh.150.1284686006273; Thu,
 16 Sep 2010 18:13:26 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Thu, 16 Sep 2010 18:13:06 -0700 (PDT)
In-Reply-To: <AANLkTikbd-RQtRQWta+_Ogdicsz-1gFLnXaDYzh3wAfG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156366>

On Thu, Sep 16, 2010 at 7:04 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Fri, Sep 17, 2010 at 10:32 AM, Pat Notz <patnotz@gmail.com> wrote:
>>> I don't see any case that "size" can be used uninitialized. Maybe t=
he
>>> compiler was confused by
>>>
>>> if (!check_index ||
>>> =A0 =A0(buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=
=3D NULL)
>>> =A0 =A0 =A0 =A0return -1;
>>>
>>
>> No, line 245: if(size=3D=3D0)
>
> The only chance for that line to be executed is read_skip_*() is
> executed and returns non-NULL buf. read_skip*() returns a non-NULL
> buffer at the end of function and does set size right before
> returning.
>
> To me it looks like a false alarm. But again, no objection to the pat=
ch.

I agree that it's a false alarm which is why I wasn't too interested
in looking into it very deeply.  Just looking to keep the code warning
free is all.

> --
> Duy
>
