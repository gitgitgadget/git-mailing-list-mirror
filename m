From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 03:43:51 -0500
Message-ID: <20141210084351.GA29776@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:44:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XycsJ-0005XV-R5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 09:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaLJInz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 03:43:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:50921 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751527AbaLJIny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 03:43:54 -0500
Received: (qmail 24567 invoked by uid 102); 10 Dec 2014 08:43:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 02:43:54 -0600
Received: (qmail 7433 invoked by uid 107); 10 Dec 2014 08:43:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 03:43:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 03:43:51 -0500
Content-Disposition: inline
In-Reply-To: <20141209222337.GA16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261195>

On Tue, Dec 09, 2014 at 02:23:37PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Elsewhere I mentioned a tool to extract comments and format them. But do
> > people actually care about the formatting step?
> 
> If formatting means "convert to a straightforward text document that I
> can read through", then I do.

I meant "run asciidoc in api-*". I am confused by your response. Here it
implies to me that you asciidoc them into a text format to make it
easier to read. But below you say "I also view [the api-* files] as
text", which implies you just look at them in your editor.

> >                                                 Does anybody asciidoc
> > the technical/api-* files? We did not even support building them until
> > sometime in 2012. Personally, I only ever view them as text.
> 
> I also view them as text.  I tend to find it easier to read the
> technical/api-* files than headers.  That might be for the same reason
> that some other people prefer header files --- a
> Documentation/technical/ file tends to be written in one chunk
> together and ends up saying exactly what I need to know about the
> calling sequence in a coherent way, while header files tend to evolve
> over time to match the implementation without maintaining that
> organization and usability.

We could probably do a better job of keeping our header files neat and
well-ordered. And perhaps would so if they had a coherent narrative in
the first place.

My feeling is that it is at least as much work to keep an api-*.txt file
neat as it would be to keep the header file neat (generally more,
because of the duplication of effort). The one exception might be that
ordering in the header file may require some forward declarations. I'd
guess that to be pretty rare, though (and certainly I did not run into
it when converting the strbuf documentation below).

> I suspect a simple tool to extract the comments and produce something
> like the technical/api-* files would help, since then when someone
> writes a patch, they could try the tool and see if the result is still
> easy to read.

That seems like wishful thinking to me. Some subset of developers will
be happy reading the documentation in the header file, and will not
commonly run the tool. Therefore they will also not bother to examine
the output of the tool when making a change (either because they forget,
or because it is simply a hassle that they do not care about).

> Anyway, the patch I wrote was an attempt at a minimal fix (and an
> attempt at getting out of a conversation that seemed to be moving
> toward bikeshedding).  If someone wants to move the documentation from
> api-strbuf.txt to strbuf.h, I won't object, since I hope that a simple
> tool like described above isn't too far away.

I do not mind a partial or minimal fix. This conversion is tedious, and
it does not have to be done all at once. But IMHO, your patch is
actively making things worse. The api-* files have slowly grown out of
date over the years, and I believe that is because they are too far
removed from the code people are actually touching. I've been making an
active effort recently to document function interfaces in comments, and
I feel like the presence of other comments has encouraged me to do so.

Here's strbuf.h, with the data from api-strbuf.txt moved into it. I
followed the ordering of api-strbuf.txt, since that has a more coherent
grouping of functions (but it does make the latter parts of the diff
messier, as we have to move function declarations around). I left the
bottom part of strbuf.h, where there are several undocumented functions,
largely untouched. As further work, it would make sense to document
those functions and also fit them into the right spot amidst the
already-grouped functions.

This has almost every bit of text from api-strbuf.txt. I omitted a few
descriptions where the documentation already in strbuf.h was actually
_better_. I did remove the function names, sine they are redundant with
the declarations below. E.g., rather than:

  /**
    * `foo`::
    *         Do something.
    */
  void foo(int x);

just:

  /**
    * Do something.
    */
  void foo(int x);

The declaration is nearby and has strictly more information, and the
less boilerplate the better for convincing people to actually write
something. An extraction tool can pretty-print the function name if it
wants.

I did drop some asciidoc-specific formatting from the main text (e.g.,
"+" lines for connecting blocks), which means that extracting the result
and running it through asciidoc won't work. I think it makes the actual
text much more readable, though. But we could do it the other way if
people really want to asciidoc it.

---
diff --git a/strbuf.h b/strbuf.h
index 652b6c4..6143680 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,22 +1,105 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
-/* See Documentation/technical/api-strbuf.txt */
-
-extern char strbuf_slopbuf[];
+/**
+ * strbuf's are meant to be used with all the usual C string and memory
+ * APIs. Given that the length of the buffer is known, it's often better to
+ * use the mem* functions than a str* one (memchr vs. strchr e.g.).
+ * Though, one has to be careful about the fact that str* functions often
+ * stop on NULs and that strbufs may have embedded NULs.
+ *
+ * A strbuf is NUL terminated for convenience, but no function in the
+ * strbuf API actually relies on the string being free of NULs.
+ *
+ * strbufs have some invariants that are very important to keep in mind:
+ *
+ * . The `buf` member is never NULL, so it can be used in any usual C
+ * string operations safely. strbuf's _have_ to be initialized either by
+ * `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
+ *
+ * Do *not* assume anything on what `buf` really is (e.g. if it is
+ * allocated memory or not), use `strbuf_detach()` to unwrap a memory
+ * buffer from its strbuf shell in a safe way. That is the sole supported
+ * way. This will give you a malloced buffer that you can later `free()`.
+ *
+ * However, it is totally safe to modify anything in the string pointed by
+ * the `buf` member, between the indices `0` and `len-1` (inclusive).
+ *
+ * . The `buf` member is a byte array that has at least `len + 1` bytes
+ *   allocated. The extra byte is used to store a `'\0'`, allowing the
+ *   `buf` member to be a valid C-string. Every strbuf function ensure this
+ *   invariant is preserved.
+ *
+ * NOTE: It is OK to "play" with the buffer directly if you work it this
+ *       way:
+ *
+ * ----
+ * strbuf_grow(sb, SOME_SIZE); <1>
+ * strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ * ----
+ * <1> Here, the memory array starting at `sb->buf`, and of length
+ * `strbuf_avail(sb)` is all yours, and you can be sure that
+ * `strbuf_avail(sb)` is at least `SOME_SIZE`.
+ *
+ * NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
+ *
+ * Doing so is safe, though if it has to be done in many places, adding the
+ * missing API to the strbuf module is the way to go.
+ *
+ * WARNING: Do _not_ assume that the area that is yours is of size `alloc
+ * - 1` even if it's true in the current implementation. Alloc is somehow a
+ * "private" member that should not be messed with. Use `strbuf_avail()`
+ * instead.
+*/
+
+/**
+ * This is the string buffer structure. The `len` member can be used to
+ * determine the current length of the string, and `buf` member provides
+ * access to the string itself.
+ */
 struct strbuf {
 	size_t alloc;
 	size_t len;
 	char *buf;
 };
 
+extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
 
-/*----- strbuf life cycle -----*/
+/** strbuf lifecycle */
+
+/**
+ *	Initialize the structure. The second parameter can be zero or a bigger
+ *	number to allocate memory, in case you want to prevent further reallocs.
+ */
 extern void strbuf_init(struct strbuf *, size_t);
+
+/**
+ *	Release a string buffer and the memory it used. You should not use the
+ *	string buffer after using this function, unless you initialize it again.
+ */
 extern void strbuf_release(struct strbuf *);
+
+/**
+ * Detach the string from the strbuf and returns it; you now own the
+ * storage the string occupies and it is your responsibility from then on
+ * to release it with `free(3)` when you are done with it.
+ */
 extern char *strbuf_detach(struct strbuf *, size_t *);
+
+/**
+ * Attach a string to a buffer. You should specify the string to attach,
+ * the current length of the string and the amount of allocated memory.
+ * The amount must be larger than the string length, because the string you
+ * pass is supposed to be a NUL-terminated string.  This string _must_ be
+ * malloc()ed, and after attaching, the pointer cannot be relied upon
+ * anymore, and neither be free()d directly.
+ */
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
+
+/**
+ * Swap the contents of two string buffers.
+ */
 static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 {
 	struct strbuf tmp = *a;
@@ -24,14 +107,33 @@ static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 	*b = tmp;
 }
 
-/*----- strbuf size related -----*/
+
+/** Related to the size of the buffer */
+
+/**
+ * Determine the amount of allocated but unused memory.
+ */
 static inline size_t strbuf_avail(const struct strbuf *sb)
 {
 	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
 }
 
+/**
+ * Ensure that at least this amount of unused memory is available after
+ * `len`. This is used when you know a typical size for what you will add
+ * and want to avoid repetitive automatic resizing of the underlying buffer.
+ * This is never a needed operation, but can be critical for performance in
+ * some cases.
+ */
 extern void strbuf_grow(struct strbuf *, size_t);
 
+/**
+ * Set the length of the buffer to a given value. This function does *not*
+ * allocate new memory, so you should not perform a `strbuf_setlen()` to a
+ * length that is larger than `len + strbuf_avail()`. `strbuf_setlen()` is
+ * just meant as a 'please fix invariants from this strbuf I just messed
+ * with'.
+ */
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
@@ -39,16 +141,279 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 	sb->len = len;
 	sb->buf[len] = '\0';
 }
+
+/**
+ * Empty the buffer by setting the size of it to zero.
+ */
 #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
 
-/*----- content related -----*/
+
+/** Related to the contents of the buffer */
+
+/**
+ * Strip whitespace from the beginning and end of a string.
+ * Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
+ */
 extern void strbuf_trim(struct strbuf *);
+
+/**
+ * Strip whitespace from the end of a string.
+ */
 extern void strbuf_rtrim(struct strbuf *);
+
+/**
+ * Strip whitespace from the beginning of a string.
+ */
 extern void strbuf_ltrim(struct strbuf *);
+
+/**
+ * Replace the contents of the strbuf with a reencoded form.  Returns -1
+ * on error, 0 on success.
+ */
 extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
+
+/**
+ * Lowercase each character in the buffer using `tolower`.
+ */
 extern void strbuf_tolower(struct strbuf *sb);
+
+/**
+ * Compare two buffers. Returns an integer less than, equal to, or greater
+ * than zero if the first buffer is found, respectively, to be less than,
+ * to match, or be greater than the second buffer.
+ */
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
+
+/** Adding data to the buffer
+ *
+ * NOTE: All of the functions in this section will grow the buffer as
+ * necessary.  If they fail for some reason other than memory shortage and the
+ * buffer hadn't been allocated before (i.e. the `struct strbuf` was set to
+ * `STRBUF_INIT`), then they will free() it.
+ */
+
+/**
+ * Add a single character to the buffer.
+ */
+static inline void strbuf_addch(struct strbuf *sb, int c)
+{
+	strbuf_grow(sb, 1);
+	sb->buf[sb->len++] = c;
+	sb->buf[sb->len] = '\0';
+}
+
+/**
+ * Add a character the specified number of times to the buffer.
+ */
+extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
+
+/**
+ * Insert data to the given position of the buffer. The remaining contents
+ * will be shifted, not overwritten.
+ */
+extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
+
+/**
+ * Remove given amount of data from a given position of the buffer.
+ */
+extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
+
+/**
+ * Remove the bytes between `pos..pos+len` and replace it with the given
+ * data.
+ */
+extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
+			  const void *, size_t);
+
+/**
+ * Add a NUL-terminated string to the buffer. Each line will be prepended
+ * by a comment character and a blank.
+ */
+extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
+
+
+/**
+ * Add data of given length to the buffer.
+ */
+extern void strbuf_add(struct strbuf *, const void *, size_t);
+
+/**
+ * Add a NUL-terminated string to the buffer.
+ *
+ * NOTE: This function will *always* be implemented as an inline or a macro
+ * using strlen, meaning that this is efficient to write things like:
+ *
+ *     strbuf_addstr(sb, "immediate string");
+ */
+static inline void strbuf_addstr(struct strbuf *sb, const char *s)
+{
+	strbuf_add(sb, s, strlen(s));
+}
+
+/**
+ * Copy the contents of another buffer at the end of the current one.
+ */
+static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
+{
+	strbuf_grow(sb, sb2->len);
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+
+/**
+ * Copy part of the buffer from a given position till a given length to the
+ * end of the buffer.
+ */
+extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
+
+/**
+ * This function can be used to expand a format string containing
+ * placeholders. To that end, it parses the string and calls the specified
+ * function for every percent sign found.
+ *
+ * The callback function is given a pointer to the character after the `%`
+ * and a pointer to the struct strbuf.  It is expected to add the expanded
+ * version of the placeholder to the strbuf, e.g. to add a newline
+ * character if the letter `n` appears after a `%`.  The function returns
+ * the length of the placeholder recognized and `strbuf_expand()` skips
+ * over it.
+ *
+ * The format `%%` is automatically expanded to a single `%` as a quoting
+ * mechanism; callers do not need to handle the `%` placeholder themselves,
+ * and the callback function will not be invoked for this placeholder.
+ *
+ * All other characters (non-percent and not skipped ones) are copied
+ * verbatim to the strbuf.  If the callback returned zero, meaning that the
+ * placeholder is unknown, then the percent sign is copied, too.
+ *
+ * In order to facilitate caching and to make it possible to give
+ * parameters to the callback, `strbuf_expand()` passes a context pointer,
+ * which can be used by the programmer of the callback as she sees fit.
+ */
+typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+
+/**
+ * Used as callback for `strbuf_expand()`, expects an array of
+ * struct strbuf_expand_dict_entry as context, i.e. pairs of
+ * placeholder and replacement string.  The array needs to be
+ * terminated by an entry with placeholder set to NULL.
+ */
+struct strbuf_expand_dict_entry {
+	const char *placeholder;
+	const char *value;
+};
+extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+
+/**
+ * Append the contents of one strbuf to another, quoting any
+ * percent signs ("%") into double-percents ("%%") in the
+ * destination. This is useful for literal data to be fed to either
+ * strbuf_expand or to the *printf family of functions.
+ */
+extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
+
+/**
+ * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
+ * 3.50 MiB).
+ */
+extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
+
+/**
+ * Add a formatted string to the buffer.
+ */
+__attribute__((format (printf,2,3)))
+extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+
+/**
+ * Add a formatted string prepended by a comment character and a
+ * blank to the buffer.
+ */
+__attribute__((format (printf, 2, 3)))
+extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+
+__attribute__((format (printf,2,0)))
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
+
+/**
+ * Read a given size of data from a FILE* pointer to the buffer.
+ *
+ * NOTE: The buffer is rewound if the read fails. If -1 is returned,
+ * `errno` must be consulted, like you would do for `read(3)`.
+ * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
+ * same behaviour as well.
+ */
+extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+
+/**
+ * Read the contents of a given file descriptor. The third argument can be
+ * used to give a hint about the file size, to avoid reallocs.  If read fails,
+ * any partial read is undone */
+extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+
+/**
+ * Read the contents of a file, specified by its path. The third argument
+ * can be used to give a hint about the file size, to avoid reallocs.
+ */
+extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+
+/**
+ * Read the target of a symbolic link, specified by its path.  The third
+ * argument can be used to give a hint about the size, to avoid reallocs.
+ */
+extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
+
+/**
+ * Set the buffer to the path of the current working directory.
+ */
+extern int strbuf_getcwd(struct strbuf *sb);
+
+/**
+ * Read a line from a FILE *, overwriting the existing contents
+ * of the strbuf. The second argument specifies the line
+ * terminator character, typically `'\n'`.
+ * Reading stops after the terminator or at EOF.  The terminator
+ * is removed from the buffer before returning.  Returns 0 unless
+ * there was nothing left before EOF, in which case it returns `EOF`.
+ */
+extern int strbuf_getline(struct strbuf *, FILE *, int);
+
+/**
+ * Like `strbuf_getline`, but keeps the trailing terminator (if
+ * any) in the buffer.
+ */
+extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
+
+/**
+ * Like `strbuf_getwholeline`, but operates on a file descriptor.
+ * It reads one character at a time, so it is very slow.  Do not
+ * use it unless you need the correct position in the file
+ * descriptor.
+ */
+extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
+
+/**
+ * Add a path to a buffer, converting a relative path to an
+ * absolute one in the process.  Symbolic links are not
+ * resolved.
+ */
+extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+
+/**
+ * Strip whitespace from a buffer. The second parameter controls if
+ * comments are considered contents to be removed or not.
+ */
+extern void stripspace(struct strbuf *buf, int skip_comments);
+
+/**
+ * Launch the user preferred editor to edit a file and fill the buffer
+ * with the file's contents upon the user completing their editing. The
+ * third argument can be used to set the environment which the editor is
+ * run in. If the buffer is NULL the editor is launched as usual but the
+ * file's contents are not read into the buffer upon completion.
+ */
+extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
 	if (strip_suffix_mem(sb->buf, &sb->len, suffix)) {
@@ -110,52 +475,6 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  */
 extern void strbuf_list_free(struct strbuf **);
 
-/*----- add data in your buffer -----*/
-static inline void strbuf_addch(struct strbuf *sb, int c)
-{
-	strbuf_grow(sb, 1);
-	sb->buf[sb->len++] = c;
-	sb->buf[sb->len] = '\0';
-}
-
-extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
-extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
-
-/* splice pos..pos+len with given data */
-extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
-                          const void *, size_t);
-
-extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
-
-extern void strbuf_add(struct strbuf *, const void *, size_t);
-static inline void strbuf_addstr(struct strbuf *sb, const char *s)
-{
-	strbuf_add(sb, s, strlen(s));
-}
-static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
-{
-	strbuf_grow(sb, sb2->len);
-	strbuf_add(sb, sb2->buf, sb2->len);
-}
-extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
-extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
-
-typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
-struct strbuf_expand_dict_entry {
-	const char *placeholder;
-	const char *value;
-};
-extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
-
-__attribute__((format (printf,2,3)))
-extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-__attribute__((format (printf, 2, 3)))
-extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
-__attribute__((format (printf,2,0)))
-extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
-
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
 /*
@@ -170,28 +489,11 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 		strbuf_addch(sb, '\n');
 }
 
-extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
-/* XXX: if read fails, any partial read is undone */
-extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
-extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
-extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
-extern int strbuf_getcwd(struct strbuf *sb);
-
-extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
-extern int strbuf_getline(struct strbuf *, FILE *, int);
-extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
-
-extern void stripspace(struct strbuf *buf, int skip_comments);
-extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
-
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
-extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
-
-extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
 __attribute__((format (printf,1,2)))
 extern int printf_ln(const char *fmt, ...);
