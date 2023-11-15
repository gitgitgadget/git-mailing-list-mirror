Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZu7cD9r"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAF1A7
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 15:28:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0737dcb26so204739276.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 15:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700090909; x=1700695709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/itm4cLR+Lgi0ducXsrCUUgWvMQ/uUpV5Oprc067i8=;
        b=dZu7cD9rf6DCVOCHrJU7LIZgQUFxVRd3vERBFHpw9DUlItyhwYAhxWDIQXJ7nDtQG1
         Ms34ZFdoRlbLxr2shqRQaCtfMtJpd9+bCecVHfjeo4FGewRu1NsupcNCThs3eCdaOrw+
         6Ta8AwZWAKMYShhwvlXhwSha6tCGQJY1qFuuhHDDYtsfpOFJDrYGfEMGgTcNH7+eygnA
         bJxB5ElA0hzVHa3Oet/+Y/50f7EU2MIhGVwPnTc2mH4mTXw6Eh0924z8ZlT73lTezK8T
         Ax9RvCszNr/Ocp+W5EdFPpw6JihECps0qLhk4vc8ut/MFvxfGBHFVgfHj/E8cpQ7OH0f
         u6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700090909; x=1700695709;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s/itm4cLR+Lgi0ducXsrCUUgWvMQ/uUpV5Oprc067i8=;
        b=Shz0xcf4TrjP6P8Nh6ZZEHT5i2tS+W7QdKhW58nlAlklL5lS7iijJ4PWlZKwHOEjqz
         7GsEnYbAvrh6l9SuVdQLbMZq6SPyluJn8Bd0Q74KAGabz+NDlntnnaK3YbTydFntsk1M
         N19Z4c3Xf9Hf2apclBvMAvZ/ls53g+QDSWmwlVlYHOIB/QhBDIqK8TaFPR2MMjmhbG24
         QMRiwCdwkc05b1OdbFPjPhikkwja0xS4Si7OzFLHwmlb0ueMGOoJXF9MujiIx0ft7Nr4
         GIqECdrU2bbbCCAqfWBMNJHCbZ7O98HO7KbVCaXSHcwgTR9XJscR6bVVC6xIFhaPq6q1
         FClQ==
X-Gm-Message-State: AOJu0YwOfh0lexz+YE3vdbTwTzy6+DfLBIS7fuJH/55O2sqyWof35R2x
	S9yY2ksjfa0oWLFvUY84cN0z2xDFYyys3rjJtHia
X-Google-Smtp-Source: AGHT+IGqPV2QHW5ZqM7hoQmz4VATjHqp3/EfuyvzhDD2Vd/8eDcQlOrePB1K668O0AqhoqG6tvdfIKgLueshvXeZlHvV
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1597:3a5a:4486:9564])
 (user=jonathantanmy job=sendgmr) by 2002:a25:cac2:0:b0:d9a:58e0:c7c7 with
 SMTP id a185-20020a25cac2000000b00d9a58e0c7c7mr327757ybg.1.1700090908993;
 Wed, 15 Nov 2023 15:28:28 -0800 (PST)
Date: Wed, 15 Nov 2023 15:28:23 -0800
In-Reply-To: <CAGE_+C4mUw8U6YK0m6hRvcqriv4pWdsELpyRJBCY-LrdHjWwgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115232824.2507648-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/5] Avoid hang if curl needs eof twice + minor related improvements
From: Jonathan Tan <jonathantanmy@google.com>
To: "=?UTF-8?q?Ji=C5=99=C3=AD=20Hru=C5=A1ka?=" <jirka@fud.cz>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ji=C5=99=C3=AD Hru=C5=A1ka <jirka@fud.cz> writes:
> Proposed changes split into several commits for clarity
>=20
> Jiri Hruska (5):
>   remote-curl: avoid hang if curl asks for more data after eof

I've already reviewed this [1] so I'll summarize what I think of the
rest.

[1] https://lore.kernel.org/git/20231115192027.2468887-1-jonathantanmy@goog=
le.com/

>   remote-curl: improve readability of curl callbacks
>   remote-curl: simplify rpc_out() - remove superfluous ifs
>   remote-curl: simplify rpc_out() - less nesting and rename
>   http: reset CURLOPT_POSTFIELDSIZE_LARGE between requests

Overall I can see how all of these make the code clearer, but in a
long-lived project like Git where it is very common to look at code
history to try to see why something was written the way it is, I'm a
bit reluctant to include 2/5 and 4/5. I think 3/5 (removes an "if"),
the part of 4/5 where we set "rpc.pos =3D 0;", and 5/5 (sets a parameter
that one could expect to be set) have significant benefit and should be
included, though. Having said that, I don't have strong opposition to
including all of them.
