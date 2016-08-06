Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF361F859
	for <e@80x24.org>; Sat,  6 Aug 2016 21:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbcHFVHr (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 17:07:47 -0400
Received: from mout.web.de ([217.72.192.78]:57588 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbcHFVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 17:07:45 -0400
Received: from [192.168.178.36] ([79.213.116.69]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M2MUi-1bD8Ix3nwC-00s8ou; Sat, 06 Aug 2016 16:35:39
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive-tar: make write_extended_header() void
Message-ID: <57A5F5BA.8010702@web.de>
Date:	Sat, 6 Aug 2016 16:35:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vP+WrKnoG9P4OwnU4izVNB28ZguN+vGc8G5WNRr2S92VtpU928n
 q/gQ42G9Rz9OfLABn66XH/F+WQfHCcx8cBGpFEI9QoJXIHlWv9wersx6NcJHcS0PWKIWGTE
 QsTEa05BCzUG8uLalMP7XzimwEuleeniF9JrSPowgmDui4a9Jdi8Vbrs3Lgjh7P5nurt7fs
 puARsAzSXmWLLAGToFGxg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:OLr16ClkExI=:bIH/FxKaOrpxrz+gqRbeB1
 iQXtPaQTHbm+4Ac0lc4lhTw8djKMkSmmT7nhJCRPFz6FriZH4jcJRbd8uPVdNYF269vUauUnE
 XhjtW+q31Ywf0ByZ9Tn/uH/BYHxJksOtmBrHvqPatsgcnILazNAuDsHxOmBOWmPBXqmVvoxBw
 +p3yM9WomBUFlTNPm+taERIOWr9DNssFVX0+L4I89i3nbwMj/DEL/vS6Z7oipKAYVTdGjHcOz
 hn9znhWbqpjvSLj8p060ZCMmJS3JX+yWChLamvDLqoQGu+2TJoMDLCI+FoZMnNu0ACqaYSEtl
 4geH/iVcJMHUwfPV9Gk83zADLbbEGNxjRJGKENy8cdi/e7lfeZcAD7tUys+EaybL/1dX9xEuZ
 lIt6cMcFqsMYa2UQ/Ja3fCQVb+130joK3pkQwbjCI52Q9y8N0NGB3KTMOtNtyVTpxWZBOGndm
 g+lbpqWjIJD4hzWuniIH9XgBlHbzwcjT8r6cdneYvqKVA1W+18WWxeQBH5K/gkjLMaDq4dM37
 MN9C9OgE0Sa5keEL1yX6owoF4U5YFrQoPbC4qdROM5Kd+bEttm10cbTb7K29X3oak97/FY0jY
 MKvjpR3lqayb177eAq+g+VJAEL/jRUDSH7DURWA8det+zVwlNb3LEmaFUn7EYeVcCB0iyI/5p
 qng/WhyfP0P0LXpqNMOlehZ32M6c4y4n2PjcH1WtcLOZG4kcyh6JuolAZNSX3bRlm4zEFX+0n
 vEccfQPT1J6PVZIUhWAqrLNIdF1Z1oYmRShn0kkkWAYml7x6wz1+qUcKGG2IiUfv19eTQKshC
 otf4FbJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The function write_extended_header() only ever returns 0.  Simplify
it and its caller by dropping its return value, like we did with
write_global_extended_header() earlier.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-tar.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 5568240..380e3ae 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -213,9 +213,9 @@ static void prepare_header(struct archiver_args *args,
 	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
 }
 
-static int write_extended_header(struct archiver_args *args,
-				 const unsigned char *sha1,
-				 const void *buffer, unsigned long size)
+static void write_extended_header(struct archiver_args *args,
+				  const unsigned char *sha1,
+				  const void *buffer, unsigned long size)
 {
 	struct ustar_header header;
 	unsigned int mode;
@@ -226,7 +226,6 @@ static int write_extended_header(struct archiver_args *args,
 	prepare_header(args, &header, mode, size);
 	write_blocked(&header, sizeof(header));
 	write_blocked(buffer, size);
-	return 0;
 }
 
 static int write_tar_entry(struct archiver_args *args,
@@ -305,12 +304,8 @@ static int write_tar_entry(struct archiver_args *args,
 	prepare_header(args, &header, mode, size_in_header);
 
 	if (ext_header.len > 0) {
-		err = write_extended_header(args, sha1, ext_header.buf,
-					    ext_header.len);
-		if (err) {
-			free(buffer);
-			return err;
-		}
+		write_extended_header(args, sha1, ext_header.buf,
+				      ext_header.len);
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
-- 
2.9.2

