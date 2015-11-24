From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] send-email: expand paths in sendemail.{to,cc}cmd
 config
Date: Tue, 24 Nov 2015 08:43:53 +0000
Message-ID: <20151124084353.GH21488@serenity.lan>
References: <cover.1447797487.git.john@keeping.me.uk>
 <db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
 <CAPig+cRY3W4VMgqnRuQFeMk7oueKsA=ZhMAk15LLyZg0KfVvCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 09:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a19O9-0006QB-S2
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 09:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbKXIzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 03:55:45 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:59339 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbKXIzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 03:55:43 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2015 03:55:43 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4B15F2304D;
	Tue, 24 Nov 2015 08:47:04 +0000 (GMT)
X-Quarantine-ID: <KXtvGp+VSx-y>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KXtvGp+VSx-y; Tue, 24 Nov 2015 08:47:03 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 8C9E023027;
	Tue, 24 Nov 2015 08:43:55 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPig+cRY3W4VMgqnRuQFeMk7oueKsA=ZhMAk15LLyZg0KfVvCA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281613>

On Mon, Nov 23, 2015 at 07:04:46PM -0500, Eric Sunshine wrote:
> On Tue, Nov 17, 2015 at 5:01 PM, John Keeping <john@keeping.me.uk> wrote:
> > These configuration variables specify the paths to commands so we should
> > support tilde-expansion for files inside a user's home directory.
> 
> Hmm, I don't see anything in the documentation which says that these
> are paths to commands, and the code itself treats them purely as
> commands to be invoked, not as paths to commands. What is the
> behavior, for instance, with --tocmd='foobar -x zopp' or even
> --tocmd='foobar -x ~/zopp'?

The path behaviour only expands leading '~' and '~user' (as documented
in git-config(1)):

	$ git -c sendemail.tocmd='foobar -x ~/zopp' config --path sendemail.tocmd
	foobar -x ~/zopp

> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 719c715..8e4c0e1 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -242,9 +242,7 @@ my %config_settings = (
> >      "smtpdomain" => \$smtp_domain,
> >      "smtpauth" => \$smtp_auth,
> >      "to" => \@initial_to,
> > -    "tocmd" => \$to_cmd,
> >      "cc" => \@initial_cc,
> > -    "cccmd" => \$cc_cmd,
> >      "aliasfiletype" => \$aliasfiletype,
> >      "bcc" => \@bcclist,
> >      "suppresscc" => \@suppress_cc,
> > @@ -259,6 +257,8 @@ my %config_settings = (
> >  my %config_path_settings = (
> >      "aliasesfile" => \@alias_files,
> >      "smtpsslcertpath" => \$smtp_ssl_cert_path,
> > +    "tocmd" => \$to_cmd,
> > +    "cccmd" => \$cc_cmd,
> >  );
