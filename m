Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8551F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDLXRo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:17:44 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44596 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeDLXRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:17:44 -0400
Received: by mail-wr0-f173.google.com with SMTP id u46so6609866wrc.11
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=0wrMRGjRvHYdb9DGI1Sqrp1xf5/gyIC8+yk9Ltu1/E8=;
        b=pgV5k1BaKikL1hroX62qMn7UdKfkOrvHIh1EiZeXto7WeUJUnso/cFpawrD/wQKQ5R
         gU3vjPa1vIAcEIY2n2ztt5RPAng+X2zJ4xV6hTPFgEmKT1roOiZOpsvlirdC9mNNSKbk
         PC/EBBPfd9Ly/duyfji6eGiN7rqGYs5UILw6ATzTV38H+fzYjOwJuD9i8qx4KM7iFNhy
         NWRHWst2GdqwLy4DG5Lx6gEPVIHlp+ztLMzuLLjFoonW+sS/56OD/sn7r1B5SeqnOTfx
         Vwz4GYQg5k4BIOpsJNkedQWbsp5zWTIWLE+dg7G0/6WcDNgjDcC+JP9mIGDD2HAZSWQa
         SFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=0wrMRGjRvHYdb9DGI1Sqrp1xf5/gyIC8+yk9Ltu1/E8=;
        b=H8zHc088JUVg/uXw8qupVWFOs2aBO5/BOVqKw0QMAgMBZSAkEnQGyTcwC7WZ2PnqLg
         GLQ67JCdY+7ZvDoGveTt3xbYi1/jF6Nfy1khs/9SMvXJpmT9Ag0DIp1yvd2dwwVST6hK
         TkfjYdC1N3pETDAy3HurE3d8O9kgm3A/cYJmoC5pLiffvYK05zL2bVCSA4GZiOYQP0V/
         cCuT3f0iNHwFAlNgel4dN8IRUAtQeehM92FoyrRprfuhvPHmEHltmy4zqYrYxhQVtgCy
         AXee57+7PXNPvi9bdn9StxiofCpxoA88ci5A+j8JdsdcFixu12/RUkuvhAWupnqXyeUA
         WIlw==
X-Gm-Message-State: ALQs6tBwXNaz0roZdKbQjzMmqzTzS/Lz1IYhZtsDh7XCvaed9YuoRLI+
        8fClXPy6XaWy26uidwTri5L6YAi3
X-Google-Smtp-Source: AIpwx49zRN4D3BF3EH1peb4oOwMTvEthIjW7DxaILq4tGNizw+t7nZDZZ8y5MvNsf3VFmR4PgsME2w==
X-Received: by 10.223.176.144 with SMTP id i16mr1999182wra.70.1523575062266;
        Thu, 12 Apr 2018 16:17:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c130sm611753wmh.33.2018.04.12.16.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 16:17:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 13 Apr 2018 08:17:41 +0900
Message-ID: <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Now, the reason it was marked as changed is that the xfs branch _had_
>> in fact changed it, but the changes were already upstream and got
>> merged away. But the file still got written out (with the same
>> contents it had before the merge), and 'make' obviously only looks at
>> modification time, so make rebuilt everything.
>
> Thanks for a clear description of the issue.  It does sound
> interesting.

A bit of detour.  "Change in side branch happened to be a subset of
the change in trunk and gets subsumed, but we end up writing the
same result" happens also with the simpler resolve strategy.

Here is a fix.

 git-merge-one-file.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9879c59395..aa7392f7ff 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -137,11 +137,21 @@ case "${1:-.}${2:-.}${3:-.}" in
 		ret=1
 	fi
 
+	# Does the merge result happen to be identical to what we
+	# already have?  Then do not cause unnecessary recompilation.
+	# But don't bother the optimization if we need to chmod
+	if cmp -s "$4" "$src1" && test "$6" = "$7"
+	then
+		:; # happy
+	else
+
 	# Create the working tree file, using "our tree" version from the
 	# index, and then store the result of the merge.
 	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
 	rm -f -- "$orig" "$src1" "$src2"
 
+	fi
+
 	if test "$6" != "$7"
 	then
 		if test -n "$msg"

	   
