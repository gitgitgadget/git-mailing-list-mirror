From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/18] ls_colors.c: add $LS_COLORS parsing code
Date: Sun, 30 Mar 2014 20:55:52 +0700
Message-ID: <1396187769-30863-2-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEB-0003CN-6M
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaC3N4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:08 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:37306 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaC3Nzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:55:49 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so6866385pde.10
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A9NEmQvJ04lZMz+gPvCIpI/NLmaX4ir6bylcka7c3iA=;
        b=tcDEgRn+mpO/Qp/P39BecIrHn3PTs0Am/IY2U2eX0/h5hpm0QVxAACF4y4Nf/ufTih
         R/bYOOcgAX+IAb81yJR+xmCRSGlSG206o4YvCFdl0cuSfLVk0o5MnvEVdj0YTytiQd/d
         x3dzhuK4A1Jw3LgJmeYOwbG2sLaULHz4mji3tPswrKtkZRI7vrx1DhMBYpdq7AI+AXEX
         mRT0e3dvPR2ucaZzuSM5bXmIpfgQt3AfDlZtvlUokP5s4Be+M98OTSvTGAgWbEWEjwYL
         i02lf2FhB9svV1T/ZET53YXJH7BroyxEzpSq6MNQvrsgXWVo7mLSGYaknDeski8MzzAu
         bXsA==
X-Received: by 10.66.12.67 with SMTP id w3mr19551961pab.29.1396187748052;
        Sun, 30 Mar 2014 06:55:48 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id pi1sm26219572pac.14.2014.03.30.06.55.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:55:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:56:45 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245473>

Reusing color settings from $LS_COLORS could give a native look and
feel on file coloring.

This code is basically from coreutils.git [1], rewritten to fit Git.

As this is from GNU ls, the environment variable CLICOLOR is not
tested. It is to be decided later whether we should ignore $LS_COLORS
if $CLICOLOR is not set on Mac or FreeBSD.

[1] commit 7326d1f1a67edf21947ae98194f98c38b6e9e527 file
    src/ls.c. This is the last GPL-2 commit before coreutils turns to
    GPL-3.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile          |   1 +
 color.h           |   8 ++
 ls_colors.c (new) | 398 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 ls_colors.c

diff --git a/Makefile b/Makefile
index f818eec..f6a6e14 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,7 @@ LIB_OBJS +=3D list-objects.o
 LIB_OBJS +=3D ll-merge.o
 LIB_OBJS +=3D lockfile.o
 LIB_OBJS +=3D log-tree.o
+LIB_OBJS +=3D ls_colors.o
 LIB_OBJS +=3D mailmap.o
 LIB_OBJS +=3D match-trees.o
 LIB_OBJS +=3D merge.o
diff --git a/color.h b/color.h
index 9a8495b..640fc48 100644
--- a/color.h
+++ b/color.h
@@ -45,6 +45,12 @@ struct strbuf;
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
=20
+#define GIT_COLOR_WHITE_ON_RED    "\033[37;41m"
+#define GIT_COLOR_WHITE_ON_BLUE   "\033[37;44m"
+#define GIT_COLOR_BLACK_ON_YELLOW "\033[30;43m"
+#define GIT_COLOR_BLUE_ON_GREEN   "\033[34;42m"
+#define GIT_COLOR_BLACK_ON_GREEN  "\033[30;42m"
+
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
=20
@@ -87,4 +93,6 @@ void color_print_strbuf(FILE *fp, const char *color, =
const struct strbuf *sb);
=20
 int color_is_nil(const char *color);
=20
+void parse_ls_color(void);
+
 #endif /* COLOR_H */
diff --git a/ls_colors.c b/ls_colors.c
new file mode 100644
index 0000000..eb944f4
--- /dev/null
+++ b/ls_colors.c
@@ -0,0 +1,398 @@
+#include "cache.h"
+#include "color.h"
+
+enum color_ls {
+	LS_LC,			/* left, unused */
+	LS_RC,			/* right, unused */
+	LS_EC,			/* end color, unused */
+	LS_RS,			/* reset */
+	LS_NO,			/* normal */
+	LS_FL,			/* file, default */
+	LS_DI,			/* directory */
+	LS_LN,			/* symlink */
+
+	LS_PI,			/* pipe */
+	LS_SO,			/* socket */
+	LS_BD,			/* block device */
+	LS_CD,			/* char device */
+	LS_MI,			/* missing file */
+	LS_OR,			/* orphaned symlink */
+	LS_EX,			/* executable */
+	LS_DO,			/* Solaris door */
+
+	LS_SU,			/* setuid */
+	LS_SG,			/* setgid */
+	LS_ST,			/* sticky */
+	LS_OW,			/* other-writable */
+	LS_TW,			/* ow with sticky */
+	LS_CA,			/* cap */
+	LS_MH,			/* multi hardlink */
+	LS_CL,			/* clear end of line */
+
+	MAX_LS
+};
+
+static char ls_colors[MAX_LS][COLOR_MAXLEN] =3D {
+	"",
+	"",
+	"",
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,
+	GIT_COLOR_NORMAL,
+	GIT_COLOR_BOLD_BLUE,
+	GIT_COLOR_BOLD_CYAN,
+
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BOLD_MAGENTA,
+	GIT_COLOR_BOLD_YELLOW,
+	GIT_COLOR_BOLD_YELLOW,
+	GIT_COLOR_NORMAL,
+	GIT_COLOR_NORMAL,
+	GIT_COLOR_BOLD_GREEN,
+	GIT_COLOR_BOLD_MAGENTA,
+
+	GIT_COLOR_WHITE_ON_RED,
+	GIT_COLOR_BLACK_ON_YELLOW,
+	GIT_COLOR_WHITE_ON_BLUE,
+	GIT_COLOR_BLUE_ON_GREEN,
+	GIT_COLOR_BLACK_ON_GREEN,
+	"",
+	"",
+	""
+};
+
+static const char *const indicator_name[] =3D {
+	"lc", "rc", "ec", "rs", "no", "fi", "di", "ln",
+	"pi", "so", "bd", "cd", "mi", "or", "ex", "do",
+	"su", "sg", "st", "ow", "tw", "ca", "mh", "cl",
+	NULL
+};
+
+struct bin_str {
+	size_t len;			/* Number of bytes */
+	const char *string;		/* Pointer to the same */
+};
+
+struct color_ext_type {
+	struct bin_str ext;		/* The extension we're looking for */
+	struct bin_str seq;		/* The sequence to output when we do */
+	struct color_ext_type *next;	/* Next in list */
+};
+
+static struct color_ext_type *color_ext_list =3D NULL;
+
+/*
+ * When true, in a color listing, color each symlink name according to=
 the
+ * type of file it points to.  Otherwise, color them according to the =
`ln'
+ * directive in LS_COLORS.  Dangling (orphan) symlinks are treated spe=
cially,
+ * regardless.  This is set when `ln=3Dtarget' appears in LS_COLORS.
+ */
+static int color_symlink_as_referent;
+
+/*
+ * Parse a string as part of the LS_COLORS variable; this may involve
+ * decoding all kinds of escape characters.  If equals_end is set an
+ * unescaped equal sign ends the string, otherwise only a : or \0
+ * does.  Set *OUTPUT_COUNT to the number of bytes output.  Return
+ * true if successful.
+ *
+ * The resulting string is *not* null-terminated, but may contain
+ * embedded nulls.
+ *
+ * Note that both dest and src are char **; on return they point to
+ * the first free byte after the array and the character that ended
+ * the input string, respectively.
+ */
+static int get_funky_string(char **dest, const char **src, int equals_=
end,
+			    size_t *output_count)
+{
+	char num;			/* For numerical codes */
+	size_t count;			/* Something to count with */
+	enum {
+		ST_GND, ST_BACKSLASH, ST_OCTAL, ST_HEX,
+		ST_CARET, ST_END, ST_ERROR
+	} state;
+	const char *p;
+	char *q;
+
+	p =3D *src;			/* We don't want to double-indirect */
+	q =3D *dest;			/* the whole darn time.  */
+
+	count =3D 0;			/* No characters counted in yet.  */
+	num =3D 0;
+
+	state =3D ST_GND;		/* Start in ground state.  */
+	while (state < ST_END) {
+		switch (state) {
+		case ST_GND:		/* Ground state (no escapes) */
+			switch (*p) {
+			case ':':
+			case '\0':
+				state =3D ST_END;	/* End of string */
+				break;
+			case '\\':
+				state =3D ST_BACKSLASH; /* Backslash scape sequence */
+				++p;
+				break;
+			case '^':
+				state =3D ST_CARET; /* Caret escape */
+				++p;
+				break;
+			case '=3D':
+				if (equals_end) {
+					state =3D ST_END; /* End */
+					break;
+				}
+				/* else fall through */
+			default:
+				*(q++) =3D *(p++);
+				++count;
+				break;
+			}
+			break;
+
+		case ST_BACKSLASH:	/* Backslash escaped character */
+			switch (*p) {
+			case '0':
+			case '1':
+			case '2':
+			case '3':
+			case '4':
+			case '5':
+			case '6':
+			case '7':
+				state =3D ST_OCTAL;	/* Octal sequence */
+				num =3D *p - '0';
+				break;
+			case 'x':
+			case 'X':
+				state =3D ST_HEX;	/* Hex sequence */
+				num =3D 0;
+				break;
+			case 'a':		/* Bell */
+				num =3D '\a';
+				break;
+			case 'b':		/* Backspace */
+				num =3D '\b';
+				break;
+			case 'e':		/* Escape */
+				num =3D 27;
+				break;
+			case 'f':		/* Form feed */
+				num =3D '\f';
+				break;
+			case 'n':		/* Newline */
+				num =3D '\n';
+				break;
+			case 'r':		/* Carriage return */
+				num =3D '\r';
+				break;
+			case 't':		/* Tab */
+				num =3D '\t';
+				break;
+			case 'v':		/* Vtab */
+				num =3D '\v';
+				break;
+			case '?':		/* Delete */
+				num =3D 127;
+				break;
+			case '_':		/* Space */
+				num =3D ' ';
+				break;
+			case '\0':		/* End of string */
+				state =3D ST_ERROR;	/* Error! */
+				break;
+			default:		/* Escaped character like \ ^ : =3D */
+				num =3D *p;
+				break;
+			}
+			if (state =3D=3D ST_BACKSLASH) {
+				*(q++) =3D num;
+				++count;
+				state =3D ST_GND;
+			}
+			++p;
+			break;
+
+		case ST_OCTAL:		/* Octal sequence */
+			if (*p < '0' || *p > '7') {
+				*(q++) =3D num;
+				++count;
+				state =3D ST_GND;
+			} else
+				num =3D (num << 3) + (*(p++) - '0');
+			break;
+
+		case ST_HEX:		/* Hex sequence */
+			switch (*p) {
+			case '0':
+			case '1':
+			case '2':
+			case '3':
+			case '4':
+			case '5':
+			case '6':
+			case '7':
+			case '8':
+			case '9':
+				num =3D (num << 4) + (*(p++) - '0');
+				break;
+			case 'a':
+			case 'b':
+			case 'c':
+			case 'd':
+			case 'e':
+			case 'f':
+				num =3D (num << 4) + (*(p++) - 'a') + 10;
+				break;
+			case 'A':
+			case 'B':
+			case 'C':
+			case 'D':
+			case 'E':
+			case 'F':
+				num =3D (num << 4) + (*(p++) - 'A') + 10;
+				break;
+			default:
+				*(q++) =3D num;
+				++count;
+				state =3D ST_GND;
+				break;
+			}
+			break;
+
+		case ST_CARET:		/* Caret escape */
+			state =3D ST_GND;	/* Should be the next state... */
+			if (*p >=3D '@' && *p <=3D '~') {
+				*(q++) =3D *(p++) & 037;
+				++count;
+			} else if (*p =3D=3D '?') {
+				*(q++) =3D 127;
+				++count;
+			} else
+				state =3D ST_ERROR;
+			break;
+
+		default:
+			abort();
+		}
+	}
+
+	*dest =3D q;
+	*src =3D p;
+	*output_count =3D count;
+
+	return state !=3D ST_ERROR;
+}
+
+void parse_ls_color(void)
+{
+	const char *p;			/* Pointer to character being parsed */
+	char *buf;			/* color_buf buffer pointer */
+	int state;			/* State of parser */
+	int ind_no;			/* Indicator number */
+	char label[3];			/* Indicator label */
+	struct color_ext_type *ext;	/* Extension we are working on */
+	static char *color_buf;
+	char *start;
+	size_t len;
+
+	if ((p =3D getenv("LS_COLORS")) =3D=3D NULL || *p =3D=3D '\0')
+		return;
+
+	ext =3D NULL;
+	strcpy (label, "??");
+
+	/*
+	 * This is an overly conservative estimate, but any possible
+	 * LS_COLORS string will *not* generate a color_buf longer
+	 * than itself, so it is a safe way of allocating a buffer in
+	 * advance.
+	 */
+	buf =3D color_buf =3D xstrdup(p);
+
+	state =3D 1;
+	while (state > 0) {
+		switch (state) {
+		case 1:		/* First label character */
+			switch (*p) {
+			case ':':
+				++p;
+				break;
+
+			case '*':
+				/*
+				 * Allocate new extension block and add to head of
+				 * linked list (this way a later definition will
+				 * override an earlier one, which can be useful for
+				 * having terminal-specific defs override global).
+				 */
+
+				ext =3D xmalloc(sizeof *ext);
+				ext->next =3D color_ext_list;
+				color_ext_list =3D ext;
+
+				++p;
+				ext->ext.string =3D buf;
+
+				state =3D (get_funky_string(&buf, &p, 1, &ext->ext.len)
+					 ? 4 : -1);
+				break;
+
+			case '\0':
+				state =3D 0;	/* Done! */
+				break;
+
+			default:	/* Assume it is file type label */
+				label[0] =3D *(p++);
+				state =3D 2;
+				break;
+			}
+			break;
+
+		case 2:		/* Second label character */
+			if (*p) {
+				label[1] =3D *(p++);
+				state =3D 3;
+			} else
+				state =3D -1;	/* Error */
+			break;
+
+		case 3:		/* Equal sign after indicator label */
+			state =3D -1;	/* Assume failure...  */
+			if (*(p++) !=3D '=3D')
+				break;
+			for (ind_no =3D 0; indicator_name[ind_no] !=3D NULL; ++ind_no) {
+				if (!strcmp(label, indicator_name[ind_no])) {
+					start =3D buf;
+					if (get_funky_string(&buf, &p, 0, &len))
+						state =3D 1;
+					else
+						state =3D -1;
+					break;
+				}
+			}
+			if (state =3D=3D -1)
+				error(_("unrecognized prefix: %s"), label);
+			else if (ind_no =3D=3D LS_LN && len =3D=3D 6 &&
+				 starts_with(start, "target"))
+				color_symlink_as_referent =3D 1;
+			else
+				sprintf(ls_colors[ind_no], "\033[%.*sm",
+				       (int)len, start);
+			break;
+
+		case 4:		/* Equal sign after *.ext */
+			if (*(p++) =3D=3D '=3D') {
+				ext->seq.string =3D buf;
+				state =3D (get_funky_string(&buf, &p, 0, &ext->seq.len)
+					 ? 1 : -1);
+			} else
+				state =3D -1;
+			break;
+		}
+	}
+
+	if (!strcmp(ls_colors[LS_LN], "target"))
+		color_symlink_as_referent =3D 1;
+}
--=20
1.9.1.345.ga1a145c
