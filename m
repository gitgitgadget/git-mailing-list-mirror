Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13ABB1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeKTXhe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Nov 2018 18:37:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37613 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTXhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:37:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so1420471oia.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CvQrLkNSA5+nI9+cSEX0l6ZtVT/Ho3szRxlUs68T/6k=;
        b=LsYl/pZqOUYvaO6XrCluofTqWbrmbW/3R6/T1bRUtkK5T1ppW7ZAs/ZatFC9Ihs2h0
         mLEyrJ40hfXkTfIBFo/xiVqCXSDfusLZxUtmihQfDmQ2DQgprY1hNwSk1igc+xDQC5Ab
         /rs5LAYDIRFXPVNhIMSz27kAnKJK1NPikBRCPDLCu609R7w3bExLH1XXqXliEKjJZhky
         By+tNxFUqMQrewwQ7S41+7gwVMxYDRdQb8+MGmRCvkGUaRAUHt8sxfJQwGqx8wxWrdP1
         GulCtEZdTtjAWX7GtkYxO5mnnEndit7Vr1BBVnGasSUeoN3VppVSRCIPLH7OAB8HEo7Q
         yTLQ==
X-Gm-Message-State: AGRZ1gJYCyaZCwJHRt7GnVWLAOQOc8IK1+APRgVbJFmckAK5Ynsr8hSC
        8pyYsxB+JeoMDg/1u3+jBawKbCReruw8op1tdjU=
X-Google-Smtp-Source: AJdET5eLGomTxKKFl8yqzzfS4EVphY7KAyYbPzr9YdfWiICEvB5OhvhZhfW05DAZI5orwxkORsJX/cFjOOLLzIclHUY=
X-Received: by 2002:aca:d414:: with SMTP id l20mr1094489oig.107.1542719310085;
 Tue, 20 Nov 2018 05:08:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+7wUsz5WyRcxMTUWTg13K866vWWp+bVGSZJFU1hRSL1Ehr8Aw@mail.gmail.com>
 <20181120125520.GZ30222@szeder.dev>
In-Reply-To: <20181120125520.GZ30222@szeder.dev>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 20 Nov 2018 14:08:17 +0100
Message-ID: <CA+7wUsxGdrYKsoydBk0iwmANM=4qxVJ7NoVv6=E_UPH6FuiaaA@mail.gmail.com>
Subject: Re: How to prepare patch for git am which remove a file ?
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 1:55 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>
> On Tue, Nov 20, 2018 at 01:39:40PM +0100, Mathieu Malaterre wrote:
> > Here is a simple setup:
> >
> >   cd /tmp
> >   mkdir g
> >   cd g
> >   git init .
> >   wget http://central.maven.org/maven2/org/apache/xmlgraphics/fop/2.1/fop-2.1.pom
> >   git add fop-2.1.pom
> >   git commit -m "My First Commit"
> >   git rm fop-2.1.pom
> >   git commit -m "Second Commit"
> >   git format-patch HEAD~
> >   git reset --hard HEAD~
> >   git am 0001-Second-Commit.patch
> > Applying: Second Commit
> > error: patch failed: fop-2.1.pom:1
> > error: fop-2.1.pom: patch does not apply
> > Patch failed at 0001 Second Commit
> > hint: Use 'git am --show-current-patch' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > What is the black magic to get `git am` to understand this patch ?
>
> The file in question uses CRLF line endings.

Ah right, I wasn't paying attention. Thanks.

>   $ git am --keep-cr 0001-Second-Commit.patch
>   Applying: Second Commit
>
> For explanation I quote ad2c928001 (git-am: Add command line parameter
> `--keep-cr` passing it to git-mailsplit, 2010-02-27):
>
>   c2ca1d7 (Allow mailsplit (and hence git-am) to handle mails with CRLF
>   line-endings, 2009-08-04) fixed "git mailsplit" to help people with
>   MUA whose output from save-as command uses CRLF as line terminators by
>   stripping CR at the end of lines.
>
>   However, when you know you are feeding output from "git format-patch"
>   directly to "git am", and especially when your contents have CR at the
>   end of line, such stripping is undesirable.  To help such a use case,
>   teach --keep-cr option to "git am" and pass that to "git mailinfo".
>
