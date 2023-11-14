Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CC33061
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btzjdzdT"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EAD6
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859dee28cso50692785e9.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699998262; x=1700603062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eztFh54zYeBEkSgRq2vC+goA5MyG5bRn4dt80lvyaSk=;
        b=btzjdzdT8EjbimHtIkrjbEPb4ux8GsWLmw1FIvKMq6kIuEgnmc5Mq238y8XD7poer2
         Z6Me4eEjydSjT2U5RmRUZTWCtnssUoqw3Y1lYo3VDcnZIwXBvPxmMkzw9ocFUNHtwzJO
         vA7YMuz0OLI5HKe+5I4gj0rYJwQ2pVgfytpmDCWcwyNl6KFYY60UfAehNgsUifbvMzU0
         Rd1zOTUyK/L3CzG1K8eaC1YO+WgfGS7k/m4okfpLH6Z703V9Lf3q333X7LmCi1TXXHVk
         63nDFQ5syRJkMAxcaS/WhV1+r3FLwodshYa8fFR80d66nhlz0HJV+b1j15uElrZS5pQ2
         ihJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998262; x=1700603062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eztFh54zYeBEkSgRq2vC+goA5MyG5bRn4dt80lvyaSk=;
        b=ZfnbW9XyeVJt4GpyA4a0uZuk+WIXvGXcmYgTNYKAAknw+jTMNyeAX37rR+Hxs93uDr
         xDinPrKlv7ffTDLl4W5cqaa2ze8VIZFvRTX7KNAtajus3Ycw6EfiXCU6LXSHyHOBB1nf
         cYGn2YGoKf5t0lmncMubLXn/K6399U8//fqAaTEOX91V7UcoD6QqgjGDyfkHK+cpA10Y
         dqtJL7wbm43MPOu8APJ6BR2wxX0YwX0IZ+JOSf1BBn+CwAksUJrTZkDgd3vgdVsFDtkv
         W6JW7tHqbYp08LgaMqq/ElVXmq7enHg9qQLib111xYk7uVfYd8zANSpDsotMpZXKtDmW
         CPag==
X-Gm-Message-State: AOJu0YzeNMX2lZnndU84UHAH4fsrBYsl7MCaYDvVg6bs+GMId4hDWC19
	GEicq/XIcZt9AYBhKbFAK+oi/Sdt44uU0A==
X-Google-Smtp-Source: AGHT+IH/xrBstzzSIblMGEpRb8oWBb59CtdcSDhtC5CqH5lK8G6KqtWjH8O4CjmXyzMSL3RDfK0nFA==
X-Received: by 2002:a05:600c:4584:b0:409:5a1a:fe16 with SMTP id r4-20020a05600c458400b004095a1afe16mr8162832wmo.28.1699998262196;
        Tue, 14 Nov 2023 13:44:22 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040651505684sm12804379wmq.29.2023.11.14.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:44:21 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 0/3] rebase: support --autosquash without -i
Date: Tue, 14 Nov 2023 21:43:36 +0000
Message-ID: <20231114214339.10925-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc2
In-Reply-To: <20231111132720.78877-1-andy.koppe@gmail.com>
References: <20231111132720.78877-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rebase --autosquash work without --interactive, but limit
rebase.autoSquash's effects to interactive mode, and improve testing
and documentation.

Changes from v4:
- Fix amend vs apply backend thinko in commit messages.
- Squash patch 3 for testing into patch 2 and improve the commit
  message.
- No source changes.

Thanks again to Junio and Phillip for their reviews.

Andy Koppe (3):
  rebase: fully ignore rebase.autoSquash without -i
  rebase: support --autosquash without -i
  rebase: rewrite --(no-)autosquash documentation

 Documentation/config/rebase.txt        |  4 ++-
 Documentation/git-rebase.txt           | 34 +++++++++++++----------
 builtin/rebase.c                       | 17 +++++-------
 t/t3415-rebase-autosquash.sh           | 38 +++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 12 --------
 5 files changed, 58 insertions(+), 47 deletions(-)

-- 
2.43.0-rc2

