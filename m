Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423171A73F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382ABA3
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:05:15 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d87554434so6965286d6.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821514; x=1698426314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CWTigSXNEH5BsYmtXdtz7MElMxMesMxSklrtvuvz8k=;
        b=tWNUi9C148X7gXOhVQpmoJXeLXlAckQXvezld989UqbZDJWjpptH+BXZdjoDwnoiCs
         e/CGyv8iKl4yIkQZvwoqPvtATCvi5pztkoXaxt6+CLcbJK3oi257DiXolTYAP7bhVp1h
         /xsoGvufR7uoefv4codRep8xioA32UwQoee17u20sfECFNLdiRJlar7MkPM4Eilr5Mys
         YDTaEd9avetLzNmWbFTBgp5O91NIcqk/DPaAsJv20Xwgzk9HVWi/o94AGox045QNGh3N
         Ke/i0sgeEtsmYnP4P49eoD9d/uQXJcCLpTf0uxW3PU36OQGvTleK2qV052IcSZtFgMJW
         5jbQ==
X-Gm-Message-State: AOJu0YzVpYyWkXxDoYC/1yjVnspIcsjQVrF2oCMCfWMmIorqdkeC8KTQ
	lM16xX/YwIQcDcYUylAQSieF/ZSkxJCdt2SjNb0=
X-Google-Smtp-Source: AGHT+IGVs8keQ9vB94GQY8lZlODACd+gND9H759PUN97fdWj1Eha4YnkBqQeHgzDbJnG7SGm5hE3HywAffViswkBbqc=
X-Received: by 2002:a05:6214:ca4:b0:66d:1318:e786 with SMTP id
 s4-20020a0562140ca400b0066d1318e786mr3177199qvs.59.1697821514349; Fri, 20 Oct
 2023 10:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
 <5c8ef6bec1c99e0fae7ada903885a8e77f8137f9.1697819838.git.code@khaugsbakk.name>
In-Reply-To: <5c8ef6bec1c99e0fae7ada903885a8e77f8137f9.1697819838.git.code@khaugsbakk.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Oct 2023 13:05:03 -0400
Message-ID: <CAPig+cTBYw9=Wo=TR8MD5xX9hgurnfR2Xzc_wHSYnL1R00=xpw@mail.gmail.com>
Subject: Re: [PATCH v2] grep: die gracefully when outside repository
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: gitster@pobox.com, ks1322@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:40=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> Die gracefully when `git grep --no-index` is run outside of a Git
> repository and the path is outside the directory tree.
>
> If you are not in a Git repository and say:
>
>     git grep --no-index search ..
>
> You trigger a `BUG`:
>
>     BUG: environment.c:213: git environment hasn't been setup
>     Aborted (core dumped)
>
> Because `..` is a valid path which is treated as a pathspec. Then
> `pathspec` figures out that it is not in the current directory tree. The
> `BUG` is triggered when `pathspec` tries to advice the user about how the
> path is not in the current (non-existing) repository.

s/advice/advise/

(probably not worth a reroll)

> Reported-by: ks1322 ks1322 <ks1322@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
