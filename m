Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfZl28nT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99DD8F
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702390600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tms1BQbG6Qr9dCd2X8ma5kxr0csRIl22e/3k7Y/7AYU=;
	b=HfZl28nTG+v6p1hQ0eGRhTaP47OW6cti16+XBFlmODdNIFNZW1prrFy6Pyh64PjQf4qd1G
	Q6KeZ/cBt518Fna03ByXNFxnfN61vTD4xkSDWCZlCrw1U7Da1esfgFcnbQPN7XCqjFnAlG
	wAnaxq5fsDr5gd+Y1MIFAHidL+qirOU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-8xnm4PCrMqCcZb7D1vft0Q-1; Tue, 12 Dec 2023 09:16:38 -0500
X-MC-Unique: 8xnm4PCrMqCcZb7D1vft0Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1bd7a5931eso314303266b.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 06:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390597; x=1702995397;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tms1BQbG6Qr9dCd2X8ma5kxr0csRIl22e/3k7Y/7AYU=;
        b=LcuBI4CH7OnFovs22dqZjOH0I0Yxw+gbFPL8zgLQ21CtFlbOH+XWb+yBXuWNaceBJc
         iR+rbuh8LjDtuNLa75fApNQp+tov6q6Ms3m9wP+tY7vcywsv0ZMTnBl3NAJzm+dKunsm
         FOO0BJiLIxwh2gnzuEwBen0M4e05ox+VQK9Ed662qm/ISab1TVqkFaprqeJrrKw6CNhB
         EF8d91/xc7bjVU550eVtbHM4qW6ozuYVgaDjH1lvDWS9aFWs+JULceUjtRTsBPdfSZsj
         OSIfT++3JNUIxt7J8NbBiQJR32eRuBLMi4vrUiJlVQE5+/vOlvtELfrvgVEyNxnLUEVZ
         zTDg==
X-Gm-Message-State: AOJu0YwSZ+VE5ms2kxEab0G1v2gb8IhYDKHXY6BO3DJkSZo7NOtLzO2w
	uBZMIeC1muT/kjId6YKAXjgQtAtZ3o0LJEOJOMxC5dYTGwtkEDh2mqUpQ/EhWj/WUH0om8uKkF2
	D734FRFJsedMhWkFagLKVh2ijOtCnN/+yRZBF7x8=
X-Received: by 2002:a17:907:6d1d:b0:a1e:eecd:6f88 with SMTP id sa29-20020a1709076d1d00b00a1eeecd6f88mr3902252ejc.77.1702390596989;
        Tue, 12 Dec 2023 06:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYDrBbQBV/AaxSfLg+Di3LLjBAcyJPcZQ/Vgt9UWqMuLPhI+cVxF+mBIos9Mw7jzq1G/AQje8Lt0bkSK4BaEk=
X-Received: by 2002:a17:907:6d1d:b0:a1e:eecd:6f88 with SMTP id
 sa29-20020a1709076d1d00b00a1eeecd6f88mr3902243ejc.77.1702390596689; Tue, 12
 Dec 2023 06:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Tue, 12 Dec 2023 15:16:26 +0100
Message-ID: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
Subject: Test breakage with zlib-ng
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

As some might have heard, there is a proposal for Fedora 40 to
transition from zlib to zlib-ng[0]. Because of this, there has been a
rebuild of all packages to ensure every package works under zlib-ng.

Git test suit has three breakages in t6300-for-each-ref.sh.
To be precise, it is:

not ok 35 - basic atom: refs/heads/main objectsize:disk
not ok 107 - basic atom: refs/tags/testtag objectsize:disk
not ok 108 - basic atom: refs/tags/testtag *objectsize:disk


All of these tests are atomic, and they compare the result against
$disklen. I discussed it with Tulio Magno Quites Machado Filho, who
ran the tests and is owner of the proposal.
It seems like the compression of zlib-ng is shaving/adding some bytes
to the actual output, which then fails the comparison.

Here is an example:

```
expecting success of 6300.35 'basic atom: refs/heads/main objectsize:disk':
git for-each-ref --format=3D"%($format)" "$ref" >actual &&
sanitize_pgp <actual >actual.clean &&
test_cmp expected actual.clean


++ git for-each-ref '--format=3D%(objectsize:disk)' refs/heads/main
++ sanitize_pgp
++ perl -ne '
/^-----END PGP/ and $in_pgp =3D 0;
print unless $in_pgp;
/^-----BEGIN PGP/ and $in_pgp =3D 1;
'
++ command /usr/bin/perl -ne '
/^-----END PGP/ and $in_pgp =3D 0;
print unless $in_pgp;
/^-----BEGIN PGP/ and $in_pgp =3D 1;
'
++ test_cmp expected actual.clean
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expected actual.clean
--- expected 2023-12-06 21:06:07.808849497 +0000
+++ actual.clean 2023-12-06 21:06:07.812849541 +0000
@@ -1 +1 @@
-138
+137
error: last command exited with $?=3D1
not ok 35 - basic atom: refs/heads/main objectsize:disk
```

The whole build log can be found here[1].

I can easily patch these tests in Fedora to be compatible with zlib-ng
only by not comparing to $disklen, but a concrete value, however I
would like to have a universal solution that works with both zlib and
zlib-ng. So if anyone has an idea on how to do it, please let me know.
Thanks


[0]https://discussion.fedoraproject.org/t/f40-change-proposal-transitioning=
-to-zlib-ng-as-a-compatible-replacement-for-zlib-system-wide/95807
[1]https://download.copr.fedorainfracloud.org/results/tuliom/zlib-ng-compat=
-mpb/fedora-rawhide-x86_64/06729801-git/builder-live.log.gz

Cheers,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

