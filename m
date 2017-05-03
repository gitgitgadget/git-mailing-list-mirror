Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7A3207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdECDaF (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:30:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33791 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdECD3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:46 -0400
Received: by mail-yw0-f194.google.com with SMTP id 203so13362238ywe.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J+WtWHnGolpDFVuq873MrjvDZbptdejLDlbMIWgqlNM=;
        b=CXP2gzMMTDWQPu9+rApL0j+4XL5dJSH/+FL81Ol20BxUJqisHo5/iS20Tfv9HbKbEv
         jlIFtl3K75ABmSVRs3BqH5Vf279LvIiAsal6TzN0y9IJLR2xntuFa38sUbuisIchyxkQ
         yQEBx+i7qTEtNiTf/Fsc8E1iWCNCr1Z8ltFtENDm05Ein8Zk/5gkYqTG6bjwNTOv+WWD
         qAtwEJz58EXP2pe+nIqAvj/CvN9s8+vdGjgSZTh8/s6/4H7DanWkTCKwJhwMoGw8HvX2
         6UOaxGCqC70gSmAt031E2Ye1Jo27oow1giNSKoMZ49AYMJgarfYXnQbuQlktEi5j7x7O
         3EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J+WtWHnGolpDFVuq873MrjvDZbptdejLDlbMIWgqlNM=;
        b=CymeeOHaXEZ1CYpu/8/kA8eWbk38kfNw0NUDnvYT+1OqMtlWKYron2xJx4psuOeevU
         Fm0RxZeQq8L96y0AkOYcJWt9v13n7eyIdrS2vp3cAGoL9pCplQrKcLkNAjckS1+bof3H
         VqUc8KnbLeMKqniHqlLdwZYK3W++W+z5dqEA7huCmivvROl4tHN4M6gp+TyK2/HGJM6D
         uwdGVqlQOUQsyztNoibx5YtRnSJCwSwBGANg7juQWsKhfrsIQTleqz8jWq5O+a0BzXJj
         QN1hlo3ArPWDsxrRX6NQmxhTeyxa8aMxLg5Resbmed67ejkLAbCOL5RLM8n/8r684fVy
         3cWg==
X-Gm-Message-State: AN3rC/4T84drCoJ9dlmsgl9C4Y4jFQpz6uPGq2xtxokQwXfd7CNIalUD
        i7uqFU9VBr3dMtn7
X-Received: by 10.129.4.70 with SMTP id 67mr4187967ywe.109.1493782185184;
        Tue, 02 May 2017 20:29:45 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:44 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 3/7] dir: add method to check if a dir_entry lexically contains another
Date:   Tue,  2 May 2017 22:29:28 -0500
Message-Id: <20170503032932.16043-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a method that allows us to check if one dir_entry corresponds
to a path which contains the path corresponding to another dir_entry.
---
 dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dir.c b/dir.c
index 6bd0350e9..25cb9eadf 100644
--- a/dir.c
+++ b/dir.c
@@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
+// check if *out lexically contains *in
+static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+{
+	return (out->len < in->len) &&
+			(out->name[out->len - 1] == '/') &&
+			!memcmp(out->name, in->name, out->len);
+}
+
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
-- 
2.12.2

