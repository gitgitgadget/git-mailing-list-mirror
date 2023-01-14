Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44976C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjANOiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANOiD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:38:03 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AEF7EF3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673707074; bh=Xjn9YUuQj2DpGew1CjEUDEz9luQ9UXBUcKVLB2tH5r0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=KVLClHuHQX8s0b5BYjb/HA4kCufh5zRYR4B1+jstq0BakFmdCVgxDN7MYLhPCILjS
         c7NgwJXy6/e1FdX2Zkosm5b12Q6ARJRt72pB6JOcQTDH8EbYiC+Rtoa0JNxDl8ZBpJ
         UCcFwSoao0rswTKIWtmi3yZFD9McdfPNnyxuZ/RHWPmQhDSR4F5sgD7ykv6WzxK/Rn
         fR9v7VIOR8xUpkraRcU9Xf279C2AhWzjuVecO9eyLSywnPRD5uhNi7Av1FQCnSTtZg
         1juNVowoIdRX18apJgBh5FyUxGZLyOOmbFBWteHr2qYJ0uXzosxiSjjTAhOnTijzfR
         Z35irNeXoz2Pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1oT7p02xSe-00ubaR; Sat, 14
 Jan 2023 15:37:54 +0100
Message-ID: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de>
Date:   Sat, 14 Jan 2023 15:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ls-tree: fix expansion of repeated %(path)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UBnGgLzYyAVv5NVpWO6TYc+ZcVcB9bgHZ1lGUuiCdKlpx/3bG9V
 i8aUXHINCaidkzoeEGdxnQILwaIAyZgZe59zb/m69VCOZBBKGDLCueBRaqCb7qUVuZmwPDQ
 CTyr5iIq4/MW9R4Yor0nXjGaBwX+dZ9AldzBtrhH/BrxzRBpT4nJ2zm2VGMoz+nHpFjSRDs
 RTsU/qgN493d8ctirtbrg==
UI-OutboundReport: notjunk:1;M01:P0:kcRfhPZTyjM=;daMRaDkjWA9mREaWfPXiSQPJUXK
 Q5ipDT0P1FygbLX4D9ZYOt7MnJ/xSaH2jDlg11BKO7eKu3z/PwKOGXvOhwtr5WyG2BtDx+R8y
 WNArfHofaBi4+/GyPSHzqkk2ikBJmlpGFG/LTEf0k4WazbXABBs2yJmyux2MiVoCndj5fqpJ9
 4HbXaeEIpYRuK5S4/SSyDghpv0dmt54u4YuHrqLvJJXyKq761+z0rS9UpoUZtNpaLPt/Wf+C2
 ZdPjz84vWsKLXUo718y7mbjh+5+QsiH6DpnVEmTTR023Y3wiC8N/8exnL2IM5sO2niGIvv0zB
 +NBQus0v1sMSIMETubPWihiqHOi0YWC2ZDNJkS7jd8P8L1Nc2f+D/73+cyoMrH+1yrzcn8Qrx
 +MF+0Qy+9QO6ZW3pClecDVSz9VHrR1IsKuQZvO58CbBistxcxxMxHOoNFO7rWm9Qp0odEBBi+
 k4xN0aCtcarmqmI6JK6q3SjvGIO9U9Yvbfa1TVBA6HZaDv9zFpdesGx8laohqZfKiXOZacvEm
 6gEIT7dU3ZEkl5xNKL3kXQgftt3ys4GlYwlN4qR3am0F7Fb8Uno5b6mCIOgjyTJrQRQ7PwMQm
 W6TW6Orlz77g+n080TsBemKfhk7rEr+xFsfBOiqhQVcjAUuJF9hgagpKQaDhU3RwrISROdrVh
 fDVIp6jyKwVZOcpwfKKtNozt0pGwCOcxD2GWemhcM2BgErq8diSlVjaKEZ5eD0oWLugrTD1Px
 /XzzM9Iz2MLYiMCWxtAVJmUvMR+3c1m+hM7l6glALjP7rtnQDT/c4wp5asxqVF32dMSfLM9Sn
 BASps5CnvLoTTlIwOXaw0m08QFxBBZXTHn7FGz+wzFrEBoDOkSvnSwyYG+IxND5LsRxl/Sn2M
 TG+Cdkljk0zFHNzcUYJl1UjdLSS1zNTBDWwyfFtODLRGB0CdVb2lNt35tV/wChTLjgpQSiNQX
 Jtq5prNFLf9o03TSkWQy2A7ki3A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

expand_show_tree() borrows the base strbuf given to us by read_tree() to
build the full path of the current entry when handling %(path).  Only
its indirect caller, show_tree_fmt(), removes the added entry name.
That works fine as long as %(path) is only included once in the format
string, but accumulates duplicates if it's repeated:

   $ git ls-tree --format=3D'%(path) %(path) %(path)' HEAD M*
   Makefile MakefileMakefile MakefileMakefileMakefile

Reset the length after each use to get the same expansion every time;
here's the behavior with this patch:

   $ ./git ls-tree --format=3D'%(path) %(path) %(path)' HEAD M*
   Makefile Makefile Makefile

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281a..120fff9fa0 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -98,9 +98,11 @@ static size_t expand_show_tree(struct strbuf *sb, const=
 char *start,
 		const char *prefix =3D chomp_prefix ? ls_tree_prefix : NULL;
 		struct strbuf quoted =3D STRBUF_INIT;
 		struct strbuf sbuf =3D STRBUF_INIT;
+		size_t baselen =3D data->base->len;
 		strbuf_addstr(data->base, data->pathname);
 		name =3D relative_path(data->base->buf, prefix, &sbuf);
 		quote_c_style(name, &quoted, NULL, 0);
+		strbuf_setlen(data->base, baselen);
 		strbuf_addbuf(sb, &quoted);
 		strbuf_release(&sbuf);
 		strbuf_release(&quoted);
@@ -144,7 +146,6 @@ static int show_recursive(const char *base, size_t bas=
elen, const char *pathname
 static int show_tree_fmt(const struct object_id *oid, struct strbuf *base=
,
 			 const char *pathname, unsigned mode, void *context UNUSED)
 {
-	size_t baselen;
 	int recurse =3D 0;
 	struct strbuf sb =3D STRBUF_INIT;
 	enum object_type type =3D object_type(mode);
@@ -164,12 +165,10 @@ static int show_tree_fmt(const struct object_id *oid=
, struct strbuf *base,
 	if (type =3D=3D OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return 0;

-	baselen =3D base->len;
 	strbuf_expand(&sb, format, expand_show_tree, &data);
 	strbuf_addch(&sb, line_termination);
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
-	strbuf_setlen(base, baselen);
 	return recurse;
 }

=2D-
2.39.0
