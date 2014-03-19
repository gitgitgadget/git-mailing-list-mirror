From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3][GSOC] diff: rename read_directory() to get_directory_list()
Date: Wed, 19 Mar 2014 11:48:51 -0700
Message-ID: <xmqq1txy3tyk.fsf@gitster.dls.corp.google.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
	<xmqqy508a1up.fsf@gitster.dls.corp.google.com>
	<xmqq4n2u5cif.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Bourn <ba.bourn@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLXv-0007mM-6v
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbaCSSsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:48:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbaCSSsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:48:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6E474AD0;
	Wed, 19 Mar 2014 14:48:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pKPRH8beFjR8q5h5uON1Nxdaq3s=; b=vniYNC
	x8GUqWd89esKQ49+8JPtGoLEHyu9doboxjyZF5Rll7sfL2FuZF8oiRGZCe3lqMjK
	KqbwH+BdMRUlJ6smw6qvdqpNqKd3J4GDst7kic6FIb5wAICys3bazM7TqmlT57uX
	q+8RfCwAwXi/0K0fku3ZOeVCKQOhIxlPMVP0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A2ftH3kVfwnlRkXvDZJpbjTKVBNmmYPs
	E1N5qwq3ulWTEo0kGd9gkyfL+SI89wGb2NwcZ7aEqE1HDQcC9BDvpZscdcA+2fz3
	Rj5ljk2MUmvJwQSf2JYKg/emEk2lZjRTIyPverJylu0pZwDPHmxx1lUZv7Q2Z9AU
	W585REj2Q/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45BDC74ACF;
	Wed, 19 Mar 2014 14:48:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D05174ACE;
	Wed, 19 Mar 2014 14:48:53 -0400 (EDT)
In-Reply-To: <xmqq4n2u5cif.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Mar 2014 10:22:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E57C1CE-AF97-11E3-BE40-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244476>

Junio C Hamano <gitster@pobox.com> writes:

>>> -static int read_directory(const char *path, struct string_list *list)
>>> +static int get_directory_list(const char *path, struct string_list *list)
>>
>> Renaming is a good idea but the new name sounds like you are
>> grabbing the names of directories, ignoring all the files, no?
>
> I am tempted to suggest, because this is an internal implementation
> detail only visible to this narrow corner of the system, calling
> this just 
>
> 	static int ls(const char *path, struct string_list *result)
>
> ;-)

Scratch that one.

I'll take read_directory_contents() from Brian Bourn, which
essentially is the same patch.

Thanks.

-- >8 --
From: Brian Bourn <ba.bourn@gmail.com>
Date: Wed, 19 Mar 2014 11:58:21 -0400
Subject: [PATCH] diff-no-index: rename read_directory()

In the next patch, we will replace a manual checking of "." or ".."
with a call to is_dot_or_dotdot() defined in dir.h.  The private
function read_directory() defined in this file will conflict with
the global function declared there when we do so.

As a preparatory step, rename the private read_directory() to avoid
the name collision.

Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 33e5982..3e4f47e 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.9.1-423-g4596e3a
