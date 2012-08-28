From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 13/16] remote-svn: add incremental import
Date: Tue, 28 Aug 2012 10:54:07 -0700
Message-ID: <7v1uiq3nea.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q87-0003i1-W1
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab2H1SDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:03:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2H1SC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:02:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 688979221;
	Tue, 28 Aug 2012 14:02:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=o2Om9x+2RvTBxMe/8m1G0avbbPw=; b=Vo02ODOvGY4K0mmpr9xV
	uzN9eS3T/RdFZRmZLm9Y7e5sjDwtRVBMrw4j54htBhLez5CurqspfnFLmTt1vjTI
	RIssqMzjaF7DH4sopNcP8rcugRA+p8Hv65Zp5ctV2OjbkYBD/cdQhgtEZGqtG13m
	P7UR1t9v7+GNM/hDFUbIcIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=REky/BaMvB+4a9pmrD85NttkaynGA2QLRnY5jbwZ1EsNVU
	L61h/28x/ePvz54N6YC+eLPel4S6gP9bnK+U2alBZkqNUqPOaSYO5p52soxwAoQh
	dZgHDXMiMp3Broz6mTWHEQyVz1OtDI8JuMxNjdlp+k+9sSeqN6GV6fZZREFvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DBA9220;
	Tue, 28 Aug 2012 14:02:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32936921E; Tue, 28 Aug 2012
 14:02:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97A51832-F13A-11E1-BB9A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204440>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Search for a note attached to the ref to update and read it's
> 'Revision-number:'-line. Start import from the next svn revision.
>
> If there is no next revision in the svn repo, svnrdump terminates with
> a message on stderr an non-zero return value. This looks a little
> weird, but there is no other way to know whether there is a new
> revision in the svn repo.
>
> On the start of an incremental import, the parent of the first commit
> in the fast-import stream is set to the branch name to update. All
> following commits specify their parent by a mark number. Previous mark
> files are currently not reused.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/svn-fe/svn-fe.c |    3 ++-
>  remote-testsvn.c        |   67 ++++++++++++++++++++++++++++++++++++++++++++---
>  test-svn-fe.c           |    2 +-
>  vcs-svn/fast_export.c   |   10 +++++--
>  vcs-svn/fast_export.h   |    6 ++---
>  vcs-svn/svndump.c       |   10 +++----
>  vcs-svn/svndump.h       |    2 +-
>  7 files changed, 84 insertions(+), 16 deletions(-)
>
> diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
> index c796cc0..f363505 100644
> --- a/contrib/svn-fe/svn-fe.c
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -10,7 +10,8 @@ int main(int argc, char **argv)
>  {
>  	if (svndump_init(NULL))
>  		return 1;
> -	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master");
> +	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master",
> +			"refs/notes/svn/revs");
>  	svndump_deinit();
>  	svndump_reset();
>  	return 0;
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index b6e7968..e90d221 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -12,7 +12,8 @@ static const char *url;
>  static int dump_from_file;
>  static const char *private_ref;
>  static const char *remote_ref = "refs/heads/master";
> -static const char *marksfilename;
> +static const char *marksfilename, *notes_ref;
> +struct rev_note { unsigned int rev_nr; };
>  
>  static int cmd_capabilities(const char *line);
>  static int cmd_import(const char *line);
> @@ -47,14 +48,70 @@ static void terminate_batch(void)
>  	fflush(stdout);
>  }
>  
> +/* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
> +static char *read_ref_note(const unsigned char sha1[20]) {

Style:

	static char *read_ref_note(const unsigned char sha1[20])
        {

> +	const unsigned char *note_sha1;
> +	char *msg = NULL;
> +	unsigned long msglen;
> +	enum object_type type;
> +	init_notes(NULL, notes_ref, NULL, 0);
> +	if(	(note_sha1 = get_note(NULL, sha1)) == NULL ||
> +			!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
> +			!msglen || type != OBJ_BLOB) {
> +		free(msg);
> +		return NULL;
> +	}
> +	free_notes(NULL);
> +	return msg;
> +}

Style:

	if (!(note_sha1 = get_note(NULL, sha1)) ||
	    !(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
	    !msglen ||
            type != OBJ_BLOB) {
		...

But a bigger question is if any of these cases is a non-error.

It may be perfectly normal so get_note() that returns NULL may be a
normal condition, but is it something you want to silently ignore if
read_sha1_file() did not give you anything when called with a
note_sha1 that ought to be valid?  How about the case where you got
msg but msglen is zero?  Is it an error?  Is it normal and the
caller wants to see a note that happens to be an empty string?  How
about the case where the note returned was ot a blob?  Is it
something you want to silently ignore, or is it an error?

Having multiple assingments inside a conditional, and chaining them
together with "||", lets you code lazily, and the resulting code
like the above _appear_ concise, but in order to prepare the code to
answer these questions sensibly, it is often a good habit to avoid
the appearance of conciseness that hides the lack of thought (e.g.
the code is hiding the reason why it does not call free_notes() when
you do have note_sah1 but found a note that is of undesired object
type, and the reader cannot tell if it is done deliberately).

It is far more preferrable to see this written like:

	if (!(note_sha1 = get_note(NULL, sha1)))
        	return NULL; /* no notes - nothing to return */
	msg = read_sha1_file(note_sha1, &type, &msglen);
	if (!msg) {
		error("cannot read notes for ...");
        } else if (type != OBJ_BLOB) {
		free(msg); /* something we cannot use */
		msg = NULL;
	} ... you may have more else if clauses here ...
        free_notes(NULL);
        return msg;

Also, I am not sure if you want to silently ignore OBJ_BLOB here.
If I understand correctly, you are not reading from a random notes
tree, but from a notes tree that was populated by an earlier
incarnation of your process, no?  If asking for a note in that notes
tree yields a note that you do not recognize, shouldn't you treat it
as an error and raise a big red flag?  The same discussion goes for
ignoring an empty msg.  If you never produce an empty msg, and if
nobody else is supposed to add random stuff to that notes tree,
shouldn't you treat it as an indication that something fishy is
going on if you read an empty msg?

> +static int parse_rev_note(const char *msg, struct rev_note *res) {

Style.

	static int parse_rev_note(const char *msg, struct rev_note *res)
	{

> +	const char *key, *value, *end;
> +	size_t len;
> +	while(*msg) {

Style.

        while (*msg) {

> +		end = strchr(msg, '\n');
> +		len = end ? end - msg : strlen(msg);
> +
> +		key = "Revision-number: ";
> +		if(!prefixcmp(msg, key)) {

Style.

		if (!prefixcmp(msg, key)) {

> +			long i;
> +			value = msg + strlen(key);
> +			i = atol(value);
> +			if(i < 0 || i > UINT32_MAX)

Style.
		if (i < 0 || ...)

More importantly, if you are parsing text that is supposed to be a
format known to you and not human generated, you should avoid using
atoi & atol when parsing numbers; use strtol or strtoul instead, as
they allow you much better error handling.

> +				return 1;

Is it signaling an error to the caller?  The usual convention is to
use negative value for such a purpose.

> +			res->rev_nr = i;
> +		}
> +		msg += len + 1;
> +	}
> +	return 0;
> +}
> +
>  static int cmd_import(const char *line)
>  {
>  	int code;
>  	int dumpin_fd;
> -	unsigned int startrev = 0;
> +	char *note_msg;
> +	unsigned char head_sha1[20];
> +	unsigned int startrev;
>  	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
>  	struct child_process svndump_proc;
>  
> +	if(read_ref(private_ref, head_sha1))

Style.

> +		startrev = 0;
> +	else {
> +		note_msg = read_ref_note(head_sha1);
> +		if(note_msg == NULL) {
> +			warning("No note found for %s.", private_ref);
> +			startrev = 0;
> +		}
> +		else {

Style.

> +			struct rev_note note = { 0 };
> +			parse_rev_note(note_msg, &note);
> +			startrev = note.rev_nr + 1;
> +			free(note_msg);
> +		}
> +	}
> +
>  	if (dump_from_file) {
>  		dumpin_fd = open(url, O_RDONLY);
>  		if(dumpin_fd < 0) {
> @@ -80,7 +137,7 @@ static int cmd_import(const char *line)
>  			"feature export-marks=%s\n", marksfilename, marksfilename);
>  
>  	svndump_init_fd(dumpin_fd, STDIN_FILENO);
> -	svndump_read(url, private_ref);
> +	svndump_read(url, private_ref, notes_ref);
>  	svndump_deinit();
>  	svndump_reset();
>  
> @@ -177,6 +234,9 @@ int main(int argc, const char **argv)
>  	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
>  	private_ref = strbuf_detach(&buf, NULL);
>  
> +	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
> +	notes_ref = strbuf_detach(&buf, NULL);
> +
>  	strbuf_addf(&buf, "%s/info/fast-import/remote-svn/%s.marks",
>  		get_git_dir(), remote->name);
>  	marksfilename = strbuf_detach(&buf, NULL);
> @@ -196,6 +256,7 @@ int main(int argc, const char **argv)
>  	strbuf_release(&buf);
>  	free((void*)url);
>  	free((void*)private_ref);
> +	free((void*)notes_ref);
>  	free((void*)marksfilename);
>  	return 0;
>  }
> diff --git a/test-svn-fe.c b/test-svn-fe.c
> index cb0d80f..0f2d9a4 100644
> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
> @@ -40,7 +40,7 @@ int main(int argc, char *argv[])
>  	if (argc == 2) {
>  		if (svndump_init(argv[1]))
>  			return 1;
> -		svndump_read(NULL, "refs/heads/master");
> +		svndump_read(NULL, "refs/heads/master", "refs/notes/svn/revs");
>  		svndump_deinit();
>  		svndump_reset();
>  		return 0;
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index df51c59..f2b23c8 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -68,13 +68,19 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
>  }
>  
>  void fast_export_begin_note(uint32_t revision, const char *author,
> -		const char *log, unsigned long timestamp)
> +		const char *log, unsigned long timestamp, const char *note_ref)
>  {
> +	static int firstnote = 1;
>  	size_t loglen = strlen(log);
> -	printf("commit refs/notes/svn/revs\n");
> +	printf("commit %s\n", note_ref);
>  	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
>  	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
>  	fwrite(log, loglen, 1, stdout);
> +	if (firstnote) {
> +		if (revision > 1)
> +			printf("from %s^0", note_ref);
> +		firstnote = 0;
> +	}
>  	fputc('\n', stdout);
>  }
>  
> diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
> index c2f6f11..c8b5adb 100644
> --- a/vcs-svn/fast_export.h
> +++ b/vcs-svn/fast_export.h
> @@ -11,10 +11,10 @@ void fast_export_delete(const char *path);
>  void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
>  void fast_export_note(const char *committish, const char *dataref);
>  void fast_export_begin_note(uint32_t revision, const char *author,
> -		const char *log, unsigned long timestamp);
> +		const char *log, unsigned long timestamp, const char *note_ref);
>  void fast_export_begin_commit(uint32_t revision, const char *author,
> -			const struct strbuf *log, const char *uuid,
> -			const char *url, unsigned long timestamp, const char *local_ref);
> +			const struct strbuf *log, const char *uuid,const char *url,
> +			unsigned long timestamp, const char *local_ref);
>  void fast_export_end_commit(uint32_t revision);
>  void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
>  void fast_export_buf_to_data(const struct strbuf *data);
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index cd65b51..31d1d83 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -309,20 +309,20 @@ static void begin_revision(const char *remote_ref)
>  		rev_ctx.timestamp, remote_ref);
>  }
>  
> -static void end_revision()

7e11902 (vcs-svn: add a comment before each commit, 2011-01-04)
added this as

	static void end_revision(void)

but it degenerated to pre-ANSI definition at "[PATCH 8/16] Enable
fetching to private refs", which needs to be fixed by losing that
hunk.

> +static void end_revision(const char *note_ref)
>  {
>  	struct strbuf mark = STRBUF_INIT;
>  	if (rev_ctx.revision) {
>  		fast_export_end_commit(rev_ctx.revision);
>  		fast_export_begin_note(rev_ctx.revision, "remote-svn",
> -				"Note created by remote-svn.", rev_ctx.timestamp);
> +				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
>  		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
>  		fast_export_note(mark.buf, "inline");
>  		fast_export_buf_to_data(&rev_ctx.note);
>  	}
>  }
>  
> -void svndump_read(const char *url, const char *local_ref)
> +void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
>  {
>  	char *val;
>  	char *t;
> @@ -363,7 +363,7 @@ void svndump_read(const char *url, const char *local_ref)
>  			if (active_ctx == REV_CTX)
>  				begin_revision(local_ref);
>  			if (active_ctx != DUMP_CTX)
> -				end_revision();
> +				end_revision(notes_ref);
>  			active_ctx = REV_CTX;
>  			reset_rev_ctx(atoi(val));
>  			strbuf_addf(&rev_ctx.note, "%s\n", t);
> @@ -479,7 +479,7 @@ void svndump_read(const char *url, const char *local_ref)
>  	if (active_ctx == REV_CTX)
>  		begin_revision(local_ref);
>  	if (active_ctx != DUMP_CTX)
> -		end_revision();
> +		end_revision(notes_ref);
>  }
>  
>  static void init(int report_fd)
> diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
> index febeecb..b8eb129 100644
> --- a/vcs-svn/svndump.h
> +++ b/vcs-svn/svndump.h
> @@ -3,7 +3,7 @@
>  
>  int svndump_init(const char *filename);
>  int svndump_init_fd(int in_fd, int back_fd);
> -void svndump_read(const char *url, const char *local_ref);
> +void svndump_read(const char *url, const char *local_ref, const char *notes_ref);
>  void svndump_deinit(void);
>  void svndump_reset(void);
