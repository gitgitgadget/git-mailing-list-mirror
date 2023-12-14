Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXe/NTo4"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7560ACF
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso2951655b3a.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563231; x=1703168031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xaz8QUNp74xM8bl73p4VvtgDU7aS99bbuavivXhTyUs=;
        b=UXe/NTo4TL98JG80/lOi/Cq5NXKJ4PSEw+hEyG3mus1I4EjE1T5mNYKfSsFi50Ae1S
         Wr2++48nenyi2LAl3KOPHd5tKR5SwjXRUIGKBvogGNBD0VeVWrr3swrjxO7f9KbDPByB
         RO1lqIRIurqn0jEQk7p4EnbaEzv6jofSbJIVCqXj0nGo2yuMjmp7Jrw5BfILxWXOlv2P
         OLDQodq0mLNeqQF+WMXp+7moZvDLd7HyKLF/Kk/yl2g8JVLH3jZA4xQCIidNzenJwcyi
         +Q/34Gv3EwyZ2vcM9WoDkVZ2Gt6Ev7bR7Z9XFm/idbPbLDtQwBuFsFmkp7LjgNH1d79R
         cAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563231; x=1703168031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xaz8QUNp74xM8bl73p4VvtgDU7aS99bbuavivXhTyUs=;
        b=bOx5tRs2Wl3Wo7N4ZDMWA2UHV+eZM8kpYLl+LEI8uNQeWtsUefDYG3eIeJaDAIhNYJ
         DWI9oO/ycNfqTg2yCsx7sLXY3+jV7MpvfEZzBenx36XmTuDnRu+4bg4FeeooSQJ4uSvC
         Tm5JaifEHQiz/C8CDeTzX2+VpO4RFf/WzxOK9QwOBRq9BCTV7c8GcE/pZJu0mwAOzoFX
         ryyTqcss1qjoDyBCIHkWew1F+QG3T5nFxbiMt/RPaVTNimfYw1EZU/MRzJLfPjj7OwJq
         +kGoSSVQhJZYkAFoOJmfsZBqs5sicXWhCvzZUaecWfF+Jm063aSaKVuGZaCpXz8+YIs+
         5gwA==
X-Gm-Message-State: AOJu0YwaF61NDuJN/+nyZPL2ct23iOiNkw2dPaqN9EF5mvD822+8G/lH
	IqKlVm2EEiRtUuyGUf+izU2Iidpb51s=
X-Google-Smtp-Source: AGHT+IGlNh7rKgAmQCwl9B+HJG9L0ufQVdYmrvqiuO9CAbA0kW0CiDWYiB0lD1yEgQcemyhxmu/ZKg==
X-Received: by 2002:aa7:830f:0:b0:6ce:558e:de91 with SMTP id bk15-20020aa7830f000000b006ce558ede91mr4537557pfb.46.1702563230666;
        Thu, 14 Dec 2023 06:13:50 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ce921da705sm11806232pfl.136.2023.12.14.06.13.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:13:50 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/4] transport-helper: call do_take_over() in connect_helper
Date: Thu, 14 Dec 2023 22:13:44 +0800
Message-Id: <af8fd2a4eb8783be4a62973bfd2135da4568570e.1702562879.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com> <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

After successfully connecting to the smart transport by calling
process_connect_service() in connect_helper(), run do_take_over() to
replace the old vtable with a new one which has methods ready for the
smart transport connection.

The connect_helper() function is used as the connect method of the
vtable in "transport-helper.c", and it is called by transport_connect()
in "transport.c" to setup a connection. The only place that we call
transport_connect() so far is in "builtin/archive.c". Without running
do_take_over(), it may fail to call transport_disconnect() in
run_remote_archiver() of "builtin/archive.c". This is because for a
stateless connection or a service like "git-upload-pack-archive", the
remote helper may receive a SIGPIPE signal and exit early. To have a
graceful disconnect method by calling do_take_over() will solve this
issue.

The subsequent commit will introduce remote archive over a stateless-rpc
connection.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 51088cc03a..3b036ae1ca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -672,6 +672,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

