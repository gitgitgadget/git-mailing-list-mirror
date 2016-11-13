Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F0920229
	for <e@80x24.org>; Sun, 13 Nov 2016 01:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbcKMBrD (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 20:47:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932167AbcKMBrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 20:47:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA7F950372;
        Sat, 12 Nov 2016 20:47:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wjmeEfXJr83FurSpyjpv1vd2UQw=; b=lQ3gGI
        Fo6D1k5BESzpgy2qRVPXOX8icsdF7RXNel3KaxhtLUdETcu2hL2IY34t5HVAkzSu
        JTfJRnF4amXm4VgQTrs9W34+GpKP9v7G93L/EtqiHQ3PMx8fn9TWLc2XuHlgm3uI
        EI44HUzAXWa1sBVnfMIe7kCIDBHSQA1xrjy3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DDUIv6KPOjnGF07AeyjQPTA8n3cGRB2z
        ihoKy7iOaW82XVz8/LuR0QlLR6WG/MYvusLCws7I/fNdpM/Z+2PFJ8uY0Ndr29b/
        97FKu+MlhdXmZAmbYcs0lMhafYAhZ3PW7zV6irLoFmNxwxnBXPcJo0re7PiEEsOr
        apapkOrXGCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A99BD50371;
        Sat, 12 Nov 2016 20:47:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 071A750370;
        Sat, 12 Nov 2016 20:46:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git User <git.user@mailfence.com>, git@vger.kernel.org
Subject: Re: Feature request - show result of URL rewrites
References: <284668531.626.1478972994238.JavaMail.root@ichabod>
        <1478974642.3227.4.camel@kaarsemaker.net>
Date:   Sat, 12 Nov 2016 17:46:58 -0800
In-Reply-To: <1478974642.3227.4.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Sat, 12 Nov 2016 19:17:22 +0100")
Message-ID: <xmqqinrsywvh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 115B0640-A943-11E6-81BC-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>> Git lets you rewrite URLs using "url.<base>.insteadOf"
>>  ...
>> Can you add a git-config option to show the result of this rewriting
>> whenever this occurs, as debugging more complicated rules can be
>> difficult/wasn't obvious without Wireshark.
>> 
>> E.g. you could have the option 'url.printRewrites [True/False]' which
>> would print the line "Rewrote url 'git://github.com/git/git' to 'http
>> s://github.com/git/git'" to terminal/stdout  when set to True.
>
> Such a configuration would be superfluous, the GIT_TRACE and
> GIT_CURL_VERBOSE environment variables already provide all the
> debugging information you need here.

While i tend to agree with you that this kind of thing should not be
a new "configuration" that you need to unset after you are done
debugging, and should instead be done with a single-shot request
mechanism like environment variables, I do not think your response
is a fair and useful one.  Perhaps it is fair for the original
request that wants to have a knob to learn what the original was
rewritten to, but then the original request did not aim high enough
to get a useful feature, I would suspect.

GIT_TRACE or CURL_VERBOSE may show you the rewritten URL, and the
end user (presumably) knows what the original URL s/he handed Git to
go to, but I do not think these two are sufficient to find out what
triggered one URL to be rewritten to the other URL, which probably
is what the user wants to know the most.

Your response may become useful if remove.c::alias_url() is taught
to react to GIT_TRACE (or some other debugging mechanism we already
have), so that it reports what rule caused what URL to be rewritten
to what other URL.

This is just to illustrate where to patch and not meant to even
compile (e.g. "debug" is not even a variable defined anywhere), but
starting from something like this, perhaps?

 remote.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index ad6c5424ed..09dca9468f 100644
--- a/remote.c
+++ b/remote.c
@@ -63,11 +63,9 @@ static int valid_remote(const struct remote *remote)
 static const char *alias_url(const char *url, struct rewrites *r)
 {
 	int i, j;
-	struct counted_string *longest;
-	int longest_i;
+	struct counted_string *longest = NULL;
+	int longest_i = -1, instead_of_j = -1;
 
-	longest = NULL;
-	longest_i = -1;
 	for (i = 0; i < r->rewrite_nr; i++) {
 		if (!r->rewrite[i])
 			continue;
@@ -77,12 +75,24 @@ static const char *alias_url(const char *url, struct rewrites *r)
 			     longest->len < r->rewrite[i]->instead_of[j].len)) {
 				longest = &(r->rewrite[i]->instead_of[j]);
 				longest_i = i;
+				instead_of_j = j;
 			}
 		}
 	}
 	if (!longest)
 		return url;
 
+	if (debug) {
+		fprintf(stderr, "rewriting %s to %s%s\n",
+			url,
+			r->rewrite[longest_i]->base, url + longest->len);
+		fprintf(stderr, "due to '%.*s.insteadof' = '%.*s'\n",
+			r->rewrite[longest_i]->baselen,
+			r->rewrite[longest_i]->base,
+			r->rewrite[longest_i]->instead_of[j].len,
+			r->rewrite[longest_i]->instead_of[j].s);
+	}
+
 	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
 
