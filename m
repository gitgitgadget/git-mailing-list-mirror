From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Tue, 22 Oct 2013 16:00:13 -0700
Message-ID: <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
	<1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
	<20131011235052.GV9464@google.com>
	<20131012002639.GE79408@vauxhall.crustytoothpaste.net>
	<20131018221535.GM865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 23 01:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYkw3-0006fd-PX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 01:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3JVXAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 19:00:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3JVXAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 19:00:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A49524DD24;
	Tue, 22 Oct 2013 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gQBV4h7zgiG9qU/nPbheFIvfTfM=; b=T3XIOL
	GRN+O7VA8jI3725V/nrBtfFacsslUynsE5m/2uUA3REum6+V1UeX+ueKvCE1bz/0
	hcOTa7Q/r217XXNg2Oym6jW8NOrQYFFGXJOIJCwNkwEppZ7Yq0H3c9TQsC+s0Y0t
	w+Zt3kcDxzmutXnOOOPDW8XchILX0MeNNydFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIE1XoPed5sxhKsfvLMlHYzoUkg1yZo4
	fNdMdl0pt2HHc0z9eX6RwB2JwxbvASy1te6Scr1NOTjtOhA4jA0+bjeaBgF7GEz7
	8gWSff05R1VbsLMVOmvwC5QZhYBFoQFRRDOe05IZixK0c/J9yMbhfhyTdc2we30R
	+aN1U1mhDTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 990B64DD23;
	Tue, 22 Oct 2013 23:00:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFDE44DD17;
	Tue, 22 Oct 2013 23:00:14 +0000 (UTC)
In-Reply-To: <20131018221535.GM865149@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 18 Oct 2013 22:15:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B66D018E-3B6D-11E3-B6F3-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236492>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sat, Oct 12, 2013 at 12:26:39AM +0000, brian m. carlson wrote:
>> On Fri, Oct 11, 2013 at 04:50:52PM -0700, Jonathan Nieder wrote:
>> > Perhaps this should be conditional on the authentication method used,
>> > so affected people could still contact broken servers without having
>> > different configuration per server and without having to wait a second
>> > for the timeout.
>> 
>> curl determines what method, but I guess it's safe to assume that the
>> authentication method used for the probe will be the same as the one
>> used for the final connection.  Unfortunately, all curl will tell us is
>> what was offered, not what it would have chosen, so if GSSAPI and
>> something non-Basic are both offered, we'd have to make a guess.  (curl
>> will always prefer non-Basic to Basic for the obvious reasons.)
>> 
>> If you can argue for some sane semantics in what we should do in that
>> case, I'll reroll with that fix and a clearer wording for the docs.
>
> Reading Jonathan Nieder's responses to the first patch, it looks like he
> was going to apply it, but I haven't seen it make its way into next or
> pu.  Junio, do you want a reroll, and if so, do you want certain
> semantics for autodetecting this case, or are you just looking for
> documentation fixes?

Sorry, I wasn't following the topic closely.  I can guess what
Jonathan meant by "fixups mentioned above", which will be something
like the attached patch, but I am not sure what the conclusion of
the discussion on 2/2 was.

Reading the first part of the description alone gives me an
impression that this is only about authentication, but the change
actually affects (and it should affect) any large-payload exchange,
not limited to authentication, no?

    +http.continue::
    +	Ensure that authentication succeeds before sending the pack data when
    +	POSTing data using the smart HTTP transport.

I also somehow find "http.continue" a strange name for the option.
"http.use100Continue" that can be set to "yes" or "no" would make
sense to me, but it is not immediately obvious what "http.continue"
set to "no" would mean to regular users, opening ourselves to an
obvious misinterpretation to misread the variable name as if it
would allow resuming a large transfer that failed previously due to
connection timeout or something.

-- >8 --
From: "Brian M. Carlson" <sandals@crustytoothpaste.net>
Date: Fri, 11 Oct 2013 22:35:44 +0000
Subject: [PATCH] http: add option to enable 100 Continue responses

When using GSS-Negotiate authentication with libcurl, the
authentication provided will change every time, and so the probe
that git uses to determine if authentication is needed is not
sufficient to guarantee that data can be sent.  If the data fits
entirely in http.postBuffer bytes, the data can be rewound and
resent if authentication fails; otherwise, a 100 Continue must be
requested in this case.

The cURL library can send an "Expect: 100 continue" if a certain
amount of data is to be uploaded, but when using chunked data, we
deliberately and unconditionally disable this behaviour, because
there are many proxy servers in the wild that do not handle
"100 continue" correctly.

Add an option http.continue, which defaults to disabled, to control
whether this header is sent; this can be used when the user knows
the destination server and all the proxies between the server and
the client handle "100 continue" correctly.

Signed-off-by: Brian M. Carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c        | 6 ++++++
 http.h        | 1 +
 remote-curl.c | 9 ++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index f3e1439..58651ee 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,7 @@
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
+int http_use_100_continue;
 
 #if LIBCURL_VERSION_NUM >= 0x070a06
 #define LIBCURL_CAN_HANDLE_AUTH_ANY
@@ -213,6 +214,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.continue", var)) {
+		http_use_100_continue = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
diff --git a/http.h b/http.h
index d77c1b5..e72786e 100644
--- a/http.h
+++ b/http.h
@@ -102,6 +102,7 @@ extern void http_cleanup(void);
 extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
+extern int http_use_100_continue;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
diff --git a/remote-curl.c b/remote-curl.c
index b5ebe01..ba2b505 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -470,7 +470,14 @@ static int post_rpc(struct rpc_state *rpc)
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
-	headers = curl_slist_append(headers, "Expect:");
+
+	/*
+	 * Force it either on or off, since curl will try to decide
+	 * based on how much data is to be uploaded and we want
+	 * consistency.
+	 */
+	headers = curl_slist_append(headers, http_use_100_continue ?
+		"Expect: 100-continue" : "Expect:");
 
 retry:
 	slot = get_active_slot();
-- 
1.8.4.1-824-gb03fdb5
