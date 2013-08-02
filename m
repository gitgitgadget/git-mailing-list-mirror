From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query filenames with spaces
Date: Fri, 02 Aug 2013 11:30:03 -0700
Message-ID: <7vmwp0osic.fsf@alter.siamese.dyndns.org>
References: <20130801201842.GA16809@kitenet.net>
	<20130802064003.GB3013@elie.Belkin>
	<20130802105402.GA25697@sigill.intra.peff.net>
	<20130802115906.GA9183@sigill.intra.peff.net>
	<7vtxj8oxin.fsf@alter.siamese.dyndns.org>
	<20130802172804.GB11329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 02 20:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5K7M-0001mn-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 20:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab3HBSaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 14:30:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab3HBSaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 14:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B53C33B97;
	Fri,  2 Aug 2013 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0C5bam5hpRyt+yuhRK+8Xn6grBs=; b=aTVZJP
	jOov/GPv557pbggqXDL+MGsSUeJrXXcFm+nzECzyarO0/6jAZdx3NSML8d8R8WoO
	VnpQ4NgeSM85407edncW3OGJxy3WELvY4fmkwNvvDydPiIf5s8/hLiF0HmEsXjVK
	1f9UjU6VSRBtELMm9QG3gOhh2ZvyvCSflC910=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KoIRiLl7mBjZkVj/WBcCdZ/8LdXSMzyK
	ruPLSmXz5DfxmeokuTUkHrLTCNJmvuD82PmZl8uB2xjBacvZnO3rUNaqvk3/QLuV
	u/I5uHh7Z1414Z7H+TIxBqZXiF72Gb1BpgcUCX2l6EWMGphiThJufaiSV8eXqVKX
	vxrnZ/iap3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F0A733B96;
	Fri,  2 Aug 2013 18:30:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03D0633B93;
	Fri,  2 Aug 2013 18:30:04 +0000 (UTC)
In-Reply-To: <20130802172804.GB11329@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 2 Aug 2013 10:28:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D1BDC12-FBA1-11E2-A4B1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231534>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 02, 2013 at 09:41:52AM -0700, Junio C Hamano wrote:
>
>> > Of the two, I think the latter is more sensible; the former is
>> > unnecessarily placing the burden on the user to match "--split" with
>> > their use of "%(rest)". The second is pointless without the first.
>> >
>> > A patch to implement (2) is below.
>> 
>> As I'd queue this on top of the revert, I had to wrangle it a bit to
>> make it relative, i.e. "this resurrects what the other reverted
>> patch did but in a weaker/safer form".
>
> Yeah, sorry. After doing the patch I had the thought that maybe the
> least invasive thing would be the fix rather than the straight revert
> (we are counting on my assertion that just reverting out part of the
> series will be OK; I'm pretty sure that is the case, but it is not
> risk-free, either).
>
> I didn't see the result of your wrangling in pu, but I will keep an eye
> out to double-check it (unless you did not finish, in which case I am
> happy to do the wrangling myself).

Here is what is on top of the revert that has been pushed out on
'pu'.

Thanks.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Fri, 2 Aug 2013 04:59:07 -0700
Subject: [PATCH] cat-file: only split on whitespace when %(rest) is used

Commit c334b87b (cat-file: split --batch input lines on whitespace,
2013-07-11) taught `cat-file --batch-check` to split input lines on
the first whitespace, and stash everything after the first token
into the %(rest) output format element.  It claimed:

   Object names cannot contain spaces, so any input with
   spaces would have resulted in a "missing" line.

But that is not correct.  Refs, object sha1s, and various peeling
suffixes cannot contain spaces, but some object names can. In
particular:

  1. Tree paths like "[<tree>]:path with whitespace"

  2. Reflog specifications like "@{2 days ago}"

  3. Commit searches like "rev^{/grep me}" or ":/grep me"

To remain backwards compatible, we cannot split on whitespace by
default, hence we will ship 1.8.4 with the commit reverted.

Resurrect its attempt but in a weaker form; only do the splitting
when "%(rest)" is used in the output format. Since that element did
not exist at all before c334b87, old scripts cannot be affected.

The existence of object names with spaces does mean that you
cannot reliably do:

  echo ":path with space and other data" |
  git cat-file --batch-check="%(objectname) %(rest)"

as it would split the path and feed only ":path" to get_sha1. But
that command is nonsensical. If you wanted to see "and other data"
in "%(rest)", git cannot possibly know where the filename ends and
the "rest" begins.

It might be more robust to have something like "-z" to separate the
input elements. But this patch is still a reasonable step before
having that.  It makes the easy cases easy; people who do not care
about %(rest) do not have to consider it, and the %(rest) code
handles the spaces and newlines of "rev-list --objects" correctly.

Hard cases remain hard but possible (if you might get whitespace in
your input, you do not get to use %(rest) and must split and join
the output yourself using more flexible tools). And most
importantly, it does not preclude us from having different splitting
rules later if a "-z" (or similar) option is added.  So we can make
the hard cases easier later, if we choose to.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cat-file.txt | 14 ++++++++++----
 builtin/cat-file.c             | 31 ++++++++++++++++++++++++++++++-
 t/t1006-cat-file.sh            | 15 +++++++++++++++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 10fbc6a..21cffe2 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -86,10 +86,9 @@ BATCH OUTPUT
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them.
-
-Each line is considered as a whole object name, and is parsed as if
-given to linkgit:git-rev-parse[1].
+from stdin, one per line, and print information about them. By default,
+the whole line is considered as an object, as if it were fed to
+linkgit:git-rev-parse[1].
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -110,6 +109,13 @@ newline. The available atoms are:
 	The size, in bytes, that the object takes up on disk. See the
 	note about on-disk sizes in the `CAVEATS` section below.
 
+`rest`::
+	If this atom is used in the output string, input lines are split
+	at the first whitespace boundary. All characters before that
+	whitespace are considered to be the object name; characters
+	after that first run of whitespace (i.e., the "rest" of the
+	line) are output in place of the `%(rest)` atom.
+
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4253460..07b4818 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -119,6 +119,7 @@ struct expand_data {
 	enum object_type type;
 	unsigned long size;
 	unsigned long disk_size;
+	const char *rest;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -127,6 +128,13 @@ struct expand_data {
 	int mark_query;
 
 	/*
+	 * Whether to split the input on whitespace before feeding it to
+	 * get_sha1; this is decided during the mark_query phase based on
+	 * whether we have a %(rest) token in our format.
+	 */
+	int split_on_whitespace;
+
+	/*
 	 * After a mark_query run, this object_info is set up to be
 	 * passed to sha1_object_info_extended. It will point to the data
 	 * elements above, so you can retrieve the response from there.
@@ -163,6 +171,11 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%lu", data->disk_size);
+	} else if (is_atom("rest", atom, len)) {
+		if (data->mark_query)
+			data->split_on_whitespace = 1;
+		else if (data->rest)
+			strbuf_addstr(sb, data->rest);
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
@@ -273,7 +286,23 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error = batch_one_object(buf.buf, opt, &data);
+		char *p;
+		int error;
+
+		if (data.split_on_whitespace) {
+			/*
+			 * Split at first whitespace, tying off the beginning of the
+			 * string and saving the remainder (or NULL) in data.rest.
+			 */
+			p = strpbrk(buf.buf, " \t");
+			if (p) {
+				while (*p && strchr(" \t", *p))
+					*p++ = '\0';
+			}
+			data.rest = p;
+		}
+
+		error = batch_one_object(buf.buf, opt, &data);
 		if (error)
 			return error;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4e911fb..a420742 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -78,6 +78,13 @@ $content"
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
+
+    test_expect_success '--batch-check with %(rest)' '
+	echo "$type this is some extra content" >expect &&
+	echo "$sha1    this is some extra content" |
+		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
+	test_cmp expect actual
+    '
 }
 
 hello_content="Hello World"
@@ -91,6 +98,14 @@ test_expect_success "setup" '
 
 run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
 
+test_expect_success '--batch-check without %(rest) considers whole line' '
+	echo "$hello_sha1 blob $hello_size" >expect &&
+	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
+	test_when_finished "git update-index --remove \"white space\"" &&
+	echo ":white space" | git cat-file --batch-check >actual &&
+	test_cmp expect actual
+'
+
 tree_sha1=$(git write-tree)
 tree_size=33
 tree_pretty_content="100644 blob $hello_sha1	hello"
-- 
1.8.4-rc1-129-g1f3472b
