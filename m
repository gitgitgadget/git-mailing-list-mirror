Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C2A29
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213899; cv=none; b=CFgaAJ+knIyWbybbfyCuxTn/n5CcMFX6DyPVb5PSVEqg2l6Vi11S3Rzj0sCPHcyNnq+g/lz3UwARCWLo7wfLEeTxPLVLq5qgVQvNNm+o3zhZQy+MpGzU26RNTlY4goZ2vEn0tcDD90Y7IWlNyz4wy5udp4O72CPBoKmRz3sR5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213899; c=relaxed/simple;
	bh=NXQZm1gG31/XvsGNOjhXt0cYwHkhx3PC1svWWUO2VU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soUwT6VOvO2UNflu1kIczwXfDkJr4SfhBV/DWugJHW2vpMiR+23ll+G56vXE1bxEUNv8owpQ0oeiezwyM9DcL4ps5bnyUBgUaq3FKFQ3Xc9sKnQH6Unqf6CC7onJuqV5nvEvBcYzqxf5rmNTY+iMfabsCi/ZKl0+j4jU3Kr+XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb36237f28so5008456d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 04:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728213896; x=1728818696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSAw49fsPB0cWq2EQQepdMuqFxUIsOCVHyKCtgBmKKU=;
        b=QnaXTsTtggxONNILhiheb4dwskEFzNl7Ih/0vRZhBiDSwB0dHeKHPPFv5+ZZsjbEYc
         jD5ibtCfPD77kfkqVzzMAZb5nhfM4JxujbLP4WXQtUbWvk5Dvh18rcKKCAOtc3pveRst
         9JCaSF5DuqwPCN/JC7MvuUXT/iNKTmXu8mbbidY2dQLw3XFlRWjcOum0jLVNtE/c1DsN
         Hsy74cpSE7cE9RZqPMc/j4lYG3zrRdRRvrv5qoBKeqPVMY2FPOlalqT7HC0+RbYAnfK0
         sMn2fgcm098yzdCc17o7KsEzJ5w30gp9PPIpTTJiln7OlYh6WsptwWIvu9LbYUQcvZZV
         zhfA==
X-Gm-Message-State: AOJu0YwxfsKJZAclvdBMW9y2PEdvMFcobRG8HGZPh+/pPWCCQAXgHuTi
	vO45W2ybTg387A0MwQj4z4Drjyz9U+TuaTxwd9RslK9ukXR3/glFPnRWSDVqJrFp4ZQVqAQv2O0
	+EOJ1r/fK4nVsYbb+4v8MnTIBem2r3qbT
X-Google-Smtp-Source: AGHT+IEHMo1gv6QEf8KNGYZfJ6Fpln9qGhApeUsAkZ36ANq5mfF6+Spw0LLJl8lv/2PI5gjTRqUeF8Vtrkq5L76I08Q=
X-Received: by 2002:ad4:5bc8:0:b0:6cb:6782:6a8c with SMTP id
 6a1803df08f44-6cb9a54e244mr55926526d6.12.1728213896145; Sun, 06 Oct 2024
 04:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-5-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-5-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 07:24:43 -0400
Message-ID: <CAPig+cSdVVy4huueVQpiO_Gvn4SAXAiQj-uVnuScgfOOFJ6h0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] worktree: prevent null pointer dereference
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:01=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> If worktrees is NULL, free_worktrees() should return immediately to
> prevent a null pointer dereference.
>
> Signed-off-by: Caleb White <cdwhite3@pm.me>

Critical questions: It is not clear why this patch is needed,
especially coming at the end of the series. Is there some code in a
patch earlier in the series which might call free_worktrees() with
NULL? If so, then this patch should come before that patch. If not,
then why do we need this patch at all?

Devil's advocate question: Why is it the responsibility of
free_worktrees() to check this condition as opposed to being the
caller's responsibility?

The commit message should explain the need for this patch and answer
these questions, not just say what change is being made.

> diff --git a/worktree.c b/worktree.c
> @@ -28,8 +28,9 @@ void free_worktree(struct worktree *worktree)
>  void free_worktrees(struct worktree **worktrees)
>  {
> -       int i =3D 0;
> -       for (i =3D 0; worktrees[i]; i++)
> +       if  (!worktrees)
> +               return;
> +       for (int i =3D 0; worktrees[i]; i++)
>                 free_worktree(worktrees[i]);

Although it's true that this project has recently started allowing
declaration of the variable in the `for` statement, that change is
unrelated to the stated purpose in the commit message. True, it's a
minor thing in this case, but it causes a hiccup for reviewers when
unrelated changes are piggybacked like this with the "real" change
since it adds noise which obscures what the reviewer should really be
focusing on.
