From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Fri, 04 Dec 2015 16:08:26 -0800
Message-ID: <xmqqzixpoiyt.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a50Ov-00014v-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 01:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbbLEAI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 19:08:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754764AbbLEAI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 19:08:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DEE831AE8;
	Fri,  4 Dec 2015 19:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ntAiqwxa6WPjJ70s0YZyypLVO4o=; b=QwJ7mnqzFjj04zXeJ2BA
	YDzGW9ikqANoRX27NzYcXIa5IiETkF8rux0ktuyid1Hkz3eZw0A0vj6gMcVd1qjD
	RK9Eb8plDa5QexwcKwukhp6GprjhEk7c1VlSQmfuypE4S0AznYs3alX631rC0Z8C
	eZh5DtBgzsYb7bt7MyyRc4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=A0pEZW1iFCehxdPz/BXyGF30zpzMKq1AUs7STZEN0oeVIm
	BWUe1SPuwbs2qMn/c+uQlgrRixE9g1iVnLgGcJpVrfEN8GgPOwtysBxLkEdIvcLf
	zThQKRdrYFtEPiWWBzL6b+11C7WyAABvRlKJ//2FWLim1n2kpNiDPTle6n91E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5546831AE7;
	Fri,  4 Dec 2015 19:08:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C993531AE6;
	Fri,  4 Dec 2015 19:08:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F4DF0E8-9AE4-11E5-B54F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282022>

David Turner <dturner@twopensource.com> writes:

> +	while (!mdb_ret) {
> +		if (starts_with(key.mv_data, refname) &&
> +		    ((char*)key.mv_data)[refname_len - 2] == '/') {

ERROR: "(foo*)" should be "(foo *)"
#877: FILE: refs/lmdb-backend.c:514:
+                   ((char*)key.mv_data)[refname_len - 2] == '/') {

> +static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
> +{
> +	unsigned char osha1[20], nsha1[20];
> +	char *email_end, *message;
> +	unsigned long timestamp;
> +	int tz;
> +
> +	/* old (raw) new (raw) name <email> SP time TAB msg LF */
> +	if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||
> +	    !(email_end = strchr(sb->buf + 40, '>')) ||
> +	    email_end[1] != ' ' ||
> +	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> +	    !message || message[0] != ' ' ||
> +	    (message[1] != '+' && message[1] != '-') ||
> +	    !isdigit(message[2]) || !isdigit(message[3]) ||
> +	    !isdigit(message[4]) || !isdigit(message[5]))
> +		return 0; /* corrupt? */

ERROR: do not use assignment in if condition
#1024: FILE: refs/lmdb-backend.c:661:
+       if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||

> +static char *check_ref(MDB_txn *txn, const char *refname,
> +		       const unsigned char *old_sha1,
> +		       unsigned char *resolved_sha1, int flags,
> +		       int *type_p)
> +{
> +	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
> +	int resolve_flags = 0;
> +	int type;
> +	char *resolved_refname;
> +
> +	if (mustexist)
> +		resolve_flags |= RESOLVE_REF_READING;
> +	if (flags & REF_DELETING) {
> +		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
> +		if (flags & REF_NODEREF)
> +			resolve_flags |= RESOLVE_REF_NO_RECURSE;
> +	}
> +
> +	/*
> +	 * The first time we resolve the refname, we're just trying to
> +	 * see if there is any ref at all by this name, even if it is
> +	 * a broken symref.
> +	 */
> +	refname = resolve_ref_unsafe(refname, resolve_flags,
> +				     resolved_sha1, &type);
> +	if (type_p)
> +	    *type_p = type;

WARNING: suspect code indent for conditional statements (8, 12)
#1177: FILE: refs/lmdb-backend.c:814:
+       if (type_p)
+           *type_p = type;

Indeed, this line should be indented with two HTs.

> +	while (!mdb_ret) {
> +		if (key.mv_size < len)
> +			break;
> +
> +		if (!starts_with(key.mv_data, log_path) || ((char*)key.mv_data)[len - 1] != 0)

ERROR: "(foo*)" should be "(foo *)"
#1254: FILE: refs/lmdb-backend.c:891:
+               if (!starts_with(key.mv_data, log_path) || ((char*)key.mv_data)[len - 1] != 0)

> +		if (strcmp (refname, orig_refname) &&

WARNING: space prohibited between function name and open parenthesis '('
#1366: FILE: refs/lmdb-backend.c:1003:
+               if (strcmp (refname, orig_refname) &&


This concludes my first pass, mechanical "lint" (with help from
checkpatch.pl).  I'll hopefully have time to do the more meaningful
design and implementation review later.

Thanks.
