Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9E7462
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731811844; cv=none; b=VmZ4AsIqPAJkeyT/hmv95M0hGq1BauYE2WS37jJhrGCtWOEpQIxdD3JrC3gT7i+fPEdyXnvGukjA23SHxOvlayoqAKndTZXxGiAqzacjpBkhfIHKYX3T7VwK9mG2/+IOvYGZsK5D9/HE556XGOPLvN4t5nEYrAVZmqeFsNC4kAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731811844; c=relaxed/simple;
	bh=XzF981FKRcFnQuJn8oOOiwlPGKcV855OSdulak2bKUo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8uKDdfgISs6JDjPuQMwBdFAMQYwTaZNjesXqrvAf85vKGuTYsctrKZOMEI55jGMz4uC62Jj5nHE4y+BXTVMbFVTOxk2C1tcbfB46/kZEamc22JhHRi3iYHkHkOA+EG5p9Ptx+jm8WsUekwQuudma/EX6/yBtIGe279c55wPH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Subject: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
Organization: Gentoo
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Sun, 17 Nov 2024 02:50:39 +0000
Message-ID: <87wmh2o9og.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

With upcoming GCC 15, a new warning is added
(-Wunterminated-string-initialization) that fires when building git:
```
    CC object-file.o
object-file.c:52:9: warning: initializer-string for array of =E2=80=98unsig=
ned char=E2=80=99 is too long [-Wunterminated-string-initialization]
   52 |         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
object-file.c:79:17: note: in expansion of macro =E2=80=98EMPTY_TREE_SHA256=
_BIN_LITERAL=E2=80=99
   79 |         .hash =3D EMPTY_TREE_SHA256_BIN_LITERAL,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
object-file.c:61:9: warning: initializer-string for array of =E2=80=98unsig=
ned char=E2=80=99 is too long [-Wunterminated-string-initialization]
   61 |         "\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
object-file.c:83:17: note: in expansion of macro =E2=80=98EMPTY_BLOB_SHA256=
_BIN_LITERAL=E2=80=99
   83 |         .hash =3D EMPTY_BLOB_SHA256_BIN_LITERAL,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

Context for the new warning is at https://gcc.gnu.org/PR115185.

thanks,
sam
