Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8450C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCGA2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCGA2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:28:51 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833113ABF
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:28:50 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id 4so7596960ilz.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678148930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KC2cuznGneo0VBpzQ4nWq/rZ+5QYbq2Bp3MIVd7TBvw=;
        b=EJczsc4wjN+muGhDhsl7QoAHL8wJ+JOpu9Dl6xnwznYkruEqb4z7mrkSWKHx5S+j5y
         g9MbtaKRtyTDvaMShE9gdsqBRhIDk2Q/SeEhE4yT3EcVNJ/udwUk98Ipi31xxs53ZqxP
         iFsZttoIAd14PUVrhS99WY/F9OngNDmC3/Z/0mdQCq2JEyCXSxV+m12BO3LrCVduYHrI
         NkgBxj4sfn1cF1MzE9CVZaa/1i4VJk7W1eXhP1pGJaAuvxQnXyuAe8o50bVkzYqR21Iy
         x03jDntV7Jiyb1PgRYrEx+ei/IUnFv1NhN6q88XMxPtBr0FnuQEyf9uQo8PbdVxR+F4j
         HuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC2cuznGneo0VBpzQ4nWq/rZ+5QYbq2Bp3MIVd7TBvw=;
        b=tREYrc+OWtNToM+SirEHAsvvQM/JNhsJ8bbAtNmnTke3XrlbeQPQVNO0l1YMVlcJOR
         UkLkEIV8O1m2qLaE6WzXndc9ZwBn1BumcXGTIF8fMF1/2iZ3G6hxLGFR8DUqMW+uccPj
         zAfUIG1REpULziatTmSPWF1yomYioEGnceS5Gzjfw2AdsUkop3xHkhpzco0r32jJNXyD
         YTH9jaO7fxMXQAHN4mC6loF8fxRvvUlNzVT+5HE0EJ12EdoFND2qTzSB+HDTr+oA+aUh
         rggJIhmZk16VuB8aqVip2jlIeUSURoRG1S9BMPCytuNpi4PfhEfeRccdE1KBney43KrS
         YO6g==
X-Gm-Message-State: AO0yUKWv4jDxdB13JkiM5cQ8dDc07bjjLVeH9GI0THOKW48uWoRsaRX6
        6OplbTN1we7KBT00pVHBA3GjgPnHutSI5ZwMmAMpCg==
X-Google-Smtp-Source: AK7set9SS3VRZ6GOd7W5LCUUisYFny7nalEq7jWjli77ZGE9NfLtxYvpALG+9bk3IWS9ls6jTekUMA==
X-Received: by 2002:a05:6e02:1608:b0:318:6d32:b12a with SMTP id t8-20020a056e02160800b003186d32b12amr11588576ilu.13.1678148929698;
        Mon, 06 Mar 2023 16:28:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a02ab85000000b003c4f35c21absm3500490jan.137.2023.03.06.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:28:49 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:28:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
Message-ID: <ZAaFQJm6UGYH4YIi@nand.local>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <xmqqy1o97apj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1o97apj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 02:54:00PM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
> >  	struct object_directory *odb;
> >
> >  	obj_read_lock();
> > +	reprepare_alt_odb(r);
> >  	for (odb = r->objects->odb; odb; odb = odb->next)
> >  		odb_clear_loose_cache(odb);
>
> Hmph, if there was an old alternate ODB from which we took some
> loose object from and cached, and if that ODB no longer is on the
> updated alternate list, would we now fail to clear the loose objects
> cache for the ODB?  Or are we only prepared for seeing "more"
> alternates and assume no existing alternates go away?

Based on my understanding of the patch, we are only prepared to see
"more" alternates, rather than some existing alternate going away.

That being said, I am not certain that is how it works. Perhaps an
alternate "goes away", but does not actually get removed from the list
of alternate ODBs. If that's the case, any object lookup in that
now-missing ODB would fail, but any subsequent ODBs which were added
after calling reprepare_alt_odb() would succeed on that object lookup.

So, I don't know. I don't have the implementation details of the
alternates ODB mechanism paged in enough to say for sure. Hopefully
Stolee can point us in the right direction.

> Other than that, looking quite well reasoned.

Agreed.

Thanks,
Taylor
