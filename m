Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDDD1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409288AbfJRBSR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:18:17 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:24333 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391934AbfJRBSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:18:17 -0400
Date:   Fri, 18 Oct 2019 01:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571361494;
        bh=XL9cYADVOcQJFyHrv89xNShvr4NnKt7Np+FEXxUpnjk=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=URN1lc6pPYIFEfYzvV4wcNB7hQZJ09H4YjWYgJBZXwky85EY5zeET4+Ejbvj13xBC
         nSaFJBdPdModrr3zTPl18tP8E1O6acoDKNw/OvaOly6Vc8jWphsEr8T39xOeOf9X44
         aXTkTXdkH5G6AL2nPWTZwmHmn/HziaKJTWRm+gRI=
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Ralph Ewig <ralph.phd@protonmail.com>
Reply-To: Ralph Ewig <ralph.phd@protonmail.com>
Subject: Re: git smart http + apache mod_auth_openidc
Message-ID: <20b6729f-a05e-b658-2cd4-70cb7a9d17b7@protonmail.com>
In-Reply-To: <20191017225529.sg37cxvyssbaitfw@camp.crustytoothpaste.net>
References: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
 <20191016233319.3rhmekasi5csytyl@camp.crustytoothpaste.net>
 <1320f616-ddcc-0eed-22f2-e28eb0abf039@protonmail.com>
 <20191017060322.GA10373@sigill.intra.peff.net>
 <5a2cc6f5-a8d0-356b-ff4e-a716aa5675b1@protonmail.com>
 <20191017225529.sg37cxvyssbaitfw@camp.crustytoothpaste.net>
Feedback-ID: JbhSByWnCQwiafGbFv64IeMW95YrXE9PqRMglI51uN_uNsIp7h5EnYZeviw8UgH0DtxilqFslLTcJ61CqL2H5Q==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Understood (and agree).

We do use git for source code (where we use SSH=20
and key authentication for CI/CD), but also for=20
configuration control of other files like=20
financial reports, engineering drawings, etc.=20
where access is via HTTPS.=C2=A0 In that 2nd group the=20
challenge is to make it as "not coding like" as=20
possible so the non-developer crowd isn't scared off.

Since we use trac for project management company=20
wide (all verticals), my latest idea is to=20
intercept the git http request on the server side=20
to authenticate against the trac session info=20
stored in the db (using a custom php script),=C2=A0 and=20
then pass it on to git-http-backend or throw an=20
error prompting the user to sign into trac first.=20
Most users are signed into trac 24/7 anyway since=20
its central to our workflow.

in the end paying the extra fee for MS Domain=20
Services to get SSO via LDAP or Kerberos might be=20
the right answer though - just trying to be=20
scrappy if I can since it's an early stage=20
startup. Nonetheless really appreciate the=20
exchange of ideas!

Ralph


On 10/17/2019 3:55 PM, brian m. carlson wrote:
> On 2019-10-17 at 14:33:38, Ralph Ewig wrote:
>> Quick follow up question: can the git client pass
>> a token read from a cookie with a request? That
>> would enable users to sign-in via a browser, store
>> the cookie, and then use that as the access token
>> to authenticate a git request.
> Git has an option, http.cookieFile, that can read a cookie from a file,
> yes.  That does, of course, require that you're able to put the cookie
> in a file from a web browser.  I'm not aware of any web browsers that
> easily provide an option to dump cookies into a file.
>
> Also, just as a note, this approach definitely won't work for automated
> systems you have, such as CI systems.  That's why I suggested Kerberos:
> because you can have services that have principals and you can use those
> credentials in your CI systems to access code and run jobs.
>
> Clearly you know your infrastructure and users better than I do, but I
> don't recommend having a web-based sign-on as your only form of
> authentication for a Git server.  It's going to cause a lot of pain and
> inconvenience on all sides.

