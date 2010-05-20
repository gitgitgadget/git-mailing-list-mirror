From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <totte.enea@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 11:02:01 +0200
Message-ID: <4BF4FA89.2040904@gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com> <4BF4F7D7.60002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 20 11:02:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1dx-00081H-Dw
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 11:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab0ETJCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 05:02:10 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:48829 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab0ETJCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 05:02:06 -0400
Received: by ewy8 with SMTP id 8so2950122ewy.28
        for <git@vger.kernel.org>; Thu, 20 May 2010 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kBnP49p/Da8Bz/kwsB7DJjVBDI3omsZ8IBd1IgO4Nqo=;
        b=WIrllkbkbmLZNXapjiniptn01IYRlmtSXk2hIGKCEHumUtn6fHTL/0U8RXIKy6aVD1
         fx1vCIG20WixHrIa6zbuocVSZ4jZaB6Oxmx7jg43ai1tBaCsGiWVN60KmJ7029TwZ0FP
         DkEstUp83yYJgbJ1vTEedu6wXg2fsHS9oX75I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JZMTmGBH/GZEvGM8+D0w3t6D4eqPL43MoysjrIeu5WMv5hGmTQxGX+B73XMKo4UM97
         U3NvM6OygbzsUjMwL6aKPlDBgeVwa2EBUGdJjRmC1tWhzf6cRhEr/LNo+rfYbFK/4CNk
         9AR91hLQJ1WQaSPBUXQBe3p2+0X3RFoq9I244=
Received: by 10.213.41.193 with SMTP id p1mr4166292ebe.0.1274346124002;
        Thu, 20 May 2010 02:02:04 -0700 (PDT)
Received: from birne.lan (h42n4fls31o954.telia.com [213.64.3.42])
        by mx.google.com with ESMTPS id 14sm4140339ewy.14.2010.05.20.02.02.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 02:02:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4BF4F7D7.60002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147367>

Hej,
I have the same problem here.
Below there is a patch, which may solve the problem.
(Yes, whitespaces are broken. I'm still fighting with
git format-patch -s --cover-letter -M --stdout origin/master | git=20
imap-send)
But this patch may be a start point for improvements.
Comments welcome
BR
/Torsten



Improved interwork between Mac OS X and linux when umlauts are used
When a git repository containing utf-8 coded umlaut characters
is cloned onto an Mac OS X machine, the Mac OS system will convert
all filenames returned by readdir() into denormalized utf-8.
As a result of this conversion, git will not find them on disk.
This helps by treating the NFD and NFD version of filenames as
identical on Mac OS.






Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
name-hash.c |   40 ++++++++++++++++++++++++++++++++++++++++
utf8.c      |   55 ++++++++++++++++++++++++++++++++++++++++++++++++----=
---
utf8.h      |   11 +++++++++++
3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 0031d78..e6494e8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
#define NO_THE_INDEX_COMPATIBILITY_MACROS
#include "cache.h"
+#include "utf8.h"

/*
  * This removes bit 5 if bit 6 is set.
@@ -100,6 +101,25 @@ static int same_name(const struct cache_entry *ce,=
=20
const char *name, int namelen
     return icase && slow_same_name(name, namelen, ce->name, len);
}

+#ifdef __APPLE__
+struct cache_entry *index_name_exists2(struct index_state *istate,=20
const char *name, int icase)
+{
+    int namelen =3D (int)strlen(name);
+    unsigned int hash =3D hash_name(name, namelen);
+    struct cache_entry *ce;
+
+    ce =3D lookup_hash(hash, &istate->name_hash);
+    while (ce) {
+        if (!(ce->ce_flags & CE_UNHASHED)) {
+            if (same_name(ce, name, namelen, icase))
+                return ce;
+        }
+        ce =3D ce->next;
+    }
+    return NULL;
+}
+#endif
+
struct cache_entry *index_name_exists(struct index_state *istate, const=
=20
char *name, int namelen, int icase)
{
     unsigned int hash =3D hash_name(name, namelen);
@@ -115,5 +135,25 @@ struct cache_entry *index_name_exists(struct=20
index_state *istate, const char *na
         }
         ce =3D ce->next;
     }
+#ifdef __APPLE__
+    {
+        char *name_nfc_nfd;
+        name_nfc_nfd =3D str_nfc2nfd(name);
+        if (name_nfc_nfd) {
+            ce =3D index_name_exists2(istate, name_nfc_nfd, icase);
+            free(name_nfc_nfd);
+            if (ce)
+                return ce;
+        }
+        name_nfc_nfd =3D str_nfd2nfc(name);
+        if (name_nfc_nfd) {
+            ce =3D index_name_exists2(istate, name_nfc_nfd, icase);
+            free(name_nfc_nfd);
+            if (ce)
+                return ce;
+        }
+    }
+#endif
+
     return NULL;
}
diff --git a/utf8.c b/utf8.c
index 84cfc72..8e794dc 100644
--- a/utf8.c
+++ b/utf8.c
@@ -2,6 +2,11 @@
#include "strbuf.h"
#include "utf8.h"

+#ifdef __APPLE__
+static iconv_t my_iconv_nfd2nfc =3D (iconv_t) -1;
+static iconv_t my_iconv_nfc2nfd =3D (iconv_t) -1;
+#endif
+
/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */

struct interval {
@@ -424,18 +429,13 @@ int is_encoding_utf8(const char *name)
#else
     typedef char * iconv_ibp;
#endif
-char *reencode_string(const char *in, const char *out_encoding, const=20
char *in_encoding)
+
+char *reencode_string_iconv(const char *in, iconv_t conv)
{
-    iconv_t conv;
     size_t insz, outsz, outalloc;
     char *out, *outpos;
     iconv_ibp cp;

-    if (!in_encoding)
-        return NULL;
-    conv =3D iconv_open(out_encoding, in_encoding);
-    if (conv =3D=3D (iconv_t) -1)
-        return NULL;
     insz =3D strlen(in);
     outsz =3D insz;
     outalloc =3D outsz + 1; /* for terminating NUL */
@@ -469,7 +469,48 @@ char *reencode_string(const char *in, const char=20
*out_encoding, const char *in_e
             break;
         }
     }
+    return out;
+}
+
+char *reencode_string(const char *in, const char *out_encoding, const=20
char *in_encoding)
+{
+    iconv_t conv;
+    char *out;
+
+    if (!in_encoding)
+        return NULL;
+    conv =3D iconv_open(out_encoding, in_encoding);
+    if (conv =3D=3D (iconv_t) -1)
+        return NULL;
+    out =3D reencode_string_iconv(in, conv);
     iconv_close(conv);
     return out;
}
+
+#ifdef __APPLE__
+char*
+str_nfc2nfd(const char *in)
+{
+    if (my_iconv_nfc2nfd =3D=3D (iconv_t) -1) {
+        my_iconv_nfc2nfd =3D iconv_open("utf-8-mac", "utf-8");
+        if (my_iconv_nfc2nfd =3D=3D (iconv_t) -1) {
+            return NULL;
+        }
+    }
+    return reencode_string_iconv(in, my_iconv_nfc2nfd);
+}
+
+char*
+str_nfd2nfc(const char *in)
+{
+    if (my_iconv_nfd2nfc =3D=3D (iconv_t) -1){
+        my_iconv_nfd2nfc =3D iconv_open("utf-8", "utf-8-mac");
+        if (my_iconv_nfd2nfc =3D=3D (iconv_t) -1) {
+            return NULL;
+        }
+    }
+    return reencode_string_iconv(in, my_iconv_nfd2nfc);
+}
+#endif /* APPLE */
+
#endif
diff --git a/utf8.h b/utf8.h
index ebc4d2f..db29c8a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -13,8 +13,19 @@ int strbuf_add_wrapped_text(struct strbuf *buf,

#ifndef NO_ICONV
char *reencode_string(const char *in, const char *out_encoding, const=20
char *in_encoding);
+char *reencode_string_iconv(const char *in, iconv_t conv);
+#ifdef __APPLE__
+char *str_nfc2nfd(const char *in);
+char *str_nfd2nfc(const char *in);
+#else
+#define str_nfc2nfd(in) (NULL)
+#define str_nfd2nfc(in) (NULL)
+#endif
#else
#define reencode_string(a,b,c) NULL
+#define reencode_string2(a,b) NULL
+#define str_nfc2nfd(in) (NULL)
+#define str_nfd2nfc(in) (NULL)
#endif

#endif
--=20
1.7.1.dirty










On 20.05.10 10:50, Michael J Gruber wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.05.2010=
 10:34:
>   =20
>> On Thu, May 20, 2010 at 07:26, Matthias Moeller
>> <matthias.moeller@math.tu-dortmund.de>  wrote:
>>     =20
>>> I have been searching the web for help and found lengthy discussion=
s
>>> which state that this is a common problem of the HFS+ filesystem.
>>> What I did not find was a solution to this problem. Is there a solu=
tion
>>> to this problem?
>>>       =20
>> Is this problem particular to Git, or do you also get it if you
>> e.g. rsync from the Linux box to the Mac OS X box?
>>
>>     =20
>>> #       "U\314\210bersicht.xls"
>>>       =20
>> You probably have to configure your shell on OSX to render UTF-8
>> correctly. It's just showing the raw escaped byte sequence instead o=
f
>> a character there.
>>
>> There isn't anything wrong with OSX in this case, filename encoding =
on
>> any POSIX system is only done by convention. You'll find that you ha=
ve
>> similar problems on Linux if you encode filename in Big5 or
>> UTF-32.
>>
>> Linux will happily accept it, but your shell / other applications wi=
ll
>> render it as unknown goo because they expect UTF-8.
>>     =20
> No, the problem with git status is not the display. Matthias' problem=
 is
> that git status reports a tracked file as untracked. The reason is th=
at
> on HFS+, you create a file with name A and get a file with name B, wh=
ere
> A and B are different representations of the same name. There seems t=
o
> be no way to reliably detect which one HFS+ uses.
>
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   =20
