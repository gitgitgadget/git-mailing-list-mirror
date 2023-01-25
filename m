Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A5C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjAYXpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAYXpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 18:45:50 -0500
X-Greylist: delayed 2555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 15:45:49 PST
Received: from tilde.club (tilde.club [IPv6:2607:5300:203:9993::114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D239DA
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 15:45:49 -0800 (PST)
Received: from tilde.club (tor-exit-relay-3.anonymizing-proxy.digitalcourage.de [185.220.102.249])
        by tilde.club (Postfix) with ESMTPSA id A3B3B220182E7;
        Wed, 25 Jan 2023 23:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club A3B3B220182E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1674690348; bh=WW57ezI8YZXPRUjDzreizQN3Xgwg/WflBiuAOGLxNBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohSDj8MloCbxJbOFucw/dvzcGiWuEO3u/ruJ7id/q7bRN0a1G7znzDfv40xpdmvzw
         RUp7Xv37QkINE4O0mk/8B3hz7KyICI59GYIAIGSbGvbS6rzDs4/xui78z5gxm1GLF8
         SeJHTvRatQpZ3DwDxVUI4/CpaIXTiYD0tfU2nq2k=
Date:   Wed, 25 Jan 2023 23:45:25 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] request-pull: filter out SSH/X.509 tag signatures
Message-ID: <Y9G+/e5ghEsO3hIb@tilde.club>
References: <20230125230117.3915827-1-gwymor@tilde.club>
 <xmqq8rhqdwxl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8rhqdwxl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-25 15:19:34-0800, Junio C Hamano wrote:
> Please sign-off your contribution. 
> cf.  Documentation/SubmittingPatches[[sign-off]]

Oops! I will resend with a sign-off.

> >  git-request-pull.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-request-pull.sh b/git-request-pull.sh
> > index 2d0e44656c..01640a044b 100755
> > --- a/git-request-pull.sh
> > +++ b/git-request-pull.sh
> > @@ -153,7 +153,7 @@ for you to fetch changes up to %H:
> >  if test $(git cat-file -t "$head") = tag
> >  then
> >  	git cat-file tag "$head" |
> > -	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
> > +	sed -n -e '1,/^$/d' -e '/^-----BEGIN \(PGP\|SSH\|SIGNED\) /q' -e p
> 
> This makes readers debate themselves if being more specific and
> narrow like the posted patch is safer and better, or making it
> looser by just requiring "^-----BEGIN " and making it forward
> looking is sufficient and maintainable.

I could imagine someone having a tag with a line starting that way (not
realizing it's a common pattern for signatures to take) and being
confused at why it's being removed. The likelihood of someone doing
that, and using request-pull with that tag, is pretty low though, so I
don't have a strong preference.
