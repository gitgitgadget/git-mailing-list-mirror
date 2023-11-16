Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8778A4
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 17:37:23 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ac376d311aso2811457b3.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 17:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098643; x=1700703443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kikNrRyIRdEPjTdnLZ9UyNZ2Gqp/vW0HYfCkh8Q5q7Q=;
        b=uQll/ZCOAl2qTuTHM3gOptWxkhA4iJCqdmmLGX/92PAKYAQ66EthFyPZX0RihFXypg
         R6OU+MCSXKMbsGaDb81XjvCMJUz9bUDdhUO+yt11UGtC+R4KCk/rtOz5o2Pgq4WB6SHf
         1+3sSFLcZdnGlhesXRgjMJZ3fEJLNU8CnCyWPv1vEg0oP6sldwLKaZXhvEmUv8OHmJyz
         dPblb7CSlGle+9QFjFqYfnXSas4sN/aYye0SeQNx2T5SVpNxQ1ubpUvnV1BXp0eOxhAa
         TQmbyGSMqYERy/x4vBLu8tia95IN0y83P/7emWSY5vAhKIXNpPB+PJQjWAp+WHGfBxjt
         VPWg==
X-Gm-Message-State: AOJu0Yyvu7BAPSQJSefkL30ChK/aD2DUs0WqKjeN/eMvYwh3A/YQgim9
	4se5VYsg6I92Z4v/QirzvX7pVwLszqHjF1WwNNlZv1JFHTlGnw==
X-Google-Smtp-Source: AGHT+IHrj039vKUyl49DF6lk/+TD8r7XdFht0l3TqzBZOJo4ecM6YDe3nV6v6vavCGfg4Y/jUXXjEVgJWMx5Iao23qI=
X-Received: by 2002:a05:6902:1509:b0:d9a:4fa0:dca9 with SMTP id
 q9-20020a056902150900b00d9a4fa0dca9mr18414047ybu.25.1700098642932; Wed, 15
 Nov 2023 17:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbkbx11x2.fsf@gitster.g> <20231114214934.3484892-1-jojwang@google.com>
 <xmqqy1eytrns.fsf@gitster.g>
In-Reply-To: <xmqqy1eytrns.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 15 Nov 2023 20:37:11 -0500
Message-ID: <CAPig+cSyrD71NMnfVCTHEf+K8vop9QHLet7uyOerrq=v9SVbFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
To: Junio C Hamano <gitster@pobox.com>
Cc: Joanna Wang <jojwang@google.com>, git@vger.kernel.org, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 8:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Joanna Wang <jojwang@google.com> writes:
> > +test_expect_success 'native object mode attributes work with --cached'=
 '
> > +     >normal && attr_check_object_mode normal unspecified --cached &&
> > +     git add normal && attr_check_object_mode normal 100644 --cached
> > +'
>
> For "--cached test", on the other hand, we should be able to set the
> executable bit or record a symbolic link regardless of the
> filesystem using "update-index", e.g.,
>
>         empty_blob=3D$(git rev-parse :normal)
>         cat <<-EOF | git update-index --index-info
>         100755 $empty_blob 0    exec
>         120000 $empty_blob 0    symlink
>         EOF
>
> or something.

A bit more idiomatic in this codebase would be:

        git update-index --index-info <<-EOF
        100755 $empty_blob 0    exec
        120000 $empty_blob 0    symlink
        EOF

No need for `cat`.
