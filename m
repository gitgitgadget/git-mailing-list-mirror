From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 12/16] transport: get_refs_via_connect exchanges capabilities before refs.
Date: Mon,  1 Jun 2015 17:02:14 -0700
Message-ID: <1433203338-27493-13-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:05:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfe-0000ju-62
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbbFBADB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:01 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34410 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbFBACu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:50 -0400
Received: by ieczm2 with SMTP id zm2so121552785iec.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xn4MICK1cIGTAZ78CYrZVOp9SrF8PmkKTTv+46uy0rQ=;
        b=Xzm3gjSMHwUtwF35LQvakeuWW4MzquYqQQmU1x/Qi5CLI+pdM4jX0AR3ycsIX3B0ox
         Pd3vyhDLqwi+N6nlY3uWNkqP5P9vODl18itcwvFBc5zmqi5Xa8DmVY5bERfepCDKk6b8
         asDDlu9o05BPTjBe+OwcYjD1NJhhgsirg4o3JOIPogTgQ3KMb1ua2oaSpUV5M4A9tudx
         ZBfPn5Lgq/c8/wND7Ztj0C17BfS+ILOo5KNqLUWOVAYWgxVQsyOr1UZNY6odpk4Jtoae
         nbRfzzeD1CG654gKnXb/cQEowIL/wz7emZp0Veoxzt+OsxtLvLjjrnc7/ktYosZORueG
         Fclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xn4MICK1cIGTAZ78CYrZVOp9SrF8PmkKTTv+46uy0rQ=;
        b=iS8Cd8Mdjy13d4YXAMABIx+OQ5G2uMkRjxOcA2F6NJo3i/8C6BS9Gh02bihnyBE7yf
         QXnCsGIPoDkaOibuSkzLdNZVn0nM193SZPpRMI7utjqJ7kFBYLfCjWxlGWVYB8aTyQo7
         I+J7VQitwtO4ZV7lSSkRJxUdgODBBi0rVYYw5PC3Jhj1o07OV7Mauff4xAAn+a2FwWn4
         HnHS4acjTNk8nv6kQ6IW6wQ+WD2966J1fON5V/D2U3NGQnaHRqoBNarOoToRIBh3Q/EK
         00MO9VxlOEq9KkODuf1CHzCJ9btqKbKz7LNI7JMjHqGqvW8KI68wYRdibVIQT86HhpUV
         MVxg==
X-Gm-Message-State: ALoCoQkBR0Y3ANL+654TS7I6kLGBOjZFlvCNY8on9YXBr031gIJ/PDgv2YRWH2LaC48HWDOC9jD3
X-Received: by 10.42.152.67 with SMTP id h3mr15481639icw.56.1433203368336;
        Mon, 01 Jun 2015 17:02:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id l6sm8903982igx.10.2015.06.01.17.02.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270498>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    A minor issue I am unsure about here is the
    line
    	&& transport->smart_options->transport_version)
    which could be prevented if we always set the transport_version
    in make_remote to be the default remote version.
    
    The advantage of having it always set in make_remote would
    be a cleaner mind model (the version set is always accurate)
    as opposed to now (version may be 0, then the default
    applies as we don't care enough to set a version)
    
    However I think the code may be more ugly if we were to
    always set the version in make_remote as then we would need
    to move the DEFAULT_TRANSPORT_VERSION define into remote.h
    or somewhere else (transport.h is not included in remote.c,
    I guess that's on purpose?)

 transport.c | 28 ++++++++++++++++++++++++----
 transport.h |  6 ++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index b49fc60..ba40677 100644
--- a/transport.c
+++ b/transport.c
@@ -523,14 +523,33 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
 {
+	struct transport_options options;
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
+	int version = DEFAULT_TRANSPORT_VERSION;
 
+	if (transport->smart_options
+	    && transport->smart_options->transport_version)
+		version = transport->smart_options->transport_version;
 	connect_setup(transport, for_push, 0);
-	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0,
-			 &data->extra_have,
-			 &data->shallow);
+	switch (version) {
+	case 2: /* first talk about capabilities, then get the heads */
+		get_remote_capabilities(data->fd[0], NULL, 0);
+		preselect_capabilities(&options);
+		if (transport->select_capabilities)
+			transport->select_capabilities(&options);
+		request_capabilities(data->fd[1], &options);
+		/* fall through */
+	case 1:
+		get_remote_heads(data->fd[0], NULL, 0, &refs,
+				 for_push ? REF_NORMAL : 0,
+				 &data->extra_have,
+				 &data->shallow);
+		break;
+	default:
+		die("BUG: Transport version %d not supported", version);
+		break;
+	}
 	data->got_remote_heads = 1;
 
 	return refs;
@@ -987,6 +1006,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->set_option = NULL;
+		ret->select_capabilities = NULL;
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push_refs = git_transport_push;
diff --git a/transport.h b/transport.h
index 6095d7a..3e63efc 100644
--- a/transport.h
+++ b/transport.h
@@ -74,6 +74,12 @@ struct transport {
 	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
 
 	/**
+	 * A callback to select protocol options. Must be set if
+	 * the caller wants to change transport options.
+	 */
+	void (*select_capabilities)(struct transport_options *);
+
+	/**
 	 * Push the objects and refs. Send the necessary objects, and
 	 * then, for any refs where peer_ref is set and
 	 * peer_ref->new_sha1 is different from old_sha1, tell the
-- 
2.4.1.345.gab207b6.dirty
