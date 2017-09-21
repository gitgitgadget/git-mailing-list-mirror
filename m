Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F71202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 16:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdIUQLE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:11:04 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:43055 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdIUQLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:11:03 -0400
Received: by mail-wr0-f169.google.com with SMTP id a43so4985502wrc.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O5B/d8qlXZitDr6G0yTMqEZj+ceTWaZM8Fq7eWQCm90=;
        b=AJ4KxKQfOre7xh2JoJ1y4R6q9uTCQSAuukhiuchjCPVAUzh6CkGtEowCHm0+d/ipqz
         /6CmaCAgOIpfnxUKNzK9eveXY5N4MeD8du3P9a73ZxyfhmzYBVK8vM+ThOsL5U57iBjt
         6NMhSMWiOyVAyr5knRRu8DbmG2HEOJBQ4UyaVCrZxhTzaFqPlL1I1Zuuv9h4N7gQtQjW
         UpnX7k6xVLWjruQRAwDjZzPpyE5Bt8ZzQz1Cyj9xnGrfbduStwQou29a+rha2+cIURYH
         UFsKKvtEtJQKJysQX0q5GFRpg5HxDytILy5PIjXYqhwavAxXw764d9va6o44v0f8D7Ae
         TDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O5B/d8qlXZitDr6G0yTMqEZj+ceTWaZM8Fq7eWQCm90=;
        b=EoWlOoRWWypiX0n9uLf0wME0FmsASz5QyVm76pEu5naF3bPZHXHrvAgYqKEmYhEWLY
         b0vIIrzCYhM9yI971NPicMPXOUa2lxw3V4d2kDetz81Iq8KRqeZbt/MbqjamFLD3SKeD
         9YokzFpp2hQMwept/dKQJI16sApIZftXujDCiwSQZ2CtXlzhMzyGwil3l+gU2/tj+/Xd
         DXu2fCW7xNBsoPd4VZCjnPDb0BnBb06YhHwTFkvRByXwWkYDwTLEBLjnPJVWLeycvv0s
         WX4p4Yns3Z/BF24nWRYpRcne26klxb9zOGNrYEWPqD/xXx345vF0R3FqpIX2NlejjPJk
         rNmw==
X-Gm-Message-State: AHPjjUiui9KXjM0yv3iUoHXYJDterKDKS2NcMMefxzK4eWtcYD0dWeu1
        NeTM8aPmZzuyrcgpd+svkzAaPXzv490=
X-Google-Smtp-Source: AOwi7QDiLSdA4pmoy5HsGOSBO0OgNmbxDTH6rETz5nZQCM7P6wWbOIFTytpxY7sEZtE1zK4+oTnnaA==
X-Received: by 10.223.142.6 with SMTP id n6mr2167839wrb.140.1506010261648;
        Thu, 21 Sep 2017 09:11:01 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id p6sm1273510wrd.10.2017.09.21.09.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 09:11:00 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 4/4] submodule: port submodule subcommand 'status' from shell to C
Date:   Thu, 21 Sep 2017 18:10:59 +0200
Message-Id: <20170921161059.11750-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170828115558.28297-5-pc44800@gmail.com>
References: <20170828115558.28297-5-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
+		NULL

the manpage over here says

  git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]

ie. multiple path arguments. Should this usage string be tweaked?

+static void print_status(struct status_cb *info, char state, const char *path,
+			 const struct object_id *oid, const char *displaypath)
+{

could do with a comment. What are the options for the `state` char?

+	if (state == ' ' || state == '+') {
+		struct argv_array get_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&get_rev_args, "get-rev-name",
+				 path, oid_to_hex(oid), NULL);
+		get_rev_name(get_rev_args.argc, get_rev_args.argv,
+			     info->prefix);

since you're not really subprocessing, can't you simply have a

  do_print_rev_name(char *path, char *sha) {
     ..
     printf("\n");
  }

and call that directly? Or call compute_rev_name directly. Then you
don't have to do argv setup here.

Also, the name get_rev_name() is a little unfortunate, since it
doesn't return a name, but rather prints it. Maybe the functions
implementing helper commands could be named like:

  command_get_rev_name

or similar.
