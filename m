Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EE3D0C9
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+DWcG3X"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b9d8bfe845so4013912b6e.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024075; x=1703628875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS8j8uqPeYqNWgsRQQgucWkQU/CGWqXYHIQRHVvhe3Q=;
        b=M+DWcG3Xiv6YnAMTKWqOYwAKUj94cbKJiiMEfVoBewwI5vK9Hru2QL+ZzmW5vNvQa1
         RTDPv5nnAAbTLQ3X7qqagP/uxuriQAfgL8gXJh5EK334YXSQVMHLXmbL7rZlqfcmmHCq
         TEOS4YVJIIjnUDVXoRprrZjPQ92TYJwbNCdBetlG91vOXEhOhFkWoTk9PAW19BnP7OuT
         Rdd6hrfQdyZSucc5qdh6Dl1HQIeeR6ka6aYSIZeXKmfNvpR24k1ohcpgmxKWhKziA7b/
         MqRlzAlAKo2XB6lCsS2WbLSBh0EUV5+/u8h9EdlnCPu1egffW5MrTc2hNGbddgIADB+H
         mX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024075; x=1703628875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS8j8uqPeYqNWgsRQQgucWkQU/CGWqXYHIQRHVvhe3Q=;
        b=mtWUlD74lF1NPfZ3Ryi0K5J44cdMlqV3d1tJL1U+Ncp6P26Ct0a9/to4bbZAwz1Wjk
         Mv714PI3mlFmTTJQGLNHjo6DjEGbYywzpRQcPzw3HmB+tuUrW7oZIaxxEm42FxpTXdPc
         iFRSf6nl6KXf6jZ91LXM/W1B/9e+aNiUXd4Cd1PRPoMhWyCLyvbVGCfdr1GbTjlRGMMj
         mEXTwN5SQCXSOp5OvdU0qOAan/Qkn96hHnk03FsQFT0eGa1sJIOuceiltOfnyfc0LJSX
         jSx8UXzbci8rdPKSkHqmfjAN+5Oyzav2HssN11oXPmA3tCYeGCGawqRK8delsLXAr/t2
         aDAQ==
X-Gm-Message-State: AOJu0YymGZX/pX/v+exacKnxZ21RUG8xocjjezi/pjXvuq2D8TogLIDB
	9t/CXcJPF5OGtLn05QknapkvaCeWGKQ=
X-Google-Smtp-Source: AGHT+IHjEF9IHh1EF2X0Pchtu+RZpFjTZUkFK0nLGhTUjbhFK87gLujdgrh6Xo05eQL16urZW+JddA==
X-Received: by 2002:a05:6358:91a8:b0:170:2b30:6597 with SMTP id j40-20020a05635891a800b001702b306597mr18123813rwa.8.1703024074597;
        Tue, 19 Dec 2023 14:14:34 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a190400b00288622137dfsm2360255pjg.5.2023.12.19.14.14.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Dec 2023 14:14:34 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH v3 0/2] completion: refactor and support reftables backend
Date: Tue, 19 Dec 2023 14:14:16 -0800
Message-ID: <cover.1703022850.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130202404.89791-1-stanhu@gmail.com>
References: <20231130202404.89791-1-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the review feedback:

1. Renames the '__git_ref_exists' helper to '__git_pseudoref_exists' in
   the first refactor patch.

Stan Hu (2):
  completion: refactor existence checks for pseudorefs
  completion: support pseudoref existence checks for reftables

 contrib/completion/git-completion.bash | 43 +++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.42.0

