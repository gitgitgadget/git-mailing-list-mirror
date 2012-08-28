From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 15/16] remote-svn: add marks-file regeneration
Date: Tue, 28 Aug 2012 10:59:42 -0700
Message-ID: <7vpq6a28tp.fsf@alter.siamese.dyndns.org>
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
 <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q88-0003i1-HU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab2H1SDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:03:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2H1SDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:03:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A988C922E;
	Tue, 28 Aug 2012 14:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=u7OVlYqRnQLhSvYAMThRFNkuvGg=; b=O+4XxXEpecL8kat1Zyhp
	04uckTib1KDTdBpXN8otw37QGp+Zonl140DYfiEqlNWtwCoujcsPvwGGbUjmhSek
	198bhkTJ7StKiyy+n/9skGBuPNLGTrpQvmvz4w+nmG0zRYTVC0xrjW7Z4fOXDRVa
	F7ITpIPH3ZbhOozv3+Ksy5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EawfLExkXBE6GLnhL2sMkH9NCfFksJkGMKxJDJGKGfGkB6
	tIIq1qpxCtV/F8IBs+tDorzkvdWdROHPo7m3d3tVZavbprEaMcAmte+EKSWgeKxs
	ePdmcYX5/R9K+4byeceXIV5QOJ5XWhoDnzRggkjhGo0Q6nTCORBFvJq0EE6sY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95F7B922D;
	Tue, 28 Aug 2012 14:03:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC23F922B; Tue, 28 Aug 2012
 14:02:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A676DB8-F13A-11E1-83F9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204442>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> fast-import mark files are stored outside the object database and are
> therefore not fetched and can be lost somehow else.  marks provide a
> svn revision --> git sha1 mapping, while the notes that are attached
> to each commit when it is imported provide a git sha1 --> svn revision
> mapping.
>
> If the marks file is not available or not plausible, regenerate it by
> walking through the notes tree.  , i.e.  The plausibility check tests
> if the highest revision in the marks file matches the revision of the
> top ref. It doesn't ensure that the mark file is completely correct.
> This could only be done with an effort equal to unconditional
> regeneration.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote-testsvn.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index e90d221..d0b81d5 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -86,6 +86,73 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
>  	return 0;
>  }
>  
> +static int note2mark_cb(const unsigned char *object_sha1,
> +		const unsigned char *note_sha1, char *note_path,
> +		void *cb_data) {
> +	FILE *file = (FILE *)cb_data;
> +	char *msg;
> +	unsigned long msglen;
> +	enum object_type type;
> +	struct rev_note note;
> +	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
> +			!msglen || type != OBJ_BLOB) {
> +		free(msg);
> +		return 1;
> +	}

The same comments as an earlier patch in the series applies here,
regarding chained assignments in coditional, whether each case is an
error that needs to be reported, and the sign of the error return
value.

> +	if (parse_rev_note(msg, &note))
> +		return 2;
> +	if (fprintf(file, ":%d %s\n", note.rev_nr, sha1_to_hex(object_sha1)) < 1)
> +		return 3;
> +	return 0;
> +}
> +
> +static void regenerate_marks(void)
> +{
> +	int ret;
> +	FILE *marksfile;
> +	marksfile = fopen(marksfilename, "w+");
> +	if (!marksfile)
> +		die_errno("Couldn't create mark file %s.", marksfilename);
> +	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
> +	if (ret)
> +		die("Regeneration of marks failed, returned %d.", ret);
> +	fclose(marksfile);
> +}
> +
> +static void check_or_regenerate_marks(int latestrev) {

Style.

> +	FILE *marksfile;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	int found = 0;
> +
> +	if (latestrev < 1)
> +		return;

It's more pleasant to read to have a blank line between the end of
decls and the first statement, like this function does.  Please fix
two functions that appear before this function in this file to match.

> +	init_notes(NULL, notes_ref, NULL, 0);
> +	marksfile = fopen(marksfilename, "r");
> +	if (!marksfile) {
> +		regenerate_marks();
> +		marksfile = fopen(marksfilename, "r");
> +		if (!marksfile)
> +			die_errno("cannot read marks file %s!", marksfilename);
> +		fclose(marksfile);
> +	} else {
> +		strbuf_addf(&sb, ":%d ", latestrev);
> +		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
> +			if (!prefixcmp(line.buf, sb.buf)) {
> +				found++;
> +				break;
> +			}
> +		}
> +		fclose(marksfile);
> +		if (!found)
> +			regenerate_marks();
> +	}
> +	free_notes(NULL);
> +	strbuf_release(&sb);
> +	strbuf_release(&line);
> +}
> +
>  static int cmd_import(const char *line)
>  {
>  	int code;
> @@ -111,6 +178,7 @@ static int cmd_import(const char *line)
>  			free(note_msg);
>  		}
>  	}
> +	check_or_regenerate_marks(startrev - 1);
>  
>  	if (dump_from_file) {
>  		dumpin_fd = open(url, O_RDONLY);
