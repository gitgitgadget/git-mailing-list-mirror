Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D016A013
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+u6PLkj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d3954833a5so624521b3a.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703156323; x=1703761123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIowFya0HBVthgak0SLolXAmytSLZNZ2EH0PUoqXgfQ=;
        b=M+u6PLkj4pPDpVsHlWurxJ9rP7QRmUAnF1aNT9yGk1cRPJbz2uyz5OQ7x06QD8qlzM
         XDl2FkeLxpej3EkFZ8RQpQsjxRSj9m7E0ktDhYv2Zjq9f9i7lyYsomV7iXUT9szyWxsC
         zL9Vwi8A51gEWTtuxIlARU6HtNPka4sQbSWnuR9oGz4PsdYRpBB90Ad0yyMJB9eLRYZZ
         RTDF9HXWhe3RlFPlp3RKsDev95lPjcqWqMYBIlxCJ4plWYg5OV5EwP2yB5s5qPDm9TA6
         08lfQ37S/4NvQCgcH970sa8Ubp7t9K58w6PpmJHlnA+UfLxCtCUAtdQfWf6tTfP2stxk
         XQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703156323; x=1703761123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIowFya0HBVthgak0SLolXAmytSLZNZ2EH0PUoqXgfQ=;
        b=X1+/m+6QUPUpTnClxiypoH4h+Jlt2ETIPmLqyIOIrZmwt1u+YOyMzvtqM2UXI4nI6i
         glRrJcXbCgtd1fHhoWlgXJdZ1SwPfU7Q6FP5LueHrwoKNuGcOigha94o05NYlVC+GsNX
         UbfdsAUUU5hfjxkA3/xmJ4Qc9x+t75z4YpRKm7ghSaIX3QDN4Ygp2l75q0v4uAcTEu6d
         WGfkYL7p1ZqN/TsaAGJwlbJ0cXfkb1zOnwl4VodeoE+hfjv7CRJZBmg9Y1MD/mvDWUxw
         oNbiRvhL3oFCjXo4kHQPeKRuEgQd3DeV/ukHZpkI35v1h5lBCNxmrp2c3QCBKWbRvOIZ
         sSeg==
X-Gm-Message-State: AOJu0YzA/mkRtmm9G1VxE5WGL7o9QxdwjLO964OfWr7isn10mfPOPTh2
	YU1MVkfVDpxqLvpGMed0+8pA8IYzysmpiUtBbwo=
X-Google-Smtp-Source: AGHT+IE1BS5G8Oi77mR3RlKzQBBratSrSupCyYPWN0PwOosVF+rXrDDVnND1LCe+O6yRWHK9q6dr2Yvohm4vc1Gmi4M=
X-Received: by 2002:a05:6a20:4da6:b0:195:10aa:eb29 with SMTP id
 gj38-20020a056a204da600b0019510aaeb29mr258299pzb.33.1703156323559; Thu, 21
 Dec 2023 02:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <cover.1702047081.git.ps@pks.im>
 <f797feff8dec383f1db9ae403cd89b80d1743432.1702047081.git.ps@pks.im>
 <ZXOV8TCqaH0xXRnS@nand.local> <ZXbRmwj1vZ2dA3s9@tanuki>
In-Reply-To: <ZXbRmwj1vZ2dA3s9@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 11:58:32 +0100
Message-ID: <CAOw_e7bvud5M-1+kCi3gRuso3DqC19ujjKx079ORHKWiwC=Zzg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] reftable/stack: reuse buffers when reloading stack
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:08=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:

> > This initially caught me by surprise, but on closer inspection I agree
> > that this is OK, since stack_filename() calls strbuf_reset() before
> > adjusting the buffer contents.
> >
> > (As a side-note, I do find the side-effect of stack_filename() to be a
> > little surprising, but that's not the fault of this series and not wort=
h
> > changing here.)
>
> Agreed, I also found this to be a bit confusing at first. I'll amend the
> commit message with "Note that we do not have to manually reset the
> buffer because `stack_filename()` does this for us already." to help
> future readers.

In C++ it is expected that assignment operators clear the destination
before executing the assignment, so it depends on your expectations.
If this is confusing, maybe another name is in order?

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
