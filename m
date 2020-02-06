Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D5C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 06:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5C420838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 06:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGfIx6NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgBFGeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:34:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgBFGeT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 01:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580970858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBSIitgWOWTe7kIuBj7W5lni8RHtosLSg87QwrLV1jo=;
        b=FGfIx6NFADAK968J8hAnyzJPouPNMwHIFpaE6Wq4Uze+HfuQ18fSCAAZvKAF2L89D1GYiZ
        PhHnPPdrzHVUQSrWV14oiUbnxrSHpGT7AwBKZuf4zRmzHn1aCBRKSwNrPuN/8aD4kpGwFY
        4dpizlE0HIQrNsBBUKI6443OTojhw6I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-8cHJmttuP5aeFJkwIzQgjg-1; Thu, 06 Feb 2020 01:34:16 -0500
X-MC-Unique: 8cHJmttuP5aeFJkwIzQgjg-1
Received: by mail-qk1-f199.google.com with SMTP id c206so2921267qkg.6
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 22:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iBSIitgWOWTe7kIuBj7W5lni8RHtosLSg87QwrLV1jo=;
        b=Ssf2AhZSx7fx4cNADbIQLp8X00o6Xpjq2DDJ9gpe1Nrdpzy4jvr1QFScEvVr0WHLef
         wmZBy+lZluWXOoxoZ8nMTEOkcmyMDI9rc4iOYch9Autk4Cx+7B3Mfxt9K8QpMSXHqCSs
         /pFoLL2Rbgd8wdwCROMJgBbfTGvbRmhnJhWt1YVsQb+hw+ycdl58sVIxZDm/O/cn/5DA
         vmqAhrBZgh84RfQ4ziZvOLwpffC1dZhvgj9x6hftRoHne5FNWmkoYNtkTUCIcUqLUdxZ
         2lkVefA4kAMYraduhJppPSqhg3nRlmZNSzKUs2gnMNTyY3xKEb/GWQAzL0fqER/Co9WZ
         3IRg==
X-Gm-Message-State: APjAAAXNp8tkbkMgJ3UZCpvUsi+AlR5BmHxkuDSyTvkaViLD3aEH5g/2
        WrvOVoNtmKndFNzXGgRfsSHLKLAK450Gm1q2UxLUI7QlpC7gJuOeZ2JrG9/kpumHG9h0LXXp7qW
        kJXFyJtGFAbMl
X-Received: by 2002:a05:620a:a97:: with SMTP id v23mr1163591qkg.251.1580970856135;
        Wed, 05 Feb 2020 22:34:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIdL8MOnBoKmSktdZ1EBNxEsto3Jd1AIY3C9I9dfZM0dcr0fryb3YEqxdP+r43ZmjJbEY8IQ==
X-Received: by 2002:a05:620a:a97:: with SMTP id v23mr1163577qkg.251.1580970855914;
        Wed, 05 Feb 2020 22:34:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id u21sm974460qke.102.2020.02.05.22.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 22:34:14 -0800 (PST)
Date:   Thu, 6 Feb 2020 01:34:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
Message-ID: <20200206012854-mutt-send-email-mst@kernel.org>
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqimkm6o4r.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqimkm6o4r.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 01:25:40PM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Am 04.02.20 um 07:14 schrieb Michael S. Tsirkin:
> >> It seems that it's not too hard to make commits such that
> >> the standard way of git format-patch -> email -> git am
> >> fails.
> >
> >> A work around is "don't do it" - avoid putting anything that looks like
> >> a unified diff in the commit log.
> >>
> >> However:
> >> - Users don't know what other restrictions exist
> >> - User sending the patch has no way to detect failure,
> >>   it's only visible to user receiving the patch
> >
> > Putting a diff in a commit message can be useful, and forbidding it is
> > hard to justify.
> >
> >> Ideas:
> >> - validate commit log and warn users?
> >
> > That's only better than the status quo insofar it turns the issue from
> > a hidden pitfall into an open one.
> >
> >> - find a way to escape text in git format-patch, and unescape in git am?
> >
> > Like a Lines: header specifying the number of lines in the commit message?
> 
> I think the existing practice is to indent such a diff in the
> message by a few characters.

So you are for validating commit log and warning users then?

>  And I think that makes sense even
> without counting its value "as a workaround"---we indent materials
> inserted in the message for illustration, and a block of diff is
> just that.

It might be intended for other purposes, for example instructions:

To try out the new foobar flag, execute the following script:

git apply --foobar << EOF
--- a.txt       2020-02-04 01:09:27.927026571 -0500
+++ c.txt       2020-02-04 01:06:57.404688233 -0500
@@ -1 +1 @@
-AA
+BB
EOF

indenting would break the script, and make it harder for users
to follow the instructions.

-- 
MST

