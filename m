Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936FCC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD0A2084B
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SS3Zvl1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfKZQlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:41:16 -0500
Received: from mout.web.de ([212.227.15.4]:56717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbfKZQlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 11:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574786469;
        bh=stz8zwa6hVWP4kaYaqbEYooHGUVJWdXMPHG3GuasHQ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SS3Zvl1yWPXqnbx7AK6olQAdTKEh2nKPCADumBRS5Hcy2DxKnR4xzOD300rIi84Wt
         Qezxkg1g2AnTtuNoPQe1OqikjwZWpI4eIRUj+f3q5fak+GbmC9k3Cx1Qyxq6wTSFrj
         obP+ut1Zwhy5DfZsORDeyVLMtiewkIhxTxgVMRz8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuMO-1hsrxx3TY4-00h6gP; Tue, 26
 Nov 2019 17:41:09 +0100
Subject: Re: [PATCH] shell: use skip_prefix() instead of starts_with()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <0a4dfbcc-9eb5-6b39-6b93-0014f5c475de@web.de>
 <20191126155647.GA25729@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <baf0aabe-f94e-852a-7c60-0c6e772fc437@web.de>
Date:   Tue, 26 Nov 2019 17:41:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126155647.GA25729@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pVJMcfj9jAZAreS4h/gAfN9lV5B0shJ5DU0KYGe7WhHeheeRgu
 Kr0fmyYuoVof+YRvkc2EqmaDHhWU9YKPGABhso7dNEilzZotZ8S5aayMLMlAswHojRzgN3Y
 OPaB5Zk7Px/YYGy4wUyDoKrAFQ0DWfX4CDFvhy1pqiA6ZMFUWQ3ino6qY0j7aVE0Izax0uE
 WLLstg/8NpeKyCYwLIjVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P29oCOQTPoY=:MqB2mVTt1+WyxFMXmDYyn+
 6jCFKPlaU76xtMuUqWIAKDtaBQlHBrsF5HowqbLkuZcHW31TceTM4KSAbl9obPC3pFo9extb1
 D985S+xUwJdv0ETyRsZl5917yqgN3JgUwosJy/AOxajrBt0DvX1NBwCCR+Rrl+avt26+Vz96U
 gKBN/pl2E46nFkbYnt2qcQdbmiz2ZPhCJndQHeNlppvy9IFlCjw2LLi2K6/u68W+e7gDBNzuK
 fS9ftJpjGGZoUQNITiLfeuKvwBnRIEf7g+/rcyc70lchRHW2btrwdtJjPP4WHY3MtNQX9lpoJ
 5eCvpzQ5jBdomshs++tzmMlGE+wQBPm+lA3Hs9o61FN77fZWxcs2k/6A8v99DmcdFsdE/avSX
 3h/Pa8mVwhg4nkM7B9FcqjhGqQge+RhYYLzuCQvPk4qY0VsbQVu1N+o7M1L7QswpzAWhESUhb
 3bWewDvU/t26AQMWUJqZM3ZhgKa08zuA1M7FD8fT01yMNyRCkE+2VhDOH7XqexBekxsfArkIM
 RqfjXUtnf0Y6tjbBhHnFbTUuygJuWE9lnggGBMYyt9WUzrki46DuEWzqL51Dx59mySFEZqGwH
 8bocNnk+++ya66OtmqusDAK8i/hq+hNH6K9bB+yvEAhfFZgevDE2zwn8rKNPlpU196PznhSu5
 cVrWXuYwaKRfP3KiZru4A3PDYrEZUgw4dICvgPRMtBdDOiyB3uysHMEzoQVoa9vAGA0hIF4zu
 tFtbihz4MRC17h9Tkmp4GqBQzuxfPPdltTFJDHBsIUAFm1YHYIqCHzloxZWaN+PMI8SADslU2
 OEA4E+bYxFUDQsUPxFgFV+uyoxdGB0N2QX50Npfd36ICJuLW8Ys4rmekf0w6IL118OqwDu7fG
 VHgF5Kx+zvJt56cx5xIkLauFzMtwhopvdK3aJZh7esjCa81hgTCE0BnPptZZj7iQw895DZwVU
 IioYIydjEAN6LuwIjOZ1P0zmMYjuJDu0QTaZ7xb7MoyeOU5xZbDPzJ6PAl3qMFO1xUYyQeGle
 7YATtC/JFBpUvyCXj/DDl9RklKjTytnZLckpRc8JoYGlCxnI/YSflLrYGSUKfSNKihcu/xOJ0
 OzNX+8mD63TbyirwCPreBhi7A0KlnmdJKTlFFTcaYI+iLYQK84lf7sCBsqUDpR3kHcD8u7W5z
 bcu8dgHB2IQNLFCe0feZ4sC46cQ+d5bV6mA+XAMzsmxMGuC/ZMvJKKvJ86IssZpYffUh2uHhX
 HxG8n9tYM2NDo+KBGFzifSAtbqAnhyXoVoxOBIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.19 um 16:56 schrieb Jeff King:
> On Tue, Nov 26, 2019 at 04:00:43PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Get rid of a magic number by using skip_prefix() instead of
>> starts_with().
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  shell.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/shell.c b/shell.c
>> index 40084a3013..54cca7439d 100644
>> --- a/shell.c
>> +++ b/shell.c
>> @@ -16,10 +16,10 @@ static int do_generic_cmd(const char *me, char *arg=
)
>>  	setup_path();
>>  	if (!arg || !(arg =3D sq_dequote(arg)) || *arg =3D=3D '-')
>>  		die("bad argument");
>> -	if (!starts_with(me, "git-"))
>> +	if (!skip_prefix(me, "git-", &me))
>>  		die("bad command");
>>
>> -	my_argv[0] =3D me + 4;
>> +	my_argv[0] =3D me;
>>  	my_argv[1] =3D arg;
>>  	my_argv[2] =3D NULL;
>
> The context makes this look obviously correct, but one thing to watch
> out for in these skip_prefix() conversions is that the value of "me" is
> now mutated.

Ah, the one time I didn't use --function-context..  It would have looked
like this:

=2D--
 shell.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index 40084a3013..54cca7439d 100644
=2D-- a/shell.c
+++ b/shell.c
@@ -12,16 +12,16 @@
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];

 	setup_path();
 	if (!arg || !(arg =3D sq_dequote(arg)) || *arg =3D=3D '-')
 		die("bad argument");
-	if (!starts_with(me, "git-"))
+	if (!skip_prefix(me, "git-", &me))
 		die("bad command");

-	my_argv[0] =3D me + 4;
+	my_argv[0] =3D me;
 	my_argv[1] =3D arg;
 	my_argv[2] =3D NULL;

 	return execv_git_cmd(my_argv);
 }
=2D-
2.24.0



