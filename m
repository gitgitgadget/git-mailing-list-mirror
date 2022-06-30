Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiF3LaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiF3LaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044A51B29
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 04:30:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q6so38318565eji.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gdss9dLEyCrFWCO9/t8wdthmpe7byeGQLynXKGUp8hE=;
        b=Zpi6kS9OXJ1S7si1GdGBQsN4MSjbMX0+UCCeFQRxAAIaZfLe31Irs+ME7/y9EUtp8R
         O9Df7VZ80MoBPLOi+EZqncGI4mX9rTigyLxNVj3WFt8ic3ePbqmDfJ4OBSAHQgffISGG
         bTRot8EdaZSoZ28AzLgzByXNw1z+hnW7KcMIZu5VemNsniijo1HnynN4pw36pS8CoZ31
         /vy0Ofact/WDbUGKnJ+DX0Zy+76xmWSIrz997rAOc++Ps3CWlILPEtKO0Sto/zBy9LAg
         m3L1ML8KRI6IHbpSfMIy4nV6Q9ezDlTCYp8KRS2wbaSztEo5SppYT4JctesVaD+bTzsD
         dnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gdss9dLEyCrFWCO9/t8wdthmpe7byeGQLynXKGUp8hE=;
        b=K0NT/3HJoqdKg0Hbs+BpEt2qx7r5ncYEbCDIDEOzrgCbvXCoIXf5F5ezPPYp7ewkFZ
         NXzLodbhsa4R2Ifb3Pi1PBNLAimOkeOEKtqWWBqNYvChfQ00VcH1s/jzxcAHoCbQkCLB
         E1kY7qQAIehO7oJ6w6mrGbWwKWO4ftCHYABp6WrCFt/mVmzfoIBIJ6NMhHEH4tYVNOfb
         qWtVZC88zQckZ/COP5gzHgxVTVHuY1IlMDl/BAxjzNo89Cuwypf/wLVPbff8K+3+AIZi
         5cJBUOj9K9r8GxZrnIiEL5LMsxCsrZwD9BRKiUYvoL4IkYN6fFiZJJHXhNsPBI/55kkv
         qvfg==
X-Gm-Message-State: AJIora/vGB7oCEp6tj5z92i02nYdXGQu1qnCtphERmQfdPkv1DGBc4kq
        8rdXz4LSkryfmtXZ2/54rbM=
X-Google-Smtp-Source: AGRyM1vPBDEWG8c+3zVhl79+afoL7k4CZ5V71NtGAXQnAr6/YaJELgLEYo9NOMGvnOqSjPt6kbpT6A==
X-Received: by 2002:a17:906:c4a:b0:726:f620:dcdc with SMTP id t10-20020a1709060c4a00b00726f620dcdcmr8456027ejf.202.1656588618242;
        Thu, 30 Jun 2022 04:30:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c1-20020a056402158100b004357dca07cdsm13158361edv.88.2022.06.30.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:30:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6sNE-002H9S-JS;
        Thu, 30 Jun 2022 13:30:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
Date:   Thu, 30 Jun 2022 13:18:55 +0200
References: <20220620004427.3586240-1-trawets@amazon.com>
 <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
 <220622.864k0dmzl9.gmgdl@evledraar.gmail.com>
 <YrJm6KactXg4elvD@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YrJm6KactXg4elvD@tapette.crustytoothpaste.net>
Message-ID: <220630.868rpee6d3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-06-21 at 22:12:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Jun 21 2022, brian m. carlson wrote:
>>=20
>> > Email::Valid is in fact correct.  However, the email which you want to
>> > use doesn't conform to the RFC and isn't valid.  So this should probab=
ly
>> > say something like, "Allow people to use an email address which is not
>> > valid according to the RFCs if the server accepts it."
>>=20
>> That's fair, but that rationale is quite disconnected from how the code
>> works now. You happen to get that check if you have Email::Valid
>> installed, otherwise not.
>>=20
>> So if it's a use-case we care about we should make it a hard dependency.
>
> Git has traditionally tried to avoid having lots of hard dependencies on
> Perl modules.  For example, Perl modules are a hassle with Homebrew.
>
> Most packagers prefer to enable the full suite of Perl modules, but it
> is a bit nicer to not make it mandatory.  However, if you feel strongly,
> we can change that.

Not really, since I'm proposing to remove it :)

But if we wanted to have our cake & eat it too we could use the
perl/FromCPAN tree for this purpose, i.e. ship the module with git, or
copy over the relevant parts of the check.

>> > I think this patch would be fine as it stands with those changes. Unli=
ke
>> > =C3=86var, I don't think we should get rid of Email::Valid, just like =
I don't
>> > think we should get rid of the transfer encoding checks.  I support
>> > warning people before sending invalid emails, especially since I belie=
ve
>> > the address in question would not be deliverable through some mail
>> > servers (such as mine).
>>=20
>> Would this be addressed by instead opening a connection to the server,
>> and seeing if it is willing to accept these addresess on a "RCPT TO"
>> line?
>
> No, because that tells you whether your smarthost will accept it.  There
> are often multiple different parties involved in SMTP (including various
> filtering programs, smarthosts, and relays) and all you'll know is
> whether the first one of them accepts it.  I have seen systems where
> there could well be four or five stages of processing an email before
> it even left the host.

Yes, it wouldn't be a perfect solution by any means, but I understood
your upthread "servers (such as mine)" to mean your local relay.

> This is no different than with things like lines longer than 998 octets,
> SMTPUTF8, or various other SMTP protocol issues.  The only surefire way
> to know that your email will be accepted by the remote system is to
> speak the protocol properly.  If people want an option to break the
> protocol, that's fine, but we should try to avoid doing that by default.

I'm not suggesting that we avoid doing it, but that we outsource the
problem to the SMTP server which we're going to be talking to shortly
anyway.

> The benefit to using Email::Valid in most cases is it prevents lots of
> obvious mistakes, where the email address is clearly syntactically
> invalid and undeliverable, especially due to bad author and committer
> metadata.  The Linux kernel history shows that this is not uncommon and
> it's useful to avoid this problem so you don't have to blow up people's
> inboxes with a v2 right away just because you got an invalid address on
> v1.  (Says the guy who has had to do almost exactly this.)

I've done that too, but not in a way where either Email::Valid or "mail
from" would help me, i.e. I just typo'd the local part of a gmail
address or whatever, which you won't know about until you get the
bounces (or incorrect delivery).

But it really seems like you're replying to a suggestion I'm not making,
which is that we just don't do any validation at all.

I'm suggesting that we replace our own validation with that of the SMTP
server's, yes they're don't 1=3D1 correspond, but I think the part of the
Venn diagram of where that matters is too small to worry about.

It has the advantage of side-stepping issues with not having
Email::Valid, as well as those cases where we're being overzelous about
RFC validation, but our local SMTP is willing to try to deliver the
mail.

It's not like authors of MTAs haven't heard of that character limit, but
they're also aware that that certain parts of the spec are loosely
enforced, and that trying delivery is often better than rejecting a mail
out of RFC pedantry.
