Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2D01F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 03:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406778AbfJQDBL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 23:01:11 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:51069 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404711AbfJQDBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 23:01:10 -0400
Date:   Thu, 17 Oct 2019 03:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571281266;
        bh=/wGBVF2h9trzjjj3/NHSOL0eArCKm86Zlf5itIMjm1Y=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=A+y2mMfF5ASbuJ+KaLs4ttJrKfN9FnD81v+OhAi7ScTZzYtR2BOMxcuCILcry3qjH
         0Bm1CIeCt3h6Iem4x+a6Kkq/QhGPllKEKgn73a7ggx/4PDQojhpii8JPWVTwu90r9u
         kmfPdbI1PC5UPozlpIGSFeonx4Dwj0JzdhF+KyDs=
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
From:   Ralph Ewig <ralph.phd@protonmail.com>
Reply-To: Ralph Ewig <ralph.phd@protonmail.com>
Subject: Re: git smart http + apache mod_auth_openidc
Message-ID: <1320f616-ddcc-0eed-22f2-e28eb0abf039@protonmail.com>
In-Reply-To: <20191016233319.3rhmekasi5csytyl@camp.crustytoothpaste.net>
References: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
 <20191016233319.3rhmekasi5csytyl@camp.crustytoothpaste.net>
Feedback-ID: JbhSByWnCQwiafGbFv64IeMW95YrXE9PqRMglI51uN_uNsIp7h5EnYZeviw8UgH0DtxilqFslLTcJ61CqL2H5Q==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply. I was hoping the Git GUI=20
might be able to handle the OpenID authentication=20
flow, but it makes sense that it would be=20
inconsistent with other git clients.

Azure AD does support both LDAP and Kerberos, but=20
unfortunately only as an extra cost add-on called=20
"Domain Services". I might try to hack up a script=20
to just sync the Azure AD password hashes to the=20
htpassword file. Otherwise I guess I'll have to=20
bite the bullet and pay the extra bill.

Nonetheless, thank you for the suggestion!
Ralph


On 10/16/2019 4:33 PM, brian m. carlson wrote:
> On 2019-10-15 at 15:59:03, Ralph Ewig wrote:
>> Hi Everyone, hoping you might have a solution for
>> this problem:
>>
>> CONTEXT
>>
>>   =C2=A0* I'm serving git repos using "smart https" via
>> apache and basic authentication; everything works
>> fine.
>>   =C2=A0* We're moving to SSO via Azure AD and apache
>> mod_auth_openidc; this works fine for gitweb (on
>> the same server as git).
>>
>> PROBLEM
>>
>> When trying to clone a repo with the OIDC setup,
>> git breaks on the redirect for user authentication
>> with the following error message (replaced server
>> ids etc with xxx):
>>
>>   =C2=A0=C2=A0=C2=A0 C:\Users\void>git clone --progress -v
>> "https://git.xxx.xxx/WebApps.git"
>>   =C2=A0=C2=A0=C2=A0 Cloning into 'WebApps'...
>>   =C2=A0=C2=A0=C2=A0 fatal: unable to update url base from
>> redirection:
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asked for:
>> https://git.xxx.xxx/WebApps.git/info/refs?service=3Dgit-upload-pack
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 redirect:
>> https://login.microsoftonline.com/xxx/oauth2/authorize?response_type=3Dc=
ode&scope=3Dopenid&client_id=3Dxxx&state=3Dxxx&redirect_uri=3Dhttps%3A%2F%2=
Fgit.xxx.xxx%2Fredirect&nonce=3Dxxx
>>
>>
>> Can the git client just not handle a web based
>> redirect for login, or is this a configuration
>> issue? Any ideas would be greatly appreciated. Thanks!
> The Git client doesn't handle any sort of web-based login.  In general,
> in order to do web-based login, you have to provide a fully functional
> graphical web browser, and Git operates in many environments that don't
> have one (such as servers, containers, and headless systems).
>
> You should treat your Git server like you would treat any API you may
> access, since essentially it is one.  That means that you would need to
> provide a way to use some sort of external credential.
>
> I know next to nothing about Azure AD, but it claims to support
> Kerberos, so you may be able to use that in conjunction with libcurl's
> GSS-Negotiate support and Apache's mod_auth_kerb (which is shipped in
> Debian).  I use Kerberos-based authentication for my personal server
> (which is Linux, not AD) and it does work, so it is possible to set up.

