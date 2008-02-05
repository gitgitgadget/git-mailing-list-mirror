From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-commit: support variable number of hook arguments
Date: Mon, 04 Feb 2008 19:09:34 -0800
Message-ID: <7vejbsgkup.fsf@gitster.siamese.dyndns.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
	<2885c7896ba72adee6bc5c9e2210a8881904f601.1200933409.git.bonzini@gnu.org>
	<alpine.LSU.1.00.0802041637460.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 04:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMECR-0000gV-FX
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 04:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYBEDJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 22:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYBEDJr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 22:09:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYBEDJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 22:09:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BBE0240AF;
	Mon,  4 Feb 2008 22:09:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 237ED40AE;
	Mon,  4 Feb 2008 22:09:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72616>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 21 Jan 2008, Paolo Bonzini wrote:
>
>> +static int run_hook(const char *index_file, const char *name, ...)
>> +{
>> +	struct child_process hook;
>> +	const char *argv[10], *env[2];
>> +	char index[PATH_MAX];
>> +	va_list args;
>> +	int i;
>> +
>> +	va_start(args, name);
>> +	argv[0] = git_path("hooks/%s", name);
>> +	i = 0;
>> +	do {
>
> Here, an
>
> 		if (++i >= ARRAY_SIZE(argv))
> 			die ("run_hook(): too many arguments");
>
> is missing.  Even nicer, you could have
>
> 	int argc = 1;
> 	char **argv = malloc(sizeof(*argv) * 2);
>
> and
>
> 		if (++i >= argc)
> 			argc = ALLOC_GROW(argv, i + 1, argc);

The sanity check to make sure we do not feed too many is
definitely needed.  For this application I think ALLOC_GROW() is
overkill, as we do not pass unbound number of arguments to the
hook.
