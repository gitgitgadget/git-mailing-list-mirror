From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 04/16] Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability.
Date: Wed, 15 Aug 2012 14:00:33 +0200
Message-ID: <2444647.P1AdWcSsQk@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com> <7v4no59phn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 14:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1cHR-0008UL-J4
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 14:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab2HOMAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 08:00:50 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38889 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2HOMAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 08:00:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so488287bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=wjDp/jXhyssvhQTIR58AulMYGR9RrRmXuvL6jbcEExg=;
        b=Pr2m3RZa3CAhSwXC2ZqSAHFw+eQydk4cNiPwJz8cTTka1Z79IzTgMR5kCyejK+Cs+D
         WXY8JdZwULlrPHthEWbTQm1Glf66LXIs3TzsdK5hbe3urFvcHA+d7dSYIL9KRPZNzQlB
         YeU6p/yGenSH4EO/SKd0tJ2jfBKrDpI2HXy3kf8lGFfDUDyAc0EtBybRLXRijaSPfZUH
         XfOJNJIaVvTW5qdqN1uP5m43WGfEa9guasusU9WB+xMHDx84OiyX+BpIx/w4X1HdHS1Z
         njDTSwR4PUoQHnfZdDpWVa7U5wwCGnV1UTCojOWRBe2ENsb9JDXDu6wUQKecavzrNLRI
         zv2g==
Received: by 10.204.154.214 with SMTP id p22mr7787759bkw.111.1345032048997;
        Wed, 15 Aug 2012 05:00:48 -0700 (PDT)
Received: from flomedio.localnet (089144206028.atnat0015.highway.a1.net. [89.144.206.28])
        by mx.google.com with ESMTPS id m9sm666557bkm.10.2012.08.15.05.00.44
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 05:00:46 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v4no59phn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203470>

On Tuesday 14 August 2012 13:40:20 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
> > to retrieve information about blobs and trees that already exist in
> > fast-import's memory. This requires a channel from fast-import to the
> > remote-helper.
> > remote-helpers that use this features shall advertise the new
> > 'bidi-import'
> 
> s/this fea/these fea/
> 
> > capability so signal that they require the communication channel.
> 
> s/so sig/to sig/, I think.
> 
> > When forking fast-import in transport-helper.c connect it to a dup of
> > the remote-helper's stdin-pipe. The additional file descriptor is passed
> > to fast-import via it's command line (--cat-blob-fd).
> 
> s/via it's/via its/;
> 
> > It follows that git and fast-import are connected to the remote-helpers's
> > stdin.
> > Because git can send multiple commands to the remote-helper on it's stdin,
> > it is required that helpers that advertise 'bidi-import' buffer all input
> > commands until the batch of 'import' commands is ended by a newline
> > before sending data to fast-import.
> > This is to prevent mixing commands and fast-import responses on the
> > helper's stdin.
> 
> Please have a blank line each between paragraphs; a solid block of
> text is very hard to follow.
> 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  transport-helper.c |   45 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> > 
> > diff --git a/transport-helper.c b/transport-helper.c
> > index cfe0988..257274b 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -10,6 +10,7 @@
> > 
> >  #include "string-list.h"
> >  #include "thread-utils.h"
> >  #include "sigchain.h"
> > 
> > +#include "argv-array.h"
> > 
> >  static int debug;
> > 
> > @@ -19,6 +20,7 @@ struct helper_data {
> > 
> >  	FILE *out;
> >  	unsigned fetch : 1,
> >  	
> >  		import : 1,
> > 
> > +		bidi_import : 1,
> > 
> >  		export : 1,
> >  		option : 1,
> >  		push : 1,
> > 
> > @@ -101,6 +103,7 @@ static void do_take_over(struct transport *transport)
> > 
> >  static struct child_process *get_helper(struct transport *transport)
> >  {
> >  
> >  	struct helper_data *data = transport->data;
> > 
> > +	struct argv_array argv = ARGV_ARRAY_INIT;
> > 
> >  	struct strbuf buf = STRBUF_INIT;
> >  	struct child_process *helper;
> >  	const char **refspecs = NULL;
> > 
> > @@ -122,11 +125,10 @@ static struct child_process *get_helper(struct
> > transport *transport)> 
> >  	helper->in = -1;
> >  	helper->out = -1;
> >  	helper->err = 0;
> > 
> > -	helper->argv = xcalloc(4, sizeof(*helper->argv));
> > -	strbuf_addf(&buf, "git-remote-%s", data->name);
> > -	helper->argv[0] = strbuf_detach(&buf, NULL);
> > -	helper->argv[1] = transport->remote->name;
> > -	helper->argv[2] = remove_ext_force(transport->url);
> > +	argv_array_pushf(&argv, "git-remote-%s", data->name);
> > +	argv_array_push(&argv, transport->remote->name);
> > +	argv_array_push(&argv, remove_ext_force(transport->url));
> > +	helper->argv = argv.argv;
> 
> Much nicer than before thanks to argv_array ;-)
> 
> >  	helper->git_cmd = 0;
> >  	helper->silent_exec_failure = 1;
> > 
> > @@ -141,6 +143,8 @@ static struct child_process *get_helper(struct
> > transport *transport)> 
> >  	data->helper = helper;
> >  	data->no_disconnect_req = 0;
> > 
> > +	free((void*) helper_env[1]);
> 
> What is this free() for???

Sorry, legacy from previous versions, will be deleted.
> 
> > +	argv_array_clear(&argv);
> 
> See below.
> 
> >  	/*
> >  	
> >  	 * Open the output as FILE* so strbuf_getline() can be used.
> > 
> > @@ -178,6 +182,8 @@ static struct child_process *get_helper(struct
> > transport *transport)> 
> >  			data->push = 1;
> >  		
> >  		else if (!strcmp(capname, "import"))
> >  		
> >  			data->import = 1;
> > 
> > +		else if (!strcmp(capname, "bidi-import"))
> > +			data->bidi_import = 1;
> > 
> >  		else if (!strcmp(capname, "export"))
> >  		
> >  			data->export = 1;
> >  		
> >  		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
> > 
> > @@ -241,8 +247,6 @@ static int disconnect_helper(struct transport
> > *transport)> 
> >  		close(data->helper->out);
> >  		fclose(data->out);
> >  		res = finish_command(data->helper);
> > 
> > -		free((char *)data->helper->argv[0]);
> > -		free(data->helper->argv);
> > 
> >  		free(data->helper);
> >  		data->helper = NULL;
> >  	
> >  	}
> > 
> > @@ -376,14 +380,24 @@ static int fetch_with_fetch(struct transport
> > *transport,> 
> >  static int get_importer(struct transport *transport, struct child_process
> >  *fastimport) {
> >  
> >  	struct child_process *helper = get_helper(transport);
> > 
> > +	struct helper_data *data = transport->data;
> > +	struct argv_array argv = ARGV_ARRAY_INIT;
> > +	int cat_blob_fd, code;
> > 
> >  	memset(fastimport, 0, sizeof(*fastimport));
> >  	fastimport->in = helper->out;
> > 
> > -	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
> > -	fastimport->argv[0] = "fast-import";
> > -	fastimport->argv[1] = "--quiet";
> > +	argv_array_push(&argv, "fast-import");
> > +	argv_array_push(&argv, "--quiet");
> > 
> > +	if (data->bidi_import) {
> > +		cat_blob_fd = xdup(helper->in);
> > +		argv_array_pushf(&argv, "--cat-blob-fd=%d", cat_blob_fd);
> > +	}
> > +	fastimport->argv = argv.argv;
> > 
> >  	fastimport->git_cmd = 1;
> > 
> > -	return start_command(fastimport);
> > +
> > +	code = start_command(fastimport);
> > +	argv_array_clear(&argv);
> > +	return code;
> > 
> >  }
> >  
> >  static int get_exporter(struct transport *transport,
> > 
> > @@ -438,11 +452,16 @@ static int fetch_with_import(struct transport
> > *transport,> 
> >  	}
> >  	
> >  	write_constant(data->helper->in, "\n");
> > 
> > +	/*
> > +	 * remote-helpers that advertise the bidi-import capability are required
> > to +	 * buffer the complete batch of import commands until this newline
> > before +	 * sending data to fast-import.
> > +	 * These helpers read back data from fast-import on their stdin, which
> > could +	 * be mixed with import commands, otherwise.
> > +	 */
> > 
> >  	if (finish_command(&fastimport))
> >  	
> >  		die("Error while running fast-import");
> > 
> > -	free(fastimport.argv);
> > -	fastimport.argv = NULL;
> 
> The updated code frees argv[] immediately after start_command()
> returns, and it may happen to be safe to do so with the current
> implementation of start_command() and friends, but I think it is a
> bad taste to free argv[] (or env[] for that matter) before calling
> finish_command().  These pieces of memory are still pointed by the
> child_process structure, and users of the structure may want to use
> contents of them (especially, argv[0]) for reporting errors and
> various other purposes, e.g.
> 
> 	child = get_helper();
> 
>         trace("started %s\n", child->argv[0]);
> 
> 	if (finish_command(child))
>         	return error("failed to cleanly finish %s", child->argv[0]);

Yes, sounds reasonable. The present of immedate clearing has the advantage 
that I don't have to store the struct argv_array, as struct child_process only 
has a member for const char **argv.
I'll improve postpone the free until the command finishes.
