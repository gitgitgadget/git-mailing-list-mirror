From: David Aguilar <davvid@gmail.com>
Subject: Re: CommonCrypto in git
Date: Thu, 25 Jul 2013 20:54:00 -0700
Message-ID: <CAJDDKr6iC+wD2QYHVDNUDgVkL=YWBR8Ey0yRuwtEB3jyHXzxbA@mail.gmail.com>
References: <C3FBBB18-7EE1-4E2B-AA1F-BE9140F4999C@apple.com>
	<CAJDDKr7Fy-nyqrWEn2_5eA7ap4AJubPXYWx-+vFdwQYBvJQH+g@mail.gmail.com>
	<4493C427-8153-4303-B319-2CCAE02C91B5@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 05:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Z6W-0000Jw-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 05:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab3GZDyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 23:54:04 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43577 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab3GZDyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jul 2013 23:54:00 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so1539615pbb.36
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UCffpGmhXHFhJwmyvOJpoWuxrCdGxS36tLyonJ5D6P4=;
        b=JGqW4OZg20DBfY9StwgWwrpnhta6vLQdp1QKSD/aj1jaRN3eBeeBdZM5tRI40bWcEx
         jLp1txGZX61+G0pd2sGMDfmI/auRV4R989EtpbSC8CVINAsiuKhv5t0Qm2+pgIVOZQNO
         iKfXM+Ml5Tk40JXYOvTJPjKeubTUHo/fvVxlIW8IC4alGinqJoVUW8AqDZ0OQqDM75hN
         FGzfccVUDF65zQUFqQxKum8qy3lTCW1RMnqmE3yEQJnT0tNTeaKdJu+UOdJHp4vHDt20
         Ke+Zzlcq3t89iwqqhSWr/TBtO9pE1ZfvBcDteHSjhJ0WW7ud/49BsRnKvzHDcbyRCHjg
         wnlg==
X-Received: by 10.68.201.6 with SMTP id jw6mr51668119pbc.202.1374810840229;
 Thu, 25 Jul 2013 20:54:00 -0700 (PDT)
Received: by 10.70.47.1 with HTTP; Thu, 25 Jul 2013 20:54:00 -0700 (PDT)
In-Reply-To: <4493C427-8153-4303-B319-2CCAE02C91B5@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231161>

[cc:ed Eric Sunshine and the Git list since folks might be
interested.. not quite [PATCH] ready yet, but it's not too far...]

On Thu, Jul 25, 2013 at 6:00 PM, Jeremy Huddleston Sequoia
<jeremyhu@apple.com> wrote:
>
> On Jul 25, 2013, at 17:40, David Aguilar <davvid@gmail.com> wrote:
>
>> On Thu, Jul 25, 2013 at 4:19 PM, Jeremy Huddleston Sequoia
>> <jeremyhu@apple.com> wrote:
>>> Thanks for finally backtracking on this decision(*) and deciding to take my CommonCrypto changes into git.  You really should've attributed us for providing you with this patch, but at least they're there...
>>>
>>> --Jeremy
>>>
>>> *: http://git.661346.n2.nabble.com/PATCH-darwin-Use-CommonCrypto-to-compute-SHA1-td4706146.html#a4706906
>>
>> Ah, sorry for not having seen that thread; I would have certainly
>> liked to have credited you.
>>
>> There are still a few deprecation warnings when building on
>> imap-send.c on 10.8 after these changes.  We don't have a solution for
>> those yet.  The warnings are because we use things from
>> openssl/x509v3.h.
>>
>> If you are aware of an upgrade path for that functionality then I'd be
>> happy to work with the Git list to get them in (and properly attribute
>> you, of course).
>
>
> Hi David,
>
> Based on comparing deprecation warning from my changes and 1.8.3.4, it looks like you got about as far as I did (HMAC/CRAM-MD5 and SHA1).
>
> Looking back on my notes, I was intending to rewrite the connection code in imap-send.c using SecureTransport (<Security/SecureTransport.h>), but I hadn't actually started working on that.
>
> I also took a stab at replacing git's use of OpenSSL for base64 encode/decode, but I ran into some issues, and the bug has been sitting with the maintainers of CFData for a while.  I've attached patch (which has probably bitrotted) and test-case for the bug.  If you wouldn't mind, could you review the changes as I'm not confident that it's not just a bug in my code and would prefer some other eyes looking it over.
> ~ $ clang test.c -lcrypto -framework Security -framework CoreFoundation
> test.c:50:9: warning: 'EVP_DecodeBlock' is deprecated [-Wdeprecated-declarations]
>     o = EVP_DecodeBlock(out, (unsigned char *)in, strlen(in));
>         ^
> 1 warning generated.
>
> ~ $ ./a.out
> 49 <0606932735571463.1337625513@cid.outersquare.org>
> 51 <0606932735571463.1337625513@cid.outersquare.org>
>
> Thanks,
> Jeremy

Hmm.  strlen() on both outputs is the same, so it's correct in that
respect, but it does seem like a bug in CFDataGetLength().  I don't
think we deal with nulls inside the strings so that could paper over
it, but it does seem kinda wrong.

The reason is that base64 encoding requires padding of the data so
that its length is a multiple of 3, and 51 is the next divisible by 3
number.  The internals of the decoder is leaking into the interface it
seems...

I'm not sure what that would mean for backwards compatibility if
CFDataGetLength() were changed.  For Git, it seems that strlen(output)
would work for imap-send's purposes.

My assumption is that folks don't have NULL in their usernames and
passwords, which I think is sane.

I've inlined your original patch and test program below.  Jeremy, can
you help with a follow-up patch?

The style should also be adjusted to match Git's; under_scores instead
of camelCase, and tabs for indents.  I can help roll a patch together
next week if you don't beat me to it ;-)

cheers, and thanks for the patch.
-- 
David

--- test.c ---

#include <stdio.h>
#include <Security/Security.h>
#include <openssl/evp.h>

#define die(...) abort()

static int _EVP_DecodeBlock(unsigned char *out, const unsigned char
*in, int in_len) {
    CFErrorRef error;
    SecTransformRef decoder;
    CFDataRef inData, outData;
    CFIndex length, result_len;

    decoder = SecDecodeTransformCreate(kSecBase64Encoding, &error);
    if (!decoder) {
        die("SecEncodeTransformCreate failed: %ld",
(long)CFErrorGetCode(error));
    }

    inData = CFDataCreate(kCFAllocatorDefault, in, in_len);

    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName,
inData, &error);
    if (error) {
        die("SecTransformSetAttribute failed: %ld",
(long)CFErrorGetCode(error));
    }

    outData = SecTransformExecute(decoder, &error);
    if (error) {
         die("SecTransformExecute failed: %ld", (long)CFErrorGetCode(error));
    }

    length = CFDataGetLength(outData);
    CFDataGetBytes(outData, CFRangeMake(0, length), out);

    CFRelease(outData);
    CFRelease(inData);
    CFRelease(decoder);

    return (int)length;
}

int main() {
    int i;
    const char *in =
"PDA2MDY5MzI3MzU1NzE0NjMuMTMzNzYyNTUxM0BjaWQub3V0ZXJzcXVhcmUub3JnPg==";
    unsigned char out[1024];
    int o;

    o = _EVP_DecodeBlock(out, (unsigned char *)in, strlen(in));
    printf("%d %ld %s\n", o, strlen((const char *)out), out);

    o = EVP_DecodeBlock(out, (unsigned char *)in, strlen(in));
    printf("%d %ld %s\n", o, strlen((const char *)out), out);

    return 0;
}

--- >8 --- original patch --- >8 ---
commit c5d5a2cb24bc3248aa49076577131e550e2af529
Author: Jeremy Huddleston <jeremyhu@apple.com>
Date:   Thu May 17 15:19:59 2012 -0700

    <rdar://problem/11477310> Stop using OpenSSL for base64 encoding

    Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>

diff --git a/src/git/Makefile b/src/git/Makefile
index 845e7c0..f3bb32f 100644
--- a/src/git/Makefile
+++ b/src/git/Makefile
@@ -1483,6 +1483,10 @@ else
  LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
 endif
+ifdef COMMONCRYPTO
+ # We use Security.framework for base64 encoding when CommonCrypto is
enabled on Lion+
+ LIB_4_CRYPTO += -framework Security -framework CoreFoundation
+endif
 ifdef NEEDS_LIBICONV
  ifdef ICONVDIR
  BASIC_CFLAGS += -I$(ICONVDIR)/include
diff --git a/src/git/imap-send.c b/src/git/imap-send.c
index 1f4fde5..3901644 100644
--- a/src/git/imap-send.c
+++ b/src/git/imap-send.c
@@ -22,6 +22,15 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */

+/* This block needs to come first, so git-compat-util.h can overwrite
ctype.h */
+#ifdef USE_COMMONCRYPTO
+#include <CommonCrypto/CommonCrypto.h>
+
+#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
+#include <Security/Security.h>
+#endif
+#endif
+
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
@@ -33,10 +42,6 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif

-#ifdef USE_COMMONCRYPTO
-#include <CommonCrypto/CommonCrypto.h>
-#endif
-
 struct store_conf {
  char *name;
  const char *path; /* should this be here? its interpretation is
driver-specific */
@@ -952,7 +957,7 @@ static void imap_close_store(struct store *ctx)
  free(ctx);
 }

-#ifndef NO_OPENSSL
+#if !defined(NO_OPENSSL) || (defined(USE_COMMONCRYPTO) &&
defined(__MAC_OS_X_VERSION_MIN_REQUIRED) &&
__MAC_OS_X_VERSION_MIN_REQUIRED >= 1070)

 /*
  * hexchar() and cram() functions are based on the code from the isync
@@ -963,6 +968,77 @@ static char hexchar(unsigned int b)
  return b < 10 ? '0' + b : 'a' + (b - 10);
 }

+#if defined(USE_COMMONCRYPTO) &&
defined(__MAC_OS_X_VERSION_MIN_REQUIRED) &&
__MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
+#define EVP_DecodeBlock _EVP_DecodeBlock
+#define EVP_EncodeBlock _EVP_EncodeBlock
+
+static int EVP_EncodeBlock(unsigned char *out, const unsigned char
*in, int in_len) {
+    CFErrorRef error;
+    SecTransformRef encoder;
+    CFDataRef inData, outData;
+    CFIndex length;
+
+    encoder = SecEncodeTransformCreate(kSecBase64Encoding, &error);
+    if (!encoder) {
+        die("SecEncodeTransformCreate failed: %ld",
(long)CFErrorGetCode(error));
+    }
+
+    inData = CFDataCreate(kCFAllocatorDefault, in, in_len);
+
+    SecTransformSetAttribute(encoder,
kSecTransformInputAttributeName, inData, &error);
+    if (error) {
+        die("SecTransformSetAttribute failed: %ld",
(long)CFErrorGetCode(error));
+    }
+
+    outData = SecTransformExecute(encoder, &error);
+    if (error) {
+         die("SecTransformExecute failed: %ld", (long)CFErrorGetCode(error));
+    }
+
+    length = CFDataGetLength(outData);
+    CFDataGetBytes(outData, CFRangeMake(0, length), out);
+
+    CFRelease(outData);
+    CFRelease(inData);
+    CFRelease(encoder);
+
+    return (int)length;
+}
+
+static int EVP_DecodeBlock(unsigned char *out, const unsigned char
*in, int in_len) {
+    CFErrorRef error;
+    SecTransformRef decoder;
+    CFDataRef inData, outData;
+    CFIndex length;
+
+    decoder = SecDecodeTransformCreate(kSecBase64Encoding, &error);
+    if (!decoder) {
+        die("SecEncodeTransformCreate failed: %ld",
(long)CFErrorGetCode(error));
+    }
+
+    inData = CFDataCreate(kCFAllocatorDefault, in, in_len);
+
+    SecTransformSetAttribute(decoder,
kSecTransformInputAttributeName, inData, &error);
+    if (error) {
+        die("SecTransformSetAttribute failed: %ld",
(long)CFErrorGetCode(error));
+    }
+
+    outData = SecTransformExecute(decoder, &error);
+    if (error) {
+         die("SecTransformExecute failed: %ld", (long)CFErrorGetCode(error));
+    }
+
+    length = CFDataGetLength(outData);
+    CFDataGetBytes(outData, CFRangeMake(0, length), out);
+
+    CFRelease(outData);
+    CFRelease(inData);
+    CFRelease(decoder);
+
+    return (int)length;
+}
+#endif
+
 #define ENCODED_SIZE(n) (4*((n+2)/3))
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
---
