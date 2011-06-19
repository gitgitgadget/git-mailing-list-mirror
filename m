From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Sat, 18 Jun 2011 18:07:04 -0700
Message-ID: <1308445625-30667-2-git-send-email-andi@firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 03:08:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY6VG-0003Wp-N0
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 03:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1FSBIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 21:08:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:49219 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307Ab1FSBId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 21:08:33 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 18 Jun 2011 18:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,387,1304319600"; 
   d="scan'208";a="19934777"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2011 18:08:32 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 2CD3D240F2E; Sat, 18 Jun 2011 18:07:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175997>

From: Andi Kleen <ak@linux.intel.com>

Add a lot of dummy returns to silence "control flow reaches
end of non void function" warnings with disabled noreturn.

If NO_NORETURN is not disabled they will be all optimized away.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 builtin/blame.c          |    1 +
 builtin/bundle.c         |    1 +
 builtin/commit.c         |    1 +
 builtin/fetch-pack.c     |    1 +
 builtin/grep.c           |    1 +
 builtin/help.c           |    1 +
 builtin/pack-redundant.c |    1 +
 builtin/push.c           |    3 +--
 builtin/reflog.c         |    1 +
 config.c                 |    1 +
 connect.c                |    1 +
 daemon.c                 |    1 +
 date.c                   |    1 +
 diff.c                   |    1 +
 notes-merge.c            |    1 +
 object.c                 |    1 +
 parse-options.c          |    1 +
 read-cache.c             |    1 +
 remote.c                 |    1 +
 revision.c               |    1 +
 setup.c                  |    1 +
 shell.c                  |    1 +
 submodule.c              |    1 +
 transport.c              |    1 +
 24 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 26a5d42..aff7781 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2011,6 +2011,7 @@ static const char *parse_loc(const char *spec,
 		regerror(reg_error, &regexp, errbuf, 1024);
 		die("-L parameter '%s': %s", spec + 1, errbuf);
 	}
+	return NULL;
 }
 
 /*
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 81046a9..14da7c3 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -62,4 +62,5 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 			list_bundle_refs(&header, argc, argv);
 	} else
 		usage(builtin_bundle_usage);
+	return 0;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index 5286432..51ee2e5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -962,6 +962,7 @@ static const char *find_author_by_nickname(const char *name)
 		return strbuf_detach(&buf, NULL);
 	}
 	die(_("No existing author found with '%s'"), name);
+	return NULL;
 }
 
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4367984..c81855c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -208,6 +208,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 		}
 	}
 	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
+	return ACK;
 }
 
 static void send_request(int fd, struct strbuf *buf)
diff --git a/builtin/grep.c b/builtin/grep.c
index 871afaa..3637a72 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -607,6 +607,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		return hit;
 	}
 	die(_("unable to grep from object of type %s"), typename(obj->type));
+	return 0;
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..5132f58 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -55,6 +55,7 @@ static enum help_format parse_help_format(const char *format)
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
 	die("unrecognized help format '%s'", format);
+	return 0;
 }
 
 static const char *get_man_viewer_info(const char *name)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f5c6afc..bf70ecc 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -580,6 +580,7 @@ static struct pack_list * add_pack_file(const char *filename)
 		p = p->next;
 	}
 	die("Filename %s not found in packed_git", filename);
+	return NULL;
 }
 
 static void load_all(void)
diff --git a/builtin/push.c b/builtin/push.c
index 9cebf9e..9ac4309 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -265,6 +265,5 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	rc = do_push(repo, flags);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
-	else
-		return rc;
+	return rc;
 }
diff --git a/builtin/reflog.c b/builtin/reflog.c
index ebf610e..8e64b81 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -779,4 +779,5 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 
 	/* Not a recognized reflog command..*/
 	usage(reflog_usage);
+	return 0;
 }
diff --git a/config.c b/config.c
index e0b3b80..aa9ef85 100644
--- a/config.c
+++ b/config.c
@@ -324,6 +324,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 			break;
 	}
 	die("bad config file line %d in %s", config_linenr, config_file_name);
+	return 0;
 }
 
 static int parse_unit_factor(const char *end, unsigned long *val)
diff --git a/connect.c b/connect.c
index 2119c3f..ae64e8b 100644
--- a/connect.c
+++ b/connect.c
@@ -148,6 +148,7 @@ static enum protocol get_protocol(const char *name)
 	if (!strcmp(name, "file"))
 		return PROTO_LOCAL;
 	die("I don't handle protocol '%s'", name);
+	return PROTO_GIT;
 }
 
 #define STR_(s)	# s
diff --git a/daemon.c b/daemon.c
index 4c8346d..adc4cc1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -930,6 +930,7 @@ static int service_loop(struct socketlist *socklist)
 			}
 		}
 	}
+	return 0;
 }
 
 /* if any standard file descriptor is missing open it to /dev/null */
diff --git a/date.c b/date.c
index 896fbb4..3db476f 100644
--- a/date.c
+++ b/date.c
@@ -675,6 +675,7 @@ enum date_mode parse_date_format(const char *format)
 		return DATE_RAW;
 	else
 		die("unknown date format %s", format);
+	return DATE_NORMAL;
 }
 
 void datestamp(char *buf, int bufsize)
diff --git a/diff.c b/diff.c
index 8f4815b..468b9de 100644
--- a/diff.c
+++ b/diff.c
@@ -506,6 +506,7 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
 		if (!diff_temp[i].name)
 			return diff_temp + i;
 	die("BUG: diff is failing to clean up its tempfiles");
+	return NULL;
 }
 
 static int remove_tempfile_installed;
diff --git a/notes-merge.c b/notes-merge.c
index e1aaf43..8eadb8a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -462,6 +462,7 @@ static int merge_one_change(struct notes_merge_options *o,
 		return 0;
 	}
 	die("Unknown strategy (%i).", o->strategy);
+	return 0;
 }
 
 static int merge_changes(struct notes_merge_options *o,
diff --git a/object.c b/object.c
index 31976b5..74f165d 100644
--- a/object.c
+++ b/object.c
@@ -41,6 +41,7 @@ int type_from_string(const char *str)
 		if (!strcmp(str, object_type_strings[i]))
 			return i;
 	die("invalid object type \"%s\"", str);
+	return 0;
 }
 
 static unsigned int hash_obj(struct object *obj, unsigned int n)
diff --git a/parse-options.c b/parse-options.c
index 73bd28a..533ea9e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -147,6 +147,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
+	return 0;
 }
 
 static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
diff --git a/read-cache.c b/read-cache.c
index 4ac9a03..2058b7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1360,6 +1360,7 @@ unmap:
 	munmap(mmap, mmap_size);
 	errno = EINVAL;
 	die("index file corrupt");
+	return 0;
 }
 
 int is_index_unborn(struct index_state *istate)
diff --git a/remote.c b/remote.c
index ca42a12..e22b5d4 100644
--- a/remote.c
+++ b/remote.c
@@ -655,6 +655,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
+	return NULL;
 }
 
 int valid_fetch_refspec(const char *fetch_refspec_str)
diff --git a/revision.c b/revision.c
index c46cfaa..e44083a 100644
--- a/revision.c
+++ b/revision.c
@@ -255,6 +255,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		return NULL;
 	}
 	die("%s is unknown object", name);
+	return NULL;
 }
 
 static int everybody_uninteresting(struct commit_list *orig)
diff --git a/setup.c b/setup.c
index ce87900..873aa2c 100644
--- a/setup.c
+++ b/setup.c
@@ -79,6 +79,7 @@ int check_filename(const char *prefix, const char *arg)
 	if (errno == ENOENT || errno == ENOTDIR)
 		return 0; /* file does not exist */
 	die_errno("failed to stat '%s'", arg);
+	return 0;
 }
 
 static void NORETURN die_verify_filename(const char *prefix, const char *arg)
diff --git a/shell.c b/shell.c
index abb8622..23ed2ec 100644
--- a/shell.c
+++ b/shell.c
@@ -215,4 +215,5 @@ int main(int argc, char **argv)
 		die("invalid command format '%s': %s", argv[2],
 		    split_cmdline_strerror(count));
 	}
+	return 0;
 }
diff --git a/submodule.c b/submodule.c
index b6dec70..e177516 100644
--- a/submodule.c
+++ b/submodule.c
@@ -245,6 +245,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 			return RECURSE_SUBMODULES_ON_DEMAND;
 		die("bad %s argument: %s", opt, arg);
 	}
+	return 0;
 }
 
 void show_submodule_summary(FILE *f, const char *path,
diff --git a/transport.c b/transport.c
index c9c8056..5113a64 100644
--- a/transport.c
+++ b/transport.c
@@ -1131,6 +1131,7 @@ int transport_connect(struct transport *transport, const char *name,
 		return transport->connect(transport, name, exec, fd);
 	else
 		die("Operation not supported by protocol");
+	return 0;
 }
 
 int transport_disconnect(struct transport *transport)
-- 
1.7.4.4
