Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BB31F859
	for <e@80x24.org>; Thu, 28 Jul 2016 10:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbcG1Kic (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 06:38:32 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:39946 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755929AbcG1Ki2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 06:38:28 -0400
Received: (qmail 18780 invoked from network); 28 Jul 2016 10:38:25 -0000
Received: (qmail 28797 invoked from network); 28 Jul 2016 10:38:25 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 28 Jul 2016 10:38:23 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1469702302.1884.8.camel@sapo.pt>
Subject: Re: [PATCH] i18n: config: unfold error messages marked for
 translation
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>
Date:	Thu, 28 Jul 2016 10:38:22 +0000
In-Reply-To: <xmqqy44mvol9.fsf@gitster.mtv.corp.google.com>
References: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
	 <xmqqy44mvol9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.4 (3.20.4-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Qua, 27-07-2016 às 13:00 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > +
> > +	switch (cf->origin_type) {
> > +	case CONFIG_ORIGIN_BLOB:
> > +		error_msg = xstrfmt(_("bad config line %d in blob
> > %s"),
> > +				      cf->linenr, cf->name);
> > +		break;
> > +	case CONFIG_ORIGIN_FILE:
> > +		error_msg = xstrfmt(_("bad config line %d in file
> > %s"),
> > +				      cf->linenr, cf->name);
> > +		break;
> 
> Hmm, if we were to switch the message based on the origin type, then
> things like this:
> 
> > 
> > +	case CONFIG_ORIGIN_STDIN:
> > +		error_msg = xstrfmt(_("bad config line %d in
> > standard input %s"),
> > +				      cf->linenr, cf->name);
> > +		break;
> 
> and this:
> 
> > 
> > +	case CONFIG_ORIGIN_STDIN:
> > +		die(errno == ERANGE
> > +		    ? _("bad numeric config value '%s' for '%s' in
> > standard input %s: out of range")
> > +		    : _("bad numeric config value '%s' for '%s' in
> > standard input %s: invalid unit"),
> > +		    value, name, cf->name);
> 
> that does not have any useful cf->name can be improved even more, no?
> 
> The only reason why we pass an empty string here:
> 
> > 
> >  static int git_config_from_stdin(config_fn_t fn, void *data)
> >  {
> > -	return do_config_from_file(fn, "standard input", "", NULL,
> > stdin, data);
> > +	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "",
> > NULL, stdin, data);
> >  }
> 
> is because do_config_from_file() function whose primary purpose is
> to read from file was reused, the interface to that function
> requires the filename there for reporting, and we do not have
> anything useful when reading from the standard input.

Probably that is why I have omitted cf->name for CONFIG_ORIGIN_STDIN
instance first time I sent this patch [1]. This patch was dropped from
previous i18n batch because it conflicted with other changes in flux.
Forgot about that and, for no good reason, added cf->name.
Thank you for pointing out.

[1] http://www.mail-archive.com/git%40vger.kernel.org/msg96368.html
