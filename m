From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 1/3] add test for git grep --recursive
Date: Wed, 29 Sep 2010 13:48:25 -0700
Message-ID: <4CA3A619.70507@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>	<1285792134-26339-2-git-send-email-judge.packham@gmail.com> <AANLkTikAUe=YWHcgF33aNFHesuxHtgCTXNZmbRoV99c-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13ZZ-0000Rw-Nu
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab0I2UsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 16:48:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62029 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab0I2UsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:48:12 -0400
Received: by pzk34 with SMTP id 34so293582pzk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DVeeVT6PjSLJeROLO32FSPeOyOmjhpBshMXPel/LYlc=;
        b=U9yGPZqW+qRSA239uTWe+I1o8VPj9BRRud6m4BcCx9wtDNpmxUKVrbyO9pJgnxezdd
         oBiCGoUJ+5ALrLsx3fZNnaJ6JsZTX/qV7RCeY0MS0NbTaL6lwwWRU1OKp+CFui4a6L+N
         YiWRBw1WBHfF90fVfOgvkivHAoBhxvqbY3NJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=q36b5unGsXoxKWXIA+9x3qsi3BiNpldAqp0wO3S3SYYVRFG/Y5GZDaSXyA6TgzZz7o
         GlzP8bqS7pRNQB4f9Sqwezm240/b9JGJvhZ/tkMWJd7/cMs1hEjOXs1oA1acH9vDKcY6
         JFEVdZAtV8H7V8OPGRFR+7UlANqpXa4InT6zE=
Received: by 10.114.135.11 with SMTP id i11mr2625883wad.37.1285793287007;
        Wed, 29 Sep 2010 13:48:07 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id k23sm15198374waf.5.2010.09.29.13.48.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:48:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTikAUe=YWHcgF33aNFHesuxHtgCTXNZmbRoV99c-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157605>

On 29/09/10 13:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Sep 29, 2010 at 20:28, Chris Packham <judge.packham@gmail.com=
> wrote:
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
>> ---
>>  t/t7820-grep-recursive.sh |  101 ++++++++++++++++++++++++++++++++++=
+++++++++++
>>  1 files changed, 101 insertions(+), 0 deletions(-)
>>  create mode 100644 t/t7820-grep-recursive.sh
>>
>> diff --git a/t/t7820-grep-recursive.sh b/t/t7820-grep-recursive.sh
>> new file mode 100644
>> index 0000000..4bbd109
>> --- /dev/null
>> +++ b/t/t7820-grep-recursive.sh
>> @@ -0,0 +1,101 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2010 Chris Packham
>> +#
>> +
>> +test_description=3D'git grep --recursive test
>> +
>> +This test checks the ability of git grep to search within submodule=
s when told
>> +to do so with the --recursive option'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup - initial commit' '
>> +       printf "one two three\nfour five six\n" >t &&
>> +       git add t &&
>> +       git commit -m "initial commit"
>> +'
>> +submodurl=3D$TRASH_DIRECTORY
>> +
>> +test_expect_success 'setup submodules for test' '
>> +       for mod in $(seq 1 5 | sed "s/.*/submodule&/"); do
>> +               git submodule add "$submodurl" $mod &&
>> +               git submodule init $mod
>> +       done
>> +'
>> +
>> +test_expect_success 'update data in each submodule' '
>> +       for n in $(seq 1 5); do
>=20
> seq isn't portable to windows, so we usually write out "1 2 3 4 5"
> directly.
>=20
>> +               (cd submodule$n &&
>> +                       sed -i "s/^four.*/& #$n/" t &&
>> +                       git commit -a -m"update")
>> +       done
>> +'
>> +
>> +cat >expected <<EOF
>> +t:four five six
>> +EOF
>> +test_expect_success 'non-recursive grep in base' '
>> +       git grep "five" >actual &&
>> +       test_cmp expected actual
>> +'
>=20
> Put the "cat >expected <<EOF" inside the test:
>=20
>     test_expect_success 'non-recursive grep in base' '
>         cat >expected <<\EOF &&
>         t:four five six
>         EOF
>         git grep "five" >actual &&
>         test_cmp expected actual
>     '
>=20
> ditto for the rest.

Thanks for the review, will be in next re-roll.
