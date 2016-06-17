Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8C52018A
	for <e@80x24.org>; Fri, 17 Jun 2016 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbcFQRmE (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:42:04 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:45340 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932288AbcFQRmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 13:42:03 -0400
Received: (qmail 20598 invoked from network); 17 Jun 2016 17:42:00 -0000
Received: (qmail 30032 invoked from network); 17 Jun 2016 17:42:00 -0000
Received: from unknown (HELO linux-omuo.localnet) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 17 Jun 2016 17:42:00 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Jiang Xin <worldhello.net@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 34/38] i18n: init-db: join message pieces
Date:	Fri, 17 Jun 2016 17:41:59 +0000
Message-ID: <1562644.BnkjqA6nsN@linux-omuo>
User-Agent: KMail/4.14.10 (Linux/4.1.21-14-default; KDE/4.14.18; x86_64; ; )
In-Reply-To: <1465304141-9392-5-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt> <1465304141-9392-5-git-send-email-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Terça, 7 de Junho de 2016 12:55:37 Vasco Almeida escreveu:
> Join message displayed during repository initialization in one entire
> sentence. That would improve translations since it's easier translate an
> entire sentence than translating each piece.
> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/init-db.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index b2d8d40..3a45f0b 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -397,13 +397,16 @@ int init_db(const char *template_dir, unsigned int
> flags) if (!(flags & INIT_DB_QUIET)) {
>  		int len = strlen(git_dir);
> 
> -		/* TRANSLATORS: The first '%s' is either "Reinitialized
> -		   existing" or "Initialized empty", the second " shared" or
> -		   "", and the last '%s%s' is the verbatim directory name. */
> -		printf(_("%s%s Git repository in %s%s\n"),
> -		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
> -		       get_shared_repository() ? _(" shared") : "",
> -		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +		if (reinit)
> +			printf(get_shared_repository()
> +			       ? _("Reinitialized existing shared Git repository in %s%s\n")
> +			       : _("Reinitialized existing Git repository in %s%s\n"),
> +			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +		else
> +			printf(get_shared_repository()
> +			       ? _("Initialized empty shared Git repository in %s%s\n")
> +			       : _("Initialized empty Git repository in %s%s\n"),
> +			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
>  	}
> 
>  	return 0;
This patch breaks test t0204-gettext-reencode-sanity.sh because those strings 
are used in Icelandic translation for checking gettext. Since the message id 
has changed, git outputs in English instead of Icelandic.

I must have forgot to check normal build (without GETTEXT_POISON enabled). I'm 
going to send a re-roll updating the Icelandic translation best I can or Ævar 
Arnfjörð Bjarmason could do it for me.
