Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B021F1F464
	for <e@80x24.org>; Thu, 19 Sep 2019 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfISUsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 16:48:41 -0400
Received: from mout.web.de ([212.227.15.3]:60119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfISUsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 16:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568926114;
        bh=RTk+mkeiGSo90xLPpuj3xm/GSJ7FhBHuJUHVM68wDWE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=rc4L4DOkRNPoot7CplD2rJKDE+o7X1vd+YY7U7xRr5e4jnFA4wIypViOWUD5MO5oC
         V+6wK8n/qzLyp+5P/mKZodRMZYXuYfA/DCCufvxEqkHabj2hwNtz5IioQoFExHv8gZ
         SW95M7LUAC98urjS4WwEgze+odxw4InvWLzsUAZo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0yjP-1hvif71jPL-00v6Ic; Thu, 19
 Sep 2019 22:48:34 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] git: use COPY_ARRAY and MOVE_ARRAY in handle_alias()
Message-ID: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
Date:   Thu, 19 Sep 2019 22:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ac52GbzfKYOefvJisyB9u2S43ncxVkqxKmnccUWCWRo63RsUrUb
 aEVePEGSVmjcr92yACVVXL4vi9oPMC+lrp9xEwpP0IYgPwisKbjiA+R9WvsIK1/6Vj9cral
 FMSsFXOtQJ2PrbyckWYiPKiqx3Uwdx0S2qxxWzhdSLQdQiAL5cSi1jpl+kpeTSmMcFZyF9R
 f6L32EAJOWPd3wsEZRTLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eMeIgqeBALo=:WJ7I5VVEO+ISHumj821I1z
 y6KUaufAJTd6TX65mp4XYTLjmoz3aKpZBd2oP2ix15KcwcAxCDFYKpbPphp3pW1ab0EO5bAI4
 F1M9O0IMzlZdIZ4aV+us+qX3e4FWwNjQo+6bBAX8IrWgDrW3KbDt4/JVdvxW+tuuZE+No6zgx
 SxQkwpPzlVbuOOqSVICAQM1FJEYoVkBlh9LX3tsXcLGAw8k9E/dSEIO91TT6SD8wgViwjvjon
 txbSwoXcO14zzbKr3GfrQb2Rqzz8Y390XMYCXqM09vV0avlKWjfijjbWY5eMB/LQf+6Nxz53Q
 mxb5AErst6BWa9bmQ9AvevOS6rvTd1GVPVSDczvQMIxGH3o9UXLHXfu08Z8RmceISiKMrAQhC
 KJFVIHLstmL63GxBYLnB/XFGaJrdwM1+gwUEKgz5Q1O5ZGro3w1EQT3QS4vzJTtv3QB7o9qzL
 7Exuebt7V2AiGIZvwUt+CTKZwQTvCuV6LNcpmntVX2734DpZYY9QVXck/Jg53kc+ppAkYEG17
 4lrOMI+9X/j6YuBc425CQmBFjlVMqwbBoKB+hsMB4Ice0HnXYgGp/zgNMuOg0rxzkKRb1zqdk
 XXZ3ii9aIL7c75v7aEObj/5X+tmhQvM49jK81ryGXlU/+sviMyXkXBqZwSxXvx6WHajeu0Bdi
 XIM8XL3r7oyrBsrQBoeKolFNyM86oLwN8NAEETfrmsTWtc8yepoExen+2mQOysSJWy67hX6qX
 2M6aWfnKlbTtiOBPxH2YhdQF4Irae5Sib0AOaCV6yeLQaClYXzTG7pvss+8BL4HvO6lv8LqM0
 wyCalbMmrWgU0cn23uGImNiOeN83OseNpI/HLhyZtqXtAXZdxEvD5aAKUWnttLnDgzJ8T091q
 Sz/zSgJv6P9t6f3iCwKZ5lhUWfYerXJ/8Km16SGurlR4OMurlQL/VbTCxbVNBpQmj0aWKEz/x
 kTLe60WrmeybkRkjc0cFNBMLpYVgPE4PpOgZm6IFYjy/6jo9QViMT83B6lkTytykx3sBSNDaM
 t+him1ZUW6+SZfDFZAomw6yazHg1zeHgy3maj4QVPG/K2EAXLAuKRcXzskWVAkhnS2eyPdiKu
 yTJl8ciJI+Gh6oYfC2DXIYLRgTw/yYB08vaveS8f9HcZohrgBa2kbkXW9fbVqOwCUSgsJiv8L
 8IiuW0yN3W32OfE3flFg3vIKBmKns2DgkWVzkVqGzUYWz9JMJ5bgMfTrhFCEh7kSGBwn4eLjc
 gwFvJYpWN3C/PBn/1SX13VLktUxGRFnJd2p3d/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the macro COPY_ARRAY to copy array elements and MOVE_ARRAY to do the
same for moving them backwards in an array with potential overlap.  The
result is shorter and safer, as it infers the element type automatically
and does a (very) basic type compatibility check for its first two
arguments.

These cases were missed by Coccinelle and contrib/coccinelle/array.cocci
because the type of the elements is "const char *", not "char *", and
the rules in the semantic patch cautiously insist on the sizeof operator
being used on exactly the same type to avoid generating transformations
that introduce subtle bugs into tricky code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index c1ee7124ed..ce6ab0ece2 100644
=2D-- a/git.c
+++ b/git.c
@@ -369,8 +369,7 @@ static int handle_alias(int *argcp, const char ***argv=
)
 			die(_("alias '%s' changes environment variables.\n"
 			      "You can use '!git' in the alias to do this"),
 			    alias_command);
-		memmove(new_argv - option_count, new_argv,
-				count * sizeof(char *));
+		MOVE_ARRAY(new_argv - option_count, new_argv, count);
 		new_argv -=3D option_count;

 		if (count < 1)
@@ -385,7 +384,7 @@ static int handle_alias(int *argcp, const char ***argv=
)

 		REALLOC_ARRAY(new_argv, count + *argcp);
 		/* insert after command name */
-		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
+		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);

 		trace2_cmd_alias(alias_command, new_argv);
 		trace2_cmd_list_config();
=2D-
2.23.0
