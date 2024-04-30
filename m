Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479A17B4EB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496038; cv=none; b=nez7xvd5dHX+iQaccEQpW//J6UKFruILBybhL0KZnAnZlFFmIR3yURWhTuCvXa1IP190J2CDae3Z5VfaDtirXSCUMB/s0N3yiVqxuhoaK/aYOMee+eikGgvmv8tF/63RCsnB9lU5W/pFHoNpQmTlQbyhVrn2OHfj2yKtsJ6bmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496038; c=relaxed/simple;
	bh=P5jntZfb+2/pz3nbRm1fC2VAceoLbSUl/WUW5FbWyQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsHryunlbG1HjRVgVEGnu1ovSBfzHPp0W7Ak5MiV2yDGZQ+USkeHsJLf+Ht3DMzcSjUSxEj6Pz4JUxPjYZPE0k+sY+XXM5Xq15UmMuSi+/QDFEd0EAbTbjO0Y8zeT7jGIi+bPYBLz7AG6/2iIfQwqZzkjpUt7sdn2MF6SiIRhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EWi8iERH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EWi8iERH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FECC1F98F;
	Tue, 30 Apr 2024 12:53:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P5jntZfb+2/pz3nbRm1fC2VAceoLbSUl/WUW5F
	bWyQ8=; b=EWi8iERHVDrXVG8Ljq8EjxsgLGX8fthfA6mIc5ArwGX0NF4Ogq1W2v
	lWxkcmSup1dmjXlILXsdYcSOfYv7oKxQSpe2A/4GfQDMk7VHQI6+10tBltfRLTNs
	88JMdBzA2VV+Ih8O5Idv6np29+meWbcmza6mE/ZG9U+/qvvwne78s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 570B01F98E;
	Tue, 30 Apr 2024 12:53:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64D791F98D;
	Tue, 30 Apr 2024 12:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Passaro
 <john.a.passaro@gmail.com>
Subject: Re: [PATCH v3 2/3] builtin/tag.c: add --trailer arg
In-Reply-To: <5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
	(John Passaro via GitGitGadget's message of "Mon, 29 Apr 2024 18:54:22
	+0000")
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 09:53:43 -0700
Message-ID: <xmqqv83yrduw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 352672AA-0712-11EF-8664-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"John Passaro via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Passaro <john.a.passaro@gmail.com>
>
> git-tag currently supports interpreting trailers from an annotated tag
> message, using --list --format="%(trailers)". There is no ergonomic way
> to add trailers to an annotated tag message.

Well said.  Drop "currently", though.  The usual way to compose a
log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

> In a previous patch, we refactored git-commit's implementation of its
> --trailer arg to the trailer.h API. Let's use that new function to teach
> git-tag the same --trailer argument, emulating as much of git-commit's
> behavior as much as possible.

Nicely described.

> @@ -178,6 +179,19 @@ This option is only applicable when listing tags without annotation lines.
>  	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
>  	is given.
>  
> +--trailer <token>[(=|:)<value>]::
> +	Specify a (<token>, <value>) pair that should be applied as a
> +	trailer. (e.g. `git tag --trailer "Signed-off-by:T A Ger \
> +	<tagger@example.com>" --trailer "Helped-by:C O Mitter \
> +	<committer@example.com>"` will add the "Signed-off-by" trailer
> +	and the "Helped-by" trailer to the tag message.)
> +	The `trailer.*` configuration variables
> +	(linkgit:git-interpret-trailers[1]) can be used to define if
> +	a duplicated trailer is omitted, where in the run of trailers
> +	each trailer would appear, and other details.
> +	The trailers can be seen in `git tag --list` using
> +	`--format="%(trailers)"` placeholder.

I can see this was copied-and-pasted from git-commit, but I am not
sure if the ones used in the example are good fit for tag objects.
What does Helped-by even mean in the context of an annotated tag?

> @@ -290,10 +292,12 @@ static const char message_advice_nested_tag[] =
>  static void create_tag(const struct object_id *object, const char *object_ref,
>  		       const char *tag,
>  		       struct strbuf *buf, struct create_tag_options *opt,
> -		       struct object_id *prev, struct object_id *result, char *path)
> +		       struct object_id *prev, struct object_id *result,
> +		       struct strvec *trailer_args, char *path)
>  {
>  	enum object_type type;
>  	struct strbuf header = STRBUF_INIT;
> +	int should_edit;
>  
>  	type = oid_object_info(the_repository, object, NULL);
>  	if (type <= OBJ_NONE)
> @@ -313,13 +317,15 @@ static void create_tag(const struct object_id *object, const char *object_ref,
>  		    tag,
>  		    git_committer_info(IDENT_STRICT));
>  
> -	if (!opt->message_given || opt->use_editor) {
> +	should_edit = opt->use_editor || !opt->message_given;
> +	if (should_edit || trailer_args->nr) {
>  		int fd;
>  
>  		/* write the template message before editing: */
>  		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
>  
> -		if (opt->message_given) {
> +		if (opt->message_given && buf->len) {
> +			strbuf_complete(buf, '\n');
>  			write_or_die(fd, buf->buf, buf->len);
>  			strbuf_reset(buf);
>  		} else if (!is_null_oid(prev)) {
> @@ -338,10 +344,22 @@ static void create_tag(const struct object_id *object, const char *object_ref,
>  		}
>  		close(fd);
>  
> -		if (launch_editor(path, buf, NULL)) {
> -			fprintf(stderr,
> -			_("Please supply the message using either -m or -F option.\n"));
> -			exit(1);
> +		if (trailer_args->nr && amend_file_with_trailers(path, trailer_args))
> +			die(_("unable to pass trailers to --trailers"));
> +
> +		if (should_edit) {
> +			if (launch_editor(path, buf, NULL)) {
> +				fprintf(stderr,
> +					_("Please supply the message using either -m or -F option.\n"));
> +				exit(1);
> +			}
> +		} else if (trailer_args->nr) {

When both should_edit and trailer_args->nr are true, this block will
not be entered.  We first do the "amend_file" thing, and then run an
editor on it, and that is the end of the story in that case.

When we do not have should_edit (e.g., -m "tag message" is given),
we would have run "amend_file" thing on it to tweak the message,
and we come in here.

> +			strbuf_reset(buf);
> +			if (strbuf_read_file(buf, path, 0) < 0) {
> +				fprintf(stderr,
> +					_("Please supply the message using either -m or -F option.\n"));
> +				exit(1);

Does this error message make sense here in this context?  The
earlier one was introduced by 7198203a (editor.c: Libify
launch_editor(), 2008-07-25)---after we fail to run the editor, as
we somehow seem to be unable to run an editor, we suggest the user
to give us a message in other ways.  But this one is different.  The
user gave us in one of these other ways already instead of using an
editor, but mucking with that with the "amend_file" thing somehow
made it unreadable.  Shouldn't it be more like

	die_errno(_("failed to read '%s'"), path);

or something along that line?
