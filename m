Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A736DA04
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036639; cv=none; b=GfbH4Q4ilPbO12z25B8sdR6aIquHJl///7ZJ/bM2cVrJAVfg0+Sw1qXos/eZkvkuB4FrpH3u9qW0tAfwNHv3OPJsqaN3nAaIKKWN/kp8h6Mire6r9kBCoHAbxZ2LWBQwOWA8a6PTrO4l/nRwf8R7A8AsQb9Ow/MZ833uWAG6veY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036639; c=relaxed/simple;
	bh=RKCnxO+5jEBAATdLabcQ9ccPDvo7dKaLtsXJZvL/glU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT3WmmY9zRNJY07/jt3bqF5QKcDJICXs/xL/RDATnvavHL5cnS/rX4eCMzt/2jJsL3Qzc+WgVtzbd+3pZlALP5G3v9AEdwMVQgEo1EqL4k0gTDOqBJGzM5vPxNuazbeJf4ZP0sq5V8/Lsqvb1cw4jnFpAb3RWgsuIgbyp0DlpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SKzrp1b/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SKzrp1b/"
Received: (qmail 62024 invoked by uid 106); 6 Aug 2026 17:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RKCnxO+5jEBAATdLabcQ9ccPDvo7dKaLtsXJZvL/glU=; b=SKzrp1b/1K+MdA0CdQl628GHfdoki5Hh/Dak0AJoAIT5mr61bSXUL6rgdU0zKUNsNh+IGhZpy1Wh/pPyBJkOuROokm7/2ISOvmIEUvWw/lu1oRKLT6+yn8ZDsoH3iSMLPZs/AQ6FcNtIGay22Ajy/mBSP4xoizeLLz5ifAyxTLfUL9Ro+afPJVrWq6c5hneRTs/6r0cMP0MbJW5UcjRREoT8ig/pdvdqZdrCAsJH18m+uCDiEG4j2TNgPo2JbjGJST3m5SmpjH9CRK1s8guVzDdeAmP78BNfOkoCADzpp5ZeVzf4+rCqpKmc8FI+De57i+u1nJeXV9SwBMhF5C3VwA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Aug 2026 17:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96029 invoked by uid 111); 6 Aug 2026 17:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Aug 2026 13:17:15 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Aug 2026 13:17:14 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH GSoC v4 0/9] cat-file: extend remote-object-info to
 support %(objecttype)
Message-ID: <20260806171714.GA1632126@coredump.intra.peff.net>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>

On Tue, Aug 04, 2026 at 08:42:54PM +0200, Pablo Sabater wrote:

> Patches 1-5 are preparatory. They don't change what the command does:
> - [1/9] is a test cleanup.
> - [2/9] fixes a possible bug in case of a malformed response.
> - [3/9] and [4/9] refactor how the object data is stored and handled. The
>   why about this refactor comes from [2].

Thanks, I think these refactors in patches 3 and 4 make sense and
address the issues raised in the earlier thread. I'd actually take patch
3 just a step further, as below (which you are welcome to put on top of
your series, or work it into the middle, or even take as inspiration and
rewrite as part of another patch).

-- >8 --
Subject: transport: drop remote object-info fields from transport struct

A remote object-info request needs three things: the transport for
contacting the remote, the list of oids to request, and a place to store
the output.

Rather than take these as function parameters, we take only the
transport object, and expect the caller to have placed the other two
into special fields in the transport struct. But this doesn't make much
sense. The set of oids and results are really only valid for one
request. There is no reason the transport would need to hang on to them
outside of the single function call.

Even though we save a few lines passing the parameters around through
the various vtable functions, the result is harder to understand (for
example, who is responsible for cleaning up results, and when shoudl it
happen?). It also opens up the possibility of a subtle bug. A caller is
likely to point those fields to stack variables which could go out of
scope, and the transport struct would be left holding invalid pointers.

This is mostly harmless now, as we disconnect the transport immediately
after the sole caller of transport_fetch_object_info(). But conceptually
we could keep we could keep the transport open and make multiple fetch
calls (and reuse the same connection to the helper, to a remote HTTP
server, and so on).

So let's pull these out of the struct and pass them as function
parameters. It's a little more verbose, but I think more clearly
illustrates the intent. I've also tweaked a few function signatures to
mark the input oid array as const, since it is purely an input to the
function.

Signed-off-by: Jeff King <peff@peff.net>
---
I do think the concept of reusing the transport will become useful
later. We limit a single request to 10,000 objects, so it is quite
conceivable a caller would want to make several. That can mostly come
later on top, though I think the design of the remote-object-info
command makes it awkward. Each invocation provides a remote by name,
which is then resolved to a transport. But a given caller is likely
going to provide the same remote over and over again.

We probably could get away with just caching the last-used transport and
reusing it when fed the same remote name again. But we could perhaps
also change the protocol (which AFAICT is not yet in any released
version, so still available for changes) to specify the two
independently, like:

   remote https://example.com/foo.git
   remote-object-info objA objB objC...
   remote-object-info objX objY objZ

And then it is more clear that setting "remote" is stateful, and will be
used for subsequent remote-* commands. But maybe that statefulness is
something we don't want. I dunno.

Anyway, either way I think the cleanup below is worth doing in the short
term.

 builtin/cat-file.c   |  6 ++----
 fetch-object-info.c  |  4 ++--
 fetch-object-info.h  |  2 +-
 transport-helper.c   |  7 +++++--
 transport-internal.h |  4 +++-
 transport.c          | 14 +++++++++-----
 transport.h          |  7 +++----
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 950d9f237f..4f4d791821 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -730,10 +730,8 @@ static int get_remote_info(int argc,
 		goto cleanup;
 	}
 
-	gtransport->smart_options->object_info_oids = object_info_oids;
-
-	gtransport->smart_options->object_info_results = results;
-	retval = transport_fetch_object_info(gtransport);
+	retval = transport_fetch_object_info(gtransport, object_info_oids,
+					     results);
 cleanup:
 	transport_disconnect(gtransport);
 	return retval;
diff --git a/fetch-object-info.c b/fetch-object-info.c
index ad27b1e4ca..385462c707 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -12,7 +12,7 @@
 /* Sends object-info command and its arguments into the request buffer. */
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
-				     struct oid_array *oids,
+				     const struct oid_array *oids,
 				     unsigned ask_size,
 				     unsigned ask_type)
 {
@@ -54,7 +54,7 @@ static int parse_object_size(const char *s, size_t *res)
 
 void fetch_object_info(enum protocol_version version,
 		       const struct string_list *server_options,
-		       struct oid_array *oids,
+		       const struct oid_array *oids,
 		       struct packet_reader *reader,
 		       struct fetch_object_info_results *results,
 		       int stateless_rpc,
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 10b3641f7c..2fba96c6f7 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -29,7 +29,7 @@ struct oid_array;
  */
 void fetch_object_info(enum protocol_version version,
 		       const struct string_list *server_options,
-		       struct oid_array *oids,
+		       const struct oid_array *oids,
 		       struct packet_reader *reader,
 		       struct fetch_object_info_results *results,
 		       int stateless_rpc,
diff --git a/transport-helper.c b/transport-helper.c
index f3cb8f8662..d5a064d386 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -786,11 +786,14 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
-static int fetch_object_info_helper(struct transport *transport)
+static int fetch_object_info_helper(struct transport *transport,
+				    const struct oid_array *oids,
+				    struct fetch_object_info_results *results)
 {
 	get_helper(transport);
 	if (process_connect(transport, 0))
-		return transport->vtable->fetch_object_info(transport);
+		return transport->vtable->fetch_object_info(transport, oids,
+							    results);
 
 	die(_("object-info requires protocol v2"));
 }
diff --git a/transport-internal.h b/transport-internal.h
index 60db0bedcd..e7ead5d785 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -51,7 +51,9 @@ struct transport_vtable {
 	 *
 	 * Uses object-info capability of v2 protocol.
 	 */
-	int (*fetch_object_info)(struct transport *transport);
+	int (*fetch_object_info)(struct transport *transport,
+				 const struct oid_array *oids,
+				 struct fetch_object_info_results *results);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index 35acdf71a2..25e2c14a7b 100644
--- a/transport.c
+++ b/transport.c
@@ -433,7 +433,9 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
-static int fetch_object_info_via_pack(struct transport *transport)
+static int fetch_object_info_via_pack(struct transport *transport,
+				      const struct oid_array *oids,
+				      struct fetch_object_info_results *results)
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
@@ -450,9 +452,9 @@ static int fetch_object_info_via_pack(struct transport *transport)
 
 	fetch_object_info(data->version,
 			  transport->server_options,
-			  transport->smart_options->object_info_oids,
+			  oids,
 			  &reader,
-			  data->options.object_info_results,
+			  results,
 			  transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
@@ -465,11 +467,13 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	return ret;
 }
 
-int transport_fetch_object_info(struct transport *transport)
+int transport_fetch_object_info(struct transport *transport,
+				const struct oid_array *oids,
+				struct fetch_object_info_results *results)
 {
 	if (!transport->vtable->fetch_object_info)
 		die(_("remote does not support object-info"));
-	return transport->vtable->fetch_object_info(transport);
+	return transport->vtable->fetch_object_info(transport, oids, results);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
diff --git a/transport.h b/transport.h
index 6948b65db9..39193d0077 100644
--- a/transport.h
+++ b/transport.h
@@ -57,9 +57,6 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
-
-	struct oid_array *object_info_oids;
-	struct fetch_object_info_results *object_info_results;
 };
 
 enum transport_family {
@@ -317,7 +314,9 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 /*
  * Fetch the object info from remote
  */
-int transport_fetch_object_info(struct transport *transport);
+int transport_fetch_object_info(struct transport *transport,
+				const struct oid_array *oids,
+				struct fetch_object_info_results *results);
 
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe
-- 
2.55.0.819.g4e24f5e379

