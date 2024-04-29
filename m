Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4A7E0F2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404577; cv=none; b=FlNypFwu7LSMp7u/WrgdjLWfv5n6Er3X57+DtLmcMW+a0rhPBg1+W9UdK1X3bwY3emzdX8kUJSyTvRWI/lwWRQd0efVrYxIdSwTkJOYcbD1Wwh7oGOMaj+YudwPusFBwz6YYjWY/aRZiZupeDmvNZSvAXj5tCSfvyYLFg9OVYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404577; c=relaxed/simple;
	bh=iRSSZHyvjseQzbc75LP19Xz5XTkNXWp7UpBtSGWd1EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AT5cqVavMW3NpYEWTrflV6iYiH4pQYdL2/WoE76hGZuh1QnAg9GMcYnp/mScIb/N0v07W0U0p/xoYvcOSAmVj3vo7SLUMI3jFUz1sJMFC2xwQykcGmxOcfH+Osi0Y+wRaHSclTE7FYWaPY4OJjisl+L+wnzj0ci0V68o6nxvuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=objU43cv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="objU43cv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D6E5236ADF;
	Mon, 29 Apr 2024 11:29:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iRSSZHyvjseQzbc75LP19Xz5XTkNXWp7UpBtSG
	Wd1EU=; b=objU43cv2extIjUL738N6WTsC5eut95Uzgzc4mcQv9PPq0aCj9+6C6
	7bf3E7VDoTx82ygbxo2RcWOk19hLhgk37TPb1cC1VADL9s23GpiNET89EI7fNJ8N
	oVYjIV1GGX4mRsfmw0zu6iNeiNajXeYPNXl31pO1h3UUM2BvNYhys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CFBFF36ADE;
	Mon, 29 Apr 2024 11:29:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C2A836ADD;
	Mon, 29 Apr 2024 11:29:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
In-Reply-To: <Zi9DGYwlT7VnW7oj@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Apr 2024 08:50:01 +0200")
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
	<Zi9DGYwlT7VnW7oj@tanuki>
Date: Mon, 29 Apr 2024 08:29:29 -0700
Message-ID: <xmqqplu8yyp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 46381600-063D-11EF-985F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 29, 2024 at 04:31:15AM +0000, John Passaro via GitGitGadget wrote:
>> From: John Passaro <john.a.passaro@gmail.com>
>> 
>> Teach git-tag to accept --trailer option to add trailers to annotated
>> tag messages, like git-commit.
>> 
>> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
>
> This feels like a sensible addition to me indeed, thanks!

At the surface level, I tend to agree, but I am of two minds,
especially around the "-s" option, though.  "commit -s" is to work
with the "Signed-off-by" trailer, but "tag -s" is not.

More importantly, I doubt that many trailers we commonly see in the
comit objects, like "Acked-by", "Reviewed-by", or even "CC", are
applicable in the context of tags.  So I am ambivalent.

If we were to adop this new feature, your review already has done a
very good job and I see room for adding nothing more on the
implementation.

Thanks, both.

> [snip]
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 9a33cb50b45..0334a5d15ec 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -28,9 +28,11 @@
>>  #include "date.h"
>>  #include "write-or-die.h"
>>  #include "object-file-convert.h"
>> +#include "run-command.h"
>>  
>>  static const char * const git_tag_usage[] = {
>>  	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
>> +	   "        [(--trailer <token>[(=|:)<value>])...]\n"
>>  	   "        <tagname> [<commit> | <object>]"),
>>  	N_("git tag -d <tagname>..."),
>>  	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
>> @@ -290,10 +292,11 @@ static const char message_advice_nested_tag[] =
>>  static void create_tag(const struct object_id *object, const char *object_ref,
>>  		       const char *tag,
>>  		       struct strbuf *buf, struct create_tag_options *opt,
>> -		       struct object_id *prev, struct object_id *result, char *path)
>> +		       struct object_id *prev, struct object_id *result, struct strvec *trailer_args, char *path)
>
> This line is overly long now, let's break it.
>
>>  {
>>  	enum object_type type;
>>  	struct strbuf header = STRBUF_INIT;
>> +	int should_edit;
>>  
>>  	type = oid_object_info(the_repository, object, NULL);
>>  	if (type <= OBJ_NONE)
>> @@ -313,14 +316,18 @@ static void create_tag(const struct object_id *object, const char *object_ref,
>>  		    tag,
>>  		    git_committer_info(IDENT_STRICT));
>>  
>> -	if (!opt->message_given || opt->use_editor) {
>> +	should_edit = opt->use_editor || !opt->message_given;
>> +	if (should_edit || trailer_args->nr) {
>>  		int fd;
>>  
>>  		/* write the template message before editing: */
>>  		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
>>  
>> -		if (opt->message_given) {
>> +		if (opt->message_given && buf->len) {
>>  			write_or_die(fd, buf->buf, buf->len);
>> +			if (trailer_args->nr && buf->buf[buf->len-1] != '\n') {
>> +				write_or_die(fd, "\n", 1);
>> +			}
>
> We avoid braces around single-line statements.
>
> I was also wondering whether we can simplify this to:
>
>     if (opt->message_given && buf->len) {
>         strbuf_complete(buf, '\n');
>         write_or_die(fd, buf->buf, buf->len);
>     }
>
> Or does changing `buf` cause problems for us?
>
>>  			strbuf_reset(buf);
>>  		} else if (!is_null_oid(prev)) {
>>  			write_tag_body(fd, prev);
>> @@ -338,10 +345,31 @@ static void create_tag(const struct object_id *object, const char *object_ref,
>>  		}
>>  		close(fd);
>>  
>> -		if (launch_editor(path, buf, NULL)) {
>> -			fprintf(stderr,
>> -			_("Please supply the message using either -m or -F option.\n"));
>> -			exit(1);
>> +		if (trailer_args->nr) {
>> +			struct child_process run_trailer = CHILD_PROCESS_INIT;
>> +
>> +			strvec_pushl(&run_trailer.args, "interpret-trailers",
>> +				     "--in-place", "--no-divider",
>> +				     path, NULL);
>> +			strvec_pushv(&run_trailer.args, trailer_args->v);
>> +			run_trailer.git_cmd = 1;
>> +			if (run_command(&run_trailer))
>> +				die(_("unable to pass trailers to --trailers"));
>> +		}
>
> This part is copied from `builtin/commit.c`. Would it make sense to move
> it into a function `amend_trailers_to_file()` or similar that we add to
> our trailer API so that we can avoid the code duplication?
>
>> +		if (should_edit) {
>> +			if (launch_editor(path, buf, NULL)) {
>> +				fprintf(stderr,
>> +				_("Please supply the message using either -m or -F option.\n"));
>> +				exit(1);
>> +			}
>
> I know you simply re-indented the block here, but let's also fix the
> indentation of the second argument to fprintf(3P) while at it.
>
>> +		} else if (trailer_args->nr) {
>> +			strbuf_reset(buf);
>> +			if (strbuf_read_file(buf, path, 0) < 0) {
>> +				fprintf(stderr,
>> +						_("Please supply the message using either -m or -F option.\n"));
>> +				exit(1);
>> +			}
>>  		}
>>  	}
>>  
>> @@ -416,6 +444,14 @@ struct msg_arg {
>>  	struct strbuf buf;
>>  };
>>  
>> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
>> +{
>> +	BUG_ON_OPT_NEG(unset);
>> +
>> +	strvec_pushl(opt->value, "--trailer", arg, NULL);
>> +	return 0;
>> +}
>> +
>>  static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>>  {
>>  	struct msg_arg *msg = opt->value;
>> @@ -463,6 +499,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  	struct ref_sorting *sorting;
>>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>>  	struct ref_format format = REF_FORMAT_INIT;
>> +	struct strvec trailer_args = STRVEC_INIT;
>>  	int icase = 0;
>>  	int edit_flag = 0;
>>  	struct option options[] = {
>> @@ -479,6 +516,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
>>  			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
>>  		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
>> +		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
>>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
>>  		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
>>  		OPT_CLEANUP(&cleanup_arg),
>> @@ -548,7 +586,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  		opt.sign = 1;
>>  		set_signing_key(keyid);
>>  	}
>> -	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
>> +	create_tag_object = (opt.sign || annotate || msg.given || msgfile || edit_flag || trailer_args.nr);
>>  
>>  	if ((create_tag_object || force) && (cmdmode != 0))
>>  		usage_with_options(git_tag_usage, options);
>> @@ -635,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  	else if (!force)
>>  		die(_("tag '%s' already exists"), tag);
>>  
>> -	opt.message_given = msg.given || msgfile;
>> +	opt.message_given = msg.given || (msgfile != NULL);
>>  	opt.use_editor = edit_flag;
>
> Besides being not required, this change also violates our coding style
> where we don't explicitly check for NULL pointers.
>
>>  	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
>> @@ -653,7 +691,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  		if (force_sign_annotate && !annotate)
>>  			opt.sign = 1;
>>  		path = git_pathdup("TAG_EDITMSG");
>> -		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
>> +		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object, &trailer_args,
>>  			   path);
>
> Nit: let's move `&trailer_args` to the next line to not make it overly
> long.
>
>>  	}
>>  
>> @@ -686,6 +724,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  	strbuf_release(&reflog_msg);
>>  	strbuf_release(&msg.buf);
>>  	strbuf_release(&err);
>> +	strvec_clear(&trailer_args);
>>  	free(msgfile);
>>  	return ret;
>>  }
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 696866d7794..364db2b4685 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -668,6 +668,105 @@ test_expect_success \
>>  	test_cmp expect actual
>>  '
>>  
>> +# trailers
>> +
>> +get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect
>> +cat >>expect <<EOF
>> +create tag with trailers
>> +
>> +my-trailer: here
>> +alt-trailer: there
>> +EOF
>
> You probably just follow precedent in this file, but our modern coding
> style sets up the `expect` file inside of the test body itself. You also
> do it like that in other tests, so let's be consistent.
>
> The same comment applies to other tests, as well.
>
> Patrick
