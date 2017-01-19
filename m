Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1DA20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbdASS1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:27:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753924AbdASS1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:27:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D5185EF60;
        Thu, 19 Jan 2017 13:27:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=98LqItOcL/Hz
        azeL7o78u6irwos=; b=N2iJoONP8mTGzE1oMie36tFog62+XOYybFpN3RXfbEnk
        xPQhUwrjsYD/Ql4wg0KawKXmOT7XbXwGBbQK8DlRdftQ2uG/RiK0mx2rOIfFlorN
        nUzdonq0++SDoVCCdj1E7HunE6VCd6S3ckaGqWy40fsqoK97+PfXtfpLVVq7VSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cbCpKS
        bGQqWUsCIiXP4CyZtTTymNwtq2gvZPzCV9a1/Z+Ma4igOn1e4CiL77ciZ4QSnW0H
        MHo90cfJsPM25UtPh1O5dct5d79KEuGe4J5jYQAHGMYv+G6rRQb4n27sYvKWXXoT
        3yjCuSLhISNydgXM2+nabajwGLQXcjhouDWQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 450295EF5F;
        Thu, 19 Jan 2017 13:27:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9020E5EF5B;
        Thu, 19 Jan 2017 13:27:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] log --graph: customize the graph lines with config log.graphColors
References: <20170109103258.25341-1-pclouds@gmail.com>
        <20170119114123.23784-1-pclouds@gmail.com>
        <20170119114123.23784-4-pclouds@gmail.com>
        <20170119165127.6cxw64fjz7aevkq2@sigill.intra.peff.net>
Date:   Thu, 19 Jan 2017 10:27:37 -0800
In-Reply-To: <20170119165127.6cxw64fjz7aevkq2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Jan 2017 11:51:27 -0500")
Message-ID: <xmqq1svy3nxi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4CDCBFE-DE74-11E6-B778-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 19, 2017 at 06:41:23PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> +static void parse_graph_colors_config(struct argv_array *colors, cons=
t char *string)
>> +{
>> +	const char *end, *start;
>> +
>> +	start =3D string;
>> +	end =3D string + strlen(string);
>> +	while (start < end) {
>> +		const char *comma =3D strchrnul(start, ',');
>> +		char color[COLOR_MAXLEN];
>> +
>> +		if (!color_parse_mem(start, comma - start, color))
>> +			argv_array_push(colors, color);
>> +		else
>> +			warning(_("ignore invalid color '%.*s' in log.graphColors"),
>> +				(int)(comma - start), start);
>> +		start =3D comma + 1;
>> +	}
>> +	argv_array_push(colors, GIT_COLOR_RESET);
>> +}
>
> This looks good.
>
>> @@ -207,9 +228,24 @@ struct git_graph *graph_init(struct rev_info *opt=
)
>>  {
>>  	struct git_graph *graph =3D xmalloc(sizeof(struct git_graph));
>> =20
>> -	if (!column_colors)
>> -		graph_set_column_colors(column_colors_ansi,
>> -					column_colors_ansi_max);
>> +	if (!column_colors) {
>> +		struct argv_array ansi_colors =3D {
>> +			column_colors_ansi,
>> +			column_colors_ansi_max + 1
>> +		};
>
> Hrm. At first I thought this would cause memory corrution, because your
> argv_array_clear() would try to free() the non-heap array you've stuffe=
d
> inside. But you only clear the custom_colors array which actually is
> dynamically allocated. This outer one is just here to give uniform
> access:
>
>> +		struct argv_array *colors =3D &ansi_colors;
>> +		char *string;
>> +
>> +		if (!git_config_get_string("log.graphcolors", &string)) {
>> +			static struct argv_array custom_colors =3D ARGV_ARRAY_INIT;
>> +			argv_array_clear(&custom_colors);
>> +			parse_graph_colors_config(&custom_colors, string);
>> +			free(string);
>> +			colors =3D &custom_colors;
>> +		}
>> +		/* graph_set_column_colors takes a max-index, not a count */
>> +		graph_set_column_colors(colors->argv, colors->argc - 1);
>> +	}
>
> Since there's only one line that cares about the result of "colors",
> maybe it would be less confusing to do:
>
>   if (!git_config_get-string("log.graphcolors", &string)) {
> 	... parse, etc ...
> 	graph_set_column_colors(colors.argv, colors.argc - 1);
>   } else {
> 	graph_set_column_colors(column_colors_ansi,
> 	                        column_colors_ansi_max);
>   }

Yes, that would be much much less confusing.  By doing so, the cover
letter can lose "pushing the limits of abuse", too ;-).


