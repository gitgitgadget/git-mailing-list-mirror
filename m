From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 11:10:40 +0100
Message-ID: <4D872420.8080501@viscovery.net>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com> <1300700704-22674-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c4Z-0005lX-Tn
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab1CUKKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:10:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46487 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1CUKKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:10:45 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q1c4O-000426-LZ; Mon, 21 Mar 2011 11:10:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 676421660F;
	Mon, 21 Mar 2011 11:10:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <1300700704-22674-2-git-send-email-bebarino@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169572>

Am 3/21/2011 10:45, schrieb Stephen Boyd:
> diff --git a/daemon.c b/daemon.c
> index 347fd0c..4c8346d 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -660,7 +660,7 @@ static void check_dead_children(void)
>  static char **cld_argv;
>  static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  {
> -	struct child_process cld = { 0 };
> +	struct child_process cld = { NULL };

IMO this change is not good.

The purpose of { 0} is not to initialize (only) the first member, but
rather to serve as a visual marker that says "We want the complete struct
zero-initialized".

> diff --git a/fast-import.c b/fast-import.c
> index d9f9a3f..65d65bf 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2939,7 +2939,7 @@ static void parse_ls(struct branch *b)
>  {
>  	const char *p;
>  	struct tree_entry *root = NULL;
> -	struct tree_entry leaf = {0};
> +	struct tree_entry leaf = {NULL};

Same here.

> diff --git a/imap-send.c b/imap-send.c
> index 71506a8..9adf4b9 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1069,7 +1069,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
>  
>  	if (srvc->tunnel) {
>  		const char *argv[] = { srvc->tunnel, NULL };
> -		struct child_process tunnel = {0};
> +		struct child_process tunnel = {NULL};

And here.

> diff --git a/transport.c b/transport.c
> index 0078660..f1c0781 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -192,7 +192,7 @@ static const char *rsync_url(const char *url)
>  static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
>  {
>  	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
> -	struct ref dummy = {0}, *tail = &dummy;
> +	struct ref dummy = {NULL}, *tail = &dummy;

And here.

-- Hannes
