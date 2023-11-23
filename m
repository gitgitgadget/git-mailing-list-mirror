Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuiynoiJ"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676010DC
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c8879a1570so14273261fa.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761450; x=1701366250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhdjFcwMeFtf9KqLxqQNOAWKxKUu7DGHAtTISD+MFi0=;
        b=FuiynoiJD/OnfQTnCr3Y2lvMor5QmR2zwwJX/65YaEtZzIIiHCkTiNYw/9cmdDX73G
         fmnQ9FzdB5YmE3gSLyp1lWBYwV5oQYI5KJWt5KUfsS1Oar3TKhTwFts0wYY34ittdHK9
         poTEUZVFqy/r+afYP45aUZKvCA3hpEBjdk1DzYvgiroHlB1qHA2Ur5PkDHWH7PPjw0hi
         /D/68v5pJq+RuQapx03/p6mkr59ys0tFOsqw1E3gyjE1B3FL6Z7M5qFbKW7vi613HLTQ
         dGMUOghKV0v+DWna9AHBI8K1rIakyu/47xqtOdxrtVyRyazegDn0bn7nKI2lBwtBcbfP
         2Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761450; x=1701366250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhdjFcwMeFtf9KqLxqQNOAWKxKUu7DGHAtTISD+MFi0=;
        b=u8j7MmitcOQVwlWBoi0GV5XMCuuOM5R7g+9eUkVG7/VdSCRrSHzIH5jrqn843IKnLr
         i8YVfCfvfAl3xdVx5xfE+DHgHePocpD9tHQ0GZkTBN1135ElYj/IZUf4xwdkOFEZQXTK
         iFSifleBLHtzV9/deRKs3gzmMXIxX0CJJ9a/numt7vZtsZiaDlJfbDeBub/O/XvwMjy3
         g8QQvTLZ6Mr3+afHhApvt9m80eTVqLbTKWpODei18NNE6fE+C73T4UL+TJ1p2tBXgceo
         WCBQBiVp6rHlsef374kQuiRoueLvdd9I5RadsaRTTHtqK9eZzGPjgktmF1iKo64WUvIH
         H/ug==
X-Gm-Message-State: AOJu0YwbgoFmZRzGdSD2duK5CG+y5AlTEvPW7Vo/Hj1FvuisfP7aUZPe
	WGXjQ+Kcx8W9w+/7bV99RXPilhFWsgE=
X-Google-Smtp-Source: AGHT+IEumz3VLYpzb6zvAsqbEyl9Zz+qeon+Lz+uuUdlMiEgKqucs3fOlRnqmyq2GQut9e0RJQqBPQ==
X-Received: by 2002:a2e:9d88:0:b0:2c4:fe14:a85 with SMTP id c8-20020a2e9d88000000b002c4fe140a85mr91907ljj.18.1700761449992;
        Thu, 23 Nov 2023 09:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm2680762wmo.23.2023.11.23.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:44:09 -0800 (PST)
Message-ID: <591c7b8d73b1a93feaa749d68156a198a7e32a9c.1700761448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 17:44:05 +0000
Subject: [PATCH 1/4] completion: squelch stray errors in sparse-checkout
 completion
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If, in the root of a project, one types

    git sparse-checkout set --cone ../<TAB>

then an error message of the form

    fatal: ../: '../' is outside repository at '/home/newren/floss/git'

is written to stderr, which munges the users view of their own command.
Squelch such messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d8..6fced40d04c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3014,7 +3014,7 @@ __gitcomp_directories ()
 			COMPREPLY+=("$c/")
 			_found=1
 		fi
-	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
+	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir 2>/dev/null)
 
 	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
 		# No possible further completions any deeper, so assume we're at
-- 
gitgitgadget

