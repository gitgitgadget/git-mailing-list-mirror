Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97072202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbdIUPb7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 11:31:59 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:48587 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdIUPb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 11:31:58 -0400
Received: by mail-wr0-f173.google.com with SMTP id 108so4896716wra.5
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cG94n8bv4gsZYqybD42lioLTtMA8hYOEssC9r5Vhl8I=;
        b=k8sgwSm1eMQR1YIESS3UYmYqnn4m+P+RngnquDvzNj9sLbHaN5XaSeT/6mhQzvutFr
         jzcC8xdF9gXT25+svwFnqUjoL3TIJlC8ClHCD7uWkUNBkYnJy8c6h+9un7dupd3l+VrU
         G4/ZK7KMujSp9m7eaIU3jv9OwzrBU6VjCiv9C9YfL0R4sO5uTxsJpGdFBdR/4+9R820w
         5CZqGzM2i5OD6MlvXyd9G/hSQBkwhE6V3ybv51gdQZALvc3yb37P1JZQn0iZUhAWS8IA
         fXnaXf74GDheat54+64FJ/FAbWTYta0UXfxB3zpJdfPQ584cLfAoHG1IIYGQlUcvgjpS
         8ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cG94n8bv4gsZYqybD42lioLTtMA8hYOEssC9r5Vhl8I=;
        b=N10brNhzGBCUBhN4RZZx/mlFFloEBQrjVLZxjKY4GRwCkglhbTqH5f6StnypPaZoXm
         IT9+S1J1r9iYz15xeAcP5j21IGKxbRKf4TpH1/pnVnZv1ELPDdI8/DqNMWXP4rz5efaI
         EhdyCfWh3RC3/Ai183Vv5w/hRDDDNsMUsnnbMl1WlqRfxn9FdegDbvsecxUFkOa5Sxs4
         XaW7QU5j8CTJGmcYXX5icpeo6qWKACmDvGmg4177SA0uZ9vPBd96xqH//ajiayUEvRIA
         Tdhf6UA4T8r7OLvagtRJ5wpZgB9JhfbAFclFUfDORv+KNWSuQShqSlbfcALsfmw1i3FF
         R7Pg==
X-Gm-Message-State: AHPjjUh8jdCGGpx9F4Bi3kjc/7s+qJLx3SFICMsAIKyDXaTQ0fnIPp6d
        qVH+in1D2fCyrU11iBHeOuvnjg==
X-Google-Smtp-Source: AOwi7QDAtKvxUrHljHFwF3VFpYhEDykVE4GVJR3CloStAQ2Rwvwf16zatGR9Dm6HMn6pCn2vJ2xp2A==
X-Received: by 10.223.197.13 with SMTP id q13mr2458644wrf.80.1506007917072;
        Thu, 21 Sep 2017 08:31:57 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id l91sm1639602wrc.16.2017.09.21.08.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 08:31:56 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 3/4] submodule: port set_name_rev() from shell to C
Date:   Thu, 21 Sep 2017 17:31:55 +0200
Message-Id: <20170921153155.8544-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170828115558.28297-4-pc44800@gmail.com>
References: <20170828115558.28297-4-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM with nits

commit message:

"revision name, and later handles its formating and printing."

typo: formatting

+		if (!capture_command(&cp, &sb, 0) && sb.len) {
+			strbuf_strip_suffix(&sb, "\n");
+			return strbuf_detach(&sb, NULL);
+		}

you discard all output if these commands fail, so if the argument is a
not a submodule, or the other is not a sha1, it will just print
nothing without error message. Maybe that is OK, though? I don't see
documentation for these commands, so maybe this is not meant to be
usable?
