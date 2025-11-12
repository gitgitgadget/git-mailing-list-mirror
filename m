Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D830B508
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943523; cv=none; b=FqM0G1akFAOaAsF913o3IXv0y+WffbowJfus13qUM/ShSs/3fkJbxxczPi5gD1aqmVb2XZrVHmHR5f1hlS4DaGOVnVhhtBQG0D9yeV8Vsf7GYmr/BwSDHRDOg0hd2+LXIBU/bRq1rWTKCTPiEEg+daZUPB1tQi8Av0XDPvlF6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943523; c=relaxed/simple;
	bh=/zCrNL/4L72+R4AQAespboDWUjLV1JeD6+hMSAByZKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8NDfUoHBAfsn3bZnKM0A0kNT4OGjsARBU7SIQ8xW0vqyfkhdCAyn4r7UDaZI/tDupt7kMX91GvpLZ/JYLE4GgGZPruSfQBIylqmNIpbR6fKi2vhjrcV2y09ZgBeFIRTrZm7NGapLrWcstVx0rH0RgWDmHggpku5o+iAE108Cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OblqqfLE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OblqqfLE"
Received: (qmail 497725 invoked by uid 109); 12 Nov 2025 10:31:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/zCrNL/4L72+R4AQAespboDWUjLV1JeD6+hMSAByZKw=; b=OblqqfLEh9qRyNstXkCmVJuylrSOZA+toxhZOMan31evZXNWq8b5SLgQL9VO2TVliW/43v0HQVJBWTMz9q56drOnZAOgNzfhRocguyUdRfUyAl0+6fiWhMjaHuXRCGKRJdAvVOCap0NM4GhF2GNqd0xUYPIX1r2jP1NniMUKSW8HAC86/5YDw2wGY0AQ2poodk65YF3cSxTIbk+S+QmUw0B7kLPVOD+EoIyTje4uHDXJF4fIuD54vcMDeOrmkLn8/AqBhZw0wK6dLqaoQP1pQUWWidDGq11gnaeonxv+uowBBr8/yuJBRSUA6CBlzd5t01KmAyRSB/jI4XEkpguCwA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 10:31:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 787917 invoked by uid 111); 12 Nov 2025 10:31:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 05:31:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 05:31:58 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <20251112103158.GA983233@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <87y0obis17.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0obis17.fsf@gmail.com>

On Wed, Nov 12, 2025 at 12:17:24AM -0800, Collin Funk wrote:

> I see that an interceptor was added in 2023 [1]. Maybe your compiler is
> older than that?

No, I'm using gcc 15.2.0 (from Debian unstable).

But I'm not sure if the linked code does anything useful for us.

One, it's not clear to me if it is even kicking in or not. It only does
anything if the region is "sanitizer managed", according to the details
at https://reviews.llvm.org/D154659. I'm not sure what that means
exactly, because I'm fuzzy on how the shadow map works.

But even when it does do something, it seems to round up to the nearest
page size. But we really want to know if we go even one byte over the
requested length, because if we touch the 1235th byte of a 1234-byte
buffer (which is going to be a NUL because of mmap rounding up the
pages), then there's probably another test case somewhere where we
access the 4097th byte of a 4096-byte buffer (which is going to
segfault).

>       char *ptr = mmap (NULL, getpagesize (), PROT_READ | PROT_WRITE,
>     		    MAP_ANONYMOUS, -1, 0);
>       if (ptr == NULL)
>         abort ();

I think you want to check for MAP_FAILED here, not NULL. And I think we
always get that, because MAP_ANONYMOUS needs to be OR-ed into MAP_SHARED
or MAP_PRIVATE. So here:

>     $ gcc -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
>     SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x400554) (BuildId: 1b7a82189bfffb3f73d420e138b9859add25901a) in main
>     $ clang -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
>     SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x4e9ee6) (BuildId: aca1d168eacebaa239082d8a45ab74c8470f4b31) in main

I don't think this is ASan finding a problem. It is just telling us that
we segfaulted for other reasons. And the fault here is because the
broken mmap() invocation returned MAP_FAILED, and we tried to access
that garbage pointer.

>       ptr[getpagesize () + 1] = 'a';

This is also making a map that is a multiple of the page size, and then
touching a byte that's on the next page. That's the easy-ish case that
we can often already find, even without ASan (though it depends on what
comes after the mapped memory; it might be a valid page).

A more interesting test for Git is to actually map a file, like:

  $ cat main.c
  #include <unistd.h>
  #include <fcntl.h>
  #include <sys/mman.h>
  #include <sys/stat.h>
  #include <stdio.h>
  static void die(const char *msg)
  {
  	perror(msg);
  	exit(1);
  }
  int main (int argc, const char **argv)
  {
  	struct stat st;
  	int fd;
  	char *ptr;
  
  	fd = open(argv[1], O_RDONLY);
  	if (fd < 0)
  		die("open");
  	if (fstat(fd, &st) < 0)
  		die("fstat");
  	ptr = mmap (NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
  	if (ptr == MAP_FAILED)
  		die("mmap");
  	printf("last byte: %d\n", ptr[st.st_size-1]);
  	printf("one byte after: %d\n", ptr[st.st_size]);
  	return 0;
  }
  $ yes | head -c 4096 >big
  $ yes | head -c 372 >small

And ASan does often detect the problem for the "big" page-sized file,
but not consistently! If I do:

  gcc -fsanitize=address main.c
  while ./a.out big; do echo ok; done

I may get output like:

  last byte: 10
  one byte after: 127
  ok
  last byte: 10
  one byte after: 0
  ok
  last byte: 10
  one byte after: 0
  ok
  last byte: 10
  =================================================================
  ==988617==ERROR: AddressSanitizer: unknown-crash on address 0x7efd40b9f000 at pc 0x564fe77b64eb bp 0x7ffff49e8160 sp 0x7ffff49e8158
  READ of size 1 at 0x7efd40b9f000 thread T0
      #0 0x564fe77b64ea in main (/home/peff/a.out+0x14ea) (BuildId: 8db121bb5c048cb336f8be729e8cefebd6f059a3)
      #1 0x7efd41233ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
      #2 0x7efd41233d64 in __libc_start_main_impl ../csu/libc-start.c:360
      #3 0x564fe77b6150 in _start (/home/peff/a.out+0x1150) (BuildId: 8db121bb5c048cb336f8be729e8cefebd6f059a3)
  
  Address 0x7efd40b9f000 is a wild pointer inside of access range of size 0x000000000001.

So it worked three times without ASan noticing the problem (producing
two different outputs), and then ASan finally crashed. But it didn't
give us the usual information we get for a malloc overflow. It's just an
"unknown crash" from a "wild pointer". So I'm not sure if it's even
finding these through its own poisoning, and not just catching an
unlucky segfault.

If we switch to the small file, then ASan never reports anything! The OS
gives us a page-sized chunk, so we consistently read a "0" in from the
byte after our requested size.

If we swap out the mmap for:

  ptr = malloc(st.st_size);
  read(fd, ptr, st.st_size);

(which is roughly what our NO_MMAP wrapper is doing behind the scenes),
then ASan does catch it consistently, even for the "small" file:

  $ ./a.out small
  =================================================================
  ==1008630==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7d11fe01b4 at pc 0x55cf89b1b4c8 bp 0x7fff471b84e0 sp 0x7fff471b84d8
  READ of size 1 at 0x7c7d11fe01b4 thread T0
      #0 0x55cf89b1b4c7 in main (/home/peff/a.out+0x14c7) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
      #1 0x7f4d12e33ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
      #2 0x7f4d12e33d64 in __libc_start_main_impl ../csu/libc-start.c:360
      #3 0x55cf89b1b150 in _start (/home/peff/a.out+0x1150) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
  
  0x7c7d11fe01b4 is located 0 bytes after 372-byte region [0x7c7d11fe0040,0x7c7d11fe01b4)
  allocated by thread T0 here:
      #0 0x7f4d1311a0ab in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
      #1 0x55cf89b1b3a0 in main (/home/peff/a.out+0x13a0) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
      #2 0x7f4d12e33ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

-Peff
