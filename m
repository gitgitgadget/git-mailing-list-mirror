Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C4C433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiDJQ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiDJQ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 12:29:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409CA5D5F3
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 09:27:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so15470226edi.13
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xdGgMxoVoZREVlKMnnRpWLIK4TEHC4ZJEjHsxLHmHvA=;
        b=t2lfF4pFEtm1GhUXJnJvCwCGu0j4/3nalzVIKBJx3PZJ8NHnpkvIotr2v21svG7pzW
         f7eviSMVE2SfLBYZJgRzWnkXLL8PWKFTsM8KoNA4WQsukRnqyeMQHzicJ8pIXqiPO3F2
         I9qF8UsTK1RU98SBxVqkgZpeQXz+Xbh/UDFWDD70vUOTE1JedVR5Wxw11HuKML7hX+Ir
         0mjXe2Zd4ZBEIzKmAZyBBJNZgO5B4d+5Z+AO2xGOsZkLP8I5qEryANtdUlfnC8yJRLsV
         BeASy7HbMEK/aKlJ7Kt1jdSwtXACHEMoiMDGRffS46O781lFVd8XIsjZyNx3CJW1fVoU
         7nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xdGgMxoVoZREVlKMnnRpWLIK4TEHC4ZJEjHsxLHmHvA=;
        b=hQRahYSOw/uJn+JWp/LKvtSfzhsU+Amn0HLAfzeHBDgfnuJSyInqJ0no00t1Q839HQ
         e/lmwvqdWHsVwyt3Sa9h+btQn/zj+l637lihP0LkxBcu7iRZ1eW8T1zmSJVUsCn3SbUR
         ZKfAHCUDx8xQenMi9GxCjJdHgQJ2PyeTdnB+0r2MigvYuMBfgcVU+9D+tjEOKpqz0LR9
         XDvBc/cB5Yh74UAr2RqY2xcohVg/4hfVjOse2HkJzNGelG7cxX/vWd9257A75cg9afL2
         AZTtGX/7HyETAMoSbveDxiNC9CllReOmDX634xOTdYO5k+NwvBTd0HDAsut0UNXw5dpG
         nWIg==
X-Gm-Message-State: AOAM531dnXvEzYPlCy8a+8nsW+lWXxqtiAgxCVThRp8zJdKX8Q5z7EAI
        VZkIitnOKHVA09e3Ar9mzox8XLdwVNtEEcEUpOHqmQ==
X-Google-Smtp-Source: ABdhPJyJewAWH64PHtRpOnxDMU1haSXZ1LgxzvOPxFvyfEBM2Nz5eA13dM7VECijpUr7mLSkevLor0koiEjUMNAs3EI=
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr29134218edt.416.1649608061815; Sun, 10
 Apr 2022 09:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net> <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz> <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <013101d84ceb$afaa51b0$0efef510$@nexbridge.com> <013201d84cee$3e8d88a0$bba899e0$@nexbridge.com>
In-Reply-To: <013201d84cee$3e8d88a0$bba899e0$@nexbridge.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 10 Apr 2022 18:27:30 +0200
Message-ID: <CAPMMpohnwTTwTEjr9u29O_qVJtQNuG29G3Ta+-rXz-De8zvMCQ@mail.gmail.com>
Subject: Re: Make commit messages optional
To:     rsbecker@nexbridge.com
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 10, 2022 at 5:18 PM <rsbecker@nexbridge.com> wrote:
> On April 10, 2022 11:00 AM, I wrote:
> >On April 10, 2022 10:00 AM, Tao Klerks wrote:
> >
> >The main argument against is that this violates the basic principles of =
a well
> >managed DevSecOps environment that requires who, what, where, when, why
> >for every change, not just the ones you publish. The key point here of h=
aving
> >comments in commits is that it allows organizations to pull in projects =
like OpenSSL
> >that ends up in production and must have the accountability for the inst=
allation to
> >be allowed. Otherwise, just give up on the concept of Open-Source becaus=
e
> >corporate auditors will reject any request to use your project. You will=
 never get
> >into a PCI environment without a full set of commit comments, not just t=
he Pull
> >Requests.

I don't understand your point here. Allowing empty commit messages, as
well as near-empty commit messages, is already a part of the git
ecosystem. Git itself does not, and could never, validate the
value/meaningfulness of any commit messages. DevSecOps, corporate
compliance, accountability, auditability - these are all useful and
necessary concepts, but meeting their requirements is not the business
of a client that millions of users use to do their daily work - it is
instead the business of secured server environments (that you might
want to push to), auditors, software supply chain management software,
etc.

Obviously your users (the ones that are expected to meet certain
requirements) should be discouraged or (more likely) prevented from
pushing messageless commits to the branches/environments that carry
auditability requirements; I'm guessing they probably also need to
have references to other systems (eg ticketing systems) to provide an
external "rationale" audit, GPG signature, ACLs and other things that
are simply not the business of the client.

I agree it would be a mistake to make it easier for such users (or any
users, really) to *accidentally* commit something without a message,
and then find themselves in a not-always-obvious "now I need to change
the past" situation.

> >
> >Granted my requirements come from regulated industries around the globe,=
 and
> >if you are making toys, so be it. My teams are making production-hardene=
d
> >applications.

No amount of "hardening" the client that people run on their own
machines will improve the security of *your* applications in any way.
All the problems you describe involve *server* security. Whether other
people choose to use the client to make toys, or art, or banking
software, or git itself... is their business? The implication that the
use of git in "serious industries" should make it worse for other
users (such as toymakers) is, I believe, unhelpful at best.

> >
> >>In that sense, allowing people to create empty commit messages when
> >>they shouldn't, is often "trapping" them into a commit history that is
> >>less valuable (or even acceptable) than they might otherwise have achie=
ved.
> >>
> >>While I therefore disagree with Aevar's proposal to "allow empty, and
> >>advise", I do think the notion of giving advice makes perfect sense -
> >>let's do it the other way around, with an advice message something
> >>like:
> >>
> >>---
> >>Empty commit messages aren't normally allowed, as they reduce the
> >>understandability of the commit history. If you do need to create a
> >>commit with an empty message, you can do so by providing the '--allow-e=
mpty-
> >message'
> >>argument to 'git commit'.
> >>---
> >>
> >>Has this already been considered/discussed? Would it meet the
> >>objectives of those folks saying "the rejection of empty messages
> >>wasted my time", while also keeping the spirit of "we should make it
> >>easy to do the right thing and harder to do the wrong thing, especially=
 for
> >beginners"?
> >
> >I am not personally going to be convinced of any of this - forgive me bu=
t, I think
> >this reduces git's value and credibility as the leading SCM solution on =
the planet
> >(and off) and see no justification for enabling comment-less repositorie=
s other
> >than laziness. Even if that were the case, it is grounds for termination=
 in my
> >company and most of my customers to deliberately bypass audit practices,=
 so if git
> >moves forward with this, we might have to move elsewhere.

Given your earlier comments, I'm not sure I understand the "this"
you're not going to be convinced by or about. What I was proposing,
and maybe I did a terrible job of it, is to *not* change the behavior
of the client in any significant way, but rather add some new advice
(which, like any git advice, can be turned off, eg by a corporate git
installer), which would show alongside the current "Aborting commit
due to empty commit message." error.

The exact text of that advice would obviously need to be carefully
considered, but I would expect it to say something like "committing
without a message is typically a mistake (and might prevent you from
pushing to the server later), but if you really want or need to, you
can use the --allow-empty-message option".

The point of this advice would be to clarify the existence of the
"--allow-empty-message" behavior (and reduce the incidence of "stupid"
commit messages like single periods), *without* in any way increasing
the incidence of *accidental* submission without a commit message.

>
> And I still don't get why the --allow-empty-message is not sufficient to =
meet your use case. git supports what is being requested already, not that =
it is allowed where I am. Are we talking about setting --allow-empty-messag=
e as the default? That is a major behavioural change. You could create a gi=
t command alias to always specify this option. So what is the point of this=
?
>

My proposal is that it absolutely is enough, functionally - but the
abundance of "we should change something" concerns in this thread and
elsewhere suggest, to me, that it might not be sufficiently
discoverable; hence the "advice" proposal.
