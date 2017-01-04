Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7746E20754
	for <e@80x24.org>; Wed,  4 Jan 2017 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbdADQL7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 11:11:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbdADQL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 11:11:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A6953611CB; Wed,  4 Jan 2017 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483546317;
        bh=vDLBBQ3bkDRGdboxgEm91BmZG3Ru9zJzCGD8hiPMFmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA1tmSCQLv3vkQMFA8YK4n/sz5rJZq7s9Zjr/kYzl3jWA3XQEDcD9gU9oJE7PT9iY
         iTt+jLmR5i/6PDfQYZlUn86rOoMFkjzWwDu9R24c6mEiS0P8DAYoT71fathbWEy8sU
         3WfrvI2UdH/wI+0x6IDtbjxxhJUhMv346T81CUMc=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8566611CB;
        Wed,  4 Jan 2017 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483546317;
        bh=vDLBBQ3bkDRGdboxgEm91BmZG3Ru9zJzCGD8hiPMFmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA1tmSCQLv3vkQMFA8YK4n/sz5rJZq7s9Zjr/kYzl3jWA3XQEDcD9gU9oJE7PT9iY
         iTt+jLmR5i/6PDfQYZlUn86rOoMFkjzWwDu9R24c6mEiS0P8DAYoT71fathbWEy8sU
         3WfrvI2UdH/wI+0x6IDtbjxxhJUhMv346T81CUMc=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org E8566611CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     repo-discuss@googlegroups.com
Cc:     jmelvin@codeaurora.org, jgit-dev@eclipse.org, git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Date:   Wed, 04 Jan 2017 09:11:55 -0700
Message-ID: <5172470.bsscxDU4yv@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am replying to this email across lists because I wanted to=20
highlight to the git community this jgit change to repacking=20
that we have up for review

 https://git.eclipse.org/r/#/c/87969/

This change introduces a new convention for how to preserve=20
old pack files in a staging area=20
(.git/objects/packs/preserved) before deleting them.  I=20
wanted to ensure that the new proposed convention would be=20
done in a way that would be satisfactory to the git=20
community as a whole so that it would be more easy to=20
provide the same behavior in git eventually.  The preserved=20
pack files (and accompanying index and bitmap files), are not=20
only moved, but they are also renamed so that they no longer=20
will match recursive finds looking for pack files.

I look forward to any review (it need not happen on the=20
change, replies to this email would be fine also), in=20
particular with respect to the approach and naming=20
conventions.

Thanks,

-Martin


On Tuesday, January 03, 2017 02:46:12 PM=20
jmelvin@codeaurora.org wrote:
> We=E2=80=99ve noticed cases where Stale File Handle Exceptions
> occur during git operations, which can happen on users of
> NFS repos when repacking is done on them.
>=20
> To address this issue, we=E2=80=99ve added two new options to the
> JGit GC command:
>=20
> --preserve-oldpacks: moves old pack files into the
> preserved subdirectory instead of deleting them after
> repacking
>=20
> --prune-preserved: prunes old pack files from the
> preserved subdirectory after repacking, but before
> potentially moving the latest old pack files to this
> subdirectory
>=20
> The strategy is to preserve old pack files around until
> the next repack with the hopes that they will become
> unreferenced by then and not cause any exceptions to
> running processes when they are finally deleted (pruned).
>=20
> Change is uploaded for review here:
> https://git.eclipse.org/r/#/c/87969/
>=20
> Thanks,
> James

--=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation

