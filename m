Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F89F9F0
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw/oLerN"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-594cb19c5d9so1973552eaf.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201799; x=1704806599; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNpfYbA7IIwyxBWgaXFJ8rFC807ZFDsc2mOyYjDnARU=;
        b=Hw/oLerNfEnlO22kT8QeBg0Pke8SLpF/EFwjKNRBYEftwGyOVxd9/Xsk3MwaX6ovoT
         F6J+PVuUSKTh4EI2gtMcvoPiJRkBlvcrrwn7pgLPrQrM6wl6uoReshb1v3ReTWwfVXWN
         QgGPayjmob2f88fn/TSeF/ebrJPuz6D7JlNzEhpi/bF/s5BXwIW7GVcO+fXgy+N96jr+
         c55oeiAXqAfPODdBs81aN7DoP3TCB3RGov0X9WYs/rwhTpXWOIf+KKoJJKXbfSIQXZp/
         SOYIg1tMST3tBNv+NooDiSu4o1WFS4GLrn24UwNhg/ni/MR4Zw3zJPByJwnglaU2Qs4+
         s+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201799; x=1704806599;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNpfYbA7IIwyxBWgaXFJ8rFC807ZFDsc2mOyYjDnARU=;
        b=mYTfyzY4F83vm/nRhZy+Z1wmk7AXqNASU6jAlTgAlvfRfp56LpRdGKl9F1ww3n4tko
         +mPMHySRUtn+r5iQgINeO82eDACCDi/hiylF9yi/xVFeHjzIQ/vHtMZajqika21g/RkN
         Df1caouYsNTwPWRHzegK7+v0sEMHkvbQJSF9aKMxaXx6PfPFxDLqjxVhvNgrGdGO8IEI
         mPHtXExmtWEr5/uaa9CDrfxBoBnwPkGTvAekPj0rLIltGrvmTukF6q7U45AoTb7dfo6W
         TskhZXYjPshYGapoI6naFICVUYoUki5kdzq9qJobrKpZEosUAopsj/SzCQljKt+C6Ek6
         8HEg==
X-Gm-Message-State: AOJu0YyGnnQOElbq61mPBxY/0PYGFEdIXEXeQpeFwD2Ye/9wXx4ybv0k
	Z82cS2mkFWRlRh/XqKU6LI7kpZXvRGnH8JwbpoNOwowG
X-Google-Smtp-Source: AGHT+IGR88tg2azajyCU5WpU+OTr14ykcAXuLGQjGAP9uBpl686c9dYplXmNiFq2mWLShbMnOv/nw95iKoGIfkbunIQ=
X-Received: by 2002:a05:6871:6108:b0:1fa:df5e:48be with SMTP id
 ra8-20020a056871610800b001fadf5e48bemr5788480oab.15.1704201798731; Tue, 02
 Jan 2024 05:23:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jan 2024 05:23:18 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ae013eaa4aba0d68172ff03dbe9f2c2bca596285.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im> <ae013eaa4aba0d68172ff03dbe9f2c2bca596285.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jan 2024 05:23:18 -0800
Message-ID: <CAOLa=ZTR6aW5aoxcMOS3U3TL1VxSfmyVno9fu7B5201pJTqyyg@mail.gmail.com>
Subject: Re: [PATCH 2/6] setup: move creation of "refs/" into the files backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Move the code to create the directory into the files backend itself to
> make it so. This means that future ref backends will also need to have
> equivalent logic around to ensure that the directory exists, but it
> seems a lot more sensible to have it this way round than to require
> callers to create the directory themselves.
>

Why not move it to refs.c:refs_init_db() instead? this way each
implementation doesn't have to do it?

@@ -2020,14 +2024,30 @@ const char *refs_resolve_ref_unsafe(struct
ref_store *refs,
 /* backend functions */
 int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
 {
+	/*
+	 * We need to create a "refs" dir in any case so that older versions of
+	 * Git can tell that this is a repository. This serves two main
+	 * purposes:
+	 *
+	 * - Clients will know to stop walking the parent-directory chain when
+	 *   detecting the Git repository. Otherwise they may end up detecting
+	 *   a Git repository in a parent directory instead.
+	 *
+	 * - Instead of failing to detect a repository with unknown reference
+	 *   format altogether, old clients will print an error saying that
+	 *   they do not understand the reference format extension.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+	adjust_shared_perm(git_path("refs"));
+
 	return refs->be->init_db(refs, flags, err);
 }
