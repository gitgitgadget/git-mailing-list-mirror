Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A7C20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdH3SAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:53 -0400
Received: from mout.web.de ([212.227.17.12]:61192 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752572AbdH3SAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:40 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8X7-1dnOH129j7-000KP7 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 25/34] send-pack: release strbuf on error return in send_pack()
Date:   Wed, 30 Aug 2017 20:00:28 +0200
Message-Id: <20170830180037.20950-6-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:3+KRh5742eVPY8KrWCw65B2qKD929LWFpTZhJsPx7bhwo4Cmzsd
 EcqBKUvBUBrIYA41DNgbxWXSXzyp0e09zP2FxEo416gbvsg6mhZS36qT08kLijHlzrTv+Os
 vB6tBlwRpJDjI7jYyZKwaXTIwWnl9s8vIO9IRjEMJCrz/VOll9J6ixZdCq+83DhVmHOfiFg
 OgRm48suex7yrQ+bwDlgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TD+4gPLvYKk=:u8b4xl0jNggyeyM6gxRlI8
 36P7wJi5JHH8CW5hKdbxQqc+2RlzkU0VJGlixexzNnRmJ7CK42TMJI0FabvhEkkB4ERUcv0R8
 glR0WJ7KdzPjwaRVvuvPlQ7ACFj4n/F1YpbWzVI9PZe52iJ/trKvW0cq3I6A85gi0XNFv8lfP
 etax+U5Z6mam3dnCh7lYnB8VVUbNmQOFJKqJ9TmnCl4mGtGbB5STYHqvwGXuzU2GV9yO7yG8w
 /dsStEfFbZnfQO7wM5q7z5rC1zELmLqE3eKoYCcrY/WMi+IekIIbI1X5W6vPJ2WcedRfs0qoE
 YfUGzKnClwKLdd22JcgsJgAcnglPvtpaPKPqQTnNAhw6tzVkixSBsWOHJ/1TRfqcfFnsG34yt
 YMz3+hMhB8hQvOj8SoIbOcUV3GF8dd6/g6tRQ+mlEceEjylwj62cL1f9EQhOJGDZpB6icEcA+
 xM2ZfljEwNdvYy2gIhAZC5t386skb5h+dk+MwboV4BlWUYvhnfGg4GJl6ZmbCEDsWwKmOYd6r
 B2WgOxMA7m/Pozb3xWjn1T9VVGqJYtHzOaGlhfCBk68wbdynTN0a7meg7Pf3nNzOUjo8kNzF4
 PJtR92nNxgfZnYxbcLvfFVw+MJNgM2/6qfyo0gndIBg5Z+xOO8I/e/V17vuOYpv1e49yEgTeO
 DxPTesvFX2E0PykFHxFPMQY1dv6I70H9Ynhvp0DvCRyd4gGQ8RRipxhAC1ttCrzkksmV+SAbk
 9a2gwj8wnFGKWftkkLOBU2zHJnV1dcHI61tdnKa9Z3sRj6k1ysTN/Df1xtHseQC2fhVlsWXqd
 OGPu4U0JCLiWusIzX5m2UgYyEX9Xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 send-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 11d6f3d983..b865f662e4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -377,253 +377,256 @@ static void reject_invalid_nonce(const char *nonce, int len)
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
 	      struct oid_array *extra_have)
 {
 	int in = fd[0];
 	int out = fd[1];
 	struct strbuf req_buf = STRBUF_INIT;
 	struct strbuf cap_buf = STRBUF_INIT;
 	struct ref *ref;
 	int need_pack_data = 0;
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
 	int use_push_options = 0;
 	int push_options_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
 	const char *push_cert_nonce = NULL;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
 	if (server_supports("quiet"))
 		quiet_supported = 1;
 	if (server_supports("agent"))
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
 	if (server_supports("push-options"))
 		push_options_supported = 1;
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
 		push_cert_nonce = server_feature_value("push-cert", &len);
 		if (push_cert_nonce) {
 			reject_invalid_nonce(push_cert_nonce, len);
 			push_cert_nonce = xmemdupz(push_cert_nonce, len);
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
 			die(_("the receiving end does not support --signed push"));
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_IF_ASKED) {
 			warning(_("not sending a push certificate since the"
 				  " receiving end does not support --signed"
 				  " push"));
 		}
 	}
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
 		die(_("the receiving end does not support --atomic push"));
 
 	use_atomic = atomic_supported && args->atomic;
 
 	if (args->push_options && !push_options_supported)
 		die(_("the receiving end does not support push options"));
 
 	use_push_options = push_options_supported && args->push_options;
 
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
 	if (use_sideband)
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
 		strbuf_addstr(&cap_buf, " quiet");
 	if (use_atomic)
 		strbuf_addstr(&cap_buf, " atomic");
 	if (use_push_options)
 		strbuf_addstr(&cap_buf, " push-options");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
 	 * send-pack machinery that set_ref_status_for_push() cannot
 	 * set this bit for us???
 	 */
 	for (ref = remote_refs; ref; ref = ref->next)
 		if (ref->deletion && !allow_deleting_refs)
 			ref->status = REF_STATUS_REJECT_NODELETE;
 
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
 	if (!args->dry_run && push_cert_nonce)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
 					       cap_buf.buf, push_cert_nonce);
 
 	/*
 	 * Clear the status for each ref and see if we need to send
 	 * the pack data.
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (check_to_send_update(ref, args)) {
 		case 0: /* no error */
 			break;
 		case CHECK_REF_STATUS_REJECTED:
 			/*
 			 * When we know the server would reject a ref update if
 			 * we were to send it and we're trying to send the refs
 			 * atomically, abort the whole operation.
 			 */
-			if (use_atomic)
+			if (use_atomic) {
+				strbuf_release(&req_buf);
+				strbuf_release(&cap_buf);
 				return atomic_push_failure(args, remote_refs, ref);
+			}
 			/* Fallthrough for non atomic case. */
 		default:
 			continue;
 		}
 		if (!ref->deletion)
 			need_pack_data = 1;
 
 		if (args->dry_run || !status_report)
 			ref->status = REF_STATUS_OK;
 		else
 			ref->status = REF_STATUS_EXPECTING_REPORT;
 	}
 
 	/*
 	 * Finally, tell the other end!
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *old_hex, *new_hex;
 
 		if (args->dry_run || push_cert_nonce)
 			continue;
 
 		if (check_to_send_update(ref, args) < 0)
 			continue;
 
 		old_hex = oid_to_hex(&ref->old_oid);
 		new_hex = oid_to_hex(&ref->new_oid);
 		if (!cmds_sent) {
 			packet_buf_write(&req_buf,
 					 "%s %s %s%c%s",
 					 old_hex, new_hex, ref->name, 0,
 					 cap_buf.buf);
 			cmds_sent = 1;
 		} else {
 			packet_buf_write(&req_buf, "%s %s %s",
 					 old_hex, new_hex, ref->name);
 		}
 	}
 
 	if (use_push_options) {
 		struct string_list_item *item;
 
 		packet_buf_flush(&req_buf);
 		for_each_string_list_item(item, args->push_options)
 			packet_buf_write(&req_buf, "%s", item->string);
 	}
 
 	if (args->stateless_rpc) {
 		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
 	} else {
 		write_or_die(out, req_buf.buf, req_buf.len);
 		packet_flush(out);
 	}
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
 
 	if (use_sideband && cmds_sent) {
 		memset(&demux, 0, sizeof(demux));
 		demux.proc = sideband_demux;
 		demux.data = fd;
 		demux.out = -1;
 		demux.isolate_sigpipe = 1;
 		if (start_async(&demux))
 			die("send-pack: unable to fork off sideband demultiplexer");
 		in = demux.out;
 	}
 
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
 				shutdown(fd[0], SHUT_WR);
 
 			/*
 			 * Do not even bother with the return value; we know we
 			 * are failing, and just want the error() side effects.
 			 */
 			if (status_report)
 				receive_unpack_status(in);
 
 			if (use_sideband) {
 				close(demux.out);
 				finish_async(&demux);
 			}
 			fd[1] = -1;
 			return -1;
 		}
 		if (!args->stateless_rpc)
 			/* Closed by pack_objects() via start_command() */
 			fd[1] = -1;
 	}
 	if (args->stateless_rpc && cmds_sent)
 		packet_flush(out);
 
 	if (status_report && cmds_sent)
 		ret = receive_status(in, remote_refs);
 	else
 		ret = 0;
 	if (args->stateless_rpc)
 		packet_flush(out);
 
 	if (use_sideband && cmds_sent) {
 		close(demux.out);
 		if (finish_async(&demux)) {
 			error("error in sideband demultiplexer");
 			ret = -1;
 		}
 	}
 
 	if (ret < 0)
 		return ret;
 
 	if (args->porcelain)
 		return 0;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
 		case REF_STATUS_OK:
 			break;
 		default:
 			return -1;
 		}
 	}
 	return 0;
 }
-- 
2.14.1

