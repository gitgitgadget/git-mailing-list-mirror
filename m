Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA92C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 07:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352092AbiASHwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 02:52:33 -0500
Received: from mout.web.de ([212.227.15.14]:48821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351490AbiASHwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 02:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642578744;
        bh=UrD415Tfq2K5gB8f3INR6JMQoyKEGAIdg9LEzy4+RNA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GswQ7GLJGHXLC++3IsbhZBlbApu3HuqbaOuxtKKxrFjO7OL8YHEf1YmqH9suyae26
         q8CX2KkISBdZsf93nhsIYeOXb8nniALfbVuUV4hpWniWazVMVZiWq1GjvIRcK2i3zk
         FXfMY09aaiws5u4IS8hBAk7qXROxKsgcQ20CtBSk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1mym2b2pJ3-00ODdk; Wed, 19
 Jan 2022 08:52:24 +0100
Message-ID: <8e640e1e-cb93-eedb-8deb-33bfa235d602@web.de>
Date:   Wed, 19 Jan 2022 08:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit
 code 126 and 127
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
 <CAPc5daWWq3KPt9hXXK8DKSFUgL3kdSeSoRcePQy8-sFuMOQ8WA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPc5daWWq3KPt9hXXK8DKSFUgL3kdSeSoRcePQy8-sFuMOQ8WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zETQyhyIrfGks6QXikLuVoAsqZMTvSKnXOT4U6YS4bbjZVnj7JH
 nifPZ7TKRqu636g2pRhnwufQFAGQE2tTObT7eIP1a/Ir8Ob+GMSp2hHx9MxKoYI8Wv0OnmR
 lBUQ81VTP37Q8ofkrKzNiLCK/jlurMApQ2cRyniBvZb80VBrwmSuZyOv1wHN42G3UCxwVRp
 vRHEbZ0XaXeQELYv2rZGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NdtJGmwnUCE=:r/b+SL1Vo/7VuDpqznxDbl
 grLPScmyQD+IkYt25VeJ1KwQ2ixbqDkpUfglKcR0F+M2wa+iNwnlN/lIXV2OH8dYII7HHWgZE
 uv2MMHv8MGoaQidKTLDx8NjJxIkD43JGKLa6o3VtwXnhi4JckK1xQQdDb75b6/jAzUzexEqoy
 CUOOFwEzN9VumdAl36lhorOeubXuTZInx9UEK5WHdYPhQMEGebQVbYflkiiSoEcHRFFaiTiMw
 r0KNdxFjcWGiL05OmRb85PAr7BZfniFmfQOkxbByPwUBtS8LFJMV6GUzKUB8FObVe5u/kEucN
 2gsUmMUbkrsBNp714z/HKjxbkeBVjm2XS5YQIAwU4cWl4bsoKLA2rUOso+ICsZthbMgf4X01S
 2O42y34Dnf9jA+0v5qjbYXcYSBHNr+t/j9dO5yfqefLks60v50KYG+3pIjsCH7Q13h+lqgveO
 p8oMPqVJIpMLOz+mjRMO0W0QeT0CleEG5eIvyEdAPuWMWgJ6XfY/ciidBDB/AyLvpMQGnpBVi
 P/Fg7DjV1lC+AlxN7AO1ll+eYoxRf1NxpaLluGENM+e2jxfHxDchh06VGqQG8GSOlQ39H1Uqh
 tUyop2Ldu/BzRhI+bupiaoHhTTB0aQ0wKdd1jm7sr7JuF14XqR0WzITFOEYdLIWD9DNiQ2ov2
 Yt/5dwSgTu43prIshmX35zCIE4G59cGvbTeYboletvbiD6aAPU5HVtqnsks/tQgMG2ZALUadV
 L7MzVvuHhOvwZcukgKVd4sWtgLMilbyd/kdWkUaep1k1DVgDzUdvJ7zxwociMWJNOmwAEV3bw
 a78yA9zX/xMexnZWK7rv/SPOU4iOcOHyV82//2LJ/XPvJxGpwbxoNULi6dk7hBU72gNKHEBGR
 EX2kCPDi1+RmOjTeQhePADjKvLNmIPMhJsLF+jBKnN5ZU9aX8K+94ONosGcVlstxS5YvW0lTL
 SbKapsF62Y0CC5V3Adk6CoVRljaYeGO00BOMRY943wLebPxwLNVoOJ9e4YH9hP0VMhYap4z2m
 ZXm3InQu+PCUr5LWQUxzTQShn17GG9Bq3zbQvbeJKEe8pwlQ4yoGDLKShxDEHSjJvwxF9ar5w
 Gv+smWO+mXPFos=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.22 um 03:36 schrieb Junio C Hamano:
>> diff --git a/bisect.h b/bisect.h
>> index ec24ac2d7e..748adf0cff 100644
>> --- a/bisect.h
>> +++ b/bisect.h
>> @@ -69,4 +69,7 @@ void read_bisect_terms(const char **bad, const char *=
*good);
>>
>>  int bisect_clean_state(void);
>>
>> +enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>> +                                 int no_checkout);
>> +
>>  #endif
>
> https://github.com/git/git/runs/4861805265?check_suite_focus=3Dtrue#step=
:4:65
>
> In file included from bisect.hcc:2:0:
> bisect.h:72:48: error: =E2=80=98struct object_id=E2=80=99 declared insid=
e parameter
> list will not be visible outside of this definition or declaration
> [-Werror]
>  enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>                                                 ^~~~~~~~~
> cc1: all warnings being treated as errors

Oops, and I didn't even know the make target hdr-check exists. :-/

=2D-- >8 ---
Subject: [PATCH] fixup! bisect--helper: double-check run command on exit c=
ode 126 and 127

=2D--
 bisect.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect.h b/bisect.h
index 748adf0cff..1015aeb8ea 100644
=2D-- a/bisect.h
+++ b/bisect.h
@@ -3,6 +3,7 @@

 struct commit_list;
 struct repository;
+struct object_id;

 /*
  * Find bisection. If something is found, `reaches` will be the number of
=2D-
2.34.1
