Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192729DB88
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647198; cv=none; b=eMI6201E2fqZy2ro2vvsCstBzrAc3xnbkUw1HZ96SYas6tQZo/d7sMnZTym9oj6u0MKoPfZWWtI91MwtcAV/CDqXP3YPynglOzA28a/gU8BU4Tfr2GKSz3a24mpNkKbqPQkrM4mZUXXc7+SD8jHZqBCP6lZzFwWmiXkyRl+J4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647198; c=relaxed/simple;
	bh=r+RFG6YJlIXuMmVFZACaEyAfdUhheMJYmQRjPFQDMvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/hCXN50Hw54mRJhIdrqJeOmAT3UXc1HUBtXXanG/OhtNG2BiuItRbi4XUyY4eaQsJ6OQ93dBYhXCIVAJAv26cgi28AUQcci3vEIUbJE30Bd02Qx13HskFpFgUHnK8tFZM9bI4yFz+k9DlQ4YI4UaBxSmaSJWM6wi6SFrhTYN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UhVA7X40; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UhVA7X40"
Received: (qmail 170977 invoked by uid 106); 27 Mar 2026 21:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=r+RFG6YJlIXuMmVFZACaEyAfdUhheMJYmQRjPFQDMvQ=; b=UhVA7X40s9LFj91BJepi9LoUktLIocNMmT0DQJtUa+qGI2u8X2elPyzrxfqN0vXdOH27lATEy2gL6y7hrfjz7Er7N+Lj58EkcJlf9h59OAw8kyyG6+9Rck31wtuiyodkjxX8sDApT3bVbak2erSry1J4ygGU6AfHHFjSlqAr62sPpgkp4HlVogbFG4RjVCFkagmn8x8qG8y9CJPy+r9YpPUA+nRUkWxHP6vO5wqpUrE70cwc/jN4Rj5AEgan70SMFzHqlZM0fOfsWRJMdW+gvZe25FeG0B8AHdVIsQ7DyC5qgaAaGb55AVBU0//XJVwgg8Z/6eiMJVsYrSyzJ5g3sA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Mar 2026 21:33:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 239637 invoked by uid 111); 27 Mar 2026 21:33:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2026 17:33:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Mar 2026 17:33:08 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] connect: Rename name to command in connect_git()
Message-ID: <20260327213308.GA598533@coredump.intra.peff.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-2-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326233739.2911354-2-wesleys@opperschaap.net>

On Thu, Mar 26, 2026 at 07:37:36PM -0400, Wesley Schwengle wrote:

> connect_git has `char *name' in its signature and it caught me a little
> offguard. I initially thought it was the remote name. But when you look
> closer at the various call sites it is actually a command that is send
> over the wire, eg . `git-receive-pack'. Change the naming makes it
> easier to read the code and understand its intention.

I agree that "name" is not all that descriptive, but I think there's a
hidden gotcha in the explanation above. This string is _not_ the command
that we send over the wire. That's "prog" in the same function. And the
reason that "name" exists is that it is a stable name for the operation
we are performing, like "git-receive-pack", even if configuration or
command-line parameters (like "--receive-pack=foo") tell us to use a
different command name.

So probably "op" or "type" is a more accurate description. This
conceptually ought to be an enum, too, since it is selecting from a
limited set of operations we know about.

I took a quick stab at converting it to an enum (see below) and it's
mostly an improvement, but:

  1. The ripple effect went much farther than I expected, since the
     transport code is passing these values, too. If we are going to
     update one function in the chain, we should probably do all of them
     (even if it is just a change of the variable name).

  2. We end up having to convert to a string at some points anyway for
     producing error messages, and for passing across the remote-helper
     barrier. But I think we are still better off, because it's more
     clear where we are using the string-ified version and what values
     it could take.

-Peff

---
diff --git a/builtin/archive.c b/builtin/archive.c
index 13ea7308c8..3c1288a123 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -31,7 +31,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	_remote = remote_get(remote);
 	transport = transport_get(_remote, _remote->url.v[0]);
-	transport_connect(transport, "git-upload-archive", exec, fd);
+	transport_connect(transport, GIT_CONNECT_UPLOAD_ARCHIVE, exec, fd);
 
 	/*
 	 * Inject a fake --format field at the beginning of the
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d9e42bad58..316badd969 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -223,7 +223,7 @@ int cmd_fetch_pack(int argc,
 		int flags = args.verbose ? CONNECT_VERBOSE : 0;
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
-		conn = git_connect(fd, dest, "git-upload-pack",
+		conn = git_connect(fd, dest, GIT_CONNECT_UPLOAD_PACK,
 				   args.uploadpack, flags);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8b81c8a848..1412b49bc8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -273,8 +273,9 @@ int cmd_send_pack(int argc,
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, "git-receive-pack", receivepack,
-			args.verbose ? CONNECT_VERBOSE : 0);
+		conn = git_connect(fd, dest, GIT_CONNECT_RECEIVE_PACK,
+				   receivepack,
+				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
diff --git a/connect.c b/connect.c
index a02583a102..dad1cff1a8 100644
--- a/connect.c
+++ b/connect.c
@@ -1428,6 +1428,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
  */
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *name,
+				  enum git_connect_type type,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
@@ -1441,7 +1442,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
 	 * to do anything else (like push or remote archive) via v2.
 	 */
-	if (version == protocol_v2 && strcmp("git-upload-pack", name))
+	if (version == protocol_v2 && type != GIT_CONNECT_UPLOAD_PACK)
 		version = protocol_v0;
 
 	/* Without this we cannot rely on waitpid() to tell
diff --git a/connect.h b/connect.h
index 1645126c17..641498c759 100644
--- a/connect.h
+++ b/connect.h
@@ -7,7 +7,12 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-struct child_process *git_connect(int fd[2], const char *url, const char *name, const char *prog, int flags);
+enum git_connect_type {
+    GIT_CONNECT_UPLOAD_PACK,
+    GIT_CONNECT_RECEIVE_PACK,
+    GIT_CONNECT_UPLOAD_ARCHIVE,
+};
+struct child_process *git_connect(int fd[2], const char *url, enum git_connect_type, const char *prog, int flags);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..c7fab6f560 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -620,8 +620,22 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	return ret;
 }
 
+static const char *connect_type_to_command(enum git_connect_type type)
+{
+	switch (type) {
+	case GIT_CONNECT_UPLOAD_PACK:
+		return "git-upload-pack";
+	case GIT_CONNECT_RECEIVE_PACK:
+		return "git-receive-pack";
+	case GIT_CONNECT_UPLOAD_ARCHIVE:
+		return "git-upload-archive";
+	}
+	BUG("unknown git_connect_type: %d", type);
+}
+
 static int process_connect_service(struct transport *transport,
-				   const char *name, const char *exec)
+				   enum git_connect_type type,
+				   const char *exec)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf cmdbuf = STRBUF_INIT;
@@ -631,7 +645,7 @@ static int process_connect_service(struct transport *transport,
 	 * Handle --upload-pack and friends. This is fire and forget...
 	 * just warn if it fails.
 	 */
-	if (strcmp(name, exec)) {
+	if (strcmp(connect_type_to_command(type), exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
 			warning(_("setting remote service path not supported by protocol"));
@@ -640,13 +654,13 @@ static int process_connect_service(struct transport *transport,
 	}
 
 	if (data->connect) {
-		strbuf_addf(&cmdbuf, "connect %s\n", name);
+		strbuf_addf(&cmdbuf, "connect %s\n", connect_type_to_command(type));
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   (!strcmp("git-upload-pack", name) ||
-		    !strcmp("git-upload-archive", name))) {
-		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
+		   (type == GIT_CONNECT_UPLOAD_PACK ||
+		    type == GIT_CONNECT_UPLOAD_ARCHIVE)) {
+		strbuf_addf(&cmdbuf, "stateless-connect %s\n", connect_type_to_command(type));
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
 			transport->stateless_rpc = 1;
@@ -660,32 +674,33 @@ static int process_connect(struct transport *transport,
 				     int for_push)
 {
 	struct helper_data *data = transport->data;
-	const char *name;
+	enum git_connect_type type;
 	const char *exec;
 	int ret;
 
-	name = for_push ? "git-receive-pack" : "git-upload-pack";
+	type = for_push ? GIT_CONNECT_RECEIVE_PACK : GIT_CONNECT_UPLOAD_PACK;
 	if (for_push)
 		exec = data->transport_options.receivepack;
 	else
 		exec = data->transport_options.uploadpack;
 
-	ret = process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, type, exec);
 	if (ret)
 		do_take_over(transport);
 	return ret;
 }
 
-static int connect_helper(struct transport *transport, const char *name,
-		   const char *exec, int fd[2])
+static int connect_helper(struct transport *transport, enum git_connect_type type,
+			  const char *exec, int fd[2])
 {
 	struct helper_data *data = transport->data;
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 
-	if (!process_connect_service(transport, name, exec))
-		die(_("can't connect to subservice %s"), name);
+	if (!process_connect_service(transport, type, exec))
+		die(_("can't connect to subservice %s"),
+		    connect_type_to_command(type));
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
diff --git a/transport-internal.h b/transport-internal.h
index 90ea749e5c..1a86c63ce0 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -58,7 +58,7 @@ struct transport_vtable {
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
-	int (*connect)(struct transport *connection, const char *name,
+	int (*connect)(struct transport *connection, enum git_connect_type type,
 		       const char *executable, int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
diff --git a/transport.c b/transport.c
index cb1befba8c..2fd94d701f 100644
--- a/transport.c
+++ b/transport.c
@@ -308,8 +308,8 @@ static int connect_setup(struct transport *transport, int for_push)
 
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ?
-					"git-receive-pack" :
-					"git-upload-pack",
+					GIT_CONNECT_RECEIVE_PACK :
+					GIT_CONNECT_UPLOAD_PACK,
 				 for_push ?
 					data->options.receivepack :
 					data->options.uploadpack,
@@ -956,12 +956,12 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
-static int connect_git(struct transport *transport, const char *name,
+static int connect_git(struct transport *transport, enum git_connect_type type,
 		       const char *executable, int fd[2])
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 name, executable, 0);
+				 type, executable, 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
@@ -1650,11 +1650,11 @@ void transport_unlock_pack(struct transport *transport, unsigned int flags)
 		string_list_clear(&transport->pack_lockfiles, 0);
 }
 
-int transport_connect(struct transport *transport, const char *name,
+int transport_connect(struct transport *transport, enum git_connect_type type,
 		      const char *exec, int fd[2])
 {
 	if (transport->vtable->connect)
-		return transport->vtable->connect(transport, name, exec, fd);
+		return transport->vtable->connect(transport, type, exec, fd);
 	else
 		die(_("operation not supported by protocol"));
 }
diff --git a/transport.h b/transport.h
index 892f19454a..1e6fd263f6 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "connect.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -324,7 +325,7 @@ char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
 
-int transport_connect(struct transport *transport, const char *name,
+int transport_connect(struct transport *transport, enum git_connect_type type,
 		      const char *exec, int fd[2]);
 
 /* Transport methods defined outside transport.c */
