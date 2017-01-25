Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D8B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdAYWhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:37:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58288 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752541AbdAYWhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:37:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A061264071;
        Wed, 25 Jan 2017 17:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCMYNWVodgyB4EJGVLnG1U3ju/w=; b=ay/Sec
        qLlSHZyjng6F/KAT5DX4T01PWI8uC2Vf6FPZAOvfP8aP36oqzDNP2G83aXwSgCHk
        VMvuSohRH6e81QkViMTCJAI6QeGI4FuqJzhkoKdgl0XQaMYAAqbGobKwBOui60Ke
        bNZZeONivDQOr7bxfIw3yUmTrwJOZ72OVQGxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pncm2lZ5XFdT7O1z6f0DtoJzmg1cFxMx
        qcqT2tJmfwjVepPC16Q/ETbVtHSRQQvp+5aKMNEcsHsIaoYwkAQlKXQHXtp6Vhib
        wQltZZc7ABykeSIej7WpLguP4iaJI5ISoim6Fb9evNW+Dvnvakf4ph3zkrPJElzP
        O8m+WFfhEv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9793E64070;
        Wed, 25 Jan 2017 17:37:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E00756406D;
        Wed, 25 Jan 2017 17:37:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
        <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091207480.3469@virtualbox>
        <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701251327090.3469@virtualbox>
        <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 25 Jan 2017 14:37:32 -0800
In-Reply-To: <xmqqinp2939j.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 25 Jan 2017 14:35:36 -0800")
Message-ID: <xmqqefzq936b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD315A7C-E34E-11E6-9B84-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yes.  Here is what comes on an obvious clean-up patch (which will be
> sent as a follow-up to this message).

... and this is the "obvious clean-up patch" to apply directly on
top of Segev's GIT_SSH_COMMAND support, which comes before the
previous one.

-- >8 --
Subject: [PATCH] connect: rename tortoiseplink and putty variables

One of these two may have originally been named after "what exact
SSH implementation do we have" so that we can tweak the command line
options, but these days "putty=1" no longer means "We are using the
plink SSH implementation that comes with PuTTY".  It is set when we
guess that either PuTTY plink or Tortoiseplink is in use.

Rename them after what effect is desired.  The current "putty"
option is about using "-P <port>" when OpenSSH would use "-p <port>",
so rename it to port_option whose value is either 'p' or 'P".  The
other one is about passing an extra command line option "-batch",
so rename it needs_batch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index c81f77001b..aa51b33bfc 100644
--- a/connect.c
+++ b/connect.c
@@ -769,7 +769,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty = 0, tortoiseplink = 0;
+			int needs_batch = 0;
+			int port_option = 'p';
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			char *ssh_argv0 = NULL;
@@ -819,12 +820,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 			if (ssh_argv0) {
 				const char *base = basename(ssh_argv0);
 
-				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
-					!strcasecmp(base, "tortoiseplink.exe");
-				putty = tortoiseplink ||
-					!strcasecmp(base, "plink") ||
-					!strcasecmp(base, "plink.exe");
-
+				if (!strcasecmp(base, "tortoiseplink") ||
+				    !strcasecmp(base, "tortoiseplink.exe")) {
+					port_option = 'P';
+					needs_batch = 1;
+				} else if (!strcasecmp(base, "plink") ||
+					   !strcasecmp(base, "plink.exe")) {
+					port_option = 'P';
+				}
 				free(ssh_argv0);
 			}
 
@@ -833,11 +836,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
-			if (tortoiseplink)
+			if (needs_batch)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
-				/* P is for PuTTY, p is for OpenSSH */
-				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_pushf(&conn->args, "-%c", port_option);
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
-- 
2.11.0-699-ga1f1475476



