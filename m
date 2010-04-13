From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC/PATCH v2 1/4] output: Add a new library for plumbing
 output
Date: Tue, 13 Apr 2010 12:43:51 +0300
Message-ID: <20100413094351.GA2558@LK-Perkele-V2.elisa-laajakaista.fi>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <20100411232118.67460.52907.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cfv-0006ye-Os
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab0DMJot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:44:49 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:35214 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab0DMJos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:44:48 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 7B69213B7A0;
	Tue, 13 Apr 2010 12:44:47 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A06AE1507F1; Tue, 13 Apr 2010 12:44:47 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3DB3927D95;
	Tue, 13 Apr 2010 12:44:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100411232118.67460.52907.julian@quantumfyre.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144803>

On Mon, Apr 12, 2010 at 12:21:14AM +0100, Julian Phillips wrote:

I'm writing S-Expression output backend as experiment (not yet even sendable
as WIP) and hit an issue in general framework...

Also, some comments on documentation...

> +The output consists of objects, arrays and the actual values, the term item is
> +used where any of these may be used, and container when either an object or
> +array may be used.  Objects are unordered collections of named items, and arrays
> +are ordered collections of unnamed items.  For simplicity a name is always
> +supplied when creating an item - though it may not always be used (e.g. if you
> +are adding the item to a list).

List? Above says types are 'object', 'array' and 'value'. Then it defines
terms 'item' and 'container'. But what is 'list'?

> +* Unstructured Output Functions

Maybe add extra note about these. When one sees output_token used in code
outputting stuff, one can get puzzled until one realizes that token output
is ignored for non normal/zero outputs.

> diff --git a/output.c b/output.c
> new file mode 100644
> index 0000000..ac8feb1
> --- /dev/null
> +++ b/output.c

> +void output_end(struct output_context *context)
> +{
> +	while(context->current)
> +		output_end_current(context);
> +
> +	/*
> +	 * OUTPUT_NORMAL and OUTPUT_ZERO are special cases - the output format
> +	 * is _already_ defined so we have to stick to the rules, we can't add
> +	 * _anything_
> +	 */
> +	if (context->style > OUTPUT_ZERO)
> +		fprintf(context->file, "\n");

This is AFAIK really inapporiate for canonical S-Expression output. Point of
canonical S-Expressions is to have only one way to serialize given tree (bit
for bit identicality) and linefeeds are not allowed except as serialization
of linefeed in string.

Perhaps one could add method/flag to output backend to tell wheither to
print trailing linefeed?

> +
> +	free(context);
> +}

-Ilari
