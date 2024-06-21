Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6315D1
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990291; cv=none; b=CPEP4PBXFK5cAepmkjgDhyknIlMPUfUZXW87i0xwQiMh3Nm+2x85HDCuyU9qJ51uyesol16+yVEByK0oECSeSniTnl7/kLo3CctRDJQ0nTqN5jQ5QoPGb4D0eedqFUqCPBqqGavr7t9oXVB2PQL7haue2bBzAO6FAWAR1OZQYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990291; c=relaxed/simple;
	bh=H/wl8o3eRes1d21cU6reL71uE3LMwJafnHfvXcFYZrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXgiEzcvDyj1GcBpTPXb+oXuOzWgLYCV89zOyaCDEl8SjZGhZsKxT9HhLTSJ1Bd2ru632uPsK9tPuanezyCN9mdacpcXxC70DmI8hdocjn0AssIxVhmCMW4bEvVaDNe7iTMKCgsgMms8D1Xa4R2X2VLDce8sC/mcmim9QkF7j5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6aedd5167d1so9320256d6.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 10:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990288; x=1719595088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NufKQHdqu2wG5aN5cyAROnBwN63O/bG1EQvw7PCOpGs=;
        b=F7geY7yfXNSJQ2ZHDIFDdTRrqYsQaFhFVeyQspN4pjSKfnB5A8GqKmVR06tOjjOXdS
         +0PAbMqxnf41ECe7wp1Myt09azcvrhrcNTeg2JkoW90dwQ0rU9+gSO0TxbHo1RIjg7Ra
         IpsvUCO9qYsWcW3XojxrhBWM95hCBc7i+uv6rn4+yqflB4Eli+hLsDRvz2lxTdcGh7pa
         MFFxCKAVPw9eInvJycHjpZXAZ4miIsOkzF0NUFOSdQEZ7ipxug1Nnz6j21mvD8aykDkn
         0u6ncRNQGTtsGYHXz7z6yBKgcGfsZgL+ZMo83IwFIsPfm+2E5rptFqc2OJKT1ZGXqRB5
         CDvA==
X-Gm-Message-State: AOJu0YzBKOdRPYesVK101zrtjUe111EAYID8SPS+gf7y1RFfGc9uD8Ms
	l10NwijskpZhVAdIFg78ehAbumde5pgaorpjLMJnJ0e+Ogcc1Vgh8Vgnpb8+KdlN76sagpsEIZR
	19hNp9H7NifjFUVft29g+n3XMkrhwd0jb
X-Google-Smtp-Source: AGHT+IEdB5e9ToLpkD5gJRIEPp780MQjsbysIPpU4Y3JE9D+f7AjER1aEAjYqC3BDNDZ+Tw6yUzv5N/w2ePzkvKwKBo=
X-Received: by 2002:a0c:f307:0:b0:6b5:187:b4e7 with SMTP id
 6a1803df08f44-6b501e57f7cmr98764266d6.37.1718990288332; Fri, 21 Jun 2024
 10:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621092258.1557258-1-toon@iotcl.com>
In-Reply-To: <20240621092258.1557258-1-toon@iotcl.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 21 Jun 2024 13:17:57 -0400
Message-ID: <CAPig+cQ7y61LZW9zDMiHLmyEm=DLcBsuR_yPOzXiK6y9iXazWw@mail.gmail.com>
Subject: Re: [PATCH] bundle-uri.c: Fix double increment in depth
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 5:23=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
> A bundle URI can serve a gitformat-bundle(5) or a bundle list. This
> plain text file is in the Git config format containing other bundle
> URIs. To avoid these bundle lists to nest too deep, we've set a limit
> with `max_bundle_uri_depth`. Although, when walk through the tree of
> bundles, the current depth is incremented in download_bundle_list() and
> then calls download_bundle_to_file(), which also increments the depth.
> Remove the increment in download_bundle_to_file().
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> @@ -259,6 +259,68 @@ test_expect_success 'clone bundle list (file, any mo=
de, all failures)' '
> +test_expect_success 'clone bundle list (file, above max depth)' '
> +       cat >bundle-list-1 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-list-2"]
> +               uri =3D file://$(pwd)/bundle-list-2
> +       EOF
> +
> +       cat >bundle-list-2 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-list-3"]
> +               uri =3D file://$(pwd)/bundle-list-3
> +       EOF
> + [...]

A very minor (and subjective) comment beyond those offered by other reviewe=
rs...

The above "setup" functionality can be collapsed to:

    for i in $(test_seq 4)
    do
        cat >bundle-list-$i <<-EOF || return 1
        [bundle]
            version =3D 1
            mode =3D any
        [bundle "bundle-list-$(($i + 1))"]
            uri =3D file://$(pwd)/bundle-list-$(($i + 1))
        EOF
    done
