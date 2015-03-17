From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/14] numparse: new module for parsing integral numbers
Date: Tue, 17 Mar 2015 17:00:03 +0100
Message-ID: <1426608016-2978-2-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvC-00015M-8q
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbbCQQAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43300 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932146AbbCQQAc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:32 -0400
X-AuditID: 12074414-f797f6d000004084-16-55084f98d4bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 06.3C.16516.89F48055; Tue, 17 Mar 2015 12:00:24 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSc023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:24 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqDvDnyPU4Ge/qUXXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6Mr1t2sxdM
	i6s4dOU+SwPjI/cuRk4OCQETiY1LP7BB2GISF+6tB7K5OIQELjNKbFq+nx0kISRwkkli+t04
	EJtNQFdiUU8zE4gtIqAmMbHtEAuIzSyQItH55w5YvbCAh8TBCa/AhrIIqErM+7EHrIZXwFli
	yvLLjBDL5CTOH//JDGJzCrhIvPjzmhFil7PE2mmT2SYw8i5gZFjFKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuhl5tZopeaUrqJERI8IjsYj5yUO8QowMGoxMPbkMceKsSaWFZcmXuIUZKDSUmU
	N8+DI1SILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO8dd6Acb0piZVVqUT5MSpqDRUmc99tidT8h
	gfTEktTs1NSC1CKYrAwHh5IEr44fUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KDLii4GxAZLiAdr7CaSdt7ggMRcoCtF6ilFRSpz3jS9QQgAkkVGaBzcWlhJeMYoDfSnMKwJM
	EEI8wHQC1/0KaDAT0OCWdjaQwSWJCCmpBsbO/CrHKAeN2beezG53DxYzuil03iT7ofG+JwrW
	v26bHD8h78DHdTpO+R+X3Hu1J1zCn5esnajwTrk69PiepklZm0KCpz1347IrfLou9W7f1rLQ
	Uyetvv80nfD6xcqQj3IP3xy+unt519cNmdUVfGXnlda/mr/nVN3j9pJnxaletya8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265634>

Implement wrappers for strtol() and strtoul() that are safer and more
convenient to use.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile   |   1 +
 numparse.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 numparse.h | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 numparse.c
 create mode 100644 numparse.h

diff --git a/Makefile b/Makefile
index 44f1dd1..6c0cfcc 100644
--- a/Makefile
+++ b/Makefile
@@ -732,6 +732,7 @@ LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
+LIB_OBJS += numparse.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
diff --git a/numparse.c b/numparse.c
new file mode 100644
index 0000000..90b44ce
--- /dev/null
+++ b/numparse.c
@@ -0,0 +1,180 @@
+#include "git-compat-util.h"
+#include "numparse.h"
+
+#define NUM_NEGATIVE (1 << 16)
+
+
+static int parse_precheck(const char *s, unsigned int *flags)
+{
+	const char *number;
+
+	if (isspace(*s)) {
+		if (!(*flags & NUM_LEADING_WHITESPACE))
+			return -NUM_LEADING_WHITESPACE;
+		do {
+			s++;
+		} while (isspace(*s));
+	}
+
+	if (*s == '+') {
+		if (!(*flags & NUM_PLUS))
+			return -NUM_PLUS;
+		number = s + 1;
+		*flags &= ~NUM_NEGATIVE;
+	} else if (*s == '-') {
+		if (!(*flags & NUM_MINUS))
+			return -NUM_MINUS;
+		number = s + 1;
+		*flags |= NUM_NEGATIVE;
+	} else {
+		number = s;
+		*flags &= ~NUM_NEGATIVE;
+	}
+
+	if (!(*flags & NUM_BASE_SPECIFIER)) {
+		int base = *flags & NUM_BASE_MASK;
+		if (base == 0) {
+			/* This is a pointless combination of options. */
+			die("BUG: base=0 specified without NUM_BASE_SPECIFIER");
+		} else if (base == 16 && starts_with(number, "0x")) {
+			/*
+			 * We want to treat this as zero terminated by
+			 * an 'x', whereas strtol()/strtoul() would
+			 * silently eat the "0x". We accomplish this
+			 * by treating it as a base 10 number:
+			 */
+			*flags = (*flags & ~NUM_BASE_MASK) | 10;
+		}
+	}
+	return 0;
+}
+
+int parse_l(const char *s, unsigned int flags, long *result, char **endptr)
+{
+	long l;
+	const char *end;
+	int err = 0;
+
+	err = parse_precheck(s, &flags);
+	if (err)
+		return err;
+
+	/*
+	 * Now let strtol() do the heavy lifting:
+	 */
+	errno = 0;
+	l = strtol(s, (char **)&end, flags & NUM_BASE_MASK);
+	if (errno) {
+		if (errno == ERANGE) {
+			if (!(flags & NUM_SATURATE))
+				return -NUM_SATURATE;
+		} else {
+			return -NUM_OTHER_ERROR;
+		}
+	}
+	if (end == s)
+		return -NUM_NO_DIGITS;
+
+	if (*end && !(flags & NUM_TRAILING))
+		return -NUM_TRAILING;
+
+	/* Everything was OK */
+	*result = l;
+	if (endptr)
+		*endptr = (char *)end;
+	return 0;
+}
+
+int parse_ul(const char *s, unsigned int flags,
+	     unsigned long *result, char **endptr)
+{
+	unsigned long ul;
+	const char *end;
+	int err = 0;
+
+	err = parse_precheck(s, &flags);
+	if (err)
+		return err;
+
+	/*
+	 * Now let strtoul() do the heavy lifting:
+	 */
+	errno = 0;
+	ul = strtoul(s, (char **)&end, flags & NUM_BASE_MASK);
+	if (errno) {
+		if (errno == ERANGE) {
+			if (!(flags & NUM_SATURATE))
+				return -NUM_SATURATE;
+		} else {
+			return -NUM_OTHER_ERROR;
+		}
+	}
+	if (end == s)
+		return -NUM_NO_DIGITS;
+
+	/*
+	 * strtoul(), perversely, accepts negative numbers, converting
+	 * them to the positive number with the same bit pattern. We
+	 * don't ever want that.
+	 */
+	if ((flags & NUM_NEGATIVE) && ul) {
+		if (!(flags & NUM_SATURATE))
+			return -NUM_SATURATE;
+		ul = 0;
+	}
+
+	if (*end && !(flags & NUM_TRAILING))
+		return -NUM_TRAILING;
+
+	/* Everything was OK */
+	*result = ul;
+	if (endptr)
+		*endptr = (char *)end;
+	return 0;
+}
+
+int parse_i(const char *s, unsigned int flags, int *result, char **endptr)
+{
+	long l;
+	int err;
+	char *end;
+
+	err = parse_l(s, flags, &l, &end);
+	if (err)
+		return err;
+
+	if ((int)l == l)
+		*result = l;
+	else if (!(flags & NUM_SATURATE))
+		return -NUM_SATURATE;
+	else
+		*result = (l <= 0) ? INT_MIN : INT_MAX;
+
+	if (endptr)
+		*endptr = end;
+
+	return 0;
+}
+
+int parse_ui(const char *s, unsigned int flags, unsigned int *result, char **endptr)
+{
+	unsigned long ul;
+	int err;
+	char *end;
+
+	err = parse_ul(s, flags, &ul, &end);
+	if (err)
+		return err;
+
+	if ((unsigned int)ul == ul)
+		*result = ul;
+	else if (!(flags & NUM_SATURATE))
+		return -NUM_SATURATE;
+	else
+		*result = UINT_MAX;
+
+	if (endptr)
+		*endptr = end;
+
+	return 0;
+}
diff --git a/numparse.h b/numparse.h
new file mode 100644
index 0000000..4de5e10
--- /dev/null
+++ b/numparse.h
@@ -0,0 +1,207 @@
+#ifndef NUMPARSE_H
+#define NUMPARSE_H
+
+/*
+ * Functions for parsing integral numbers.
+ *
+ * strtol() and strtoul() are very flexible, in fact too flexible for
+ * many purposes. These functions wrap them to make them easier to use
+ * in a stricter way.
+ *
+ * There are two classes of function, parse_*() and convert_*(). The
+ * former try to read a number from the front of a string and report a
+ * pointer to the character following the number. The latter don't
+ * report the end of the number, and are meant to be used when the
+ * input string should contain only a single number, with no trailing
+ * characters.
+ *
+ * Each class of functions has four variants:
+ *
+ * - parse_l(), convert_l() -- parse long ints
+ * - parse_ul(), convert_ul() -- parse unsigned long ints
+ * - parse_i(), convert_i() -- parse ints
+ * - parse_ui(), convert_ui() -- parse unsigned ints
+ *
+ * The style of parsing is controlled by a flags argument which
+ * encodes both the base of the number and many other options. The
+ * base is encoded by its numerical value (2 <= base <= 36), or zero
+ * if it should be determined automatically based on whether the
+ * number has a "0x" or "0" prefix.
+ *
+ * The functions all return zero on success. On error, they return a
+ * negative integer indicating the first error that was detected. For
+ * example, if no sign characters were allowed but the string
+ * contained a '-', the function will return -NUM_MINUS. If there is
+ * any kind of error, *result and *endptr are unchanged.
+ *
+ * Examples:
+ *
+ * - Convert hexadecimal string s into an unsigned int. Die if there
+ *   are any characters in s besides hexadecimal digits, or if the
+ *   result exceeds the range of an unsigned int:
+ *
+ *     if (convert_ui(s, 16, &result))
+ *             die("...");
+ *
+ * - Read a base-ten long number from the front of a string, allowing
+ *   sign characters and setting endptr to point at any trailing
+ *   characters:
+ *
+ *     if (parse_l(s, 10 | NUM_SIGN | NUM_TRAILING, &result, &endptr))
+ *             die("...");
+ *
+ * - Convert decimal string s into a signed int, but not allowing the
+ *   string to contain a '+' or '-' prefix (and thereby indirectly
+ *   ensuring that the result will be non-negative):
+ *
+ *     if (convert_i(s, 10, &result))
+ *             die("...");
+ *
+ * - Convert s into a signed int, interpreting prefix "0x" to mean
+ *   hexadecimal and "0" to mean octal. If the value doesn't fit in an
+ *   unsigned int, set result to INT_MIN or INT_MAX.
+ *
+ *     if (convert_i(s, NUM_SLOPPY, &result))
+ *             die("...");
+ */
+
+
+/*
+ * Constants for parsing numbers.
+ *
+ * These can be passed in flags to allow the specified features. Also,
+ * if there is an error parsing a number, the parsing functions return
+ * the negated value of one of these constants (or NUM_NO_DIGITS or
+ * NUM_OTHER_ERROR) to indicate the first error detected.
+ */
+
+/*
+ * The lowest 6 bits of flags hold the numerical base that should be
+ * used to parse the number, 2 <= base <= 36. If base is set to 0,
+ * then NUM_BASE_SPECIFIER must be set too; in this case, the base is
+ * detected automatically from the string's prefix.
+ */
+#define NUM_BASE_MASK 0x3f
+
+/* Skip any whitespace before the number. */
+#define NUM_LEADING_WHITESPACE (1 << 8)
+
+/* Allow a leading '+'. */
+#define NUM_PLUS               (1 << 9)
+
+/* Allow a leading '-'. */
+#define NUM_MINUS              (1 << 10)
+
+/*
+ * Allow a leading base specifier:
+ * - If base is 0: a leading "0x" indicates base 16; a leading "0"
+ *   indicates base 8; otherwise, assume base 10.
+ * - If base is 16: a leading "0x" is allowed and skipped over.
+ */
+#define NUM_BASE_SPECIFIER     (1 << 11)
+
+/*
+ * If the number is not in the allowed range, return the smallest or
+ * largest representable value instead.
+ */
+#define NUM_SATURATE           (1 << 12)
+
+/*
+ * Just parse until the end of the number, ignoring any subsequent
+ * characters. If this option is not specified, then it is an error if
+ * the whole string cannot be parsed.
+ */
+#define NUM_TRAILING           (1 << 13)
+
+
+/* Additional errors that can come from parsing numbers: */
+
+/* There were no valid digits */
+#define NUM_NO_DIGITS          (1 << 14)
+/* There was some other error reported by strtol()/strtoul(): */
+#define NUM_OTHER_ERROR        (1 << 15)
+
+/*
+ * Please note that there is also a NUM_NEGATIVE, which is used
+ * internally.
+ */
+
+/*
+ * Now define some useful combinations of parsing options:
+ */
+
+/* A bunch of digits with an optional sign. */
+#define NUM_SIGN (NUM_PLUS | NUM_MINUS)
+
+/*
+ * Be as liberal as possible with the form of the number itself
+ * (though if you also want to allow leading whitespace and/or
+ * trailing characters, you should combine this with
+ * NUM_LEADING_WHITESPACE and/or NUM_TRAILING).
+ */
+#define NUM_SLOPPY (NUM_SIGN | NUM_SATURATE | NUM_BASE_SPECIFIER)
+
+
+/*
+ * Number parsing functions:
+ *
+ * The following functions parse a number (long, unsigned long, int,
+ * or unsigned int respectively) from the front of s, storing the
+ * value to *result and storing a pointer to the first character after
+ * the number to *endptr. flags specifies how the number should be
+ * parsed, including which base should be used. flags is a combination
+ * of the numerical base (2-36) and the NUM_* constants above (see).
+ * Return 0 on success or a negative value if there was an error. On
+ * failure, *result and *entptr are left unchanged.
+ *
+ * Please note that if NUM_TRAILING is not set, then it is
+ * nevertheless an error if there are any characters between the end
+ * of the number and the end of the string.
+ */
+
+int parse_l(const char *s, unsigned int flags,
+	    long *result, char **endptr);
+
+int parse_ul(const char *s, unsigned int flags,
+	     unsigned long *result, char **endptr);
+
+int parse_i(const char *s, unsigned int flags,
+	    int *result, char **endptr);
+
+int parse_ui(const char *s, unsigned int flags,
+	     unsigned int *result, char **endptr);
+
+
+/*
+ * Number conversion functions:
+ *
+ * The following functions parse a string into a number. They are
+ * identical to the parse_*() functions above, except that the endptr
+ * is not returned. These are most useful when parsing a whole string
+ * into a number; i.e., when (flags & NUM_TRAILING) is unset.
+ */
+static inline int convert_l(const char *s, unsigned int flags,
+			    long *result)
+{
+	return parse_l(s, flags, result, NULL);
+}
+
+static inline int convert_ul(const char *s, unsigned int flags,
+			     unsigned long *result)
+{
+	return parse_ul(s, flags, result, NULL);
+}
+
+static inline int convert_i(const char *s, unsigned int flags,
+			    int *result)
+{
+	return parse_i(s, flags, result, NULL);
+}
+
+static inline int convert_ui(const char *s, unsigned int flags,
+			     unsigned int *result)
+{
+	return parse_ui(s, flags, result, NULL);
+}
+
+#endif /* NUMPARSE_H */
-- 
2.1.4
