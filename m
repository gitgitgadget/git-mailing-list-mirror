From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Fri, 29 Apr 2011 17:12:44 +0200
Message-ID: <4DBAD56C.8020804@drmicha.warpmail.net>
References: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 29 17:12:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFpNE-0005Xx-F8
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 17:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab1D2PMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 11:12:47 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44675 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897Ab1D2PMq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 11:12:46 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2C69A203BC
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 11:12:46 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 29 Apr 2011 11:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=f9AuXWr7x3Us4x33GXlhbPHfVHQ=; b=SVDsu0u3MHjGE3me3HojWiRZQ/pu9kZoYGmqhEUmzmlJC04BIoWV7ZJg35LZ7eNLpsjw8f4vN/4bbk0MwHqPAgS3Uv21GYJk9XhtocoPDFgrmAzS/D7Tnuckq7GkN7y9oVzZzYHHZxc+aup5dVqeSJI83vtXEzjeWit3HjSnKGk=
X-Sasl-enc: G7+pU052hb70XPp0d2OIfm27l7JsO2hpE62yK2pXYtYY 1304089965
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 93692440E69
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 11:12:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172457>

Michael J Gruber venit, vidit, dixit 29.04.2011 16:57:
> Often one is interested in the full --stat output only for commits which
> change a few files, but not others, because larger restructuring gives a
> --stat which fills a few screens.
> 
> Introduce a new option --stat-lines=<lines> which limits the --stat output
> to the first and last <lines> lines, separated by a "..." line. It can
> also be given as the third parameter in
> --stat=<width>,<name-width>,<lines>.
> 
> Also, the unstuck form is supported analogous to the other two stat
> parameters.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I would even consider a default of 10 (i.e. show a 20 line stat in full,
> abbreviate larger ones) to be sensible but have refrained from such a
> behaviour change.
> 
> We have hardcoded defaults for width (80) and name-width (50), so having
> one for lines should be okay also. Can I has tis wiz default? ;)
> ---
>  Documentation/diff-options.txt |    5 ++++-
>  diff.c                         |   25 +++++++++++++++++++++++--
>  diff.h                         |    1 +
>  3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 34f0145..e0429b3 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -48,11 +48,14 @@ endif::git-format-patch[]
>  --patience::
>  	Generate a diff using the "patience diff" algorithm.
>  
> ---stat[=<width>[,<name-width>]]::
> +--stat[=<width>[,<name-width>[,<lines>]]]::
>  	Generate a diffstat.  You can override the default
>  	output width for 80-column terminal by `--stat=<width>`.
>  	The width of the filename part can be controlled by
>  	giving another width to it separated by a comma.
> +	By giving a third parameter `<lines>`, you can limit the
> +	output to the first and last `<lines>` lines, separated by
> +	`...`.
>  
>  --numstat::
>  	Similar to `\--stat`, but shows number of added and
> diff --git a/diff.c b/diff.c
> index feced34..9ccba1e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1244,7 +1244,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	int i, len, add, del, adds = 0, dels = 0;
>  	uintmax_t max_change = 0, max_len = 0;
>  	int total_files = data->nr;
> -	int width, name_width;
> +	int width, name_width, lines;
>  	const char *reset, *add_c, *del_c;
>  	const char *line_prefix = "";
>  	struct strbuf *msg = NULL;
> @@ -1259,6 +1259,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  
>  	width = options->stat_width ? options->stat_width : 80;
>  	name_width = options->stat_name_width ? options->stat_name_width : 50;
> +	lines = options->stat_lines;
>  
>  	/* Sanity: give at least 5 columns to the graph,
>  	 * but leave at least 10 columns for the name.
> @@ -1303,6 +1304,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		width = max_change;
>  
>  	for (i = 0; i < data->nr; i++) {
> +		if (lines && i >= lines && i < data->nr-lines) {
> +			fprintf(options->file, "%s ...\n", line_prefix);
> +			i = data->nr-lines-1;
> +			lines = 0; /* no need to recheck */
> +			continue;
> +		}

One could/should do the same limitting for the earlier loop which
computes the maximal line width (since the largest file names may be
skipped now). I'll leave this for a v2 which I'm sure will be necessary :)

Michael
