Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E225115
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvuKwJUx"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD00D5F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 13:22:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso67523227b3.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 13:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699910567; x=1700515367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y3JZQ9EeciqTWl3hfh09ZgV/VNXLCsneoO7gVdY0sg=;
        b=YvuKwJUxY/1k3mtuSMLcL4VQz7T9MWV8Z+b/7PQuz/JNCTpjddgweAYlngBdUotvJU
         ZmNeCQ/tESQKk/Dwd/s3bZIPTvhgtb5MVlf/zUKnFWapE3g3YozghW3uC/bO+ysKsdFR
         QL3Xy5eZPa4+qBhRSXNDDNNw8GT/bB2sZlyWdZ6Ej8KSMJjh1WysvIUxU7p0Qal6AeF1
         qZRKMl49Ay9hg6wnOEy4yScyrB+7jq61XzxcKrA2f+F4YHf8ZiNA//fhLTMjRRZ9nd7c
         8ZIaw+hkjqWc1Ei1VuGdlQRPnNOslqYnNlpyQqVHqeAQixK+j5rfU+aUPbrRsPeDX9um
         l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910567; x=1700515367;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3y3JZQ9EeciqTWl3hfh09ZgV/VNXLCsneoO7gVdY0sg=;
        b=Yd3sG/stHcpj8AkCzQd1PRr3sFWMefraaDeVUYN280KjR/YTelVPJHWZQf2H6Lpw9I
         3yAb5zdHG4rQ7Z2EoxtRmdsMjkuhfIAss6Q4VO4XQG5BiAX83fozDvzJQqGFzbQhTHlI
         k3AVvYPWwDydO8FmJOY0TzR8Pzlxkb8wG5jZvqz+oQSv2UkoJ9+gPYZ4CrDaMi53AxDe
         RGeaA7Y+Y/bZA+G6EmJmnZKzr5YWLwyhN3qf+QgTV1sy9WMCwPJeMD5q0S06ej52IRH6
         OIjpYfhs2CTA8FxZmU98/UzpgGrzJASvl+RKtKLTjVE0ZjGXCWmcB9c2Lsx1UFXq6xDN
         fcWA==
X-Gm-Message-State: AOJu0YzY5A0YroNvdf9l1fwOjqPwvYrMPabIY84QiqLNlfNxD8QjF+xh
	zM6ODesM+T5H7G9RF1G5ETIjCcsueCq9zlvirTxk
X-Google-Smtp-Source: AGHT+IF5rLjSVzviKCRb6NuCeFpzCelguqVD9ocRPoQ4k5CwpRMoP359ri2NChp2er57NPbjr80DhKUoLVaOoA9src6K
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1402:4356:9b02:7688])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4e44:0:b0:5a7:af47:9dda with
 SMTP id c65-20020a814e44000000b005a7af479ddamr227491ywb.9.1699910567004; Mon,
 13 Nov 2023 13:22:47 -0800 (PST)
Date: Mon, 13 Nov 2023 13:22:42 -0800
In-Reply-To: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113212243.1495815-1-jonathantanmy@google.com>
Subject: Re: [PATCH] remote-curl: avoid hang if curl asks for more data after eof
From: Jonathan Tan <jonathantanmy@google.com>
To: "=?UTF-8?q?Ji=C5=99=C3=AD=20Hru=C5=A1ka?=" <jirka@fud.cz>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ji=C5=99=C3=AD Hru=C5=A1ka <jirka@fud.cz> writes:
> It has been observed that under some circumstances, libcurl can call
> our `CURLOPT_READFUNCTION` callback `rpc_out()` again even after
> already getting a return value of zero (EOF) back once before.
>=20
> This results in `rpc_read_from_out()` trying to read more from the
> child process pipe, because `rpc->flush_read_but_not_sent` is reset to
> false already the first time EOF is returned, and then the whole
> operation gets stuck - the child process is already trying to read
> a response back and will not write anything to the output pipe anymore,
> while the parent/remote process is now blocked waiting to read more too
> and never even finishes sending the request.

Ah, thanks for finding this bug. It sounds worthwhile to make Git more
resilient in this situation.

I'll just make some preliminary comments.

> This commit addresses the bug with the following changes:

[snip]

This seems like a long list of changes, when from the description of the
bug above, I would have assumed it sufficient to record somewhere when
the CURLOPT_READFUNCTION callback returns zero, and then always return
zero after that if the callback is ever re-invoked. If this is indeed
not sufficient, we should describe why.

Also, if multiple changes are needed, please split them into several
commits.

> A trivial solution would be to just take the line which resets the flag
>=20
>     /*
>      * The line length either does not need to be sent at
>      * all or has already been completely sent. Now we can
>      * return 0, indicating EOF, meaning that the flush has
>      * been fully sent.
>      */
> -   rpc->flush_read_but_not_sent =3D 0;
>     return 0;
>=20
> from rpc_out() and reset it only in post_rpc(), before the next time a la=
rge
> request is being sent out and rpc_out() will go into play again:
>=20
>     if (large_request) {
>         ...
>         rpc->initial_buffer =3D 1;
> +       rpc->flush_read_but_not_sent =3D 0;
>         curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
>=20
> This way the CURLOPT_READFUNCTION would be returning zeros at the end of =
the
> upload as long as needed, just like fread() at the end of a real file.
>=20
> Hence, the bug could be fixed with just that two-lines change.

Ah, you describe the straightforward fix here. I haven't looked at this
closely enough to see if this would work, though.

> But while trying to figure out the above, I noticed a few things that pro=
longed
> the time I needed to understand what was going on, so I would like to pro=
pose
> some more changes to make the code perhaps a bit easier to read for the n=
ext
> person who comes to hack on it after me.
>=20
> The description of the extra modifications is in the commit message. All =
of
> these changes are obviously optional and naturally subjective. I think th=
at we
> can all agree on some points (less indentation =3D good), but naming is h=
ard,
> and so is balance between unclear and too verbose, or when to split all
> non-functional changes to a separate commit. So let me know if there are =
things
> to do differently and I will gladly obey, it is your codebase after all.

Yes, please split non-functional changes into a separate commit
(preferably one for each concern). I do envision reviewers saying "let's
put patches X, Y, and Z in, but not patches A, B, and C", so splitting
would make it easier to decide what's worthwhile to have.

> Which brings me to the next topic, testing.
>=20
> Validating the fix would be trivial with a mocked libcurl, but turns out =
to be
> much harder with the integration-level test suite of this project.

[snip]

> But outside of that, and as far as the bundled test suite goes, I have fa=
iled to
> write a test that could validate this problem does not ever occur again.

Due to the nature of the bug and the fix, I do agree that it's hard to
test and I would be OK with including the fix without associated tests.

=20
