From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] Import $LS_COLORS parsing code from coreutils
Date: Thu, 20 Mar 2014 17:15:44 +0700
Message-ID: <1395310551-23201-2-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:15:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa0t-0000g1-TM
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbaCTKPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:15:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43985 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCTKPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:15:46 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so727140pad.16
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2A4OUB+7HFRc/ZqF5h3r1Cw7ma5V2+kjqP+knFKfPQQ=;
        b=AFuxnjTll8adl7pIP+6rTv18RUK8G+7zUyjuzqgLS3gUZG19Bf49YSR4hLr24XAj3+
         R7WrNPIH26C8OfOAGh0mYdZg1tmWE+45KQvSuUOKlDIKLRDumYMtfPMxGjsTAB8UY1S1
         SDriiO3IopHS02eiZLTHV1l+LVnkx4XJKrRXl6vqhgV4zvk6uki3S0Azm2kLnKLNOzmv
         b1kmsTyTc0oilzEzPHRlKWNbOMk1Y8SQokyrj67U2dCnZ27D/yM5VtJFfwcww2BeoUwj
         ACZxAjhn61OO3ctjqeHtHsw1/HfP0skDUxdABxclJesB0KlLYT4N5aiENW5SwOR3yyow
         mQ4g==
X-Received: by 10.67.1.202 with SMTP id bi10mr46067066pad.68.1395310545623;
        Thu, 20 Mar 2014 03:15:45 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id kt8sm7856139pab.7.2014.03.20.03.15.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:15:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:15:58 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244531>

This could could help highlight files in ls-files or status output, or
even diff --name-only (but that's questionable).

This code is from coreutils.git commit
7326d1f1a67edf21947ae98194f98c38b6e9e527 file src/ls.c. This is the
last GPL-2 commit before coreutils turns to GPL-3.

The code is reformatted to fit Git coding style, which is more than
just adding and removing spaces. For example, "bool" is replaced with
"int", or true/false replaced with 1/0, or the use of git's error()
instead of error(3). There are also two "#if 0" to make it build with
git-compat-util.h.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile          |   1 +
 ls_colors.c (new) | 477 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 ls_colors.h (new) |  20 +++
 3 files changed, 498 insertions(+)
 create mode 100644 ls_colors.c
 create mode 100644 ls_colors.h

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
diff --git a/ls_colors.c b/ls_colors.c
new file mode 100644
index 0000000..6385446
--- /dev/null
+++ b/ls_colors.c
@@ -0,0 +1,477 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "ls_colors.h"
+
+#define STREQ(a, b) (strcmp(a, b) =3D=3D 0)
+
+enum indicator_no {
+	C_LEFT, C_RIGHT, C_END, C_NORM, C_FILE, C_DIR, C_LINK, C_FIFO, C_SOCK=
,
+	C_BLK, C_CHR, C_MISSING, C_ORPHAN, C_EXEC, C_DOOR, C_SETUID, C_SETGID=
,
+	C_STICKY, C_OTHER_WRITABLE, C_STICKY_OTHER_WRITABLE
+};
+
+#define FILETYPE_INDICATORS				\
+  {							\
+    C_ORPHAN, C_FIFO, C_CHR, C_DIR, C_BLK, C_FILE,	\
+    C_LINK, C_SOCK, C_FILE, C_DIR			\
+  }
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
+static const char *const indicator_name[]=3D {
+	"lc", "rc", "ec", "no", "fi", "di", "ln", "pi", "so",
+	"bd", "cd", "mi", "or", "ex", "do", "su", "sg", "st",
+	"ow", "tw", NULL
+};
+
+#define LEN_STR_PAIR(s) sizeof(s) - 1, s
+static struct bin_str color_indicator[] =3D {
+	{ LEN_STR_PAIR("\033[") },	/* lc: Left of color sequence */
+	{ LEN_STR_PAIR("m") },		/* rc: Right of color sequence */
+	{ 0, NULL },			/* ec: End color (replaces lc+no+rc) */
+	{ LEN_STR_PAIR("0") },		/* no: Normal */
+	{ LEN_STR_PAIR("0") },		/* fi: File: default */
+	{ LEN_STR_PAIR("01;34") },	/* di: Directory: bright blue */
+	{ LEN_STR_PAIR("01;36") },	/* ln: Symlink: bright cyan */
+	{ LEN_STR_PAIR("33") },		/* pi: Pipe: yellow/brown */
+	{ LEN_STR_PAIR("01;35") },	/* so: Socket: bright magenta */
+	{ LEN_STR_PAIR("01;33") },	/* bd: Block device: bright yellow */
+	{ LEN_STR_PAIR("01;33") },	/* cd: Char device: bright yellow */
+	{ 0, NULL },			/* mi: Missing file: undefined */
+	{ 0, NULL },			/* or: Orphaned symlink: undefined */
+	{ LEN_STR_PAIR("01;32") },	/* ex: Executable: bright green */
+	{ LEN_STR_PAIR("01;35") },	/* do: Door: bright magenta */
+	{ LEN_STR_PAIR("37;41") },	/* su: setuid: white on red */
+	{ LEN_STR_PAIR("30;43") },	/* sg: setgid: black on yellow */
+	{ LEN_STR_PAIR("37;44") },	/* st: sticky: black on blue */
+	{ LEN_STR_PAIR("34;42") },	/* ow: other-writable: blue on green */
+	{ LEN_STR_PAIR("30;42") },	/* tw: ow w/ sticky: black on green */
+};
+
+static struct color_ext_type *color_ext_list =3D NULL;
+/* Buffer for color sequences */
+static char *color_buf;
+
+/*
+ * True means use colors to mark types.  Also define the different
+ * colors as well as the stuff for the LS_COLORS environment variable.
+ * The LS_COLORS variable is now in a termcap-like format.
+ */
+static int print_with_color;
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
+			if (*(p++) =3D=3D '=3D') { /* It *should* be...  */
+				for (ind_no =3D 0; indicator_name[ind_no] !=3D NULL; ++ind_no) {
+					if (STREQ (label, indicator_name[ind_no])) {
+						color_indicator[ind_no].string =3D buf;
+						state =3D (get_funky_string(&buf, &p, 0,
+									  &color_indicator[ind_no].len)
+							 ? 1 : -1);
+						break;
+					}
+				}
+				if (state =3D=3D -1)
+					error(_("unrecognized prefix: %s"), label);
+			}
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
+	if (state < 0) {
+		struct color_ext_type *e;
+		struct color_ext_type *e2;
+
+		error(_("unparsable value for LS_COLORS environment variable"));
+		free(color_buf);
+		for (e =3D color_ext_list; e !=3D NULL; /* empty */) {
+			e2 =3D e;
+			e =3D e->next;
+			free(e2);
+		}
+		print_with_color =3D 0;
+	}
+
+	if (color_indicator[C_LINK].len =3D=3D 6 &&
+	    !strncmp(color_indicator[C_LINK].string, "target", 6))
+		color_symlink_as_referent =3D 1;
+}
+
+/* Output a color indicator (which may contain nulls).  */
+static void put_indicator(const struct bin_str *ind)
+{
+	size_t i;
+	const char *p;
+
+	p =3D ind->string;
+
+	for (i =3D ind->len; i !=3D 0; --i)
+		putchar(*(p++));
+}
+
+void print_color_indicator(const char *name, mode_t mode, int linkok,
+			   int stat_ok, enum filetype filetype)
+{
+	int type;
+	struct color_ext_type *ext;	/* Color extension */
+	size_t len;			/* Length of name */
+
+	/* Is this a nonexistent file?  If so, linkok =3D=3D -1.  */
+
+	if (linkok =3D=3D -1 && color_indicator[C_MISSING].string !=3D NULL)
+		type =3D C_MISSING;
+	else if (!stat_ok) {
+		static enum indicator_no filetype_indicator[] =3D FILETYPE_INDICATOR=
S;
+		type =3D filetype_indicator[filetype];
+	} else {
+		if (S_ISREG(mode)) {
+			type =3D C_FILE;
+			if ((mode & S_ISUID) !=3D 0)
+				type =3D C_SETUID;
+			else if ((mode & S_ISGID) !=3D 0)
+				type =3D C_SETGID;
+#if 0
+			else if ((mode & S_IXUGO) !=3D 0)
+				type =3D C_EXEC;
+#endif
+		} else if (S_ISDIR(mode)) {
+			if ((mode & S_ISVTX) && (mode & S_IWOTH))
+				type =3D C_STICKY_OTHER_WRITABLE;
+			else if ((mode & S_IWOTH) !=3D 0)
+				type =3D C_OTHER_WRITABLE;
+			else if ((mode & S_ISVTX) !=3D 0)
+				type =3D C_STICKY;
+			else
+				type =3D C_DIR;
+		} else if (S_ISLNK(mode))
+			type =3D ((!linkok && color_indicator[C_ORPHAN].string)
+				? C_ORPHAN : C_LINK);
+		else if (S_ISFIFO(mode))
+			type =3D C_FIFO;
+		else if (S_ISSOCK(mode))
+			type =3D C_SOCK;
+		else if (S_ISBLK(mode))
+			type =3D C_BLK;
+		else if (S_ISCHR(mode))
+			type =3D C_CHR;
+#if 0
+		else if (S_ISDOOR(mode))
+			type =3D C_DOOR;
+#endif
+		else {
+			/* Classify a file of some other type as C_ORPHAN.  */
+			type =3D C_ORPHAN;
+		}
+	}
+
+	/* Check the file's suffix only if still classified as C_FILE.  */
+	ext =3D NULL;
+	if (type =3D=3D C_FILE) {
+		/* Test if NAME has a recognized suffix.  */
+
+		len =3D strlen(name);
+		name +=3D len;		/* Pointer to final \0.  */
+		for (ext =3D color_ext_list; ext !=3D NULL; ext =3D ext->next) {
+			if (ext->ext.len <=3D len
+			    && strncmp(name - ext->ext.len, ext->ext.string,
+				       ext->ext.len) =3D=3D 0)
+				break;
+		}
+	}
+
+	put_indicator(&color_indicator[C_LEFT]);
+	put_indicator(ext ? &(ext->seq) : &color_indicator[type]);
+	put_indicator(&color_indicator[C_RIGHT]);
+}
diff --git a/ls_colors.h b/ls_colors.h
new file mode 100644
index 0000000..3201be6
--- /dev/null
+++ b/ls_colors.h
@@ -0,0 +1,20 @@
+#ifndef LS_COLORS_H
+#define LS_COLORS_H
+
+enum filetype {
+	unknown,
+	fifo,
+	chardev,
+	directory,
+	blockdev,
+	normal,
+	symbolic_link,
+	sock,
+	whiteout,
+	arg_directory
+};
+
+void parse_ls_color(void);
+void print_color_indicator(const char *name, mode_t mode, int linkok,
+			   int stat_ok, enum filetype filetype);
+#endif
--=20
1.9.0.40.gaa8c3ea
