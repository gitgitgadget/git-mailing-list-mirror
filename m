From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect failed me again
Date: Fri, 12 May 2006 08:12:07 -0700
Message-ID: <20060512081207.6cd701f9.akpm@osdl.org>
References: <20060512000249.71933599.akpm@osdl.org>
	<Pine.LNX.4.64.0605120738190.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 12 17:15:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeZMQ-0005aI-5x
	for gcvg-git@gmane.org; Fri, 12 May 2006 17:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWELPPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 11:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWELPPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 11:15:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932122AbWELPPH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 11:15:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4CFF1tH012754
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 08:15:02 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k4CFF1dN016953;
	Fri, 12 May 2006 08:15:01 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605120738190.3866@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19916>

Linus Torvalds <torvalds@osdl.org> wrote:
>
> (In fact, the _most_ visually obvious way to do it is to do this:
> 
>  	git bisect reset
>  	git bisect start
>  	git bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
>  	git bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
>  	git bisect visualize &
>  	git bisect good c52851b60cc0aaaf974ff0e49989fb698220447d
>  	.. go into the "file" menu, and select "re-read references" ..
>  	git-bisect good 7e1f19e50371e1d148226b64c8edc77fec47fa5b
>  	.. do "re-read references" again ..
> 
>  and you'll see exactly what "git bisect" is doing).
> 
>  You claimed that the previous commit (7e1f19..) was good, and that 
>  9011bff.. itself was bad). So if that was true, then it really _was_ that 
>  9011bff.. commit that caused it.
> 
>  > What did I do wrong this time?
> 
>  You did nothing wrong, unless your _testing_ was wrong, and one of your 
>  "git bisect good" entries should have been bad, or the other way around 
>  (you booted into the wrong kernel, so you thought something was ok when it 
>  wasn't).
> 
>  Why are you so sure that git bisect gave the wrong answer? This is ACPI, 
>  after all. For all we know, subtle cache-effects could break it.
> 
>  "git bisect" sadly won't help with bugs that show up due to some other 
>  subtle interaction..
> 
>  Anyway, my first guess would be that you might have marked something good 
>  or bad that wasn't. How sure are you about that initial "git bisect bad" 
>  you did?

Am pretty confident.


bix:/usr/src/25> grep '^commit ' patches/git-acpi.patch 
commit 9011bff4bdc0fef1f9a782d7415c306ee61826c9		<- This was my `bad'
commit 5d882e684aafea30c508d86d235327d94e1d38ae
commit 14394600cdfe0c952ce662a32a68c5c5524d32ac
commit da95181baf3cf6a2bd81c0c8af1d4c6790703e4f
commit b128440ed11d108c375772b7fe9ad46d2ac07084		<- This was the bug
commit 61ce94e1f8b16b1694475adba9bf2e07fac02020
commit a48142ea89e02ed0aba0a481ead1e9302e1a4160
commit d5c11d3ba31d6ead24f27de648dc2dcfde5092e3
commit f6a08bf2cb06ee3d5be749cf20685b677619bc8e
commit 2cb7f1704275905b7548eee299c554bcdc5cf357
commit 2ce2b16467f0d43d0f8933eb4821b2369b31888c
commit 8ec0cbd9386a40a3afffad78334f4403b256dc4b
commit ba8acc597cff47fcbbd7b9f0d73a59e784852d8b
commit 7e9e8344848d80c9b6e1b9eaf32dd498b48ca5bb
commit d2606159ffdf8e435f6a7714f8e8910672b944d5
commit 8fb1d47b74e2bad912f74783048b433a1e313799
commit f7c0fce6da5cb68b8b0e203df4ff8ef9b3265105
commit 61e295946a248e43cf244cb24097e284d1d00e35
commit a32283362a7a8e7cff608fe25299a59925daea4d
commit 4cd5611ca16348b3805ddcf89b97fe670e76faaa
commit 529758bad4b0f9a8eec56fcc5cad342e9680ea36
commit 91afb9e683426ff238aab159e60f6d6e792e7488
commit 9f102deee398ea4dfcee3b2108dc00bc59ea877b
commit e85eb9a47f19a26b636b58106e309f8db6b2415d
commit 4597ac50598b85a09417df531849b80ce2e8e44b
commit 74951d613e758f9709d6f2173107be68f18f77f4
commit e6f1f3c54974a30c65ea0b699809d12f0aa04272
commit c12ea918ee175ceb3a258cd81f1c43e897d0c0bc
commit eefa27a93a0490902f33837ac86dbcf344b3aa29
commit ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
commit df42baa0d8e54df18dd9366dd7c93d6be7d5d063
commit 200739c179c63d21804e9e8e2ced265243831579
commit 5e15b92d07fb11490c886c5dd7567f523ea43e2d
commit 9224a867c497053842dc595e594ca6d32112221f
commit 459c7266d7a5c1730169258217e25fdd1b7ca854
commit 1a36561607abf1405b56a41aac2fd163429cd1f8
commit e4513a57ef719d3d6d1cee0ca4d9f4016aa452bb
commit 578b333bfe8eb1360207a08a53c321822a8f40f3
commit 9d9f749b316ac21cb59ad3e595cbce469b409e1a
commit cd090eedd85256829f762677d0752a846c1b88b9
commit 81507ea9cfa64e9851b53e0fefebfa776eda9ecb
commit 1c6e7d0aeecac38e66b1bb63e3eff07b2a1c2f2c
commit b5f2490b6e3317059e87ba40d4f659d1c30afc1f
commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d
commit 7e1f19e50371e1d148226b64c8edc77fec47fa5b
commit 1300124f69cafc54331bc06e968a8dd67863f989
commit ec7381d6bfd3e7b8d2880dd5e9d03b131b0603f6
commit 8313524a0d466f451a62709aaedf988d8257b21c
commit ea936b78f46cbe089a4ac363e1682dee7d427096
commit 52fc0b026e99b5d5d585095148d997d5634bbc25
commit 46358614ed5b031797522f1020e989c959a8d8a6
commit 6665bda76461308868bd1e52caf627f4cb29ed32
commit fdc136ccd3332938e989439c025c363f8479f3e6
commit a1f9e65e2085e0a87f28a4d5a8ae43b32c087f24
commit 1fee94034917aa711fcbd4ebf4c36f7ebd9fa7d6
commit 0eacee585a89ce5827b572a73a024931506bef48
commit 9cfda2c94df61c9f859b474abe774c65a4464d0a
commit d52bb94d56676acd9bdac8e097257a87b4b1b2e1
commit c52851b60cc0aaaf974ff0e49989fb698220447d
commit 09b4d1ee881c8593bfad2a42f838d85070365c3e
commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
commit ffd642e748c867a7339b57225b8bf8b9a0dcd9c5      <- This was my `good'
commit f9ea7fd8be9827791f407ca1191ff70ec25eb2d9
commit b60e49b2383db0334bef1f0d9cdad9bec2336050
commit 1ca218d3bd6acca0922a349cb76e3244d27ebfba

and git-bisect claimed that 9011bff4bdc0fef1f9a782d7415c306ee61826c9
introduced the bug.  
