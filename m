From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 15:40:05 -0700
Message-ID: <xmqqtxhgqvui.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<20130911191620.GB24251@sigill.intra.peff.net>
	<CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
	<CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
	<CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
	<20130919211659.GB16556@sigill.intra.peff.net>
	<xmqqy56sqxj1.fsf@gitster.dls.corp.google.com>
	<20130919220531.GA13723@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 00:40:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMmtW-0003Bv-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab3ISWkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 18:40:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3ISWkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 18:40:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 262BB43736;
	Thu, 19 Sep 2013 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x6mqYRwQ2ait+xnNjgIR21WyS4w=; b=gwkcRT
	1yBkvifrk+KfqhIwfoBVYZfnm746SUgJnu3S9JRip9DfXCK8oGYnV76LESJ3aN4j
	E5lLtDbA9PXr+o2/kCqwu5MxI/6VH/MZgikD/F6B7ZtnRMo3KWvFHzYMWlpUEs+5
	pxyFuQ1nNi/m6mYInJw+SmOikkNY7VJVX0gSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QrUHInUA9q1mCtWvHWHE9QgyppDHke5s
	6hJSdbdMYY7hiwULjiAnupwu4svUrh7dRCqZSO0irsQw5d3UxIYKq4BskCArj8rH
	0JNAMlgIKbl5qWgF9O77Aylz5zRIwYJCAuSFKt2yZCKg+1qFEyuh07YW5TV0Ft5l
	MCdI6uo98vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E0143735;
	Thu, 19 Sep 2013 22:40:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 518B64372C;
	Thu, 19 Sep 2013 22:40:09 +0000 (UTC)
In-Reply-To: <20130919220531.GA13723@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 18:05:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70412EDE-217C-11E3-BF42-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235036>

Jeff King <peff@peff.net> writes:

> ... "...and
> no, we do not want to go there". Calling it a booby-trap was meant to be
> derogatory. :)

OK, I've resurrected the following and queued on 'pu'.

-- >8 --
Subject: [PATCH] mailmap: work around implementations with pure inline strcasecmp

On some systems (e.g. MinGW 4.0), string.h has only inline
definition of strcasecmp and no non-inline implementation is
supplied anywhere, which is, eh, "unusual".  We cannot take an
address of such a function to store it in namemap.cmp.

Work it around by introducing our own level of indirection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 44614fc..91a7532 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -52,6 +52,20 @@ static void free_mailmap_entry(void *p, const char *s)
 	string_list_clear_func(&me->namemap, free_mailmap_info);
 }
 
+/*
+ * On some systems (e.g. MinGW 4.0), string.h has _only_ inline
+ * definition of strcasecmp and no non-inline implementation is
+ * supplied anywhere, which is, eh, "unusual"; we cannot take an
+ * address of such a function to store it in namemap.cmp.  This is
+ * here as a workaround---do not assign strcasecmp directly to
+ * namemap.cmp until we know no systems that matter have such an
+ * "unusual" string.h.
+ */
+static int namemap_cmp(const char *a, const char *b)
+{
+	return strcasecmp(a, b);
+}
+
 static void add_mapping(struct string_list *map,
 			char *new_name, char *new_email,
 			char *old_name, char *old_email)
@@ -75,7 +89,7 @@ static void add_mapping(struct string_list *map,
 		item = string_list_insert_at_index(map, index, old_email);
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
-		me->namemap.cmp = strcasecmp;
+		me->namemap.cmp = namemap_cmp;
 		item->util = me;
 	}
 
@@ -241,7 +255,7 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	int err = 0;
 
 	map->strdup_strings = 1;
-	map->cmp = strcasecmp;
+	map->cmp = namemap_cmp;
 
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
-- 
1.8.4-613-ge7dc249
