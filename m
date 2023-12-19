Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27431D149
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klerks.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b="Ck/CsGn3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553729ee917so2756874a12.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1703002243; x=1703607043; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmX0g6gtpIVjEkgnN+CGA8kfPfevDZoUuzyY7Jkuoic=;
        b=Ck/CsGn37aMIEG00cEWSCKnArXptKO63p/jXRs3vGQ/bZgLgNxzfUoJhnXpcT947HV
         vrvj4koWKWr+ukFPI6qE/4G4napN+IZD6aFyMCmX7DQuZza/8eYMwggDfs6kyeEzbiuC
         BRZBjGfz8BWTP1c8P7ATfej/GH9kB14tFfYak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002243; x=1703607043;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmX0g6gtpIVjEkgnN+CGA8kfPfevDZoUuzyY7Jkuoic=;
        b=w+v5/Dq/eMOyFSXr+p/4TVIdaUoxjgkisQUCf43LsZUQ8DedBZ41Il8VqYrIx2fc3M
         dWqu3SlIocEWQjO6IM7ePpO2SYmcBqNFi9AGO7gmJrloCee5WYJylx7k6Z+vpZ6gS9dA
         Ne76mA0P90rembr7tX8iLtNLprEvMgCbrvm1XnzJOoqHMZykB/jTw+9wLeRcMxh6/GAk
         ziq0dBW6exEzYunMH4SpY3xo7Sg0MJztLHM+7E+uFIZqgXXzIZD014pVwZwSxw+CprUh
         tl6lc6IQxJWrDi20q8sQvgBulq0Lg1O15v8NTH7aZx3Y0OM0xC7I9b6/2B0yWeqSJYl9
         BF/A==
X-Gm-Message-State: AOJu0YwU/I4DJKwZqEmQjlTsPqRlbXOx8QXpNr1U4Hurz+hLRhyPzfMA
	sx8Xm/PkvrohMlWJRZ+AYnIKRhK79Xw4wuRli6nlIDJLhkNzCiB45lMekAW+
X-Google-Smtp-Source: AGHT+IEWzE41Y0ouRj4kwEv34tQ+7+J0H05k1uneBar44Rep773vKJvg/uxP/+TK+ykKW5b6HAOPvbFrArPY3iz+iaA=
X-Received: by 2002:a17:907:9854:b0:a23:6e93:2be0 with SMTP id
 jj20-20020a170907985400b00a236e932be0mr969151ejc.72.1703002242669; Tue, 19
 Dec 2023 08:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao Klerks <tao@klerks.biz>
Date: Tue, 19 Dec 2023 17:10:29 +0100
Message-ID: <CAPMMpohbQK+3o46iiY+0o=vS+UC_HBB=CxsNT_hAb5dDz+514Q@mail.gmail.com>
Subject: Is --minimal ever not the right thing?
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

A user today showed me a situation where `git diff` (and `git blame`)
seemed to be doing the wrong thing: where two big blocks of text were
removed from a file, leaving 4 lines untouched in the middle, the
default diff was noting all three regions as lines removed, with those
4 "untouched" lines as *added* in the same place.

We compared to another diffing tool, p4merge, and that was showing
"the right thing" - two deleted regions with untouched lines in the
middle.

We realized that `--minimal` does "the right thing" in git, and you
can set up `diff.algorithm` config to use it by default in `git diff`
(although `git blame` doesn't currently/yet support it... a small
enhancement opportunity there :) ), but that raises two questions:

1. Is there any practical reason for any user *not* to set
`diff.algorithm` to `minimal`? Has anyone ever done an analysis of the
performance cost (or "diff readability cost", if that is a thing) of
"minimal" vs "default"?

2. If "minimal" is just better, and its higher computational cost is
effectively trivial, then why wouldn't we change the default?

I suspect this comes down to situations where git does big diffs
behind the scenes...? But I don't know offhand.

Any feedback would be most appreciated!

Thanks,
Tao
