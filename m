Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCD39FF4
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doCgQLcY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso24410825e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704813938; x=1705418738; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQd0bKtL/7jT69no1nyRnQFuuGdfCR+qPyezbElScT4=;
        b=doCgQLcYzuvvR6VpKy2sUyoBttzQWFoszjf5ZQhrrEcvyLXJ44roFqxTVgLYq/pgkM
         AUCELLJKKS3Io0QWEG0kbSk2APm0cS9frbK7LR9lg9DP8TY1OgXev7OjQOPaR+FWe/29
         vnl4455yIF+fr28LJXX7pU3S8p8odsz1jm2hgckqN9SWLdbFJtlLvYT1PsRyqHOgDigQ
         welrH7uUm8UXBc0jRStsLp8HdNHszrd63LCJBLHx0jLvSfbnRE4o+wYTHubOrYxOMYG3
         /vrpUfDzz9R6qfjpDM89RiiRsXkh6ABbSeIk8jW3CUzBkFGBIBCM8tVb6Nj7wLamql9b
         fXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704813938; x=1705418738;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wQd0bKtL/7jT69no1nyRnQFuuGdfCR+qPyezbElScT4=;
        b=QPSgZTbBzj1rjAq3+swUskWUGGoNY3yviTe5hlKt2h71T5DzaTK9vI9K4eTNqlBE09
         CFVW4NZNeafcG3n37xWvbfvIlhCR/kuXE888jCISz16WAS+pKsQcB7fB1mExr8sWb1yE
         SCx8q023s2aOtcdhF9LllhyyeznLqmaflgpq7zHxakUpzw5TMFF+CRR5Mbb+WOyCeI51
         vJyN75maxTZbB5DuUQauD33fhRqIFtORVxjn4YLwxTAJLD6dph4DCb8B1md5rO9GUFh8
         UF+p3R7NHiqsOoAstwQQ+9QqolOSJKIZRn6lJAjraHuk3LfzBxVuNt7Ofvpr5wgfocys
         JnCQ==
X-Gm-Message-State: AOJu0Yy2rKW05DJ+0pcbekWsU6689rehEUcHpDyqX6IQH/ufS8oeoUlX
	IRfM47cNHk+vNWJ1Q3kAK2mraKE2nBA=
X-Google-Smtp-Source: AGHT+IFNkkYsF0tODMkaps52s38X6iJaOGdaoh0/X96N2WHdUF6daJHyYpStOge8yVmv3C4G8S81Ow==
X-Received: by 2002:a05:600c:3514:b0:40e:3dcd:2e24 with SMTP id h20-20020a05600c351400b0040e3dcd2e24mr2795682wmq.180.1704813938406;
        Tue, 09 Jan 2024 07:25:38 -0800 (PST)
Received: from gmail.com (228.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.228])
        by smtp.gmail.com with ESMTPSA id f3-20020a056000128300b003376dbc75e9sm2646329wrx.14.2024.01.09.07.25.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:25:37 -0800 (PST)
Message-ID: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Date: Tue, 9 Jan 2024 16:25:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/3] allow disabling the automatic hint in advise_if_enabled()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using advise_if_enabled() to display an advice will automatically
include instructions on how to disable the advice, along with the main
advice:

	hint: use --reapply-cherry-picks to include skipped commits
	hint: Disable this message with "git config advice.skippedCherryPicks false"

This may become distracting or "noisy" over time, while the user may
still want to receive the main advice.

Let's have a switch to allow disabling this automatic advice.

Rubén Justo (3):
  t/test-tool: usage description
  t/test-tool: handle -c <name>=<value> arguments
  advice: allow disabling the automatic hint in advise_if_enabled()

 advice.c             |  3 ++-
 advice.h             |  3 ++-
 t/helper/test-tool.c | 15 +++++++++++++--
 t/t0018-advice.sh    |  8 ++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.42.0

