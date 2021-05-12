Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E505AC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2BD611BF
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELH6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELH62 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:58:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F974C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:57:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so9688088otq.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=t+ukEblTbez5B4EBBYA7wRNZZ4j4VfMruUCPlcdmiVw=;
        b=ZlOdIbSpGqXmIx8tPmDJAONhec7tn6Zk3Cp7BapSA54ihHkiuJXjtDBddoahTmK/15
         BJ3GPtXJ3WRMWjs+9OEu6n9lEuVxMoCOQL47CShBBf3M3ahOlzUzmnuDuxNssT/3fHQd
         p9es58pSpYF4nwfK1orCs5tAWA/bV4f2xEQttzheB3lH5xq39MPuqLOByos18RHyZSoE
         FRUM2jzmSmr8cLpjoLoExYSlq536Ygm2E7wToEcM/Rz1ZkW8kvFzWWPbVv5DzuDW6+yL
         Iyc7fxCW0aXgey/A+cCCvpOmLErG9yLMeqB3AY8ODw7jmHN82QNVTg6+S67l/Jp/etP4
         j0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=t+ukEblTbez5B4EBBYA7wRNZZ4j4VfMruUCPlcdmiVw=;
        b=oaPU8+zD0ilQNk0zkRLJsq21sawqLVIMyLQS4j8p0KBsaafu6tQcT2gCgP5VSRoJuA
         +bbn/x5kMFETEzEhOjJSiUFfKqr6CZWGp0QC5Aov2kN0TZEVp8iPhyhWypMsFyTWDVg/
         TflX9+ZzjYelxyN24wKmOOB44De7YdJDp35+kSBH4DHVBIXitLv511UpI9wtu11vTg67
         U7JM2eXqKwa1oxexEQY8Sig3Kg6vyrNpajLmlfq13Oa8SM5MuNO/lWM9gRhHg7wtB63A
         bk1zHwUBgz+vn1jtfeHzjzc6NLNgVXwEdJMr7Vlm23ljrhrLw1IBlsaPTWwcmLRl4tMW
         iWUA==
X-Gm-Message-State: AOAM530coP/2iBXmG42ks7BEIkgz4Yin5bw2DcWF4d6J0pdehbJmF/3j
        gbl15x6YNoMTcYl5KCBRYYgpztpN2oM8rQ==
X-Google-Smtp-Source: ABdhPJwqpl6WHLAg+VhI0khgp6P02VyW1IGqaS+/HSEMhqSPyA1VzT1iSx70mSyLAWeyLJGzgU2/NQ==
X-Received: by 2002:a9d:51c7:: with SMTP id d7mr20938185oth.51.1620806238965;
        Wed, 12 May 2021 00:57:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p15sm4346231otl.23.2021.05.12.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:57:18 -0700 (PDT)
Date:   Wed, 12 May 2021 02:57:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>
Message-ID: <609b8a5a65826_6e0fc2084c@natae.notmuch>
In-Reply-To: <20210512033039.4022-1-greg@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
Subject: RE: [PATCH] git-send-email: add sendmailCommand option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -159,13 +159,23 @@ Sending
>  ~~~~~~~
>  
>  --envelope-sender=<address>::
> -	Specify the envelope sender used to send the emails.
> -	This is useful if your default address is not the address that is
> -	subscribed to a list. In order to use the 'From' address, set the
> -	value to "auto". If you use the sendmail binary, you must have
> -	suitable privileges for the -f parameter.  Default is the value of the
> -	`sendemail.envelopeSender` configuration variable; if that is
> -	unspecified, choosing the envelope sender is left to your MTA.
> +	Specify the envelope sender used to send the emails.  This is
> +	useful if your default address is not the address that is
> +	subscribed to a list. In order to use the 'From' address, set
> +	the value to "auto". If you use the sendmail binary, you must
> +	have suitable privileges for the -f parameter.  Default is the
> +	value of the `sendemail.envelopeSender` configuration variable;
> +	if that is unspecified, choosing the envelope sender is left to
> +	your MTA.

I'm not against these kinds of changes but it took me one minute to
figure out all you did was change the format.

This belongs in a separate patch.

> +--sendmail-cmd=<command>::

Oh no no no. Don't do shortcuts.

If you think --sendmail-command is too long, then address that problem
head on, don't try to hide it.

I do think it's too long, which is why I suggested --command (especially
since it's obvious which command we are talking about), but I wouldn't
suggest --sdm-command, or something of that sort. We have to own our
decisions.

  1. --command
  2. --sendmail
  3. --sendmail-command

We have to pick one. I suggest #1.

To try to make #3 shorter is just shoving the problem under the rug.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -70,6 +70,7 @@ sub usage {
>  
>    Sending:
>      --envelope-sender       <str>  * Email envelope sender.
> +    --sendmail-cmd          <str>  * Shell command to run to send email.
>      --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
>                                       is optional. Default 'localhost'.
>      --smtp-server-option    <str>  * Outgoing SMTP server option to use.
> @@ -252,6 +253,7 @@ sub do_edit {
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> +my ($sendmail_command);
>  # Variables with corresponding config settings & hardcoded defaults
>  my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
>  my $thread = 1;
> @@ -299,6 +301,7 @@ sub do_edit {
>      "assume8bitencoding" => \$auto_8bit_encoding,
>      "composeencoding" => \$compose_encoding,
>      "transferencoding" => \$target_xfer_encoding,
> +    "sendmailcommand" => \$sendmail_command,
>  );
>  
>  my %config_path_settings = (
> @@ -432,6 +435,7 @@ sub read_config {
>  		    "no-bcc" => \$no_bcc,
>  		    "chain-reply-to!" => \$chain_reply_to,
>  		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
> +		    "sendmail-cmd=s" => \$sendmail_command,

Isn't it interesting that to make the code readable you picked
$sendmail_command, but you don't want users to type so much, even if
it's more readable?

Once again: "$command=s" -> \$command,

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -57,7 +57,7 @@ test_no_confirm () {
>  		git send-email \
>  		--from="Example <from@example.com>" \
>  		--to=nobody@example.com \
> -		--smtp-server="$(pwd)/fake.sendmail" \
> +		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \

People are already using --smpt-server=$cmd, we need to keep testing
that.

Yes, eventually we would want them to move to --sendmail-cmd (or
--command, or whatever), but that won't happen tomorrow. Therefore our
primary tests need to be focused on --smtp-server.

We need new *additional* tests for --sendmail-cmd, but those should not
override the current tests. At least not right now.

Cheers.

-- 
Felipe Contreras
