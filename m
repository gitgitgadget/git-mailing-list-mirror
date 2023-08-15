Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9E5C04E69
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 04:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHOEQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 00:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHOEN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 00:13:59 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553C1BF9
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 21:05:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40feecefa84so25505781cf.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trimble.com; s=google; t=1692072336; x=1692677136;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP/ehOGHyfszz1Ij2w9sqRy+mI9ZoMoPnA0q/jpgveg=;
        b=eGDxSWmkprz4fFhN7qn932tVlmUf4IVJnp6nSEQz48DETD19KHzlbJrLxGPUUBu0Nf
         Li6O43e0FBjQBwVsL9U8ZlHh+0qsfB/z7sB1XyrjBXjr8b/jWHtDTNSoujcTdkJTsje+
         M5aGybZS+ThTDioQ9I4T4MFmObBZ/o0w/xOrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692072336; x=1692677136;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP/ehOGHyfszz1Ij2w9sqRy+mI9ZoMoPnA0q/jpgveg=;
        b=R9F80uyA2lVIhD926s1tf69sspamHfJ9180Isi7aImDbZkyB1q3URcT6xKi+hjCmwC
         /FVoOqHigFrSZT2l/LVA+dbHQgFatd0uUjF5dUlzgP29Y53k3RHui93bj2nG+qSapS6Z
         sHZTn5aFSbhEMXZjR2ajLInnTvk407cmgORylnnrwnY71b1dkE3maFjPeYA6p0tpuhaT
         FQZG5C6YWm9EaH4dgnVG4gTN+JJZ6UMMcAyEQkHL1wE6CCUaJiwHtSZVcUkVndgnk5JL
         ywoxy8lO+02xFWBXevnq6zlE+EYvKWllLmTg1eJUXQ6LIdApAKjAAsy2qTA05QGdtVwe
         3gyg==
X-Gm-Message-State: AOJu0Yx9scPdFW12hHUo4cwMuM1NpaL0K5I4dCAz0bbBynsUxNRYOrxS
        qWj2e5MG3Q6olvUQWNOC8BUhK0WkA6fWuVHEnt+3Bl5OKqAUo8otUvtznvDn0RGXtkrTybuFAoH
        0bNuTTnLmVVbZqY7JpjrFRxxbzJvfNIzbwFAAcxkNMSJQcNb1JiU7Mq3Vtr9yI2iS7xc41F1cHA
        Vvyras
X-Google-Smtp-Source: AGHT+IEjEPK576RJT8V3F1A8YTcTcyWlsF26bIZD0UgiNo7XhBsOHSQWbEZvmAeShoV/aLJzXWtpAg==
X-Received: by 2002:a05:622a:1a96:b0:40f:f1ed:982e with SMTP id s22-20020a05622a1a9600b0040ff1ed982emr12562727qtc.3.1692072336334;
        Mon, 14 Aug 2023 21:05:36 -0700 (PDT)
Received: from MN2PR03MB5072.namprd03.prod.outlook.com ([2603:1036:302:40e7::5])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8468d000000b004033c3948f9sm3576566qto.42.2023.08.14.21.05.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:05:35 -0700 (PDT)
From:   Grant Singleton <grant_singleton@trimble.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Corrupt repo with force push when using a reference repo 
Thread-Topic: Corrupt repo with force push when using a reference repo 
Thread-Index: AQHZzy1855qVoxCaE0STi1T7RadJRQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 15 Aug 2023 04:05:34 +0000
Message-ID: <MN2PR03MB5072F08C68E7F32C9F5AC866A614A@MN2PR03MB5072.namprd03.prod.outlook.com>
Accept-Language: en-NZ, en-GB, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!=0A=
Please answer the following questions to help us understand your issue.=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
With 3 clones of a repo, one on branch-a one a mirror,  another using the m=
irror as a reference repo on branch-b, do the following=0A=
=0A=
# in the repo on branch-a, make a change, commit and push=0A=
cd bad-object-test=0A=
echo $(( RANDOM % 1000 + 1 )) > file.txt=0A=
git ci -am "change a file"=0A=
git push=0A=
=0A=
# do a git fetch in the reference repo=0A=
cd ../bad-object-test.git/=0A=
git fetch=0A=
=0A=
# do a git pull in the repo on branch-b=0A=
cd ../bad-object-test-with-reference-repo/=0A=
git pull=0A=
=0A=
# All good so far=0A=
=0A=
# in the repo on branch-a, discard HEAD and force push=0A=
cd ../bad-object-test=0A=
git reset --hard HEAD~1=0A=
git push --force=0A=
=0A=
# do a git fetch in the reference repo and then prune loose objects=0A=
cd ../bad-object-test.git/=0A=
git fetch=0A=
git prune -v --expire=3Dnow=0A=
=0A=
# do a git pull in the repo on branch-b=0A=
cd ../bad-object-test-with-reference-repo=0A=
git pull=0A=
=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
=0A=
the repo on branch-b does a force update of romote tracking branch branch-a=
=0A=
=0A=
=0A=
What happened instead? (Actual behavior)=0A=
xxx> git pull=0A=
fatal: bad orefs/remotes/origin/branch-a=0A=
error: https://github.com/xxxxx/yyyyyyy.git did not send all necessary obje=
cts=0A=
=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
I expected the force push to succeed, but insted I get a corrupt repo=0A=
=0A=
=0A=
Anything else you want to add:=0A=
=0A=
git rev-parse refs/remotes/origin/branch-a=0A=
will return the hash of the commit that was discarded by the git reset comm=
and=0A=
=0A=
=0A=
Please review the rest of the bug report below.=0A=
You can delete any lines you don't wish to share.=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.41.0=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 5.15.0-79-generic #86-Ubuntu SMP Mon Jul 10 16:07:21 UTC 2023 =
x86_64=0A=
compiler info: gnuc: 11.3=0A=
libc info: glibc: 2.35=0A=
$SHELL (typically, interactive shell): /bin/bash=0A=
=0A=
=0A=
[Enabled Hooks]=
