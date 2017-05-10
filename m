Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC88120188
	for <e@80x24.org>; Wed, 10 May 2017 18:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdEJSsl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 14:48:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdEJSsk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 14:48:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 517BC6084E; Wed, 10 May 2017 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1494442119;
        bh=KJrb8fvpOVLpc0lfS0Va+WarUo/Zuc4o91KdwUyfsyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPNfYbGTimkYwTWTtCAqxrmd3HQl9F3PU+UfpW/bcqM18FL8xpho2Ho/8Es9JgIsx
         SVxQ1uIDW3ze7c574fcsz9YyZLPIDyQSbWt3NW+vazESI3JDxA80x1w7iQpva6/s12
         UMy7wvnq7iZqn4kdkyc93Jmd6/lwc4Gtx7tmX6Qc=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8EFC6081B;
        Wed, 10 May 2017 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1494442118;
        bh=KJrb8fvpOVLpc0lfS0Va+WarUo/Zuc4o91KdwUyfsyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rq8lGOiMSKBqFV1jQaoE53WbxvqK0PjHkn3KSQgD9gmae1qMso6uFWLVjnwuaTsp+
         iBPwzt0tdJy4OirGrWEwnIqYlVsFwKxQMJGNiJ0gHv77pT+lBJ71BSeJpkjhz9eXZe
         InIRo9dTuIgPjoxaFiJ2gc5urIzixwN5ExBizAXg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8EFC6081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Date:   Wed, 10 May 2017 12:48:37 -0600
Message-ID: <2839966.sklLQJ8GHA@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <20170510182049.GZ28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com> <CACBZZX4AnmP2N_-WLtqQncUDCZDeWS3LFomZrWLYP6iW-hL5KA@mail.gmail.com> <20170510182049.GZ28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 10, 2017 11:20:49 AM Jonathan Nieder=20
wrote:
> Hi,
>=20
> =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > Just a side question, what are the people who use this
> > feature using it for? The only thing I can think of
> > myself is some out of band ref advertisement because
> > you've got squillions of refs as a hack around git's
> > limitations in that area.
>=20
> That's one use case.
>=20
> Another is when you really care about the exact sha1 (for
> example because you are an automated build system and
> this is the specific sha1 you have already decided you
> want to build).
> > Are there other use-cases for this? All the commits[1]
> > that touched this feature just explain what, not why.
>=20
> Similar to the build system case I described above is when
> a human has a sha1 (from a mailing list, or source
> browser, or whatever) and wants to fetch just that
> revision, with --depth=3D1.  You could use "git archive
> --remote", but (1) github doesn't support that and (2)
> that doesn't give you all the usual git-ish goodness.


Perhaps another use case is submodules and repo(android=20
tool) subprojects since they can be "pinned" to sha1s,

-Martin
--=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation

