Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DA71FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbcLUVKV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:10:21 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34318 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756462AbcLUVKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:10:20 -0500
Received: by mail-pg0-f45.google.com with SMTP id y62so37089173pgy.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 13:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xdccw3+jI91PLfRV5gPD2JBYUraeRN6HirjuBdE/SpY=;
        b=EgPMEWwLPic3u3ruEaOqU16uK7az2+G3/KRCEBkQu3LJjSy9bTZGPUPOc+82mMQ48u
         0zSsypYHsz2klW3J2Up2erSh2Lb/D5nFqUWjz3hI6O2ZKNlAzH/3umt4OSxXhOr8b0s1
         yAMwIGx5VOnawS+8MkhrAirYdARXHqbmemiTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xdccw3+jI91PLfRV5gPD2JBYUraeRN6HirjuBdE/SpY=;
        b=ZBwN2XsSK/oBb+OW6BKMTC3ddUgfAuexUVgajXiHCSPbAcDl3nQBGQfwtat2t1Nrl3
         c5oacW73nHzrdyjuwOfg41PfaM2k+6Q5uWbnTACQo+LbjYiTojhOzYcjgTmY46BOHYfc
         XWSxDqU4DFs4XXYZ6PUzJP1xWG/BJHUQoyc7Ja5Wjom0XwT0DitBlgiJ4Y26VOhEKceL
         GTdoX3akCLegH3hqMCChgQrPgf+yjImW+YVQ8rE1YnS9hVR4LSAQUE2vPW+w83ZpidSt
         sneIG5Q1KwPm+7J9GiauDzIA4Z24y1z0Y+PnwdoedOutHY82Y0oUd3bnnSCCmD58EDhz
         4nyQ==
X-Gm-Message-State: AIkVDXIHuj8UPdMqNn65vKHqy9Uw3WCNf+DrlhyhAqbgsjgX3Eyk7YlWsX86GjPXmlaq3R8K
X-Received: by 10.99.126.6 with SMTP id z6mr10928511pgc.182.1482354619575;
        Wed, 21 Dec 2016 13:10:19 -0800 (PST)
Received: from [192.168.65.161] ([216.38.152.90])
        by smtp.gmail.com with ESMTPSA id 89sm48985451pfi.70.2016.12.21.13.10.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 13:10:19 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bug report: Git pull hang occasionally
From:   Kai Zhang <kai@netskope.com>
In-Reply-To: <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Dec 2016 13:10:18 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB5CD780-BDDA-44C5-BD7D-1325F5891926@netskope.com>
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com> <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your insight and detailed explanation Junio.

I think what you said is what is happening in my environment. Both =
writing and reading are happening simultaneously.=20


> On Dec 21, 2016, at 12:59 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> Kai Zhang <kai@netskope.com> writes:
>=20
>> 2016/12/20 20:38:10 [error] 9957#0: *687703 FastCGI sent in stderr: =
"fatal: 'HEAD' is a symref but it is not?" while reading response header =
from upstream, client: 10.1.0.11, server: server, request: "POST =
/git/repo_name/.git/git-upload-pack HTTP/1.1", upstream: =
"fastcgi://unix:/var/run/fcgiwrap.socket:", host: "server"
>=20
> (Not a solution)
>=20
> In order to tell the client if HEAD is a symbolic ref and to what
> underlying ref it points at if it is a symbolic ref, at the very
> beginning of upload-pack, there is a call to head_ref_namespaced()
> that uses find_symref().  find_symref() gets "HEAD" and a boolean
> that says if it is a symbolic ref, but it does not get where the
> symbolic ref points at, so it does resolve_ref_unsafe() to learn
> that information.
>=20
> Between the time head_ref_namespaced() checks the refs database and
> finds that HEAD is a symbolic ref, and the time find_symref() calls
> resolve_ref_unsafe() to find out where it leads to, if somebody else
> updates HEAD, resolve_ref_unsafe() can give an unexpected result, as
> all of these read-only operations are performed without any locking.
>=20
> And the unexpected discrepancy is reported by find_symref() as
> fatal.  The server side dies, and somehow that fact is lost between
> the upload-pack process and the client and somebody in the middle
> (e.g. fastcgi interface or nginx webserver on the server side, or
> the remote-curl helper on the client side) keeps the "git fetch"
> process waiting.
>=20
> So there seem to be two issues. =20
>=20
> - Because of the unlocked read, find_symref() can observe an
>   inconsistent state.  Perhaps it should be updated not to die but
>   to retry, expecting that transient inconsistency will go away.
>=20
> - A fatal error in upload-pack is not reported back to the client
>   to cause it exit is an obvious one, and even if we find a way to
>   make this fatal error in find_symref() not to trigger, fatal
>   errors in other places in the code can trigger the same symptom.
>=20

