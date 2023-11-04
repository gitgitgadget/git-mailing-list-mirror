Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDCF9FC
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C10D69
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 16:50:32 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-66d093265dfso19561756d6.3
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 16:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699141831; x=1699746631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqvq6y+oC6U8t8v8ktzjSxt0JPzC/Dg0Z4oo0+CW3NI=;
        b=Ae054RoR6KOKWEwi7ZZchF75AUoKSnD2gaWvxar5lbvaoEjdQJ0TcIOGS0bv7yjU5D
         CNhBGJm6qr6EI6BoNvJOe8raylCgWKllRluaT4IrdtSUy89DqSIzRhoyC/O2a9IECIYO
         1APV/Ay21UPUceRI6pElG75kB/0aw9ESRwvQCycpW9dYFvO0zDctfD5vcqVKH3hiOrzs
         c+SollcEUI/9fl9pZiLnQlt8gFnQcREkIcgIh5PUjSJ7q60GSv0Hjqg6MaLZIRoChY+w
         sqe0zePOCG18GZAdI8yIWnrGfVWPEQGFSPcXJn1nkJrwxjmBbNeD0zhsfkcFittmf1iy
         3ZrA==
X-Gm-Message-State: AOJu0YyxBS4qf7HbBi2xg6PogVyTcttdsG0VfEXX6jNjhwOectA8DeyO
	5QJTk3pe3ySWKKe3Ed3Ys4EiO3Ga9T6rA3fwiIt5XHzykC8=
X-Google-Smtp-Source: AGHT+IGK7dU9mgnvIubGqBBTawupV02n/IXqtGd5ngLzADsU0tFduSXB0ClfBE35zRpsCZ7U4D8W7Ws+DHmZUDZuYzE=
X-Received: by 2002:a05:6214:1d09:b0:649:8f20:5528 with SMTP id
 e9-20020a0562141d0900b006498f205528mr31518662qvd.60.1699141831275; Sat, 04
 Nov 2023 16:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
 <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com> <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
 <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com> <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
 <xmqq8r7egd8u.fsf@gitster.g>
In-Reply-To: <xmqq8r7egd8u.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 4 Nov 2023 19:50:20 -0400
Message-ID: <CAPig+cSC8m5a8PhMw_eJbswwNB-VgBt+n56HSTLLabV9_+y--g@mail.gmail.com>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 3:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Also, in the longer term, as you suggested, `xargs` is likely a more
> > fruitful solution.
>
> Hmph, the list of our test scripts exceed command line limit?  That
> sounds a bit nasty, as we somehow need to prepare a pipe and feed
> them into it, in order to drive xargs downstream of the pipe.
>
> Ideally if there were a GNUMake function that slices a list into
> sublists of "reasonable" lengths, we could use it to directly drive
> N invocations of check-non-portable-shell script instead of xargs,
> but I didn't find one.  Here is I came up with, using foreach that
> is "slice the list into many sublists of 1 element", but it made me
> feel dirty.

Indeed, that's ugly. I hadn't even put any thought into it since there
doesn't seem to be a pressing need for it.

In the long run, =C3=86var's idea of having `make` notice which, if any,
test scripts have changed, and only perform linting on an as-needed
basis may be the way to go[1,2,3], thus only passing a single script
as argument to each of the linters.

[1]: https://lore.kernel.org/git/220901.86bkrzjm6e.gmgdl@evledraar.gmail.co=
m/
[2]: https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.co=
m/
[3]: https://github.com/avar/git/commits/avar/t-Makefile-break-T-to-file-as=
sociation
