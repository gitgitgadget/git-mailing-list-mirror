Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03BD207F8
	for <e@80x24.org>; Sat,  6 May 2017 12:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdEFMam (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 08:30:42 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34597 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdEFMal (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 08:30:41 -0400
Received: by mail-wm0-f50.google.com with SMTP id u65so7171108wmu.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=WC8NLhKSX2kceM/EAO1/fFkI1OO5pmVfIPg0lW2nxxA=;
        b=I1DbTJmNhVabYyDhodowUBnv41VBAzmxo3SX/J8fzxamBr1aFIf+0EvkbdIbtZSQdk
         l9odiZfaLDeLU2gj8Ibf//iDo1oU6TJSCCQCAIz+gyXpxut9KdursVg1mViKAigO/Vvh
         YjS4hDdXZxKvqwWDNMu/N818MFh4pg2WKXkBIaxCaE9mNeWDQTgjwI7SVtEGht4e+vFK
         GLlvvVedoQ6Yr7Ga0eavUJ39DjbYeoM7F5IIwte9SSjxPw1TDC75mIoie9c+65FuaSmp
         6qGnhnA2u+72KERmZqHT51hkIvvH32Bm+o2EGQzqAfTW7E6zxpBXgJfxJTdjprss5b+3
         Qh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=WC8NLhKSX2kceM/EAO1/fFkI1OO5pmVfIPg0lW2nxxA=;
        b=oMFu3EY9eSM9Ngb3LIzDn2/cqfUvanaNkHMQoxIVrM8qiRSREB3YnrsciuDf0L8y23
         dcNyQ0PaLwYrlH5tEccVSRc0nAJYim/u7CAMlEnkT/VtT82jSfRXgwMYQLaAsS2ILyG8
         aWK2YdAPHV2Q3D+KYs/9jLeSGbT8lJrPmYgAEd9BiMqPWtg+pKFA8OhCOAtvhhT+2+Pg
         xDlGAKV9RojvJ6tV/Ve+sKDKBCtmdnVaSOhTcCSYI0oENIKFpuyDTatsrEM/XMTYyLOY
         lXsABPiN5W9KS5gDIScrFvbOZ94nDp+XQ68/jtYLaAVZk9WQgxtmxjrWqrmbCpZylek0
         ilNQ==
X-Gm-Message-State: AN3rC/4RxblEip/PwML174tJ17rsxj/65DdDMB9LBJwf1wGAI/jtongY
        MBaUbFmGV3wxZfeAt0w=
X-Received: by 10.28.6.199 with SMTP id 190mr8442265wmg.15.1494073839324;
        Sat, 06 May 2017 05:30:39 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:3ec2:1200:5891:3333:d19e:cdda? ([2a02:ab88:3ec2:1200:5891:3333:d19e:cdda])
        by smtp.gmail.com with ESMTPSA id x20sm5831920wme.0.2017.05.06.05.30.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 05:30:38 -0700 (PDT)
From:   akos tajti <akos.tajti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Git smart http: parsing commit messages in git-receive-pack
Message-Id: <7DA6022F-02F0-41AC-ABAB-64565E81481F@gmail.com>
Date:   Sat, 6 May 2017 14:30:35 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear All,

we implemented a java servlet around the git-http-backend. This servlet =
intercepts the requests sent by the git client when pushing. One thing I =
want to achieve is parsing the commit messages in the pre push phase =
(request param service=3D=3Dgit-receive-pack) and after checking if the =
commit messages contain a given string reject/accept the request. The =
problem is that I couldn't find a way of parsing the commit messages in =
git-receive-pack (I can do this in the post  push phase but in that case =
I cannot reject the push because the changes are already on the server). =
Is there a way of getting the commit messages before they're actually on =
the server so that I can reject the push?

Thanks in advance,
=C3=81kos Tajti

