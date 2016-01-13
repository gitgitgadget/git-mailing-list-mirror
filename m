From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/5] nedmalloc: allow compiling with MSys2's compiler
Date: Wed, 13 Jan 2016 14:31:05 +0100 (CET)
Message-ID: <cb506b103e7102073a1567044727837ab8ff5c64.1452691805.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLWE-0002Xz-KS
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760666AbcAMNbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:31:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:56046 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760653AbcAMNbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:31:10 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MePcd-1aXIYf2jNf-00QFZj; Wed, 13 Jan 2016 14:31:06
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:NxNanARg1in0kZiYo34usXrXv8Neh7cXlH1lQ1bi8YhjmmIWuFJ
 boXqdgJiod/k/UMfM51HSxmCGm3TYm0fhvJ103JvrgNwY9kF21V7wTapo7w6CgDnenKWQ2p
 88PzufxCxMptHEQLkhlwm0yRDeltKUC3KNYAOz82+X1oKw4thSLJmhClwmSNEhV80BDEwEb
 6oFKQ9yjxK/3lPEhZcnDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3vOWH2CopG0=:psCCwvKRWdJFfYOf8HyQA1
 14hnT+PsqpkQUworJeRLTnWdsmezizs81/D3ZxJadDlZ+3R/EJwYzmMftELWFXO9Fxx7oi+49
 sTMqgyW/TmsatvcNAITBdRVsqBgLj8m7v93jUv/pSP6ZjgV8smKGc7vj392vj1TpzHftOtkej
 JJ49nkOV8d2yP+3FqDCx6P7HmwwlfLYhV4slL2WAQHJYOYegLMtS0GedTCWhIu6APiwmGmvyB
 KMBj5JjseYQueflaMa/JTedxmu+r0M/+qTEBI0vUEkYwS8oYPskGx3z77oN/9GrDfmnO8BKoM
 hO4yXCgGiqL59HgjzNS76EsBadRe88zRGs2XfWBH+xrhxqlnRacWMZYyuxs5t56tdFloflUk3
 gRogcD7PnHx5pPIyC+ejYmXczKSC+H8d29NMmDBL0hRALLDJfeR3tO1gkIwv+4BALWgA05PUc
 YymyJZr9OgeVnGYDpro+/nfAvu45DwGWl8ERQVZH3Tnlo83x63u8RLwnKXJkkEIzy69IJZjwc
 6g8h/RgcZEvM9PJECBvCSnXd92KeBNWG7/SORpjs/xJHF70d1rTctN6H16Xz5WJumTYbGx58s
 SOgphFrD3+Cusgr72abFXXbUCRrLfO0D8Zt73oG3SE59+HhBk9juq6LcSAZNod9Rv2N0+xsrr
 hr0zN7TZPNKtYPRdBD2y7aaGqLZ1jLZULQlzwHpK1VhqXzwhZDmxD6NeZw9dqxGeeT8jlgfYa
 t51axoXISWAnZ2TR/jBMaeDtzG3YAn87/gGhh8K8+yP5vv3LZCzAGv2PuZgWINxaQL5DTo0o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283917>

With MSys2's GCC, `ReadWriteBarrier` is already defined, and FORCEINLINE
unfortunately gets defined incorrectly.

Let's work around both problems, using the MSys2-specific
__MINGW64_VERSION_MAJOR constant to guard them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/malloc.c.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..18634e3 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -720,6 +720,9 @@ struct mallinfo {
   inlining are defined as macros, so these aren't used for them.
 */
 
+#ifdef __MINGW64_VERSION_MAJOR
+#undef FORCEINLINE
+#endif
 #ifndef FORCEINLINE
   #if defined(__GNUC__)
 #define FORCEINLINE __inline __attribute__ ((always_inline))
@@ -1382,6 +1385,9 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 
   /*** Atomic operations ***/
   #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
+    #ifdef __MINGW64_VERSION_MAJOR
+      #undef _ReadWriteBarrier
+    #endif
     #define _ReadWriteBarrier() __sync_synchronize()
   #else
     static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
-- 
2.6.3.windows.1.300.g1c25e49
