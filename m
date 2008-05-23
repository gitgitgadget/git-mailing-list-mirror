From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] git-init: inform user of `git --bare init' option
Date: Thu, 22 May 2008 23:02:59 -0700
Message-ID: <7vy761sgks.fsf@gitster.siamese.dyndns.org>
References: <20080519175313.GA17305@bit.office.eurotux.com>
 <20080520194850.GB19226@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri May 23 08:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzQNu-0001jA-6S
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 08:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYEWGDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 02:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYEWGDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 02:03:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbYEWGDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 02:03:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F05313C49;
	Fri, 23 May 2008 02:03:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 326EE3C48; Fri, 23 May 2008 02:03:07 -0400 (EDT)
In-Reply-To: <20080520194850.GB19226@bit.office.eurotux.com> (Luciano Rocha's
 message of "Tue, 20 May 2008 20:48:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECD2C982-288D-11DD-8EA8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82682>

Luciano Rocha <luciano@eurotux.com> writes:

> Creation of a bare repository isn't consistent:
>
> $ git init --bare
> usage: git-init [-q | --quiet] [--template=<template-directory>] [--shared]
> $ git --bare init
> Initialized empty Git repository in ...

The examples do not demonstrate that "it isn't consistent".  It just
demonstrates that it is easy for people to forget that --bare option is an
option to the "git" potty itself and not an option to "git init".

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index a76f5d3..65454b1 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -334,6 +334,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  			template_dir = arg+11;
>  		else if (!strcmp(arg, "--shared"))
>  			shared_repository = PERM_GROUP;
> +		else if (!strcmp(arg, "--bare"))
> +			die("Run `git --bare init' instead to create a bare repository");
>  		else if (!prefixcmp(arg, "--shared="))
>  			shared_repository = git_config_perm("arg", arg+9);
>  		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))

Given that you are adding a special case support for "git init --bare"
anyway, a better approach to help people out of this easy confusion (and
we have to admit that the confusion is very easy!) would be to make "git
init --bare" pretend/behave as if the user said "git --bare init", don't
you think?
