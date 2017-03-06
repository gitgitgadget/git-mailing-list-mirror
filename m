Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED66320133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbdCFWls (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:41:48 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56020 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754113AbdCFWll (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2017 17:41:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AD94208D8;
        Mon,  6 Mar 2017 17:33:32 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 06 Mar 2017 17:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=mplew.is; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=lCqrTZJcWgldF5a
        BwYcllXTHc6I=; b=V/I9WfdWuxvfW0M8igSc6o9D2M4aHEJED9uu5k3+9xkjnPi
        onxJACQ6Ey/DyhmtokOmYebLolMNmToFoE+irmo3TRjFF7bTokIebTOAXA84HG++
        YN1A87hrKON44+TyOc6B5ZrSnac+x84dCX3YeqJAQMQr+6lKe3ZMGD1c1uC0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=lCqrTZJcWgldF5aBwYcllXTHc6I=; b=LCEmbIxeUmo4zVEBwt9I
        o43Rty9vOAfI7dADfT/hbCfcbbMnKv+t+faYwdcEED/pvvs6avV3wBHQgxVy6QW4
        oAtmw4uHV0yhpAC2jd8Td0pa52evvvedtasFINqYGJ0VcFksYxC0HJFip1JO9Ntq
        en51UY9wMBPsTkZv8Z9BitU=
X-ME-Sender: <xms:vOO9WNsLSkPRNn6QWDecyHGC0-Px7Fx1GBAY_gUznsHPtbKGMev1yg>
X-Sasl-enc: AdZV78v8HWbexFdF7s42cKJu7FouldpB0Y2w6egwpH8q 1488839612
Received: from [10.0.230.6] (unknown [8.26.230.239])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D5697E31E;
        Mon,  6 Mar 2017 17:33:32 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Server-side hooks on non-bare repository
From:   Mike Lewis <mike@mplew.is>
X-Mailer: iPhone Mail (14D27)
In-Reply-To: <xmqq1suankus.fsf@junio-linux.mtv.corp.google.com>
Date:   Mon, 6 Mar 2017 17:33:09 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <547DCC7D-7FA1-43BB-84A6-93DE74334A01@mplew.is>
References: <719CE082-14AB-4E18-AE7D-7D2A818CF499@mplew.is> <xmqq1suankus.fsf@junio-linux.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for taking the time to reply. I apologize if there was a misunderstan=
ding in my previous email; I'm relatively new to dealing with some of the mo=
re advanced features of git, and did not describe my situation as clearly as=
 possible.

I am using the pre-receive hook to determine whether to allow the push or no=
t. Essentially, I'm rejecting the entire push if a branch not checked out is=
 pushed, and then ensuring that a backup has been made of some critical data=
 to prevent any issues with deployment (and if that backup fails for whateve=
r reason, I also reject the push). The post-receive hook is essentially used=
 for notification of a couple services that the push had been completed.

My point #1 was supposed to be something along the lines of "I found this be=
havior unintuitive and poorly documented, but it's fine since I can work aro=
und it", but it didn't come across that way. I understand that breaking back=
wards compatibility by changing this behavior would be a huge deal, and I wa=
s not intending to suggest it.=20

Point #2, however is what I was attempting to discuss in more detail. I'm cu=
rious as to why git doesn't recognize that it's currently inside the working=
 tree in that situation, and if that's intended or not. There's no update cu=
rrently happening in either hook (since they are called immediately before a=
nd after any changes), which means that I can't see a reason to have behavio=
r that differs (having to specify a GIT_DIR, which may or may not be a compl=
ete workaround) between when the hooks are running and when they're not. Tha=
t doesn't mean there isn't a reason; it's more likely I'm just not familiar e=
nough with how the hooks are called internally to see it, and am looking for=
 a more thorough explanation as to the motivations behind this behavior. If i=
t's intended and not going to change, I think the behavior should be documen=
ted more thoroughly so that nobody has to repeat the process I did to find o=
ut why my hooks were failing. I don't mind contributing to this, but I have n=
o idea where to start.=20

Anyways, thanks for responding, and I apologize again if my first email was p=
oorly written and rushed.=20

Mike Lewis

> On Mar 6, 2017, at 16:42, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Mike Lewis <mike@mplew.is> writes:
>=20
>> I=E2=80=99m having some issues with using server-side hooks when pushing
>> to a non-bare repository. In my git config, I have
>> `receive.denyCurrentBranch` set to `updateInstead`, which behaves
>> as expected, and updates the current working tree when the current
>> branch is pushed to. However, attempting to process those changes
>> with pre-receive and post-receive hooks results in some unexpected
>> behavior regarding the current working directory of the scripts
>> and using git commands.
>=20
> The pre-receive hook is to inspect the objects and ref updates and
> say "yes, allow it" or "no, refuse it"---you are not supposed to do
> anything else, so even though what processing you are interested in
> doing in your "attempting to process" is unclear, this hook is not
> what you want to use anyway.
>=20
> The post-receive hook is a more interesting case.  It is called only
> after everything finishes, so it is like running a custom script
> after "git push" is processed.
>=20
>> I=E2=80=99ve tested these issues using both git
>> 2.11 and 2.12 on various systems (macOS and CentOS), and get the
>> same behavior each time.
>=20
> That is a very good news, as I do not think at least in the past few
> years we planned to change the established behaviour of the hook.
>=20
>> 1. When using a non-bare repository, I would expect the the
>> working directory of the hook to be the root directory of the
>> working tree,...
>> 2. While running the hooks, git treats the repository as being
>> bare, regardless of whether it actually is.
>=20
> Yes, and it is unlikely that the behaviour wrt to where $cwd is
> during the hook's execution will ever change; otherwise existing
> scripts that know what the rule is (i.e. the rule you figured out in
> 2.) will be broken.  denycurrent=3Dupdateinstead *is* an odd-man out,
> and its processing is purely internal---its addition does not mean
> hook authors are suddenly required to do things differently
> depending on bare/non-bare-ness of the repository.
>=20
>=20

