From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 4/6] Win32: add Unicode conversion functions
Date: Sat,  7 Jun 2014 09:57:23 +0200
Message-ID: <1402127845-4862-5-git-send-email-kasal@ucw.cz>
References: <20140606183935.GA4197@camelia.ucw.cz>
 <1402127845-4862-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com Sat Jun 07 09:57:33 2014
Return-path: <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>)
	id 1WtBVJ-0004YO-IP
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:57:29 +0200
Received: by mail-wg0-f59.google.com with SMTP id k14sf376501wgh.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=maWb+69fUIGDLt7MWCNy0bOVAqUOajP8O2cXj3kyUKg=;
        b=hK1ZJqmrkx1pRSsOP2Ud13QOPNHpE7gCHhJOcrACVFJ941EEKB/zFz5fPhink9h6+v
         TAAbXAN0DKJuaZGrgSfDYIiPhdQDfrAFy655/dcXaKFzCAFtA6BNoHSiUiXv0yQ3k2lv
         EQ79BGLUyRWwahbiA57KTGO9Vk5j5nZz6/Usv1wsJQ+aBxnYfTbzNEykBlHMNjruH6h2
         mjCGvLzxLWVSUNuyasEj/wJA97ZUyvQCK0iMDFeN1iNFhB6vfzC4AlXU54XVo91n+xQ7
         CcY8YgTWI4umgRa9me+7eQSkp74ZWeOVq5RpIrOe8KkXjWY0qtgSKolhPm2GNbleWG4N
         U4Yg==
X-Received: by 10.152.18.134 with SMTP id w6mr132399lad.1.1402127848960;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.22.195 with SMTP id g3ls216284laf.59.gmail; Sat, 07 Jun
 2014 00:57:27 -0700 (PDT)
X-Received: by 10.152.42.141 with SMTP id o13mr86780lal.7.1402127847942;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si88300wiw.1.2014.06.07.00.57.27
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id B58D51C00AA; Sat,  7 Jun 2014 09:57:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402127845-4862-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251036>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 25 Nov 2011 21:05:06 +0100

Add Unicode conversion functions to convert between Windows native UTF-16LE
encoding to UTF-8 and back.

To support repositories with legacy-encoded file names, the UTF-8 to UTF-16
conversion function tries to create valid, unique file names even for
invalid UTF-8 byte sequences, so that these repositories can be checked out
without error.

The current implementation leaves invalid UTF-8 bytes in range 0xa0 - 0xff
as is (producing printable Unicode chars \u00a0 - \u00ff, equivalent to
ISO-8859-1), and converts 0x80 - 0x9f to hex-code (\u0080 - \u009f are
control chars).

The Windows MultiByteToWideChar API was not used as it either drops invalid
UTF-8 sequences (on Win2k/XP; producing non-unique or even empty file
names) or converts them to the replacement char \ufffd (Vista/7; causing
ERROR_INVALID_NAME in subsequent calls to file system APIs).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c |  85 ++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index c03bafa..6f1fb10 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1848,6 +1848,91 @@ int mingw_offset_1st_component(const char *path)
 	return offset + is_dir_sep(path[offset]);
 }
 
+int xutftowcsn(wchar_t *wcs, const char *utfs, size_t wcslen, int utflen)
+{
+	int upos = 0, wpos = 0;
+	const unsigned char *utf = (const unsigned char*) utfs;
+	if (!utf || !wcs || wcslen < 1) {
+		errno = EINVAL;
+		return -1;
+	}
+	/* reserve space for \0 */
+	wcslen--;
+	if (utflen < 0)
+		utflen = INT_MAX;
+
+	while (upos < utflen) {
+		int c = utf[upos++] & 0xff;
+		if (utflen == INT_MAX && c == 0)
+			break;
+
+		if (wpos >= wcslen) {
+			wcs[wpos] = 0;
+			errno = ERANGE;
+			return -1;
+		}
+
+		if (c < 0x80) {
+			/* ASCII */
+			wcs[wpos++] = c;
+		} else if (c >= 0xc2 && c < 0xe0 && upos < utflen &&
+				(utf[upos] & 0xc0) == 0x80) {
+			/* 2-byte utf-8 */
+			c = ((c & 0x1f) << 6);
+			c |= (utf[upos++] & 0x3f);
+			wcs[wpos++] = c;
+		} else if (c >= 0xe0 && c < 0xf0 && upos + 1 < utflen &&
+				!(c == 0xe0 && utf[upos] < 0xa0) && /* over-long encoding */
+				(utf[upos] & 0xc0) == 0x80 &&
+				(utf[upos + 1] & 0xc0) == 0x80) {
+			/* 3-byte utf-8 */
+			c = ((c & 0x0f) << 12);
+			c |= ((utf[upos++] & 0x3f) << 6);
+			c |= (utf[upos++] & 0x3f);
+			wcs[wpos++] = c;
+		} else if (c >= 0xf0 && c < 0xf5 && upos + 2 < utflen &&
+				wpos + 1 < wcslen &&
+				!(c == 0xf0 && utf[upos] < 0x90) && /* over-long encoding */
+				!(c == 0xf4 && utf[upos] >= 0x90) && /* > \u10ffff */
+				(utf[upos] & 0xc0) == 0x80 &&
+				(utf[upos + 1] & 0xc0) == 0x80 &&
+				(utf[upos + 2] & 0xc0) == 0x80) {
+			/* 4-byte utf-8: convert to \ud8xx \udcxx surrogate pair */
+			c = ((c & 0x07) << 18);
+			c |= ((utf[upos++] & 0x3f) << 12);
+			c |= ((utf[upos++] & 0x3f) << 6);
+			c |= (utf[upos++] & 0x3f);
+			c -= 0x10000;
+			wcs[wpos++] = 0xd800 | (c >> 10);
+			wcs[wpos++] = 0xdc00 | (c & 0x3ff);
+		} else if (c >= 0xa0) {
+			/* invalid utf-8 byte, printable unicode char: convert 1:1 */
+			wcs[wpos++] = c;
+		} else {
+			/* invalid utf-8 byte, non-printable unicode: convert to hex */
+			static const char *hex = "0123456789abcdef";
+			wcs[wpos++] = hex[c >> 4];
+			if (wpos < wcslen)
+				wcs[wpos++] = hex[c & 0x0f];
+		}
+	}
+	wcs[wpos] = 0;
+	return wpos;
+}
+
+int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
+{
+	if (!wcs || !utf || utflen < 1) {
+		errno = EINVAL;
+		return -1;
+	}
+	utflen = WideCharToMultiByte(CP_UTF8, 0, wcs, -1, utf, utflen, NULL, NULL);
+	if (utflen)
+		return utflen - 1;
+	errno = ERANGE;
+	return -1;
+}
+
 void mingw_startup()
 {
 	/* copy executable name to argv[0] */
diff --git a/compat/mingw.h b/compat/mingw.h
index d3cffb7..921ba08 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -357,6 +357,110 @@ void mingw_open_html(const char *path);
 char **make_augmented_environ(const char *const *vars);
 void free_environ(char **env);
 
+/**
+ * Converts UTF-8 encoded string to UTF-16LE.
+ *
+ * To support repositories with legacy-encoded file names, invalid UTF-8 bytes
+ * 0xa0 - 0xff are converted to corresponding printable Unicode chars \u00a0 -
+ * \u00ff, and invalid UTF-8 bytes 0x80 - 0x9f (which would make non-printable
+ * Unicode) are converted to hex-code.
+ *
+ * Lead-bytes not followed by an appropriate number of trail-bytes, over-long
+ * encodings and 4-byte encodings > \u10ffff are detected as invalid UTF-8.
+ *
+ * Maximum space requirement for the target buffer is two wide chars per UTF-8
+ * char (((strlen(utf) * 2) + 1) [* sizeof(wchar_t)]).
+ *
+ * The maximum space is needed only if the entire input string consists of
+ * invalid UTF-8 bytes in range 0x80-0x9f, as per the following table:
+ *
+ *               |                   | UTF-8 | UTF-16 |
+ *   Code point  |  UTF-8 sequence   | bytes | words  | ratio
+ * --------------+-------------------+-------+--------+-------
+ * 000000-00007f | 0-7f              |   1   |   1    |  1
+ * 000080-0007ff | c2-df + 80-bf     |   2   |   1    |  0.5
+ * 000800-00ffff | e0-ef + 2 * 80-bf |   3   |   1    |  0.33
+ * 010000-10ffff | f0-f4 + 3 * 80-bf |   4   |  2 (a) |  0.5
+ * invalid       | 80-9f             |   1   |  2 (b) |  2
+ * invalid       | a0-ff             |   1   |   1    |  1
+ *
+ * (a) encoded as UTF-16 surrogate pair
+ * (b) encoded as two hex digits
+ *
+ * Note that, while the UTF-8 encoding scheme can be extended to 5-byte, 6-byte
+ * or even indefinite-byte sequences, the largest valid code point \u10ffff
+ * encodes as only 4 UTF-8 bytes.
+ *
+ * Parameters:
+ * wcs: wide char target buffer
+ * utf: string to convert
+ * wcslen: size of target buffer (in wchar_t's)
+ * utflen: size of string to convert, or -1 if 0-terminated
+ *
+ * Returns:
+ * length of converted string (_wcslen(wcs)), or -1 on failure
+ *
+ * Errors:
+ * EINVAL: one of the input parameters is invalid (e.g. NULL)
+ * ERANGE: the output buffer is too small
+ */
+int xutftowcsn(wchar_t *wcs, const char *utf, size_t wcslen, int utflen);
+
+/**
+ * Simplified variant of xutftowcsn, assumes input string is \0-terminated.
+ */
+static inline int xutftowcs(wchar_t *wcs, const char *utf, size_t wcslen)
+{
+	return xutftowcsn(wcs, utf, wcslen, -1);
+}
+
+/**
+ * Simplified file system specific variant of xutftowcsn, assumes output
+ * buffer size is MAX_PATH wide chars and input string is \0-terminated,
+ * fails with ENAMETOOLONG if input string is too long.
+ */
+static inline int xutftowcs_path(wchar_t *wcs, const char *utf)
+{
+	int result = xutftowcsn(wcs, utf, MAX_PATH, -1);
+	if (result < 0 && errno == ERANGE)
+		errno = ENAMETOOLONG;
+	return result;
+}
+
+/**
+ * Converts UTF-16LE encoded string to UTF-8.
+ *
+ * Maximum space requirement for the target buffer is three UTF-8 chars per
+ * wide char ((_wcslen(wcs) * 3) + 1).
+ *
+ * The maximum space is needed only if the entire input string consists of
+ * UTF-16 words in range 0x0800-0xd7ff or 0xe000-0xffff (i.e. \u0800-\uffff
+ * modulo surrogate pairs), as per the following table:
+ *
+ *               |                       | UTF-16 | UTF-8 |
+ *   Code point  |  UTF-16 sequence      | words  | bytes | ratio
+ * --------------+-----------------------+--------+-------+-------
+ * 000000-00007f | 0000-007f             |   1    |   1   |  1
+ * 000080-0007ff | 0080-07ff             |   1    |   2   |  2
+ * 000800-00ffff | 0800-d7ff / e000-ffff |   1    |   3   |  3
+ * 010000-10ffff | d800-dbff + dc00-dfff |   2    |   4   |  2
+ *
+ * Note that invalid code points > 10ffff cannot be represented in UTF-16.
+ *
+ * Parameters:
+ * utf: target buffer
+ * wcs: wide string to convert
+ * utflen: size of target buffer
+ *
+ * Returns:
+ * length of converted string, or -1 on failure
+ *
+ * Errors:
+ * EINVAL: one of the input parameters is invalid (e.g. NULL)
+ * ERANGE: the output buffer is too small
+ */
+int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen);
+
 /*
  * A critical section used in the implementation of the spawn
  * functions (mingw_spawnv[p]e()) and waitpid(). Intialised in
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
