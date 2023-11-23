Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIp3YQ6H"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B56210C3
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4079ed65582so7296785e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761450; x=1701366250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l2PJTPfbycDoDr93RRdPw74cIgzmF05P4xvYZkpcuTI=;
        b=hIp3YQ6HRsF6z4++znT4UsUx4PcWHcjVjquJiAQ8EEANF+V2I8lVbmgdKFLgFP8gMP
         ZBnBGhkIT4z3s5gvrxUUj10y6fmmHPJrpNCpU2hmL5UqkJW1oCH+cXXMr9+VOt31C3gS
         GxbzGb8xr3uDKzGCxsQZmZe3mgJig2fr5GU3LTb507La6ddMf15PXrtMvBw1AV7aKT/6
         sCFfgYLxPBCGALNmE6iMTbD6ieHsOSjAHFWOXrVVA9XfG9arcwQxXjfQJh+SAztMQYmu
         zGhsmyZjrEC3jmMDEXklcj0vEL2bq4G5g8eJPi2+tsuRNRTQWfy2LzgSRvvyFYRos9yP
         ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761450; x=1701366250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2PJTPfbycDoDr93RRdPw74cIgzmF05P4xvYZkpcuTI=;
        b=i+zAxKqjDkIrIwlcIiwjbJK7zgvknf6wRwgDblnIJ7IGvwP0XLKlKDyVrPk0C+Vvv4
         n6N3AJHCrAIOz0KW7MImrXDlfliZnecHdnesMOehuNYYPqW7F6jzOs7xhHqmXxfC1Yse
         9yU7n/c6Siy7BKsIh20lUbwtN34Ffsdc994dd9a4ecUT+90cRw56uH9ZhJ5m+UGUZ+0V
         LLrDO6RmqDHP0MWSyIoWKoWwY+rQVF251p5YZazgS9JOk51tJPT0vUBor6VV6TUVqRet
         w5Z1nQbJrIDgw54qTHY4Td/MSN85nSBr5HeuRvm/FbvIHp4sxtLtlWyGYewKc7e1YOwU
         YEFA==
X-Gm-Message-State: AOJu0YzgeNdyUQyBrE1ITLjkp3Slb4RK6r9Rt3KA6xrXu8gdFj8FjNvQ
	INSUUA9PlAYNapKdh47NZKGWtH/MQeg=
X-Google-Smtp-Source: AGHT+IFYxBcO5e+9Ger1Fd8gYbG8F1UUyTDDxmaqU75hmx0Q3dZfYgsJKQu9K0lOM9CsdYjvRaurTw==
X-Received: by 2002:a05:600c:470c:b0:402:8896:bb7b with SMTP id v12-20020a05600c470c00b004028896bb7bmr205739wmo.6.1700761449503;
        Thu, 23 Nov 2023 09:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c37-20020a05600c4a2500b003fee6e170f9sm2594515wmp.45.2023.11.23.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:44:09 -0800 (PST)
Message-ID: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 17:44:04 +0000
Subject: [PATCH 0/4] Sparse checkout completion fixes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>

This fixes a few issues with tab completion for the sparse-checkout command,
specifically with the "add" and "set" subcommands.

The 4th patch should probably be considered RFC; it is notable in that we
previously discussed a much different proposal and the general problem
area[1], though our discussion was from a limited vantage point and none of
us (myself included) were aware of the full context at the time. In that
thread, Junio gave some helpful general high-level guidelines for
completion. I believe the existing completion rules fail Junio's guidelines
pretty badly and that we thus need to do something else. See the lengthy
commit message. I implement a simple though somewhat suboptimal choice for
that something else (while arguing that it's at least much better than our
current solution), while also documenting with a code comment a much more
involved alternative solution that we could consider in the future. Comments
on this choice welcome.

[1] https://lore.kernel.org/git/xmqqv8yjz5us.fsf@gitster.g/

Elijah Newren (4):
  completion: squelch stray errors in sparse-checkout completion
  completion: fix logic for determining whether cone mode is active
  completion: avoid misleading completions in cone mode
  completion: avoid user confusion in non-cone mode

 contrib/completion/git-completion.bash | 95 +++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 3 deletions(-)


base-commit: 79f2338b3746d23454308648b2491e5beba4beff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1349%2Fnewren%2Fsparse-checkout-completion-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1349/newren/sparse-checkout-completion-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1349
-- 
gitgitgadget
