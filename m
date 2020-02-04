Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68EC3524D
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 01:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C63E21744
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 01:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="KJ+8U1en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBDBgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:36:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36412 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBDBgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 20:36:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so16750529ljg.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 17:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQ34QF+NijeL3aBdJUwfKUtDFYo6wrmHepFJ56LtmIw=;
        b=KJ+8U1enOxA9TjrtbvJGxUNooKyN0eiPxQVxxETLUOHs8uF9F8jtH8DYGqUJsp3YPu
         9NyzdzrxFQaJrT6rFHVa/UZdO137Elei1WsN+d83VPgEvMpO0Lbi5wdtd426Yw4MMfCL
         h33QVq4YPhMwqgc8gssoqz/d5VOXRXArPf7/5OEEX4TmNqpgYV19VzamylvN2hIJgJiK
         z4ASuN9y4FEFmabsrOG0HFXCCXs8RtcVhYTGov7gkhH4nF8ju5OinmGDN3kba1f/c9r2
         R+WDzg6O5GSh6ajsU/t9/PyAAYMSTDPjgQzYKM1VXtFKaM7pmSxSGkR03iF32dW5ry/J
         mmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQ34QF+NijeL3aBdJUwfKUtDFYo6wrmHepFJ56LtmIw=;
        b=QylUftqdaudKAz3/FY0xknbiF2EpX7NV3Jh9/NmhnPfJlvbEgVnCOS3P+Ox8zH/cB4
         DUxbO57Fv2dRJiGT9MW3farHUUkLftl9wpG3BHCF8COf5XCo8LPxAFpez3zGz9PR3P+v
         q/Qr23wRgQjpd5WTnMVSsDmbV4451rWYs3TJa+wZypMqWC2OKlmZU9t6RBDt9nVjakEi
         xvpU0kCoxYK1yjuL/yk6GJB6BWJhDZA6ipFfCWVyyrhUC3ER92nMw2/d5XiJLMAln+dv
         ilLHFiyivBiP0ooTewpg2b9or3FMTOScIkSuoH5hHQzXMoNzN6AtCXk3oekHUHDZJe9y
         4iuw==
X-Gm-Message-State: APjAAAWWxPIRkQY1cwE4nDrFo6q+sXMllnFA0gw/P/A6VF7Nlhahj5bp
        7ndYNaVY0EWfVO/bwdZaNSRds2nrPHDa86PKDMMmV3PNgL4=
X-Google-Smtp-Source: APXvYqxlkvEGsG/r4iN34DsyqnhvXAFDsrO+qxIPoqY3+LPXWehb9Fhe6MAzibytUYzrQikNAOeZaaNHfKGI/DsomIs=
X-Received: by 2002:a2e:6815:: with SMTP id c21mr14147180lja.10.1580780168666;
 Mon, 03 Feb 2020 17:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
 <20191213235247.23660-2-yang.zhao@skyboxlabs.com> <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
 <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com>
 <CAE5ih7-ngXsn1+RYSJ9qk_Ajr9x9zLRWNCyUiBGjg=sx_cOuzA@mail.gmail.com>
 <CAE5ih78dpmPhdsR73cwGJuDYQECDaCvdOuosOAhLyLun9DyL_A@mail.gmail.com> <CABvFv3KcpmCXsM2hSaHTzrb0Lz9BAD23sVcNsjO4uf8xCLDh5g@mail.gmail.com>
In-Reply-To: <CABvFv3KcpmCXsM2hSaHTzrb0Lz9BAD23sVcNsjO4uf8xCLDh5g@mail.gmail.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Mon, 3 Feb 2020 17:35:58 -0800
Message-ID: <CABvFv3KPZ9ibx9+WDkgWJ9Zn1_VyuoX_KiOPxYSvL2AwRVsMxg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 10:11 AM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
>
> On Mon, Feb 3, 2020 at 4:54 AM Luke Diamand <luke@diamand.org> wrote:
> > One very small bug report:
> >
> > When doing "git p4 sync" it prints out the percent complete. It looks
> > like it's no longer rounding it sensibly, so where before it would say
> > 77%, now it says 77.7777777%.
> >
> > It's this line:
> >
> >    sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt *
> > 100 / len(changes)))
> >
> > I think / just needs replacing with //.
>
> Good catch.
>
> The patch below should do the trick, and be more explicit about how
> we're formatting things.

Oops, missed a line. Below is more correct (pardon the webmail patch clobbering)

diff --git a/git-p4.py b/git-p4.py
index ca0a874501..da3a5aa684 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2959,8 +2959,8 @@ def streamP4FilesCb(self, marshalled):
             'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
-                progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' %
(self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                progress = self.stream_file['streamContentSize']/size
+                sys.stdout.write('\r{} {:.0%} ({}
MB)'.format(self.stream_file['depotFile'], progress,
int(size/1024/1024)))
                 sys.stdout.flush()

         self.stream_have_file_info = True
@@ -3435,7 +3435,7 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)

             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" %
(change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision {}
({:.0%})".format(change, cnt / len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
