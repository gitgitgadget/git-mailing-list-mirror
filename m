Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB0F1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeDIIcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:34655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeDIIca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:30 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meutp-1epsFB0nRB-00OYAY; Mon, 09
 Apr 2018 10:32:20 +0200
Date:   Mon, 9 Apr 2018 10:32:20 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 13/15] git_config_set: make use of the config parser's
 event stream
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <a187a526f46b008c2e81dad6ef90c7d2ddc56044.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d+kxFvEB9Ryuni5W17og/UxuzRMhiINgIfPrx5sBqcMMWQK2Zai
 owozU1BZaGhticlBHF5QZ+4+enOPPvular0KvtNFshtUtP/w7LFyP7Noa9oqXpCoHdd6sVl
 fZuQzuEXRryyodaI+t2xco7FlsNqtdENJBnD28JLbdqBeCYzMq1XzE3o6URuELAhl4930gd
 r+yzP6VA5UB6aGmJa7y4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pZFjWKq164U=:Pi0NyHcZDA7iGTkeoruocJ
 flWSq0EWLG5lOKmv1BHakmGcXd/FGJIUK50+RYFDCawYVzMaozCWbW5UOHlYn5PP7ikresQHP
 squw72ijvcBFo3BHTIuzdfXIwXsDSe3kXty5etUjNQ5zUGh12X93SvN0u1sk4W5zuXUD1NSZW
 G/C27d77OiYxtIuaf2YATQUujluDbqShtDz1Gru2Vz+ebOrK5u5MM8uj0e4ZzXoxNKoL3s3cw
 gozaJjFLnE1G6q4IX4CFzDRXYFnPHrY4I0ebtZzVN6gRpayOzd8pbRU09k+VGipvRUMhecIT+
 wX3dHFMVQv9uv90hago1ReRiflstBWeyoygAu5/9gxxeC1RARAYcz2FmkUG4aKbbN389E36aI
 ecshb/4lVKgRUUKBFdou1ZBdV2XmWybiRXDdMrIUM/Ts5/uhMQHrUt4nTcqZgdlQAztw2rc6/
 jR6QdaT/G2RimkDQQ87dPrUC6TGmjk64KM7JrtHUFKUyjsGxy16CA1FaSUVCDkyFxB7mffScO
 7MMn9DTs970ABua4MktpXWh0ImUzzp5xMsVMXgDknRIP6w4/H6DnaDyiq6cCijnK+KK6YWN7I
 +x+P/IIbnAhjnm5N8k1pXYZo3C2fj6VTPm/xGXYAhuiMg7ftbY8kmnSF5xpQpqhOwcKobg5wa
 jNJ5Fe70aJrbRGGmgJaIEjzhOYUKT1Q+AsHErGaD0BPWtkSIJAyhB/es/A6wcx5bxYVUtURkQ
 boASPJOMX/ucSlDrzvVAWN3afUVaT6cKXZL+TscE1/vlusMkIgR/ewLRmcd1aheHIHjcmjl0K
 qI+Rem0LlVchX0bLZdcEIbmFeWxlzHKTpBcRu898LfGDehiXpA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the recent commit with the title "config: introduce an optional event
stream while parsing", we introduced an optional callback to keep track
of the config parser's events "comment", "white-space", "section header"
and "entry".

One motivation for this feature was to make use of it in the code that
edits the config. And this commit makes it so.

Note: this patch changes the meaning of the `seen` array that records
whether we saw the config entry that is to be edited: previously, it
contained the end offset of the found entry. Now, we introduce a new
array `parsed` that keeps a record of *all* config parser events (with
begin/end offsets), and the items in the `seen` array now point into the
`parsed` array.

There are two reasons why we do it this way:

1. To keep the implementation simple, the config parser's event stream
   reports the event only after the config callback was called, so we
   would not receive the begin offset otherwise.

2. In the following patches, we will re-use the `parsed` array to fix two
   long-standing bugs related to empty sections.

Note that this also makes the code more robust with respect to finding the
begin offset of the part(s) of the config file to be edited, as we no
longer back-track to find the beginning of the line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 170 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 81 insertions(+), 89 deletions(-)

diff --git a/config.c b/config.c
index 3f1cbfa181e..72d71fc9a4e 100644
--- a/config.c
+++ b/config.c
@@ -2302,8 +2302,11 @@ struct config_store_data {
 	int do_not_match;
 	regex_t *value_regex;
 	int multi_replace;
-	size_t *seen;
-	unsigned int seen_nr, seen_alloc;
+	struct {
+		size_t begin, end;
+		enum config_event_t type;
+	} *parsed;
+	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
@@ -2321,10 +2324,31 @@ static int matches(const char *key, const char *value,
 		(value && !regexec(store->value_regex, value, 0, NULL, 0));
 }
 
+static int store_aux_event(enum config_event_t type,
+			   size_t begin, size_t end, void *data)
+{
+	struct config_store_data *store = data;
+
+	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
+	store->parsed[store->parsed_nr].begin = begin;
+	store->parsed[store->parsed_nr].end = end;
+	store->parsed[store->parsed_nr].type = type;
+	store->parsed_nr++;
+
+	if (type == CONFIG_EVENT_SECTION) {
+		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
+			BUG("Invalid section name '%s'", cf->var.buf);
+
+		/* Is this the section we were looking for? */
+		store->is_keys_section = cf->var.len - 1 == store->baselen &&
+			!strncasecmp(cf->var.buf, store->key, store->baselen);
+	}
+
+	return 0;
+}
+
 static int store_aux(const char *key, const char *value, void *cb)
 {
-	const char *ep;
-	size_t section_len;
 	struct config_store_data *store = cb;
 
 	if (store->key_seen) {
@@ -2336,55 +2360,21 @@ static int store_aux(const char *key, const char *value, void *cb)
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
 				   store->seen_alloc);
 
-			store->seen[store->seen_nr] = cf->do_ftell(cf);
+			store->seen[store->seen_nr] = store->parsed_nr;
 			store->seen_nr++;
 		}
-		return 0;
 	} else if (store->is_keys_section) {
 		/*
-		 * What we are looking for is in store->key (both
-		 * section and var), and its section part is baselen
-		 * long.  We found key (again, both section and var).
-		 * We would want to know if this key is in the same
-		 * section as what we are looking for.  We already
-		 * know we are in the same section as what should
-		 * hold store->key.
+		 * Do not increment matches yet: this may not be a match, but we
+		 * are in the desired section.
 		 */
-		ep = strrchr(key, '.');
-		section_len = ep - key;
-
-		if ((section_len != store->baselen) ||
-		    memcmp(key, store->key, section_len+1)) {
-			store->is_keys_section = 0;
-			return 0;
-		}
-		/*
-		 * Do not increment matches: this is no match, but we
-		 * just made sure we are in the desired section.
-		 */
-		ALLOC_GROW(store->seen, store->seen_nr + 1,
-			   store->seen_alloc);
-		store->seen[store->seen_nr] = cf->do_ftell(cf);
-	}
-
-	if (matches(key, value, store)) {
-		ALLOC_GROW(store->seen, store->seen_nr + 1,
-			   store->seen_alloc);
-		store->seen[store->seen_nr] = cf->do_ftell(cf);
-		store->seen_nr++;
-		store->key_seen = 1;
+		ALLOC_GROW(store->seen, store->seen_nr + 1, store->seen_alloc);
+		store->seen[store->seen_nr] = store->parsed_nr;
 		store->section_seen = 1;
-		store->is_keys_section = 1;
-	} else {
-		if (strrchr(key, '.') - key == store->baselen &&
-		      !strncmp(key, store->key, store->baselen)) {
-				store->section_seen = 1;
-				store->is_keys_section = 1;
-				ALLOC_GROW(store->seen,
-					   store->seen_nr + 1,
-					   store->seen_alloc);
-				store->seen[store->seen_nr] =
-					cf->do_ftell(cf);
+
+		if (matches(key, value, store)) {
+			store->seen_nr++;
+			store->key_seen = 1;
 		}
 	}
 
@@ -2485,32 +2475,6 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 	return ret;
 }
 
-static ssize_t find_beginning_of_line(const char *contents, size_t size,
-	size_t offset_, int *found_bracket)
-{
-	size_t equal_offset = size, bracket_offset = size;
-	ssize_t offset;
-
-contline:
-	for (offset = offset_-2; offset > 0
-			&& contents[offset] != '\n'; offset--)
-		switch (contents[offset]) {
-			case '=': equal_offset = offset; break;
-			case ']': bracket_offset = offset; break;
-		}
-	if (offset > 0 && contents[offset-1] == '\\') {
-		offset_ = offset;
-		goto contline;
-	}
-	if (bracket_offset < equal_offset) {
-		*found_bracket = 1;
-		offset = bracket_offset+1;
-	} else
-		offset++;
-
-	return offset;
-}
-
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *value)
 {
@@ -2621,6 +2585,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
+		struct config_options opts;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
@@ -2643,17 +2608,24 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			}
 		}
 
-		ALLOC_GROW(store.seen, 1, store.seen_alloc);
-		store.seen[0] = 0;
-		store.seen_nr = 0;
+		ALLOC_GROW(store.parsed, 1, store.parsed_alloc);
+		store.parsed[0].end = 0;
+
+		memset(&opts, 0, sizeof(opts));
+		opts.event_fn = store_aux_event;
+		opts.event_fn_data = &store;
 
 		/*
-		 * After this, store.offset will contain the *end* offset
-		 * of the last match, or remain at 0 if no match was found.
+		 * After this, store.parsed will contain offsets of all the
+		 * parsed elements, and store.seen will contain a list of
+		 * matches, as indices into store.parsed.
+		 *
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, &store)) {
+		if (git_config_from_file_with_options(store_aux,
+						      config_filename,
+						      &store, &opts)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL &&
@@ -2705,19 +2677,39 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		if (store.seen_nr == 0)
+		if (store.seen_nr == 0) {
+			if (!store.seen_alloc) {
+				/* Did not see key nor section */
+				ALLOC_GROW(store.seen, 1, store.seen_alloc);
+				store.seen[0] = store.parsed_nr
+					- !!store.parsed_nr;
+			}
 			store.seen_nr = 1;
+		}
 
 		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
+			size_t replace_end;
+			int j = store.seen[i];
+
 			new_line = 0;
-			if (store.seen[i] == 0) {
-				store.seen[i] = copy_end = contents_sz;
-			} else if (!store.key_seen) {
-				copy_end = store.seen[i];
-			} else
-				copy_end = find_beginning_of_line(
-					contents, contents_sz,
-					store.seen[i], &new_line);
+			if (!store.key_seen) {
+				replace_end = copy_end = store.parsed[j].end;
+			} else {
+				replace_end = store.parsed[j].end;
+				copy_end = store.parsed[j].begin;
+				/*
+				 * Swallow preceding white-space on the same
+				 * line.
+				 */
+				while (copy_end > 0 ) {
+					char c = contents[copy_end - 1];
+
+					if (isspace(c) && c != '\n')
+						copy_end--;
+					else
+						break;
+				}
+			}
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
@@ -2731,7 +2723,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				    write_str_in_full(fd, "\n") < 0)
 					goto write_err_out;
 			}
-			copy_begin = store.seen[i];
+			copy_begin = replace_end;
 		}
 
 		/* write the pair (value == NULL means unset) */
-- 
2.17.0.windows.1.4.g7e4058d72e3


