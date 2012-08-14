From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 04/16] Connect fast-import to the remote-helper
 via pipe, adding 'bidi-import' capability.
Date: Tue, 14 Aug 2012 13:40:20 -0700
Message-ID: <7v4no59phn.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Nuh-0007sj-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455Ab2HNUk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:40:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756255Ab2HNUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:40:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CEB78394;
	Tue, 14 Aug 2012 16:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pOUUQCpP8s47KxE7bJYLSiW5ImI=; b=DzNCSl
	kj5BVhFJMA+YvEtodqf6yXtIZ+lIafURakwfN1pTKmCH7+I1EC9K5Qu7vISUPuAQ
	Z73M3fYc7EMQlMAElvKINsRoJIUzXYeAu8AuF2ktDE48fM1dG/WO6UAHnWTfV++Q
	fQ3yHtJXHOmCKaLmxZQj/Za/AVFjbhMlPxxBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtOgKdRAdRu4hpZ0H4aWDyo0KWmJDm3X
	BscN/q1TmpLowyPIUWjpBB17Ae2GAgxUIuRldjx1pCFX0wK/GMx0qTLQOodvg4Co
	4prNw+XnKzuKWVW6Jmc5qnMRHQ1W3CkBTTfwIN4B97MtOArjPVaIBgu+bnf/Wl+d
	ZEqZ99PEASI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3148392;
	Tue, 14 Aug 2012 16:40:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E5C78391; Tue, 14 Aug 2012
 16:40:21 -0400 (EDT)
In-Reply-To: <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44536B06-E650-11E1-8397-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203447>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
> to retrieve information about blobs and trees that already exist in
> fast-import's memory. This requires a channel from fast-import to the
> remote-helper.
> remote-helpers that use this features shall advertise the new 'bidi-import'

s/this fea/these fea/

> capability so signal that they require the communication channel.

s/so sig/to sig/, I think.

> When forking fast-import in transport-helper.c connect it to a dup of
> the remote-helper's stdin-pipe. The additional file descriptor is passed
> to fast-import via it's command line (--cat-blob-fd).

s/via it's/via its/;

> It follows that git and fast-import are connected to the remote-helpers's
> stdin.
> Because git can send multiple commands to the remote-helper on it's stdin,
> it is required that helpers that advertise 'bidi-import' buffer all input
> commands until the batch of 'import' commands is ended by a newline
> before sending data to fast-import.
> This is to prevent mixing commands and fast-import responses on the
> helper's stdin.

Please have a blank line each between paragraphs; a solid block of
text is very hard to follow.

> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  transport-helper.c |   45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index cfe0988..257274b 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -10,6 +10,7 @@
>  #include "string-list.h"
>  #include "thread-utils.h"
>  #include "sigchain.h"
> +#include "argv-array.h"
>  
>  static int debug;
>  
> @@ -19,6 +20,7 @@ struct helper_data {
>  	FILE *out;
>  	unsigned fetch : 1,
>  		import : 1,
> +		bidi_import : 1,
>  		export : 1,
>  		option : 1,
>  		push : 1,
> @@ -101,6 +103,7 @@ static void do_take_over(struct transport *transport)
>  static struct child_process *get_helper(struct transport *transport)
>  {
>  	struct helper_data *data = transport->data;
> +	struct argv_array argv = ARGV_ARRAY_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct child_process *helper;
>  	const char **refspecs = NULL;
> @@ -122,11 +125,10 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->in = -1;
>  	helper->out = -1;
>  	helper->err = 0;
> -	helper->argv = xcalloc(4, sizeof(*helper->argv));
> -	strbuf_addf(&buf, "git-remote-%s", data->name);
> -	helper->argv[0] = strbuf_detach(&buf, NULL);
> -	helper->argv[1] = transport->remote->name;
> -	helper->argv[2] = remove_ext_force(transport->url);
> +	argv_array_pushf(&argv, "git-remote-%s", data->name);
> +	argv_array_push(&argv, transport->remote->name);
> +	argv_array_push(&argv, remove_ext_force(transport->url));
> +	helper->argv = argv.argv;

Much nicer than before thanks to argv_array ;-)

>  	helper->git_cmd = 0;
>  	helper->silent_exec_failure = 1;
>  
> @@ -141,6 +143,8 @@ static struct child_process *get_helper(struct transport *transport)
>  
>  	data->helper = helper;
>  	data->no_disconnect_req = 0;
> +	free((void*) helper_env[1]);

What is this free() for???

> +	argv_array_clear(&argv);

See below.

>  	/*
>  	 * Open the output as FILE* so strbuf_getline() can be used.
> @@ -178,6 +182,8 @@ static struct child_process *get_helper(struct transport *transport)
>  			data->push = 1;
>  		else if (!strcmp(capname, "import"))
>  			data->import = 1;
> +		else if (!strcmp(capname, "bidi-import"))
> +			data->bidi_import = 1;
>  		else if (!strcmp(capname, "export"))
>  			data->export = 1;
>  		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
> @@ -241,8 +247,6 @@ static int disconnect_helper(struct transport *transport)
>  		close(data->helper->out);
>  		fclose(data->out);
>  		res = finish_command(data->helper);
> -		free((char *)data->helper->argv[0]);
> -		free(data->helper->argv);
>  		free(data->helper);
>  		data->helper = NULL;
>  	}
> @@ -376,14 +380,24 @@ static int fetch_with_fetch(struct transport *transport,
>  static int get_importer(struct transport *transport, struct child_process *fastimport)
>  {
>  	struct child_process *helper = get_helper(transport);
> +	struct helper_data *data = transport->data;
> +	struct argv_array argv = ARGV_ARRAY_INIT;
> +	int cat_blob_fd, code;
>  	memset(fastimport, 0, sizeof(*fastimport));
>  	fastimport->in = helper->out;
> -	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
> -	fastimport->argv[0] = "fast-import";
> -	fastimport->argv[1] = "--quiet";
> +	argv_array_push(&argv, "fast-import");
> +	argv_array_push(&argv, "--quiet");
>  
> +	if (data->bidi_import) {
> +		cat_blob_fd = xdup(helper->in);
> +		argv_array_pushf(&argv, "--cat-blob-fd=%d", cat_blob_fd);
> +	}
> +	fastimport->argv = argv.argv;
>  	fastimport->git_cmd = 1;
> -	return start_command(fastimport);
> +
> +	code = start_command(fastimport);
> +	argv_array_clear(&argv);
> +	return code;
>  }
>  
>  static int get_exporter(struct transport *transport,
> @@ -438,11 +452,16 @@ static int fetch_with_import(struct transport *transport,
>  	}
>  
>  	write_constant(data->helper->in, "\n");
> +	/*
> +	 * remote-helpers that advertise the bidi-import capability are required to
> +	 * buffer the complete batch of import commands until this newline before
> +	 * sending data to fast-import.
> +	 * These helpers read back data from fast-import on their stdin, which could
> +	 * be mixed with import commands, otherwise.
> +	 */
>  
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> -	free(fastimport.argv);
> -	fastimport.argv = NULL;

The updated code frees argv[] immediately after start_command()
returns, and it may happen to be safe to do so with the current
implementation of start_command() and friends, but I think it is a
bad taste to free argv[] (or env[] for that matter) before calling
finish_command().  These pieces of memory are still pointed by the
child_process structure, and users of the structure may want to use
contents of them (especially, argv[0]) for reporting errors and
various other purposes, e.g.

	child = get_helper();

        trace("started %s\n", child->argv[0]);

	if (finish_command(child))
        	return error("failed to cleanly finish %s", child->argv[0]);
