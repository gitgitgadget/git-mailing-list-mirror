Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F1D20195
	for <e@80x24.org>; Sun, 17 Jul 2016 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbcGQLAA (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 07:00:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:53954 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbcGQK76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 06:59:58 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M1WHV-1b4k0A3ccL-00tXOi; Sun, 17 Jul 2016 12:59:39
 +0200
Date:	Sun, 17 Jul 2016 12:59:38 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] Teach `git fsck` a new option: `--name-objects`
In-Reply-To: <cover.1468510191.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1468752290.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9OkRMdAjTex4JJvc2fojsodTkfViGFl7s84rsnpDML8LHjokcRv
 y3hUZJter8oeNBK7AF4pLLJB48ubWFirwBbizFe45REQ+TevRzrdAainemEIRu/lF/kLNVw
 FFiTxu/pWthX7UMDFWqJsWVzXMrimdVAfkfRgPNmRysHdekMBX01yvm4PIgozysza5BFoAf
 +7AsBTvejGAgkPpremU0w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eyDL0MJmL8g=:J9TIsWCu+v+ubdbM6f7Rt8
 xFsK8ym6aJIP8tZh1/wb7tLTeU+hJtaODrb3Ex11aC7UA0N2gdMON2OG24Fq/NH14VMOa0tko
 ZJRC3AVRW/zIo6AN7+ltH0XIDc2r9t0ifCg2yUaQrhJ7B0c/zSsvck/YvvkiD9zapU5O/c8C+
 W8ZnVePycnQ81d2hTbN0/Tgzv9CK+AW+fl/UF0ZEkoo0jOFbvaPDXuHQB9p7f91N5tbjtYIUA
 nwjJ/gP+h9HA5xg8Q0kQrWGgb3G8megmS/T+cJ6GWJXyQtYpXv6ZdB5k0KnQhXmX+W/lUk3QG
 4VkFHYpdpXbFu3k7Q0UjcON7MOHV1jZ2BXSDioedBGhdZAJwFqGLXZMfTNwWf1zem57NKcH1P
 3lMSsA4X+zyLxXWm59fYQOg0a88uo/oxIxQrtoWCtYLCMA/dV8i0h/QDcguaswIhkfuVo4dST
 QpC0wwX7ji0suD0oAI9Xft8klUJ3g1a8BJRDWr1owmCokFz79greVMea/14Dn0gu+RF+AaPxq
 bAsXe1mZnHadurqbUPrONH/MtZTMVShauM/NH/MPRiubg5HiL942tHtFDQvoOwNtcT9dzByZ0
 UyFWPooNmUcD9oANnE34zzmTpsK+hSNVThRI2QM6RdqmUHbE3jkzF8F5xEZpcuCAQh1BdW2YE
 jOcX/Jn4leZd1xXf4H6Q2eAMOD9iT73iR79yIL0o+yaEADrcmoLre1fWjCeHMYx9WNl6B/ynT
 9Na67BHkSUs+4kG2XlCtofWOHbmz7dlv4fiHQpUPY3jpdBIPTUxOZKCQec5sKJKqBD0cY9+qd
 9quG/wc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When using experimental features (such as worktrees), it is quite
possible to end up with a repository that is a little bit corrupted. In
this developer's case, the auto gc run during interactive rebases in
worktrees completely messed up the reflogs.

The symptoms are broken links between commits/trees/blobs.

Trying to work around such problems can be a real challenge: while
several tools will report when objects are missing, all of them simply
state the SHA-1. This is not useful when the user has to kiss the
offending reflog good-bye, but does not even know which one.

This patch series introduces a new option to `git fsck`: --name-objects.
With this option, the fsck command will report not only the SHA-1 of
missing objects, but also a name by which this object is supposed to be
reachable.

Example output:

	...
	broken link from    tree b5eb6ff...  (refs/stash@{<date>}~37:)
		      to    blob ec5cf80...

Relative to v1, a tyop was fixed, Junio's suggestions about an early
return from {get,put}_object_name() and about avoiding parsing of
objects were addressed, and I found a couple more places in fsck.c that
could benefit from object names.


Johannes Schindelin (4):
  fsck: refactor how to describe objects
  fsck_walk(): optionally name objects on the go
  fsck: give the error function a chance to see the fsck_options
  fsck: optionally show more helpful info for broken links

 Documentation/git-fsck.txt |   9 +++-
 builtin/fsck.c             |  80 ++++++++++++++++++++++++--------
 fsck.c                     | 113 +++++++++++++++++++++++++++++++++++++++++----
 fsck.h                     |   7 ++-
 t/t1450-fsck.sh            |  22 +++++++++
 5 files changed, 200 insertions(+), 31 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/fsck-name-objects-v2
Interdiff vs v1:

 diff --git a/builtin/fsck.c b/builtin/fsck.c
 index e2173b6..49680e9 100644
 --- a/builtin/fsck.c
 +++ b/builtin/fsck.c
 @@ -93,7 +93,8 @@ static int objerror(struct object *obj, const char *err)
  	return -1;
  }
  
 -static int fsck_error_func(struct object *obj, int type, const char *message)
 +static int fsck_error_func(struct fsck_options *o,
 +	struct object *obj, int type, const char *message)
  {
  	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
  	return (type == FSCK_WARN) ? 0 : 1;
 @@ -598,7 +599,7 @@ static struct option fsck_opts[] = {
  	OPT_BOOL(0, "lost-found", &write_lost_and_found,
  				N_("write dangling objects in .git/lost-found")),
  	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 -	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for rechable objects")),
 +	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
  	OPT_END(),
  };
  
 diff --git a/fsck.c b/fsck.c
 index fe6a28a..c9cf3de 100644
 --- a/fsck.c
 +++ b/fsck.c
 @@ -291,7 +291,7 @@ static int report(struct fsck_options *options, struct object *object,
  
  	va_start(ap, fmt);
  	strbuf_vaddf(&sb, fmt, ap);
 -	result = options->error_func(object, msg_type, sb.buf);
 +	result = options->error_func(options, object, msg_type, sb.buf);
  	strbuf_release(&sb);
  	va_end(ap);
  
 @@ -300,17 +300,21 @@ static int report(struct fsck_options *options, struct object *object,
  
  static char *get_object_name(struct fsck_options *options, struct object *obj)
  {
 -	return options->object_names ?
 -		lookup_decoration(options->object_names, obj) : NULL;
 +	if (!options->object_names)
 +		return NULL;
 +	return lookup_decoration(options->object_names, obj);
  }
  
  static void put_object_name(struct fsck_options *options, struct object *obj,
  	const char *fmt, ...)
  {
  	va_list ap;
 -	char *existing = lookup_decoration(options->object_names, obj);
  	struct strbuf buf = STRBUF_INIT;
 +	char *existing;
  
 +	if (!options->object_names)
 +		return;
 +	existing = lookup_decoration(options->object_names, obj);
  	if (existing)
  		return;
  	va_start(ap, fmt);
 @@ -319,6 +323,19 @@ static void put_object_name(struct fsck_options *options, struct object *obj,
  	va_end(ap);
  }
  
 +static const char *describe_object(struct fsck_options *o, struct object *obj)
 +{
 +	static struct strbuf buf = STRBUF_INIT;
 +	char *name;
 +
 +	strbuf_reset(&buf);
 +	strbuf_addstr(&buf, oid_to_hex(&obj->oid));
 +	if (o->object_names && (name = lookup_decoration(o->object_names, obj)))
 +		strbuf_addf(&buf, " (%s)", name);
 +
 +	return buf.buf;
 +}
 +
  static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
  {
  	struct tree_desc desc;
 @@ -332,26 +349,29 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
  	name = get_object_name(options, &tree->object);
  	init_tree_desc(&desc, tree->buffer, tree->size);
  	while (tree_entry(&desc, &entry)) {
 +		struct object *obj;
  		int result;
  
 -		if (name) {
 -			struct object *obj = parse_object(entry.oid->hash);
 -
 -			if (obj)
 -				put_object_name(options, obj, "%s%s%s", name,
 -					entry.path,
 -					S_ISDIR(entry.mode) ? "/" : "");
 -		}
 -
  		if (S_ISGITLINK(entry.mode))
  			continue;
 -		if (S_ISDIR(entry.mode))
 -			result = options->walk(&lookup_tree(entry.oid->hash)->object, OBJ_TREE, data, options);
 -		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
 -			result = options->walk(&lookup_blob(entry.oid->hash)->object, OBJ_BLOB, data, options);
 +
 +		if (S_ISDIR(entry.mode)) {
 +			obj = &lookup_tree(entry.oid->hash)->object;
 +			if (name)
 +				put_object_name(options, obj, "%s%s/", name,
 +					entry.path);
 +			result = options->walk(obj, OBJ_TREE, data, options);
 +		}
 +		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
 +			obj = &lookup_blob(entry.oid->hash)->object;
 +			if (name)
 +				put_object_name(options, obj, "%s%s", name,
 +					entry.path);
 +			result = options->walk(obj, OBJ_BLOB, data, options);
 +		}
  		else {
  			result = error("in tree %s: entry %s has bad mode %.6o",
 -					oid_to_hex(&tree->object.oid), entry.path, entry.mode);
 +					describe_object(options, &tree->object), entry.path, entry.mode);
  		}
  		if (result < 0)
  			return result;
 @@ -447,7 +467,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
  	case OBJ_TAG:
  		return fsck_walk_tag((struct tag *)obj, data, options);
  	default:
 -		error("Unknown object type for %s", oid_to_hex(&obj->oid));
 +		error("Unknown object type for %s", describe_object(options, obj));
  		return -1;
  	}
  }
 @@ -890,12 +910,13 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
  			  obj->type);
  }
  
 -int fsck_error_function(struct object *obj, int msg_type, const char *message)
 +int fsck_error_function(struct fsck_options *o,
 +	struct object *obj, int msg_type, const char *message)
  {
  	if (msg_type == FSCK_WARN) {
 -		warning("object %s: %s", oid_to_hex(&obj->oid), message);
 +		warning("object %s: %s", describe_object(o, obj), message);
  		return 0;
  	}
 -	error("object %s: %s", oid_to_hex(&obj->oid), message);
 +	error("object %s: %s", describe_object(o, obj), message);
  	return 1;
  }
 diff --git a/fsck.h b/fsck.h
 index 26c0d41..1891c18 100644
 --- a/fsck.h
 +++ b/fsck.h
 @@ -23,9 +23,11 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
  typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct fsck_options *options);
  
  /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 -typedef int (*fsck_error)(struct object *obj, int type, const char *message);
 +typedef int (*fsck_error)(struct fsck_options *o,
 +	struct object *obj, int type, const char *message);
  
 -int fsck_error_function(struct object *obj, int type, const char *message);
 +int fsck_error_function(struct fsck_options *o,
 +	struct object *obj, int type, const char *message);
  
  struct fsck_options {
  	fsck_walk_func walk;

-- 
2.9.0.281.g286a8d9

base-commit: 29493589e97a2de0c4c1c314f61ccafaee3b5caf
