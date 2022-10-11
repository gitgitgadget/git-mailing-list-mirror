Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D9C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJKWe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKWeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 18:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495744E422
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665527662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmR4D8nyBvqVzuZIQSplZ60PJYZJ1UNtpgOmwlOh6yk=;
        b=Qv69BjrqVdbGYf82cCRHIgmL/doZcstVK1leQtccXovT2Mbr20AmP4STXH3b+onxqbmoRr
        Ag3ul8YF3mJ6qLn4aeyrfap/2lj4U+LUeOCUm3beyll2/2UTWq/gbqHcAV+t7rjgefb5cf
        lk2Dkc6Zw87TqtSu9Xmqrf3Y7KYdsX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-FSoLAnnlPXOrfl6mSU-HMQ-1; Tue, 11 Oct 2022 18:34:21 -0400
X-MC-Unique: FSoLAnnlPXOrfl6mSU-HMQ-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso4293807wra.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmR4D8nyBvqVzuZIQSplZ60PJYZJ1UNtpgOmwlOh6yk=;
        b=F+633Vu+pSjqePjLYh+Fi9dtlNllzkKoOjyUcwYJcxskOtITVCg4Kve/V4w/Qi5LnD
         WkTl1WCJ5pj/o20AfPWD1eGcWHS4S/1tVlIOdhtXvns5nOQa8Xont79n9/z+zKefsEkP
         HEz3AEFoDMAX6HdH5vcDiB60QRtOVp7iC35h3hvn8x1aMic6j5p5CZdxFEBDPcbBvGgg
         NXuXgpo3Hqd4qe9JJnZwFW+jLkdu/h9Tr9EEy1oLMoxKFwZMs2Bm7zaesjth5j6pF/Pb
         kp3cJu1Bku4PRpoBShhzM9U96fiPf0XH5hn4x+Hu3Hozwf5Y2TgfDT62v375vCNhhMvh
         4UTA==
X-Gm-Message-State: ACrzQf0lKv/D5dHNAeIjQUPmw7jNNPcyn3Msrl2U4cNytbnvpgFmxcdi
        Ib5iGtiHQXMEgFqSK6UGv2PAeQE5Zkj60OmYasZ9c07J01xZxAvzueWHMQzs4I/vOQAlMNv5/o0
        fH1fE+Scuo6F9
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr15415005wri.428.1665527659873;
        Tue, 11 Oct 2022 15:34:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/FeMoHpEsvsEov8xWD/w/Ts+degUw9NM0hJCofYX+zt0TXVXm1HdQVUPgqgNTezjE2NiW9w==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr15415000wri.428.1665527659606;
        Tue, 11 Oct 2022 15:34:19 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d50c8000000b0022e36c1113fsm12338720wrt.13.2022.10.11.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:34:19 -0700 (PDT)
Date:   Tue, 11 Oct 2022 18:34:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: sudmodule.<name>.recurse ignored
Message-ID: <20221011182119-mutt-send-email-mst@kernel.org>
References: <20221007060713-mutt-send-email-mst@kernel.org>
 <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
 <20221007085334-mutt-send-email-mst@kernel.org>
 <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq35bze3rr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq35bze3rr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 02:13:12PM -0700, Junio C Hamano wrote:
> Glen Choo <chooglen@google.com> writes:
> 
> > - where to get the submodule from during a fetch/clone, e.g.
> >   `submodule.<name>.url`, `submodule.<name>.branch`
> > - information needed for submodules to work correctly, e.g.
> >   `submodule.<name>.path`
> > - default config that gets populated in .git/config via `git submodule
> >   init`, e.g. `submodule.<name>.update`,
> >   `submodule.<name>.fetchRecurseSubmodules`
> >
> > With respect to config, the general stance is that .gitmodules is meant
> > to provide defaults for .git/config and _not_ to be read directly (see
> > Ævar's answer).
> 
> I think that is a sensible way to think about this.
> 
> It is more like "suggestion made by the upstream", to be taken after
> examining it, just like you should type "make" after examining the
> Makefile.  At least enough to trust its contents ;-)
> 
> > There are some very limited cases where config is read
> > directly from .gitmodules, but that approach is very frowned upon and
> > it's unlikely that we'll add more of them in the future.
> 
> Yup, we should be careful and see if we can get rid of existing
> uses.
> 
> Thanks.


Fundamentally the problem we encounter regularly is this:
	qemu is superproject, ui/keycodemapdb is subproject.


	I have a change on master setting the submodule commit:

	qemu$ git show master | grep +Sub
	+Subproject commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352

	and check it out:

	qemu$ git submodule update --init ui/keycodemapdb
	Submodule 'ui/keycodemapdb' (https://gitlab.com/qemu-project/keycodemapdb.git) registered for path 'ui/keycodemapdb'
	Submodule path 'ui/keycodemapdb': checked out '7381b9bfadd31c4c9e9a10b5bb5032f9189d4352'


	In another branch I have a different commit:

	qemu$ git show sub-foo  | grep +Sub
	+Subproject commit 57ba70da5312170883a3d622cd2aa3fd0e2ec7ae


	Now I switch branches and nothing happens, the submodule
	is marked as dirty:

	qemu$ git checkout sub-foo
	M       ui/keycodemapdb
	Switched to branch 'sub-foo'

	qemu$ (cd ui/keycodemapdb && git show | head -1)
	commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352


it is now very easy to generate incorrect code:
- git commit -a  will commit the change to submodule
- any build will use a mix of super and subproject that
  is completely untested


As a result people are basically saying avoid using submodules
but I am wondering whether git can be tweaked to do the
right thing by default.


I understand we can work around it by asking everyone to
create a correct config, but can't we make it DTRT by default
to reduce friction?


-- 
MST

