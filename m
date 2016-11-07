Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA3E2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbcKGQEi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 11:04:38 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:46382 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbcKGQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 11:04:37 -0500
Received: (qmail 30361 invoked from network); 7 Nov 2016 16:04:34 -0000
Received: (qmail 6826 invoked from network); 7 Nov 2016 16:04:34 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Nov 2016 16:04:34 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1478534673.29048.12.camel@sapo.pt>
Subject: Re: [PATCH v4 08/14] i18n: add--interactive: mark
 edit_hunk_manually message for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Date:   Mon, 07 Nov 2016 15:04:33 -0100
In-Reply-To: <20161010125449.7929-9-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
         <20161010125449.7929-9-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Seg, 10-10-2016 às 12:54 +0000, Vasco Almeida escreveu:
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 045b847..861f7b0 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1058,6 +1058,30 @@ sub color_diff {
>         } @_;
>  }
>  
> +my %edit_hunk_manually_modes = (
> +       stage => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for staging."),
> +       stash => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for stashing."),
> +       reset_head => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for unstaging."),
> +       reset_nothead => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for applying."),
> +       checkout_index => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for discarding"),
> +       checkout_head => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for discarding."),
> +       checkout_nothead => N__(
> +"# If the patch applies cleanly, the edited hunk will immediately be
> +# marked for applying."),
> +);
> +

I think marking strings comment with '#' for translation is not the
best thing because there is a change that a translator will miss to
comment a line. I will change this to mark only the text and then, at
run time, prefix comment chars to that text.

>  sub edit_hunk_manually {
>         my ($oldtext) = @_;
>  
> @@ -1065,22 +1089,21 @@ sub edit_hunk_manually {
>         my $fh;
>         open $fh, '>', $hunkfile
>                 or die sprintf(__("failed to open hunk edit file for
> writing: %s"), $!);
> -       print $fh "# Manual hunk edit mode -- see bottom for a quick
> guide\n";
> +       print $fh __("# Manual hunk edit mode -- see bottom for a
> quick guide\n");

Here too.

>         print $fh @$oldtext;
> -       my $participle = $patch_mode_flavour{PARTICIPLE};
>         my $is_reverse = $patch_mode_flavour{IS_REVERSE};
>         my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') :
> ('+', '-');
> -       print $fh <<EOF;
> -# ---
> -# To remove '$remove_minus' lines, make them ' ' lines (context).
> -# To remove '$remove_plus' lines, delete them.
> +       print $fh sprintf(__(
> +"# ---
> +# To remove '%s' lines, make them ' ' lines (context).
> +# To remove '%s' lines, delete them.
>  # Lines starting with # will be removed.
> -#
> -# If the patch applies cleanly, the edited hunk will immediately be
> -# marked for $participle. If it does not apply cleanly, you will be
> given
> +#\n"), $remove_minus, $remove_plus),
> +__($edit_hunk_manually_modes{$patch_mode}), __(
> +# TRANSLATORS: 'it' refers to the patch mentioned in the previous
> messages.
> +" If it does not apply cleanly, you will be given
>  # an opportunity to edit again. If all lines of the hunk are
> removed,
> -# then the edit is aborted and the hunk is left unchanged.
> -EOF
> +# then the edit is aborted and the hunk is left unchanged.\n");

And here too.
Currently this joins the two sentences/parts in the same line like so

# If the patch applies cleanly, the edited hunk will immediately be
# marked for staging. If it does not apply cleanly, you will be given
# an opportunity to edit again. If all lines of the hunk are removed,
# then the edit is aborted and the hunk is left unchanged.

But since the translator translates each sentence separately, it is
hard to align them properly to not make lines too long. Hence I am
considering to break each sentence to start on its own line.
