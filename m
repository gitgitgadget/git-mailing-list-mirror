Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D613520A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbdASTfr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:35:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52177 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754458AbdASTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:35:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B24886025C;
        Thu, 19 Jan 2017 14:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PR6ENO2CSmBYb+pJocHjR93KrWs=; b=pzcWv8
        O/nXF+PMhAHhkWlJOH3rNg5w6HPijou6fUZSQ8U5PsNEywjf6tlgF/F8DIAiphco
        Oe4CsmwaCN3SokjHqv50Otm2SyvW7BO1ZIFnh2RgBRkvLMtiVVVbmb3H50cNwu2E
        Wa6GBlijBe3nAafHeZuJRdLhihy/qxRaGtIqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=US1C1EzieGjB5gaY+D3PF4zwWVtpoeOt
        zEyMAOkjcbhu7WS0JKuaPY1WCwg7/uNtKr2McWskZnJ/LC18JGgbyV/51yTu7T1d
        X/0b3oq/CsMuohwrUJCkXZVRZdnBjlVJrR19g0N2ifuF2SRE/DZUR+ddXZvoWGRM
        hDGiYV0vIU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A81436025B;
        Thu, 19 Jan 2017 14:34:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 071A060259;
        Thu, 19 Jan 2017 14:34:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] log --graph: customize the graph lines with config log.graphColors
References: <20170109103258.25341-1-pclouds@gmail.com>
        <20170119114123.23784-1-pclouds@gmail.com>
        <20170119114123.23784-4-pclouds@gmail.com>
        <20170119165127.6cxw64fjz7aevkq2@sigill.intra.peff.net>
        <xmqq1svy3nxi.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 19 Jan 2017 11:34:38 -0800
In-Reply-To: <xmqq1svy3nxi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 19 Jan 2017 10:27:37 -0800")
Message-ID: <xmqqd1fi269d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51C42B1A-DE7E-11E6-8BDF-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Since there's only one line that cares about the result of "colors",
>> maybe it would be less confusing to do:
>>
>>   if (!git_config_get-string("log.graphcolors", &string)) {
>> 	... parse, etc ...
>> 	graph_set_column_colors(colors.argv, colors.argc - 1);
>>   } else {
>> 	graph_set_column_colors(column_colors_ansi,
>> 	                        column_colors_ansi_max);
>>   }
>
> Yes, that would be much much less confusing.  By doing so, the cover
> letter can lose "pushing the limits of abuse", too ;-).

Will queue with a squashable change.

Thanks.

 graph.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/graph.c b/graph.c
index 822d40ae20..00aeee36d8 100644
--- a/graph.c
+++ b/graph.c
@@ -229,22 +229,20 @@ struct git_graph *graph_init(struct rev_info *opt)
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
 	if (!column_colors) {
-		struct argv_array ansi_colors = {
-			column_colors_ansi,
-			column_colors_ansi_max + 1
-		};
-		struct argv_array *colors = &ansi_colors;
 		char *string;
-
-		if (!git_config_get_string("log.graphcolors", &string)) {
+		if (git_config_get_string("log.graphcolors", &string)) {
+			/* not configured -- use default */
+			graph_set_column_colors(column_colors_ansi,
+						column_colors_ansi_max);
+		} else {
 			static struct argv_array custom_colors = ARGV_ARRAY_INIT;
 			argv_array_clear(&custom_colors);
 			parse_graph_colors_config(&custom_colors, string);
 			free(string);
-			colors = &custom_colors;
+			/* graph_set_column_colors takes a max-index, not a count */
+			graph_set_column_colors(custom_colors.argv,
+						custom_colors.argc - 1);
 		}
-		/* graph_set_column_colors takes a max-index, not a count */
-		graph_set_column_colors(colors->argv, colors->argc - 1);
 	}
 
 	graph->commit = NULL;
