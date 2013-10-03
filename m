From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Thu, 3 Oct 2013 08:01:23 +0700
Message-ID: <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com>
References: <201309282137.21802.tboegi@web.de> <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
 <524C6885.8020602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 03 03:02:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRXIk-000145-MK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 03:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab3JCBBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Oct 2013 21:01:54 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:46893 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3JCBBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Oct 2013 21:01:53 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so1689785oag.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4H5e24TXmXv0j3yADs8SdQ9U42ZDPT+L3i8MZ9+5Ht8=;
        b=KmHCxBS9uAR250T8iTbHwbtJ3lulOCgQUlgS+AcaoL0ekI/8oZA2uuFaoy8wN1nIox
         6PXGPaCg388BlMu8VSUYGstWSXPIbDi7Iru7UjDt5vPB9QvohBVS/EhwUdaUQgjcpNED
         yfnkLT8skBYxI/sujry2I0ZmsukapGGEsSyHzBDJH4uUf7dpmmOGb8VZ12sgZg7D/I41
         d3hvsNi2FuwQ8OQvoMkMRipZ8aosWAQAxKB4QDc91hHaShpKvH5HD+HmHOeaCW6bgo2R
         7HM1I13DymcdTpTm/w1HhBfFmW2TnDwOpVNSxCwOEwmOaJPF2MGE2mSQsYmAUppXBE8Y
         oZQA==
X-Received: by 10.60.115.164 with SMTP id jp4mr8012850oeb.19.1380762113161;
 Wed, 02 Oct 2013 18:01:53 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Wed, 2 Oct 2013 18:01:23 -0700 (PDT)
In-Reply-To: <524C6885.8020602@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235678>

On Thu, Oct 3, 2013 at 1:40 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2013-09-29 02.33, Duy Nguyen wrote:
>> On Sun, Sep 29, 2013 at 2:37 AM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>> "git clone /foo/bar:baz" or "git clone ../foo/bar:baz"
>>> are meant to clone from the local file system, and not to clone
>>> from a remote server over git-over-ssh.
>>
>> I don't think this is necessary. Commit 6000334 should detect both
>> cases fine because both have a slash before the first colon.
> Sorry for the noise, I noticed it when I was trying to construct test=
 cases.
>
> What do we think about adding this at the end of t5505:

As usual more tests are usually better. But is t5505-remote.sh the
best place? That file seems about "git remote"..

>
>
>
> test_expect_success 'fetch fail [noexistinghost0:2223]:blink.git' '
>         (
>                 ! git fetch [noexistinghost0:2223]:blink.git 2>err &&
>                 grep ssh err &&
>                 rm err
>         )
> '
>
> test_expect_success 'fetch fail noexistinghost1:2223:blink.git' '
>         (
>                 ! git fetch "noexistinghost1:2223:blink.git" 2>err &&
>                 grep ssh err &&
>                 rm err
>         )
> '
>
> test_expect_success 'fetch fail noexistinghost2:2223' '
>         (
>                 ! git fetch "noexistinghost2:2223" 2>err &&
>                 grep ssh err &&
>                 rm err
>         )
> '
> test_expect_success 'fetch fail ./noexistinghost4:2223"' '
>         (
>                 ! git fetch "./noexistinghost4:2223" 2>err &&
>                 grep "does not appear to be a git repository" err &&
>                 rm err
>         )
> '
>
>
>
>
>
>
>
>
>
>
>
>



--=20
Duy
