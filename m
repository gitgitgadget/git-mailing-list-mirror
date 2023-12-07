Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrjqJSE+"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CE10DE
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 14:12:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1915034144so194977066b.0
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987133; x=1702591933; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Mm0OCqe8QpeKw0G+Ky4SqtlBbPd8p4ep27frbI6pYg=;
        b=CrjqJSE+X5MZ4rvXTgBdhX5WKmv/lG7ZWW6ftjOzS9lWJKS1XJ3uC2c4GXBlrHWYRm
         ObWKPXAWYDLggOE1qQ8a3a3sZs2cOYLJHJ3tRLAa4/qOAgYtrH5WWjDKWgdbOdTIyO+w
         NH6508Uhg/00wuUGkT6DTFPVdHYorUgSqPMlC8r2f62ZeMNQMQIex0tv76pbX1AqtuAe
         3UjxFGVphJU1jp4WrCv4cIEz+Q06pU+KzhxUpzxJykfAO2Xr5Pb3cfgGHXogDfixIhUV
         VzaFmxmkBDCofxJl+z3c0u+FKPB0AkeMgl516yU3Dspyv5QQJtj9N01sb+MiLORO/qqj
         Pi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987133; x=1702591933;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Mm0OCqe8QpeKw0G+Ky4SqtlBbPd8p4ep27frbI6pYg=;
        b=kUqNP2QEioaR4WwbFfY+7CBQKHdl5bd603jSpUuCEOJ1jgzmaa+cbBhSagIIgJu4v8
         zGwsr8TdDhS0yYAsLlX+nXTauLgEzEIWH4l8/jzUVwNG+vXpbjFQUlr0UCLMO70ne7eF
         aO/IIWTT6wI9d3sO/I3+FpgeQowwS8aqg6dQEJWg+6w7CGQX24jYwCuLc6qDeJBFdBVt
         FtUnYo0F2fSHrryVKCXqMssrQPgTyrLqtPfiI0WL2V93+v269AnGigKggRFNCCQRYFfd
         c+C49y8FMmyeVajDb/HOmV8b/xBOlw5aVWbUU4ZrhX5RFDwe2xRoGdomb4b9adZfA7G2
         0ujg==
X-Gm-Message-State: AOJu0Yy4hmO/C/SutHNlk0k8uShBY+gaJqDbN9Xfq3Bnfyr/xb8IRoxA
	3qfAQby3Idop5nBC1kXHiWQe/u0sZwZCBhepWE7aHRXBEVA=
X-Google-Smtp-Source: AGHT+IHIXY6Kc1ItH9lYuOtSc3gQ3e27xmAl0j+h17lb8SR1tyL+bpvX1U1w9+lvpnVcUuKwNKkLVgf7PPm6Sibdp/k=
X-Received: by 2002:a17:906:2459:b0:a1a:57e2:2cc4 with SMTP id
 a25-20020a170906245900b00a1a57e22cc4mr1876266ejb.52.1701987133010; Thu, 07
 Dec 2023 14:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Thu, 7 Dec 2023 13:12:01 -0900
Message-ID: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
Subject: [BUG] rev-list doesn't validate arguments to -n option
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It tolerates non-numeric arguments and garbage after a number:

For example:

$ # -n 1 means same as -n 0:
$ git rev-list -n q newest_commit
$ git rev-list -n 0 newest_commit
$ # Garbage after number is tolerated:
$ git rev-list -n 1q newest_commit
3be33f83695088d968cf084a1a08bdcde25a8d7a
$ git rev-list -n 2q newest_commit
3be33f83695088d968cf084a1a08bdcde25a8d7a
286e62e1b68e39334978e6222cbff187ecc17bcf
