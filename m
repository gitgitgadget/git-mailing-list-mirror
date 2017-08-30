Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130D120285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbdH3SAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:54 -0400
Received: from mout.web.de ([217.72.192.78]:57340 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdH3SAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:39 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maayz-1e76z91APR-00KChp for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 23/34] remote: release strbuf after use in migrate_file()
Date:   Wed, 30 Aug 2017 20:00:26 +0200
Message-Id: <20170830180037.20950-4-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:+HHJ/TJtJ6y6OefrKF71thhSK/XVgrKrlKB7XUDTXwh1/9J4rf6
 oeu47oOSNMXFenK7OCGc2k0wSZOVv3PSzd6UwmjmVN5l0SUluw48Nter2E1azEzoifZ8Ct0
 LzblCF82PYT5wksPcsfcXFIrgIe73LfxvEUt5XXx7GGnejp0io062TucWGlP03z/kiv67QJ
 /feLebLV3AljJ5QKjV8qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qg3hXjjrgAA=:8KgYeFpnnBtoNhPQBe+WJO
 2FVTPg3dMI3+AyJOR4e1BhGQrqYaA+e/FWNuYU89M7KOpX6Ikz/eGww9mQNjHq/vgmd1t3+6h
 ptinybDCk6fa2mZ6vl/+f1ZMQQyjtX+50BcPMv+52OxaP3kc6pqpsPSFuQH6rbqa3XzwfOxKu
 WLOUyhI7bqSZPru7AzQsGd31Ni07hoqlGzPFq8izJctZdZUPe43GRwlJNQQz7llcJqvaE8pvp
 V1kijjkNMTYxLP7DnZ8FvPC/6GjYJrAWElChMWsdqt4zIpPyizIBr19aOjtvgwj2yA6bt9hS0
 Cpcgkyz0cq7RGvdYH7kvcOuEhj+7b2QnQ1J0kCVouTUdy9hp/ZfPCbWqS3Kv+Oynnej4Oe60f
 mE7sU4i5T6tjeZLD52V+qXl8i1kYbP4H5StJ3U2KzY+3HwG6tczD1e6OMbUTogKyr9irtLL3o
 XHZSLIkTPjdtJR70tA/pzMzkBTkJelWZN3TujBeBe7d6P1aVL3+FUFFJ7dwwK3gGPPutcPoAM
 D3e3/4vvNlHV/Vejm7Rk237hgafXUl+sYRBhBtkzCfxb3EHlJSoL8h0OY8O+HbscyEloMU4vs
 qZQbnd2rvT5wHnx6Y7XE9E18bdrNdkylM3FV9a6WknIBrtBlpscEosBHrWzq+GePbpacpdkdx
 Iu8yrd8bOE1x3CUp1lEYaURHsp9fcCD2+z5H86nv3qin5ypVzAPklZInZMZbtMau4oHPruOfk
 Dalh2Tongpnyn87vu7nsCKWPe3ryke5QlprU3ttxXBOPu1+0fwyKoJDPMVWCeHPPZriPfo7Tg
 NK055Mxs+9J/DXVHzTftwwew2RFQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index d0bf999abf..0a56d7da66 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -579,23 +579,24 @@ static int read_remote_branches(const char *refname,
 static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int i;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
 		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
 		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
 		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
 		unlink_or_warn(git_path("branches/%s", remote->name));
+	strbuf_release(&buf);
 
 	return 0;
 }
-- 
2.14.1

