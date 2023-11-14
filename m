Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237D1863F
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fadTXO80"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31BA4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:16:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c83ffcdbe3so30449151fa.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699956991; x=1700561791; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vOsrWKMeAd3q+HcN5iTwaq5NjkYmdtDFqF4FzsjCqis=;
        b=fadTXO80fUraKAhYoGW+h8RMw+xTVKXOfcVjdLqMUaPx3o/jeJqsBoglGytxkjDxlt
         3UvHzBlSj7amJ2K5/Sp8wsRcZwYdHnWBaD5N/+9fuDiajf+L03OyoT7RPOFKhJ/ILDow
         kB0vM8VXXDKEMgi8YLU2MMqRjp5hSmZb4tHhiTc6NkrArc9cGOuWAWp2QHFobq3bSEjC
         uEccRJjFkIHkEIt0i3DDecOQP88vGkPX49Szgf7AvbVLPX97iC6m7L0+C1YAbjyGnR8Z
         FBfSdfIz/LFM6KTw/mZMg6k221de+ipKECCYixz5fDwAJTjOz8gUM9QPg47ZHwhhFNSM
         cn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956991; x=1700561791;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOsrWKMeAd3q+HcN5iTwaq5NjkYmdtDFqF4FzsjCqis=;
        b=tjjDa+NJFLb7CbrSqSFLai7/V+2b9UwPhK5rkP9DUdimeGBnYvuldSH/xpahixDh5w
         1/92G8aSRkM2+Eq+NapPtDZuqFuu7CWLvwlenwL8gGg8ca4rDHyCOQJmbUYok4WTlPOX
         vWQc+18C+3olnukQqRi7DZzYi2Ahvkj/LSROBsiNXa0LdGIpX36ycaeLzBsfalEWSDIh
         OQKjC8sqbNQUNsEEAvInbJX3sd7LyjtDF3DHeH1pFMd+7tDdDy4jWbFD6rZipPm4xP/k
         9BScN91xqYCQ5rjLsH8crTkl/sZ07IWEv61FJY+kTyMb1HPcGTsupIKD1epxscVufeyg
         2MzQ==
X-Gm-Message-State: AOJu0Yx2CrRBini+t7NkbCCBamcowiKca0zaseBBKyE31Aj9FRrYqhew
	znzwt+G3N8giRqxldJT0hF6O8PdgDZcpYtPd310DrubLYes=
X-Google-Smtp-Source: AGHT+IFf0dml83gQSSLQy1rwqFoPd5OEPNv1TwczchCCcMChEby9nUfusG2jCZ8hFgPrOe3hk910PXvRc7DKnklP3bo=
X-Received: by 2002:a2e:700b:0:b0:2bd:19c5:3950 with SMTP id
 l11-20020a2e700b000000b002bd19c53950mr1283619ljc.33.1699956991038; Tue, 14
 Nov 2023 02:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Tue, 14 Nov 2023 11:16:19 +0100
Message-ID: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
Subject: Feature request: git status --branch-only
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I am working on a tol which should fetch changes from a remote
repository on a user click. I want to limit fetch on the current
remote tracking branch (something like "origin/master"), but
surprisingly, it's hard to get it for all corner cases like a fresh
clone of an empty repository or detached head, etc. E.g see this SO
thread https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking/52896538

The most reliable way for me is to call

git status -b --no-ahead-behind --porcelain=v2

and parse the "# branch.upstream" line output. However, it is a bit
slow on large repos and yields unused output for me. So, I propose a
new switch "git status --branch-only" which would output branch status
only.

Note: workaround is to specify some non-existing directory, like

git status -b --no-ahead-behind --porcelain=v2 .this-dir-does-not-exists

Thanks
Ondra Medek
