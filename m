From: "Rob Shearman" <robertshearman@gmail.com>
Subject: [PATCH 3/3] imap-send.c: Clean up coding style to better match the rest of the git codebase.
Date: Mon, 7 Jul 2008 09:05:42 +0100
Message-ID: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 10:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFlkG-0000xa-NJ
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 10:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYGGIFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbYGGIFq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 04:05:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:54403 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYGGIFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 04:05:43 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1391030wri.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=t8MemM9FNddeY9VJq+z7Ti8qjkL+bjgLiRz8TzGT4zE=;
        b=opGL8eTPjhP886/sUOMYKVcGM+uAll8/CF+uJ03tOXUohIffvHbaF6qHLwh+kpxrzs
         vLJAFAdYVr+IlfUVOvHEG+BYBrzao4PPRe4lsAMNC3MfMkOA4VtAQJERhhilazDS0r9W
         T/dA0Jx+lYMq4ivCDg+q4/rmKWJpqZVGYG92w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KNw85yM2GknyNfO8hlr7lh2kZMwMDo+6/1gUxLaJbEOYzz0IubnrQy32NFPm35OvhB
         yISIfaptiqgjnVKL/RGmz1vwy6vBi+GmWaIQW+9yDgZ8G+uCPndCGrb0/cda8i2fFCTk
         N4sXgJj/175jBJ8eC8MSCKf8ycZ+2nOSKhRuc=
Received: by 10.90.63.15 with SMTP id l15mr4767852aga.79.1215417943041;
        Mon, 07 Jul 2008 01:05:43 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Mon, 7 Jul 2008 01:05:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87592>

---
 imap-send.c |  631 ++++++++++++++++++++++++++++-------------------------------
 1 files changed, 301 insertions(+), 330 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index d138726..59ef4eb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -102,14 +102,14 @@ typedef struct {

 static int Verbose, Quiet;

-static void imap_info( const char *, ... );
-static void imap_warn( const char *, ... );
+static void imap_info(const char *, ...);
+static void imap_warn(const char *, ...);

-static char *next_arg( char ** );
+static char *next_arg(char **);

-static void free_generic_messages( message_t * );
+static void free_generic_messages(message_t *);

-static int nfsnprintf( char *buf, int blen, const char *fmt, ... );
+static int nfsnprintf(char *buf, int blen, const char *fmt, ...);

 static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 {
@@ -125,8 +125,8 @@ static int nfvasprintf(char **strp, const char
*fmt, va_list ap)
 	return len;
 }

-static void arc4_init( void );
-static unsigned char arc4_getbyte( void );
+static void arc4_init(void);
+static unsigned char arc4_getbyte(void);

 typedef struct imap_server_conf {
 	char *name;
@@ -187,8 +187,8 @@ typedef struct imap_store {
 } imap_store_t;

 struct imap_cmd_cb {
-	int (*cont)( imap_store_t *ctx, struct imap_cmd *cmd, const char *prompt );
-	void (*done)( imap_store_t *ctx, struct imap_cmd *cmd, int response);
+	int (*cont)(imap_store_t *ctx, struct imap_cmd *cmd, const char *prompt);
+	void (*done)(imap_store_t *ctx, struct imap_cmd *cmd, int response);
 	void *ctx;
 	char *data;
 	int dlen;
@@ -225,7 +225,7 @@ static const char *cap_list[] = {
 #define RESP_NO    1
 #define RESP_BAD   2

-static int get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd );
+static int get_cmd_result(imap_store_t *ctx, struct imap_cmd *tcmd);


 static const char *Flags[] = {
@@ -243,8 +243,7 @@ static void ssl_socket_perror(const char *func)
 }
 #endif

-static void
-socket_perror( const char *func, Socket_t *sock, int ret )
+static void socket_perror(const char *func, Socket_t *sock, int ret)
 {
 #ifndef NO_OPENSSL
 	if (sock->ssl) {
@@ -321,8 +320,7 @@ static int ssl_socket_connect(Socket_t *sock, int
use_tls_only, int verify)
 #endif
 }

-static int
-socket_read( Socket_t *sock, char *buf, int len )
+static int socket_read(Socket_t *sock, char *buf, int len)
 {
 	ssize_t n;
 #ifndef NO_OPENSSL
@@ -330,17 +328,16 @@ socket_read( Socket_t *sock, char *buf, int len )
 		n = SSL_read(sock->ssl, buf, len);
 	else
 #endif
-		n = xread( sock->fd, buf, len );
+		n = xread(sock->fd, buf, len);
 	if (n <= 0) {
-		socket_perror( "read", sock, n );
-		close( sock->fd );
+		socket_perror("read", sock, n);
+		close(sock->fd);
 		sock->fd = -1;
 	}
 	return n;
 }

-static int
-socket_write( Socket_t *sock, const char *buf, int len )
+static int socket_write(Socket_t *sock, const char *buf, int len)
 {
 	int n;
 #ifndef NO_OPENSSL
@@ -348,10 +345,10 @@ socket_write( Socket_t *sock, const char *buf, int len )
 		n = SSL_write(sock->ssl, buf, len);
 	else
 #endif
-		n = write_in_full( sock->fd, buf, len );
+		n = write_in_full(sock->fd, buf, len);
 	if (n != len) {
-		socket_perror( "write", sock, n );
-		close( sock->fd );
+		socket_perror("write", sock, n);
+		close(sock->fd);
 		sock->fd = -1;
 	}
 	return n;
@@ -369,8 +366,7 @@ static void socket_shutdown(Socket_t *sock)
 }

 /* simple line buffering */
-static int
-buffer_gets( buffer_t * b, char **s )
+static int buffer_gets(buffer_t * b, char **s)
 {
 	int n;
 	int start = b->offset;
@@ -384,7 +380,7 @@ buffer_gets( buffer_t * b, char **s )
 				/* shift down used bytes */
 				*s = b->buf;

-				assert( start <= b->bytes );
+				assert(start <= b->bytes);
 				n = b->bytes - start;

 				if (n)
@@ -394,8 +390,8 @@ buffer_gets( buffer_t * b, char **s )
 				start = 0;
 			}

-			n = socket_read( &b->sock, b->buf + b->bytes,
-					 sizeof(b->buf) - b->bytes );
+			n = socket_read(&b->sock, b->buf + b->bytes,
+					 sizeof(b->buf) - b->bytes);

 			if (n <= 0)
 				return -1;
@@ -404,12 +400,12 @@ buffer_gets( buffer_t * b, char **s )
 		}

 		if (b->buf[b->offset] == '\r') {
-			assert( b->offset + 1 < b->bytes );
+			assert(b->offset + 1 < b->bytes);
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
 				if (Verbose)
-					puts( *s );
+					puts(*s);
 				return 0;
 			}
 		}
@@ -419,39 +415,36 @@ buffer_gets( buffer_t * b, char **s )
 	/* not reached */
 }

-static void
-imap_info( const char *msg, ... )
+static void imap_info(const char *msg, ...)
 {
 	va_list va;

 	if (!Quiet) {
-		va_start( va, msg );
-		vprintf( msg, va );
-		va_end( va );
-		fflush( stdout );
+		va_start(va, msg);
+		vprintf(msg, va);
+		va_end(va);
+		fflush(stdout);
 	}
 }

-static void
-imap_warn( const char *msg, ... )
+static void imap_warn(const char *msg, ...)
 {
 	va_list va;

 	if (Quiet < 2) {
-		va_start( va, msg );
-		vfprintf( stderr, msg, va );
-		va_end( va );
+		va_start(va, msg);
+		vfprintf(stderr, msg, va);
+		va_end(va);
 	}
 }

-static char *
-next_arg( char **s )
+static char *next_arg(char **s)
 {
 	char *ret;

 	if (!s || !*s)
 		return NULL;
-	while (isspace( (unsigned char) **s ))
+	while (isspace((unsigned char) **s))
 		(*s)++;
 	if (!**s) {
 		*s = NULL;
@@ -460,10 +453,10 @@ next_arg( char **s )
 	if (**s == '"') {
 		++*s;
 		ret = *s;
-		*s = strchr( *s, '"' );
+		*s = strchr(*s, '"');
 	} else {
 		ret = *s;
-		while (**s && !isspace( (unsigned char) **s ))
+		while (**s && !isspace((unsigned char) **s))
 			(*s)++;
 	}
 	if (*s) {
@@ -475,27 +468,25 @@ next_arg( char **s )
 	return ret;
 }

-static void
-free_generic_messages( message_t *msgs )
+static void free_generic_messages(message_t *msgs)
 {
 	message_t *tmsg;

 	for (; msgs; msgs = tmsg) {
 		tmsg = msgs->next;
-		free( msgs );
+		free(msgs);
 	}
 }

-static int
-nfsnprintf( char *buf, int blen, const char *fmt, ... )
+static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
 	int ret;
 	va_list va;

-	va_start( va, fmt );
-	if (blen <= 0 || (unsigned)(ret = vsnprintf( buf, blen, fmt, va ))
>= (unsigned)blen)
-		die( "Fatal: buffer too small. Please report a bug.\n");
-	va_end( va );
+	va_start(va, fmt);
+	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >=
(unsigned)blen)
+		die("Fatal: buffer too small. Please report a bug.\n");
+	va_end(va);
 	return ret;
 }

@@ -503,21 +494,20 @@ static struct {
 	unsigned char i, j, s[256];
 } rs;

-static void
-arc4_init( void )
+static void arc4_init(void)
 {
 	int i, fd;
 	unsigned char j, si, dat[128];

-	if ((fd = open( "/dev/urandom", O_RDONLY )) < 0 && (fd = open(
"/dev/random", O_RDONLY )) < 0) {
-		fprintf( stderr, "Fatal: no random number source available.\n" );
-		exit( 3 );
+	if ((fd = open("/dev/urandom", O_RDONLY)) < 0 && (fd =
open("/dev/random", O_RDONLY)) < 0) {
+		fprintf(stderr, "Fatal: no random number source available.\n");
+		exit(3);
 	}
-	if (read_in_full( fd, dat, 128 ) != 128) {
-		fprintf( stderr, "Fatal: cannot read random number source.\n" );
-		exit( 3 );
+	if (read_in_full(fd, dat, 128) != 128) {
+		fprintf(stderr, "Fatal: cannot read random number source.\n");
+		exit(3);
 	}
-	close( fd );
+	close(fd);

 	for (i = 0; i < 256; i++)
 		rs.s[i] = i;
@@ -533,8 +523,7 @@ arc4_init( void )
 		arc4_getbyte();
 }

-static unsigned char
-arc4_getbyte( void )
+static unsigned char arc4_getbyte(void)
 {
 	unsigned char si, sj;

@@ -547,54 +536,54 @@ arc4_getbyte( void )
 	return rs.s[(si + sj) & 0xff];
 }

-static struct imap_cmd *
-v_issue_imap_cmd( imap_store_t *ctx, struct imap_cmd_cb *cb,
-		  const char *fmt, va_list ap )
+static struct imap_cmd *v_issue_imap_cmd(imap_store_t *ctx,
+					 struct imap_cmd_cb *cb,
+					 const char *fmt, va_list ap)
 {
 	imap_t *imap = ctx->imap;
 	struct imap_cmd *cmd;
 	int n, bufl;
 	char buf[1024];

-	cmd = xmalloc( sizeof(struct imap_cmd) );
-	nfvasprintf( &cmd->cmd, fmt, ap );
+	cmd = xmalloc(sizeof(struct imap_cmd));
+	nfvasprintf(&cmd->cmd, fmt, ap);
 	cmd->tag = ++imap->nexttag;

 	if (cb)
 		cmd->cb = *cb;
 	else
-		memset( &cmd->cb, 0, sizeof(cmd->cb) );
+		memset(&cmd->cb, 0, sizeof(cmd->cb));

 	while (imap->literal_pending)
-		get_cmd_result( ctx, NULL );
+		get_cmd_result(ctx, NULL);

-	bufl = nfsnprintf( buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS) ?
+	bufl = nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS) ?
 			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
-			   cmd->tag, cmd->cmd, cmd->cb.dlen );
+			   cmd->tag, cmd->cmd, cmd->cb.dlen);
 	if (Verbose) {
 		if (imap->num_in_progress)
-			printf( "(%d in progress) ", imap->num_in_progress );
-		if (memcmp( cmd->cmd, "LOGIN", 5 ))
-			printf( ">>> %s", buf );
+			printf("(%d in progress) ", imap->num_in_progress);
+		if (memcmp(cmd->cmd, "LOGIN", 5))
+			printf(">>> %s", buf);
 		else
-			printf( ">>> %d LOGIN <user> <pass>\n", cmd->tag );
+			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
 	}
-	if (socket_write( &imap->buf.sock, buf, bufl ) != bufl) {
-		free( cmd->cmd );
-		free( cmd );
+	if (socket_write(&imap->buf.sock, buf, bufl) != bufl) {
+		free(cmd->cmd);
+		free(cmd);
 		if (cb)
-			free( cb->data );
+			free(cb->data);
 		return NULL;
 	}
 	if (cmd->cb.data) {
 		if (CAP(LITERALPLUS)) {
-			n = socket_write( &imap->buf.sock, cmd->cb.data, cmd->cb.dlen );
-			free( cmd->cb.data );
+			n = socket_write(&imap->buf.sock, cmd->cb.data, cmd->cb.dlen);
+			free(cmd->cb.data);
 			if (n != cmd->cb.dlen ||
-			    (n = socket_write( &imap->buf.sock, "\r\n", 2 )) != 2)
+			    (n = socket_write(&imap->buf.sock, "\r\n", 2)) != 2)
 			{
-				free( cmd->cmd );
-				free( cmd );
+				free(cmd->cmd);
+				free(cmd);
 				return NULL;
 			}
 			cmd->cb.data = NULL;
@@ -609,109 +598,106 @@ v_issue_imap_cmd( imap_store_t *ctx, struct
imap_cmd_cb *cb,
 	return cmd;
 }

-static struct imap_cmd *
-issue_imap_cmd( imap_store_t *ctx, struct imap_cmd_cb *cb, const char
*fmt, ... )
+static struct imap_cmd *issue_imap_cmd(imap_store_t *ctx,
+				       struct imap_cmd_cb *cb,
+				       const char *fmt, ...)
 {
 	struct imap_cmd *ret;
 	va_list ap;

-	va_start( ap, fmt );
-	ret = v_issue_imap_cmd( ctx, cb, fmt, ap );
-	va_end( ap );
+	va_start(ap, fmt);
+	ret = v_issue_imap_cmd(ctx, cb, fmt, ap);
+	va_end(ap);
 	return ret;
 }

-static int
-imap_exec( imap_store_t *ctx, struct imap_cmd_cb *cb, const char *fmt, ... )
+static int imap_exec(imap_store_t *ctx, struct imap_cmd_cb *cb,
+		     const char *fmt, ...)
 {
 	va_list ap;
 	struct imap_cmd *cmdp;

-	va_start( ap, fmt );
-	cmdp = v_issue_imap_cmd( ctx, cb, fmt, ap );
-	va_end( ap );
+	va_start(ap, fmt);
+	cmdp = v_issue_imap_cmd(ctx, cb, fmt, ap);
+	va_end(ap);
 	if (!cmdp)
 		return RESP_BAD;

-	return get_cmd_result( ctx, cmdp );
+	return get_cmd_result(ctx, cmdp);
 }

-static int
-imap_exec_m( imap_store_t *ctx, struct imap_cmd_cb *cb, const char *fmt, ... )
+static int imap_exec_m(imap_store_t *ctx, struct imap_cmd_cb *cb,
+		       const char *fmt, ...)
 {
 	va_list ap;
 	struct imap_cmd *cmdp;

-	va_start( ap, fmt );
-	cmdp = v_issue_imap_cmd( ctx, cb, fmt, ap );
-	va_end( ap );
+	va_start(ap, fmt);
+	cmdp = v_issue_imap_cmd(ctx, cb, fmt, ap);
+	va_end(ap);
 	if (!cmdp)
 		return DRV_STORE_BAD;

-	switch (get_cmd_result( ctx, cmdp )) {
+	switch (get_cmd_result(ctx, cmdp)) {
 	case RESP_BAD: return DRV_STORE_BAD;
 	case RESP_NO: return DRV_MSG_BAD;
 	default: return DRV_OK;
 	}
 }

-static int
-is_atom( list_t *list )
+static int is_atom(list_t *list)
 {
 	return list && list->val && list->val != NIL && list->val != LIST;
 }

-static int
-is_list( list_t *list )
+static int is_list(list_t *list)
 {
 	return list && list->val == LIST;
 }

-static void
-free_list( list_t *list )
+static void free_list(list_t *list)
 {
 	list_t *tmp;

 	for (; list; list = tmp) {
 		tmp = list->next;
-		if (is_list( list ))
-			free_list( list->child );
-		else if (is_atom( list ))
-			free( list->val );
-		free( list );
+		if (is_list(list))
+			free_list(list->child);
+		else if (is_atom(list))
+			free(list->val);
+		free(list);
 	}
 }

-static int
-parse_imap_list_l( imap_t *imap, char **sp, list_t **curp, int level )
+static int parse_imap_list_l(imap_t *imap, char **sp, list_t **curp, int level)
 {
 	list_t *cur;
 	char *s = *sp, *p;
 	int n, bytes;

 	for (;;) {
-		while (isspace( (unsigned char)*s ))
+		while (isspace((unsigned char)*s))
 			s++;
 		if (level && *s == ')') {
 			s++;
 			break;
 		}
-		*curp = cur = xmalloc( sizeof(*cur) );
+		*curp = cur = xmalloc(sizeof(*cur));
 		curp = &cur->next;
 		cur->val = NULL; /* for clean bail */
 		if (*s == '(') {
 			/* sublist */
 			s++;
 			cur->val = LIST;
-			if (parse_imap_list_l( imap, &s, &cur->child, level + 1 ))
+			if (parse_imap_list_l(imap, &s, &cur->child, level + 1))
 				goto bail;
 		} else if (imap && *s == '{') {
 			/* literal */
-			bytes = cur->len = strtol( s + 1, &s, 10 );
+			bytes = cur->len = strtol(s + 1, &s, 10);
 			if (*s != '}')
 				goto bail;

-			s = cur->val = xmalloc( cur->len );
+			s = cur->val = xmalloc(cur->len);

 			/* dump whats left over in the input buffer */
 			n = imap->buf.bytes - imap->buf.offset;
@@ -720,7 +706,7 @@ parse_imap_list_l( imap_t *imap, char **sp, list_t
**curp, int level )
 				/* the entire message fit in the buffer */
 				n = bytes;

-			memcpy( s, imap->buf.buf + imap->buf.offset, n );
+			memcpy(s, imap->buf.buf + imap->buf.offset, n);
 			s += n;
 			bytes -= n;

@@ -729,13 +715,13 @@ parse_imap_list_l( imap_t *imap, char **sp,
list_t **curp, int level )

 			/* now read the rest of the message */
 			while (bytes > 0) {
-				if ((n = socket_read (&imap->buf.sock, s, bytes)) <= 0)
+				if ((n = socket_read(&imap->buf.sock, s, bytes)) <= 0)
 					goto bail;
 				s += n;
 				bytes -= n;
 			}

-			if (buffer_gets( &imap->buf, &s ))
+			if (buffer_gets(&imap->buf, &s))
 				goto bail;
 		} else if (*s == '"') {
 			/* quoted string */
@@ -750,11 +736,11 @@ parse_imap_list_l( imap_t *imap, char **sp,
list_t **curp, int level )
 		} else {
 			/* atom */
 			p = s;
-			for (; *s && !isspace( (unsigned char)*s ); s++)
+			for (; *s && !isspace((unsigned char)*s); s++)
 				if (level && *s == ')')
 					break;
 			cur->len = s - p;
-			if (cur->len == 3 && !memcmp ("NIL", p, 3)) {
+			if (cur->len == 3 && !memcmp("NIL", p, 3)) {
 				cur->val = NIL;
 			} else {
 				cur->val = xmemdupz(p, cur->len);
@@ -775,39 +761,36 @@ parse_imap_list_l( imap_t *imap, char **sp,
list_t **curp, int level )
 	return -1;
 }

-static list_t *
-parse_imap_list( imap_t *imap, char **sp )
+static list_t *parse_imap_list(imap_t *imap, char **sp)
 {
 	list_t *head;

-	if (!parse_imap_list_l( imap, sp, &head, 0 ))
+	if (!parse_imap_list_l(imap, sp, &head, 0))
 		return head;
-	free_list( head );
+	free_list(head);
 	return NULL;
 }

-static list_t *
-parse_list( char **sp )
+static list_t *parse_list(char **sp)
 {
-	return parse_imap_list( NULL, sp );
+	return parse_imap_list(NULL, sp);
 }

-static void
-parse_capability( imap_t *imap, char *cmd )
+static void parse_capability(imap_t *imap, char *cmd)
 {
 	char *arg;
 	unsigned i;

 	imap->caps = 0x80000000;
-	while ((arg = next_arg( &cmd )))
+	while ((arg = next_arg(&cmd)))
 		for (i = 0; i < ARRAY_SIZE(cap_list); i++)
-			if (!strcmp( cap_list[i], arg ))
+			if (!strcmp(cap_list[i], arg))
 				imap->caps |= 1 << i;
 	imap->rcaps = imap->caps;
 }

-static int
-parse_response_code( imap_store_t *ctx, struct imap_cmd_cb *cb, char *s )
+static int parse_response_code(imap_store_t *ctx, struct imap_cmd_cb *cb,
+			       char *s)
 {
 	imap_t *imap = ctx->imap;
 	char *arg, *p;
@@ -815,43 +798,42 @@ parse_response_code( imap_store_t *ctx, struct
imap_cmd_cb *cb, char *s )
 	if (*s != '[')
 		return RESP_OK;		/* no response code */
 	s++;
-	if (!(p = strchr( s, ']' ))) {
-		fprintf( stderr, "IMAP error: malformed response code\n" );
+	if (!(p = strchr(s, ']'))) {
+		fprintf(stderr, "IMAP error: malformed response code\n");
 		return RESP_BAD;
 	}
 	*p++ = 0;
-	arg = next_arg( &s );
-	if (!strcmp( "UIDVALIDITY", arg )) {
-		if (!(arg = next_arg( &s )) || !(ctx->gen.uidvalidity = atoi( arg ))) {
-			fprintf( stderr, "IMAP error: malformed UIDVALIDITY status\n" );
+	arg = next_arg(&s);
+	if (!strcmp("UIDVALIDITY", arg)) {
+		if (!(arg = next_arg(&s)) || !(ctx->gen.uidvalidity = atoi(arg))) {
+			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
-	} else if (!strcmp( "UIDNEXT", arg )) {
-		if (!(arg = next_arg( &s )) || !(imap->uidnext = atoi( arg ))) {
-			fprintf( stderr, "IMAP error: malformed NEXTUID status\n" );
+	} else if (!strcmp("UIDNEXT", arg)) {
+		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
+			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
 			return RESP_BAD;
 		}
-	} else if (!strcmp( "CAPABILITY", arg )) {
-		parse_capability( imap, s );
-	} else if (!strcmp( "ALERT", arg )) {
+	} else if (!strcmp("CAPABILITY", arg)) {
+		parse_capability(imap, s);
+	} else if (!strcmp("ALERT", arg)) {
 		/* RFC2060 says that these messages MUST be displayed
 		 * to the user
 		 */
-		for (; isspace( (unsigned char)*p ); p++);
-		fprintf( stderr, "*** IMAP ALERT *** %s\n", p );
-	} else if (cb && cb->ctx && !strcmp( "APPENDUID", arg )) {
-		if (!(arg = next_arg( &s )) || !(ctx->gen.uidvalidity = atoi( arg )) ||
-		    !(arg = next_arg( &s )) || !(*(int *)cb->ctx = atoi( arg )))
+		for (; isspace((unsigned char)*p); p++);
+		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
+	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
+		if (!(arg = next_arg(&s)) || !(ctx->gen.uidvalidity = atoi(arg)) ||
+		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg)))
 		{
-			fprintf( stderr, "IMAP error: malformed APPENDUID status\n" );
+			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
 		}
 	}
 	return RESP_OK;
 }

-static int
-get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
+static int get_cmd_result(imap_store_t *ctx, struct imap_cmd *tcmd)
 {
 	imap_t *imap = ctx->imap;
 	struct imap_cmd *cmdp, **pcmdp, *ncmdp;
@@ -859,38 +841,38 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 	int n, resp, resp2, tag;

 	for (;;) {
-		if (buffer_gets( &imap->buf, &cmd ))
+		if (buffer_gets(&imap->buf, &cmd))
 			return RESP_BAD;

-		arg = next_arg( &cmd );
+		arg = next_arg(&cmd);
 		if (*arg == '*') {
-			arg = next_arg( &cmd );
+			arg = next_arg(&cmd);
 			if (!arg) {
-				fprintf( stderr, "IMAP error: unable to parse untagged response\n" );
+				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
 				return RESP_BAD;
 			}

-			if (!strcmp( "NAMESPACE", arg )) {
-				imap->ns_personal = parse_list( &cmd );
-				imap->ns_other = parse_list( &cmd );
-				imap->ns_shared = parse_list( &cmd );
-			} else if (!strcmp( "OK", arg ) || !strcmp( "BAD", arg ) ||
-				   !strcmp( "NO", arg ) || !strcmp( "BYE", arg )) {
-				if ((resp = parse_response_code( ctx, NULL, cmd )) != RESP_OK)
+			if (!strcmp("NAMESPACE", arg)) {
+				imap->ns_personal = parse_list(&cmd);
+				imap->ns_other = parse_list(&cmd);
+				imap->ns_shared = parse_list(&cmd);
+			} else if (!strcmp("OK", arg) || !strcmp("BAD", arg) ||
+				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
+				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
 					return resp;
-			} else if (!strcmp( "CAPABILITY", arg ))
-				parse_capability( imap, cmd );
-			else if ((arg1 = next_arg( &cmd ))) {
-				if (!strcmp( "EXISTS", arg1 ))
-					ctx->gen.count = atoi( arg );
-				else if (!strcmp( "RECENT", arg1 ))
-					ctx->gen.recent = atoi( arg );
+			} else if (!strcmp("CAPABILITY", arg))
+				parse_capability(imap, cmd);
+			else if ((arg1 = next_arg(&cmd))) {
+				if (!strcmp("EXISTS", arg1))
+					ctx->gen.count = atoi(arg);
+				else if (!strcmp("RECENT", arg1))
+					ctx->gen.recent = atoi(arg);
 			} else {
-				fprintf( stderr, "IMAP error: unable to parse untagged response\n" );
+				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
 				return RESP_BAD;
 			}
 		} else if (!imap->in_progress) {
-			fprintf( stderr, "IMAP error: unexpected reply: %s %s\n", arg, cmd
? cmd : "" );
+			fprintf(stderr, "IMAP error: unexpected reply: %s %s\n", arg, cmd
? cmd : "");
 			return RESP_BAD;
 		} else if (*arg == '+') {
 			/* This can happen only with the last command underway, as
@@ -898,30 +880,30 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 			cmdp = (struct imap_cmd *)((char *)imap->in_progress_append -
 			       offsetof(struct imap_cmd, next));
 			if (cmdp->cb.data) {
-				n = socket_write( &imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen );
-				free( cmdp->cb.data );
+				n = socket_write(&imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen);
+				free(cmdp->cb.data);
 				cmdp->cb.data = NULL;
 				if (n != (int)cmdp->cb.dlen)
 					return RESP_BAD;
 			} else if (cmdp->cb.cont) {
-				if (cmdp->cb.cont( ctx, cmdp, cmd ))
+				if (cmdp->cb.cont(ctx, cmdp, cmd))
 					return RESP_BAD;
 			} else {
-				fprintf( stderr, "IMAP error: unexpected command continuation request\n" );
+				fprintf(stderr, "IMAP error: unexpected command continuation request\n");
 				return RESP_BAD;
 			}
-			if (socket_write( &imap->buf.sock, "\r\n", 2 ) != 2)
+			if (socket_write(&imap->buf.sock, "\r\n", 2) != 2)
 				return RESP_BAD;
 			if (!cmdp->cb.cont)
 				imap->literal_pending = 0;
 			if (!tcmd)
 				return DRV_OK;
 		} else {
-			tag = atoi( arg );
+			tag = atoi(arg);
 			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
 				if (cmdp->tag == tag)
 					goto gottag;
-			fprintf( stderr, "IMAP error: unexpected tag %s\n", arg );
+			fprintf(stderr, "IMAP error: unexpected tag %s\n", arg);
 			return RESP_BAD;
 		  gottag:
 			if (!(*pcmdp = cmdp->next))
@@ -929,26 +911,26 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 			imap->num_in_progress--;
 			if (cmdp->cb.cont || cmdp->cb.data)
 				imap->literal_pending = 0;
-			arg = next_arg( &cmd );
-			if (!strcmp( "OK", arg ))
+			arg = next_arg(&cmd);
+			if (!strcmp("OK", arg))
 				resp = DRV_OK;
 			else {
-				if (!strcmp( "NO", arg )) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(
cmd, "[TRYCREATE]", 11 ))) { /* SELECT, APPEND or UID COPY */
-						p = strchr( cmdp->cmd, '"' );
-						if (!issue_imap_cmd( ctx, NULL, "CREATE \"%.*s\"", strchr( p +
1, '"' ) - p + 1, p )) {
+				if (!strcmp("NO", arg)) {
+					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate ||
!memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
+						p = strchr(cmdp->cmd, '"');
+						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", strchr(p + 1,
'"') - p + 1, p)) {
 							resp = RESP_BAD;
 							goto normal;
 						}
 						/* not waiting here violates the spec, but a server that does not
 						   grok this nonetheless violates it too. */
 						cmdp->cb.create = 0;
-						if (!(ncmdp = issue_imap_cmd( ctx, &cmdp->cb, "%s", cmdp->cmd ))) {
+						if (!(ncmdp = issue_imap_cmd(ctx, &cmdp->cb, "%s", cmdp->cmd))) {
 							resp = RESP_BAD;
 							goto normal;
 						}
-						free( cmdp->cmd );
-						free( cmdp );
+						free(cmdp->cmd);
+						free(cmdp);
 						if (!tcmd)
 							return 0;	/* ignored */
 						if (cmdp == tcmd)
@@ -956,21 +938,21 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 						continue;
 					}
 					resp = RESP_NO;
-				} else /*if (!strcmp( "BAD", arg ))*/
+				} else /*if (!strcmp("BAD", arg))*/
 					resp = RESP_BAD;
-				fprintf( stderr, "IMAP command '%s' returned response (%s) - %s\n",
-					 memcmp (cmdp->cmd, "LOGIN", 5) ?
+				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
+					 memcmp(cmdp->cmd, "LOGIN", 5) ?
 							cmdp->cmd : "LOGIN <user> <pass>",
 							arg, cmd ? cmd : "");
 			}
-			if ((resp2 = parse_response_code( ctx, &cmdp->cb, cmd )) > resp)
+			if ((resp2 = parse_response_code(ctx, &cmdp->cb, cmd)) > resp)
 				resp = resp2;
 		  normal:
 			if (cmdp->cb.done)
-				cmdp->cb.done( ctx, cmdp, resp );
-			free( cmdp->cb.data );
-			free( cmdp->cmd );
-			free( cmdp );
+				cmdp->cb.done(ctx, cmdp, resp);
+			free(cmdp->cb.data);
+			free(cmdp->cmd);
+			free(cmdp);
 			if (!tcmd || tcmd == cmdp)
 				return resp;
 		}
@@ -978,31 +960,28 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 	/* not reached */
 }

-static void
-imap_close_server( imap_store_t *ictx )
+static void imap_close_server(imap_store_t *ictx)
 {
 	imap_t *imap = ictx->imap;

 	if (imap->buf.sock.fd != -1) {
-		imap_exec( ictx, NULL, "LOGOUT" );
-		socket_shutdown( &imap->buf.sock );
+		imap_exec(ictx, NULL, "LOGOUT");
+		socket_shutdown(&imap->buf.sock);
 	}
-	free_list( imap->ns_personal );
-	free_list( imap->ns_other );
-	free_list( imap->ns_shared );
-	free( imap );
+	free_list(imap->ns_personal);
+	free_list(imap->ns_other);
+	free_list(imap->ns_shared);
+	free(imap);
 }

-static void
-imap_close_store( store_t *ctx )
+static void imap_close_store(store_t *ctx)
 {
-	imap_close_server( (imap_store_t *)ctx );
-	free_generic_messages( ctx->msgs );
-	free( ctx );
+	imap_close_server((imap_store_t *)ctx);
+	free_generic_messages(ctx->msgs);
+	free(ctx);
 }

-static store_t *
-imap_open_store( imap_server_conf_t *srvc )
+static store_t *imap_open_store(imap_server_conf_t *srvc)
 {
 	imap_store_t *ctx;
 	imap_t *imap;
@@ -1012,9 +991,9 @@ imap_open_store( imap_server_conf_t *srvc )
 	int s, a[2], preauth;
 	pid_t pid;

-	ctx = xcalloc( sizeof(*ctx), 1 );
+	ctx = xcalloc(sizeof(*ctx), 1);

-	ctx->imap = imap = xcalloc( sizeof(*imap), 1 );
+	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
 	imap->buf.sock.fd = -1;
 	imap->buf.sock.ssl = NULL;
 	imap->in_progress_append = &imap->in_progress;
@@ -1022,51 +1001,51 @@ imap_open_store( imap_server_conf_t *srvc )
 	/* open connection to IMAP server */

 	if (srvc->tunnel) {
-		imap_info( "Starting tunnel '%s'... ", srvc->tunnel );
+		imap_info("Starting tunnel '%s'... ", srvc->tunnel);

-		if (socketpair( PF_UNIX, SOCK_STREAM, 0, a )) {
-			perror( "socketpair" );
-			exit( 1 );
+		if (socketpair(PF_UNIX, SOCK_STREAM, 0, a)) {
+			perror("socketpair");
+			exit(1);
 		}

 		pid = fork();
 		if (pid < 0)
-			_exit( 127 );
+			_exit(127);
 		if (!pid) {
-			if (dup2( a[0], 0 ) == -1 || dup2( a[0], 1 ) == -1)
-				_exit( 127 );
-			close( a[0] );
-			close( a[1] );
-			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
-			_exit( 127 );
+			if (dup2(a[0], 0) == -1 || dup2(a[0], 1) == -1)
+				_exit(127);
+			close(a[0]);
+			close(a[1]);
+			execl("/bin/sh", "sh", "-c", srvc->tunnel, NULL);
+			_exit(127);
 		}

-		close (a[0]);
+		close(a[0]);

 		imap->buf.sock.fd = a[1];

-		imap_info( "ok\n" );
+		imap_info("ok\n");
 	} else {
-		memset( &addr, 0, sizeof(addr) );
-		addr.sin_port = htons( srvc->port );
+		memset(&addr, 0, sizeof(addr));
+		addr.sin_port = htons(srvc->port);
 		addr.sin_family = AF_INET;

-		imap_info( "Resolving %s... ", srvc->host );
-		he = gethostbyname( srvc->host );
+		imap_info("Resolving %s... ", srvc->host);
+		he = gethostbyname(srvc->host);
 		if (!he) {
-			perror( "gethostbyname" );
+			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info( "ok\n" );
+		imap_info("ok\n");

 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);

-		s = socket( PF_INET, SOCK_STREAM, 0 );
+		s = socket(PF_INET, SOCK_STREAM, 0);

-		imap_info( "Connecting to %s:%hu... ", inet_ntoa( addr.sin_addr ),
ntohs( addr.sin_port ) );
-		if (connect( s, (struct sockaddr *)&addr, sizeof(addr) )) {
-			close( s );
-			perror( "connect" );
+		imap_info("Connecting to %s:%hu... ", inet_ntoa(addr.sin_addr),
ntohs(addr.sin_port));
+		if (connect(s, (struct sockaddr *)&addr, sizeof(addr))) {
+			close(s);
+			perror("connect");
 			goto bail;
 		}
 		
@@ -1077,28 +1056,28 @@ imap_open_store( imap_server_conf_t *srvc )
 			close(s);
 			goto bail;
 		}
-		imap_info( "ok\n" );
+		imap_info("ok\n");
 	}

 	/* read the greeting string */
-	if (buffer_gets( &imap->buf, &rsp )) {
-		fprintf( stderr, "IMAP error: no greeting response\n" );
+	if (buffer_gets(&imap->buf, &rsp)) {
+		fprintf(stderr, "IMAP error: no greeting response\n");
 		goto bail;
 	}
-	arg = next_arg( &rsp );
-	if (!arg || *arg != '*' || (arg = next_arg( &rsp )) == NULL) {
-		fprintf( stderr, "IMAP error: invalid greeting response\n" );
+	arg = next_arg(&rsp);
+	if (!arg || *arg != '*' || (arg = next_arg(&rsp)) == NULL) {
+		fprintf(stderr, "IMAP error: invalid greeting response\n");
 		goto bail;
 	}
 	preauth = 0;
-	if (!strcmp( "PREAUTH", arg ))
+	if (!strcmp("PREAUTH", arg))
 		preauth = 1;
-	else if (strcmp( "OK", arg ) != 0) {
-		fprintf( stderr, "IMAP error: unknown greeting response\n" );
+	else if (strcmp("OK", arg) != 0) {
+		fprintf(stderr, "IMAP error: unknown greeting response\n");
 		goto bail;
 	}
-	parse_response_code( ctx, NULL, rsp );
-	if (!imap->caps && imap_exec( ctx, NULL, "CAPABILITY" ) != RESP_OK)
+	parse_response_code(ctx, NULL, rsp);
+	if (!imap->caps && imap_exec(ctx, NULL, "CAPABILITY") != RESP_OK)
 		goto bail;

 	if (!preauth) {
@@ -1114,38 +1093,38 @@ imap_open_store( imap_server_conf_t *srvc )
 				goto bail;
 		}
 #endif
-		imap_info ("Logging in...\n");
+		imap_info("Logging in...\n");
 		if (!srvc->user) {
-			fprintf( stderr, "Skipping server %s, no user\n", srvc->host );
+			fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
 			goto bail;
 		}
 		if (!srvc->pass) {
 			char prompt[80];
-			sprintf( prompt, "Password (%s@%s): ", srvc->user, srvc->host );
-			arg = getpass( prompt );
+			sprintf(prompt, "Password (%s@%s): ", srvc->user, srvc->host);
+			arg = getpass(prompt);
 			if (!arg) {
-				perror( "getpass" );
-				exit( 1 );
+				perror("getpass");
+				exit(1);
 			}
 			if (!*arg) {
-				fprintf( stderr, "Skipping account %s@%s, no password\n",
srvc->user, srvc->host );
+				fprintf(stderr, "Skipping account %s@%s, no password\n",
srvc->user, srvc->host);
 				goto bail;
 			}
 			/*
 			 * getpass() returns a pointer to a static buffer.  make a copy
 			 * for long term storage.
 			 */
-			srvc->pass = xstrdup( arg );
+			srvc->pass = xstrdup(arg);
 		}
 		if (CAP(NOLOGIN)) {
-			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n",
srvc->user, srvc->host );
+			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
srvc->user, srvc->host);
 			goto bail;
 		}
 		if (!imap->buf.sock.ssl)
 			imap_warn( "*** IMAP Warning *** Password is being "
 				   "sent in the clear\n" );
-		if (imap_exec( ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user,
srvc->pass ) != RESP_OK) {
-			fprintf( stderr, "IMAP error: LOGIN failed\n" );
+		if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user,
srvc->pass) != RESP_OK) {
+			fprintf(stderr, "IMAP error: LOGIN failed\n");
 			goto bail;
 		}
 	} /* !preauth */
@@ -1155,12 +1134,11 @@ imap_open_store( imap_server_conf_t *srvc )
 	return (store_t *)ctx;

   bail:
-	imap_close_store( &ctx->gen );
+	imap_close_store(&ctx->gen);
 	return NULL;
 }

-static int
-imap_make_flags( int flags, char *buf )
+static int imap_make_flags(int flags, char *buf)
 {
 	const char *s;
 	unsigned i, d;
@@ -1179,8 +1157,7 @@ imap_make_flags( int flags, char *buf )

 #define TUIDL 8

-static int
-imap_store_msg( store_t *gctx, msg_data_t *data, int *uid )
+static int imap_store_msg(store_t *gctx, msg_data_t *data, int *uid)
 {
 	imap_store_t *ctx = (imap_store_t *)gctx;
 	imap_t *imap = ctx->imap;
@@ -1191,7 +1168,7 @@ imap_store_msg( store_t *gctx, msg_data_t *data,
int *uid )
 	int start, sbreak = 0, ebreak = 0;
 	char flagstr[128], tuid[TUIDL * 2 + 1];

-	memset( &cb, 0, sizeof(cb) );
+	memset(&cb, 0, sizeof(cb));

 	fmap = data->data;
 	len = data->len;
@@ -1207,18 +1184,18 @@ imap_store_msg( store_t *gctx, msg_data_t
*data, int *uid )
 					sbreak = ebreak = i - 2 + nocr;
 					goto mktid;
 				}
-				if (!memcmp( fmap + start, "X-TUID: ", 8 )) {
+				if (!memcmp(fmap + start, "X-TUID: ", 8)) {
 					extra -= (ebreak = i) - (sbreak = start) + nocr;
 					goto mktid;
 				}
 				goto nloop;
 			}
 		/* invalid message */
-		free( fmap );
+		free(fmap);
 		return DRV_MSG_BAD;
 	 mktid:
 		for (j = 0; j < TUIDL; j++)
-			sprintf( tuid + j * 2, "%02x", arc4_getbyte() );
+			sprintf(tuid + j * 2, "%02x", arc4_getbyte());
 		extra += 8 + TUIDL * 2 + 2;
 	}
 	if (nocr)
@@ -1227,7 +1204,7 @@ imap_store_msg( store_t *gctx, msg_data_t *data,
int *uid )
 				extra++;

 	cb.dlen = len + extra;
-	buf = cb.data = xmalloc( cb.dlen );
+	buf = cb.data = xmalloc(cb.dlen);
 	i = 0;
 	if (!CAP(UIDPLUS) && uid) {
 		if (nocr) {
@@ -1238,12 +1215,12 @@ imap_store_msg( store_t *gctx, msg_data_t
*data, int *uid )
 				} else
 					*buf++ = fmap[i];
 		} else {
-			memcpy( buf, fmap, sbreak );
+			memcpy(buf, fmap, sbreak);
 			buf += sbreak;
 		}
-		memcpy( buf, "X-TUID: ", 8 );
+		memcpy(buf, "X-TUID: ", 8);
 		buf += 8;
-		memcpy( buf, tuid, TUIDL * 2 );
+		memcpy(buf, tuid, TUIDL * 2);
 		buf += TUIDL * 2;
 		*buf++ = '\r';
 		*buf++ = '\n';
@@ -1257,13 +1234,13 @@ imap_store_msg( store_t *gctx, msg_data_t
*data, int *uid )
 			} else
 				*buf++ = fmap[i];
 	} else
-		memcpy( buf, fmap + i, len - i );
+		memcpy(buf, fmap + i, len - i);

-	free( fmap );
+	free(fmap);

 	d = 0;
 	if (data->flags) {
-		d = imap_make_flags( data->flags, flagstr );
+		d = imap_make_flags(data->flags, flagstr);
 		flagstr[d++] = ' ';
 	}
 	flagstr[d] = 0;
@@ -1276,11 +1253,11 @@ imap_store_msg( store_t *gctx, msg_data_t
*data, int *uid )
 			imap->caps = imap->rcaps & ~(1 << LITERALPLUS);
 	} else {
 		box = gctx->name;
-		prefix = !strcmp( box, "INBOX" ) ? "" : ctx->prefix;
+		prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 		cb.create = 0;
 	}
 	cb.ctx = uid;
-	ret = imap_exec_m( ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr );
+	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
@@ -1294,8 +1271,7 @@ imap_store_msg( store_t *gctx, msg_data_t *data,
int *uid )

 #define CHUNKSIZE 0x1000

-static int
-read_message( FILE *f, msg_data_t *msg )
+static int read_message(FILE *f, msg_data_t *msg)
 {
 	struct strbuf buf;

@@ -1312,8 +1288,7 @@ read_message( FILE *f, msg_data_t *msg )
 	return msg->len;
 }

-static int
-count_messages( msg_data_t *msg )
+static int count_messages(msg_data_t *msg)
 {
 	int count = 0;
 	char *p = msg->data;
@@ -1323,7 +1298,7 @@ count_messages( msg_data_t *msg )
 			count++;
 			p += 5;
 		}
-		p = strstr( p+5, "\nFrom ");
+		p = strstr(p+5, "\nFrom ");
 		if (!p)
 			break;
 		p++;
@@ -1331,22 +1306,21 @@ count_messages( msg_data_t *msg )
 	return count;
 }

-static int
-split_msg( msg_data_t *all_msgs, msg_data_t *msg, int *ofs )
+static int split_msg(msg_data_t *all_msgs, msg_data_t *msg, int *ofs)
 {
 	char *p, *data;

-	memset( msg, 0, sizeof *msg );
+	memset(msg, 0, sizeof *msg);
 	if (*ofs >= all_msgs->len)
 		return 0;

-	data = &all_msgs->data[ *ofs ];
+	data = &all_msgs->data[*ofs];
 	msg->len = all_msgs->len - *ofs;

 	if (msg->len < 5 || prefixcmp(data, "From "))
 		return 0;

-	p = strchr( data, '\n' );
+	p = strchr(data, '\n');
 	if (p) {
 		p = &p[1];
 		msg->len -= p-data;
@@ -1354,7 +1328,7 @@ split_msg( msg_data_t *all_msgs, msg_data_t
*msg, int *ofs )
 		data = p;
 	}

-	p = strstr( data, "\nFrom " );
+	p = strstr(data, "\nFrom ");
 	if (p)
 		msg->len = &p[1] - data;

@@ -1363,8 +1337,7 @@ split_msg( msg_data_t *all_msgs, msg_data_t
*msg, int *ofs )
 	return 1;
 }

-static imap_server_conf_t server =
-{
+static imap_server_conf_t server = {
 	NULL,	/* name */
 	NULL,	/* tunnel */
 	NULL,	/* host */
@@ -1377,12 +1350,11 @@ static imap_server_conf_t server =

 static char *imap_folder;

-static int
-git_imap_config(const char *key, const char *val, void *cb)
+static int git_imap_config(const char *key, const char *val, void *cb)
 {
 	char imap_key[] = "imap.";

-	if (strncmp( key, imap_key, sizeof imap_key - 1 ))
+	if (strncmp(key, imap_key, sizeof imap_key - 1))
 		return 0;

 	if (!val)
@@ -1390,9 +1362,9 @@ git_imap_config(const char *key, const char
*val, void *cb)

 	key += sizeof imap_key - 1;

-	if (!strcmp( "folder", key )) {
-		imap_folder = xstrdup( val );
-	} else if (!strcmp( "host", key )) {
+	if (!strcmp("folder", key)) {
+		imap_folder = xstrdup(val);
+	} else if (!strcmp("host", key)) {
 		if (!prefixcmp(val, "imap:"))
 			val += 5;
 		else if (!prefixcmp(val, "imaps:")) {
@@ -1401,23 +1373,22 @@ git_imap_config(const char *key, const char
*val, void *cb)
 		}
 		if (!prefixcmp(val, "//"))
 			val += 2;
-		server.host = xstrdup( val );
+		server.host = xstrdup(val);
 	}
-	else if (!strcmp( "user", key ))
-		server.user = xstrdup( val );
-	else if (!strcmp( "pass", key ))
-		server.pass = xstrdup( val );
-	else if (!strcmp( "port", key ))
-		server.port = git_config_int( key, val );
-	else if (!strcmp( "tunnel", key ))
-		server.tunnel = xstrdup( val );
-	else if (!strcmp( "ssl_verify", key ))
-		server.ssl_verify = git_config_bool( key, val );
+	else if (!strcmp("user", key))
+		server.user = xstrdup(val);
+	else if (!strcmp("pass", key))
+		server.pass = xstrdup(val);
+	else if (!strcmp("port", key))
+		server.port = git_config_int(key, val);
+	else if (!strcmp("tunnel", key))
+		server.tunnel = xstrdup(val);
+	else if (!strcmp("sslverify", key))
+		server.ssl_verify = git_config_bool(key, val);
 	return 0;
 }

-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	msg_data_t all_msgs, msg;
 	store_t *ctx = NULL;
@@ -1429,57 +1400,57 @@ main(int argc, char **argv)
 	/* init the random number generator */
 	arc4_init();

-	setup_git_directory_gently( NULL );
+	setup_git_directory_gently(NULL);
 	git_config(git_imap_config, NULL);

 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;

 	if (!imap_folder) {
-		fprintf( stderr, "no imap store specified\n" );
+		fprintf(stderr, "no imap store specified\n");
 		return 1;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf( stderr, "no imap host specified\n" );
+			fprintf(stderr, "no imap host specified\n");
 			return 1;
 		}
 		server.host = "tunnel";
 	}

 	/* read the messages */
-	if (!read_message( stdin, &all_msgs )) {
+	if (!read_message(stdin, &all_msgs)) {
 		fprintf(stderr,"nothing to send\n");
 		return 1;
 	}

-	total = count_messages( &all_msgs );
+	total = count_messages(&all_msgs);
 	if (!total) {
 		fprintf(stderr,"no messages to send\n");
 		return 1;
 	}

 	/* write it to the imap server */
-	ctx = imap_open_store( &server );
+	ctx = imap_open_store(&server);
 	if (!ctx) {
-		fprintf( stderr,"failed to open store\n");
+		fprintf(stderr,"failed to open store\n");
 		return 1;
 	}

-	fprintf( stderr, "sending %d message%s\n", total, (total!=1)?"s":"" );
+	fprintf(stderr, "sending %d message%s\n", total, (total!=1)?"s":"");
 	ctx->name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
-		fprintf( stderr, "%4u%% (%d/%d) done\r", percent, n, total );
-		if (!split_msg( &all_msgs, &msg, &ofs ))
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+		if (!split_msg(&all_msgs, &msg, &ofs))
 			break;
-		r = imap_store_msg( ctx, &msg, &uid );
+		r = imap_store_msg(ctx, &msg, &uid);
 		if (r != DRV_OK) break;
 		n++;
 	}
-	fprintf( stderr,"\n" );
+	fprintf(stderr, "\n");

-	imap_close_store( ctx );
+	imap_close_store(ctx);

 	return 0;
 }
-- 
1.5.6.GIT
