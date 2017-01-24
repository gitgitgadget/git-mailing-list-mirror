Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368951F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 17:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750779AbdAXRjy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:39:54 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34456 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdAXRjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:39:53 -0500
Received: by mail-qt0-f181.google.com with SMTP id l7so196101348qtd.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ywo3wITue7tyMJftuoc5biPoxoa2WdHntq6T2cccyAg=;
        b=Q/oLtpvHj9q+pqiOJCFUECrXyayJRPfVTxkiwvzTOyPHkismBYGXRBOoAgiOmEBW1x
         +0SFDE4M6ITVSgKRtqYdedUhRE1aMb9DrHhcJx5cLic4/PAMBjsH+5AaYGNUAMiWPzdZ
         Tps6iVeIxo3XTzmuVWJt/gxyGVKspzKRUuFzw11nYeeogKUj0nvssvE3GTxV2gVlnBU9
         +lTX03c8KVhRIAMgBOmPsshjft3pGYNGjysm3XT74TRCAAZ9BZPl3pMczmCOp01IERtm
         EiNgcPqYDeKHR8BGL3covd8tuno9ei9US3WGEtMRLJaxNKYpcNQuZhEwu4N/n36c690E
         u1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ywo3wITue7tyMJftuoc5biPoxoa2WdHntq6T2cccyAg=;
        b=KgnNZ13fAmTmmWHmymglcyVivNwU58t70O1ZfUFXUOI2viY9LTcBkh4/FbM0MbaDQJ
         8R/a7Y+fcS/zvpR32xZzBLDmQyfGn3/Zobfab/wkktiK8ePsBKp+sP5dnA3d/wp74eHW
         lx9k+O2zUGLbMi7rP2BztIChBO7taDrClEVJbXi38sAiUsvXsgBCCc08gipJJ1+r45Ve
         V4teaCA4FegKh/kwte9fHqzgen82L6fQN376rNhJFIAg9JuSYp0qv5YC4/xSRCJzh0vQ
         TKJ/AYnHIbSX2eJ8P67yIbjZK/KQaIdEH0s4R2OldV6L1w69PR5MQw0XYCFTqWVD+dSF
         l1xA==
X-Gm-Message-State: AIkVDXL42Kbc7RK30W8cNakxT87ziMrRRsJQhE7McV983hGLzhQmdOFIasH59c6M9SfNhREm9wIPXSDwn06LPg==
X-Received: by 10.55.183.133 with SMTP id h127mr32343527qkf.121.1485279592272;
 Tue, 24 Jan 2017 09:39:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.162.6 with HTTP; Tue, 24 Jan 2017 09:39:31 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 24 Jan 2017 09:39:31 -0800
Message-ID: <CABURp0ryBtLALEnzRdoeYeUUdrzBxiT3+yTvW6B=vpqMG3p1Rw@mail.gmail.com>
Subject: diff --color-words breaks spacing
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed some weird spacing when comparing files with git diff
--color-words.  The space before a colored word disappears sometimes.

$ git --version
git version 2.11.0.485.g4e59582ff

echo "FOO foo; foo = bar" > a
echo "FOO foo = baz" > b
git diff --color-words --no-index a b
FOOfoo; foo = barbaz

There should be a space after FOO in the diff, even if git doesn't
think "foo" and "foo;" are the same word.

If I remove the semicolon, it looks better, but in fact it only moves
the error later. The missing space is now between the two "foo" words.

echo "FOO foo foo = bar" > a
echo "FOO foo = baz" > b
git diff --color-words --no-index a b
FOO foofoo = barbaz

Here's the same with the color codes changed to text for purposes of this email:

echo "FOO foo; foo = bar" > a
echo "FOO foo = baz" > b
git diff --color-words --no-index a b | tr  \\033 E
FOOE[31mfoo;E[m foo = E[31mbarE[mE[32mbazE[m

echo "FOO foo foo = bar" > a
echo "FOO foo = baz" > b
git diff --color-words --no-index a b | tr  \\033 E
FOO fooE[31mfooE[m = E[31mbarE[mE[32mbazE[m
