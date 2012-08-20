From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Mon, 20 Aug 2012 16:01:12 -0700
Message-ID: <7vehn1gocn.fsf@alter.siamese.dyndns.org>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 01:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3aym-0005ev-E0
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 01:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab2HTXBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 19:01:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab2HTXBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 19:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62A659520;
	Mon, 20 Aug 2012 19:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1AbWot9YUr+vojvvCx70fd3nw4=; b=SD7SrX
	rn6elIigmJytK5+XKaLAQP4b+QN2sC/TzvcV6wr2KXuJ3dweEbyoaCNELbww67/M
	STnTFAEUzOoJewXQe8PrPf+UmQZfZydUX0dpFAPpI7OLX3z6uCPirdezN3CZyqVQ
	Mn9RAdpt5Tmg5OWAJHc20Wn1bDDQIgBj1GVaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EASFwg1R5pjxw2TJXvRRXdRtMBedB07S
	j6HctSqbb/MBWFF9YCxeMVCCerI1PlcrLN5c6fS+zywI59qyQUG2FphBI6RpR3GA
	kQpQ07ohc4fY8bOtYCDAzTKu9MoyzOd2yE5KdVHF/kq1hKnWiHjC/Em264wNYceo
	QNFECuoGdaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F9E5951F;
	Mon, 20 Aug 2012 19:01:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B37A951E; Mon, 20 Aug 2012
 19:01:13 -0400 (EDT)
In-Reply-To: <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Mon, 20 Aug 2012 23:52:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F094BCE8-EB1A-11E1-8761-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203907>

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
>  remote-testsvn.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index e90d221..2c0dc99 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -86,6 +86,68 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
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
> +	if (parse_rev_note(msg, &note))
> +		return 2;
> +	if (fprintf(file, ":%d %s\n", note.rev_nr, sha1_to_hex(object_sha1)) < 1)
> +		return 3;
> +	return 0;
> +}
> +
> +static void regenerate_marks() {
> +	int ret;
> +	FILE *marksfile;
> +	marksfile = fopen(marksfilename, "w+");

Where does marksfilename come from?  Should this be

	static void regenerate_marks(const char *marksfilename)
	{

> +	if (!marksfile)
> +		die_errno("Couldn't create mark file %s.", marksfilename);
> +	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
> +	if (ret)
> +		die("Regeneration of marks failed, returned %d.", ret);
> +	fclose(marksfile);
> +}
> +
> +static void check_or_regenerate_marks(int latestrev) {
> +	FILE *marksfile;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +	int found = 0;
> +
> +	if (latestrev < 1)
> +		return;
> +
> +	init_notes(NULL, notes_ref, NULL, 0);
> +	marksfile = fopen(marksfilename, "r");
> +	if (!marksfile)
> +		regenerate_marks(marksfile);

Huh?  regenerate_marks() take a NULL pointer of type "FILE *"?

I think you meant something like:

	init_notes(NULL, notes_ref, NULL, 0);
        marksfile = fopen(marksfilename, "r");
        if (!marksfile) {
        	regenerate_marks(marksfilename);
                marksfile = fopen(marksfilename, "r");
                if (!marksfile)
	                die("cannot read marks file!");
	} else {
        	...

Also there is another call to regenerate_marks() without any
argument.  Has this even been compile-tested?
