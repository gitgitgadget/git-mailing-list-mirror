Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E498FC35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6F20838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="vWxmc6Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgBCSLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:11:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45798 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgBCSLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 13:11:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id f25so15635354ljg.12
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HHEgkaV+KWXJ4xOdTVV+0diERMvOm9p+Z2ZHW00Fh4=;
        b=vWxmc6CiDwd/nn1XysNqE6BNfFyOlYivItkmALpva6fizjegR6d/jPXYMpH+OMNtV4
         LZPZcHVLl+nzkl6aT81+2v+QyMOm++mCVocoft31sBELclWVJqiWC1Ql6oZi3/iDzPbx
         gQmPR8s42SW4CE0zHqHUiBxyzt63UwKO5GM6NRZ3k2alZtm5zqx9ZW80JYu68uZSs2/F
         ek97cU5HFxOaogw6F5jQyD/dINPGEzhaqWRZpkswJeeliNGac26cpp0eg6hiQLTTfTX2
         kwd1iBFkpXfw3d0I9SaAofw+Ut5qHeHG8O0yo2J0AW23bFJjHXCjPkPg+U7aMSotCs63
         qFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HHEgkaV+KWXJ4xOdTVV+0diERMvOm9p+Z2ZHW00Fh4=;
        b=nP/xV1zQYSKZNwq3+jnrFAXRc0ddCXYODYuFfFEcnig9IrPWspB9turHgZVCHUT9FN
         w3EfR4OMQGWBywWJkIJB6T+VPQWzUe/BDcoW0oQjmIDlajJG6p7njOkx0HHR9kPgOlKq
         lwp1MzxM7d/XfNLksKRYaFGGwFtYfcgnNdSNtzUBWBnlU3thBRYgn5jXoO8JQzGxeEX2
         rr6qE43cyKEf3necbuWvwEeiraFtBa2Vegmw3GclVUGcpRgmbDBtjuRru1Tk1ynXO+6i
         0QiDxnXX98C8WoTVs3C7NPrV0QKoABkymeiUTP/90Hf8/51a90GSXDeWFTAvhoq2iTnX
         712Q==
X-Gm-Message-State: APjAAAXqDlXFDDvtsPTbbku0+NX7bvhQFAWPXT/WyZ61dxWOueltMCOy
        4CDdkMWc0AfXuKATZwGBxk1DOghHg30YnBb85m/r0IK3yypxFQ==
X-Google-Smtp-Source: APXvYqyljkftY4zEsg2pxexfd1rOxLIc1rXYkX+V94MPOSGH4N/6G+4MysJkfYYUSWMjixm7tkA3KKu/9Q61hT4ej+U=
X-Received: by 2002:a2e:b007:: with SMTP id y7mr13994767ljk.215.1580753476418;
 Mon, 03 Feb 2020 10:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
 <20191213235247.23660-2-yang.zhao@skyboxlabs.com> <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
 <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com>
 <CAE5ih7-ngXsn1+RYSJ9qk_Ajr9x9zLRWNCyUiBGjg=sx_cOuzA@mail.gmail.com> <CAE5ih78dpmPhdsR73cwGJuDYQECDaCvdOuosOAhLyLun9DyL_A@mail.gmail.com>
In-Reply-To: <CAE5ih78dpmPhdsR73cwGJuDYQECDaCvdOuosOAhLyLun9DyL_A@mail.gmail.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Mon, 3 Feb 2020 10:11:05 -0800
Message-ID: <CABvFv3KcpmCXsM2hSaHTzrb0Lz9BAD23sVcNsjO4uf8xCLDh5g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 4:54 AM Luke Diamand <luke@diamand.org> wrote:
> One very small bug report:
>
> When doing "git p4 sync" it prints out the percent complete. It looks
> like it's no longer rounding it sensibly, so where before it would say
> 77%, now it says 77.7777777%.
>
> It's this line:
>
>    sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt *
> 100 / len(changes)))
>
> I think / just needs replacing with //.

Good catch.

The patch below should do the trick, and be more explicit about how
we're formatting things.

I'll roll it into the GitHub branch.

diff --git a/git-p4.py b/git-p4.py
index ca0a874501..183959ec8c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2960,7 +2960,7 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' %
(self.stream_file['depotFile'], progress, int(size/1024/1024)))
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
