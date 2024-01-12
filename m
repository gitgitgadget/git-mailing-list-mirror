Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C0171DC
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXzdv9GL"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b71b86ef81so1340362e0c.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705096270; x=1705701070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ34p2PYPLiq6Pu9slFNrINKQEPeQ5YUBt2NT4eyZtU=;
        b=nXzdv9GL567/W6WsFDVMhXw8YzQHUsgDQYh794vV2I9N2eZRewxxb2G509T3gq6KB1
         +SaWuZraTHmwon1IuxkWbsbiR/lfMV6rYoYBo7XhCi4R0J85SOzVKVBG08z5YmwCSSU3
         ngYpB8RPKZqf2Rmrn2jfJ4B9Qd+byX2FcceuQaEQ6gV0u8vMmdVNDEHc7frDD1SOVxbK
         jNUMAhiEzX5cNvBVAfVRSi0Bzxp89awufhFLORfEADOlhn1SPHt/yT3rknfNSpjD5dpG
         weDtXm9UfK8DBOB/uG8fQ+OGQ5I7GBh+nF/RujKLYkOxe2GnFxrcVAvQ6XOqsTzNYZLx
         jVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096270; x=1705701070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ34p2PYPLiq6Pu9slFNrINKQEPeQ5YUBt2NT4eyZtU=;
        b=sAgzzvbazghqw4/l4fzi1uwuXQTFhmphf8uKNtBGiyLa2hzQ+Py3geZ8RWpkLf9EXH
         3v01AfOfOyfxb6A2gOS6OfUx347mds4U6RCzEYUXa/0/WogSytaiyF9uYzWTRdAdqVUv
         HU/W4J2UfwfuuEDq2rXsp9R6tlCqd+NCvGKjc5FCHWJQPXU9rgqokdnRvq1uZ2KlZzpc
         mPJWTye8yHTYO//WUIbVFgkdz6vXevqQJhiri4ACrIpMlM3pWAnyk3V/6rzbhWAOgqAE
         cr96FbeUc47mhodEX3msd81n2HaTuNx0HKfm1FzKq1SAjsSeQX7g9zS23tR95VmHfUgF
         Z39g==
X-Gm-Message-State: AOJu0YwgCDVow0I+pP7uXkNBzOQJOQUH3SDQkR5xbGRJl9CW8aaOcCKR
	SptxyyW9PbIbg8T4V8SGtlKgPjz1F68l4N4xqrlo2V8OxOB2
X-Google-Smtp-Source: AGHT+IEqFF0J7BBgXg9tGzC7GeQH2kVmwIFPhYyCkDd1rwo1RH29iNowURugMhuwJZm2kPtn3u4RCgogflrSO9G05vk=
X-Received: by 2002:a05:6122:4491:b0:4b7:8199:5d17 with SMTP id
 cz17-20020a056122449100b004b781995d17mr1726316vkb.25.1705096270496; Fri, 12
 Jan 2024 13:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com>
 <xmqqply68c87.fsf@gitster.g>
In-Reply-To: <xmqqply68c87.fsf@gitster.g>
From: Raul Rangel <rrangel@google.com>
Date: Fri, 12 Jan 2024 14:50:57 -0700
Message-ID: <CAHQZ30AZjqC9t9xDo407FEo3sDUDOSApOwMP_3Pm2nv7itttQQ@mail.gmail.com>
Subject: Re: Make git ls-files omit deleted files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 2:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Raul Rangel <rrangel@google.com> writes:
>
> > I'm trying to copy my current git worktree to a new directory, while
> > including all modified and untracked files, but excluding any ignored
> > files.
>
> Curiously missing from the above is "unmodified".  You only talked
> about modified, untracked, and ignored, but what do you want to do
> with them?

I guess another way of saying it is, I want to make a copy of the
worktree while honoring .gitignore. i.e., I don't want my copied work
tree to contain any ignored files.

>
> As you are grabbing the files from the working tree, I suspect that
> you do not want to base your decision on what is in the index, which
> means that ls-files might be a wrong tool for the job.

Hrmm, that makes sense. Do you have any recommendations?
