From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory
 "foo"
Date: Fri, 01 Feb 2008 09:56:43 +0100
Message-ID: <47A2DECB.5040007@op5.se>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>	<47A06EF9.60704@users.sourceforge.net>	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>	<47A1733E.9040103@users.sourceforge.net>	<7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>	<7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>	<20080131094124.GA25546@coredump.intra.peff.net>	<7vfxwecmfe.fsf@gitster.siamese.dyndns.org>	<20080131104256.GF25546@coredump.intra.peff.net>	<alpine.LSU.1.00.0801311128190.23907@racer.site>	<6bc632150801310356w1b2fa019n87d92986aed807c5@mail.gmail.com> <7vr6fxbr5a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pradeep singh rautela <rautelap@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKrjc-00060x-6b
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 09:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbYBAI6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 03:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbYBAI6Y
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 03:58:24 -0500
Received: from mail.op5.se ([193.201.96.20]:58434 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbYBAI6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 03:58:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 67CB51F0801E;
	Fri,  1 Feb 2008 09:58:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.321
X-Spam-Level: 
X-Spam-Status: No, score=-4.321 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=-0.078, BAYES_00=-2.599,
	SUBJECT_FUZZY_TION=0.156]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GK5IVQqRcGpX; Fri,  1 Feb 2008 09:58:18 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.155])
	by mail.op5.se (Postfix) with ESMTP id 3951B1F0801D;
	Fri,  1 Feb 2008 09:58:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vr6fxbr5a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72158>

Junio C Hamano wrote:
> "pradeep singh rautela" <rautelap@gmail.com> writes:
> 
>> How about something like,
>>                   warning("Ignoring ignore entry because of trailing
>> slash: %s\n Remove the trailing slash from the directory name to
>> ignore it", string);
>> May be this will help absolute git newbies.
> 
> I am afraid that this is leading us in the wrong direction.
> 
> What would be the first reaction if somebody sees such a
> message?
> 
>     The message implies that the user said "foo/" which would be
>     ignored and the right substitution is "foo".  If that is the
>     right substitution, why doesn't the stupid "git" program do
>     that for the user automatically?!?!?!?!
> 
> See?
> 
> "Remove the trailing" suggestion assumes that we would want "foo/"
> and "foo" to mean the same thing.
> 
> Maybe we do, but we usually match both directory "foo/" and
> regular file "foo" when you say "foo", and we match only
> directory "foo/" when you say "foo/", as you saw in the ls-files
> example.
> 
> While I am not 100% convinced that we want to keep the
> distinction between these two forms, I am far from thinking that
> the existing distinction in other parts of the system is useless
> and should be removed.
> 
> Maybe we would want to drop this distinction in the gitignore
> entries, and the apparent inconsistency may not hurt in reality.
> If that is what we would want, that is fine, but then we
> shouldn't give a warning with a stupid piece of advice, but
> instead just do it ourselves.
> 
> Like this on top of 'master' (i.e. discarding all the previous
> patches), perhaps...
> 
> -- >8 --
> [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
> 
> A pattern "foo/" in the exclude list did not match directory
> "foo", but a pattern "foo" did.  This just strips the trailing
> slash from such input.
> 
> This makes the behaviour slightly inconsistent with that of
> pathspecs, where "foo/" only matches directory "foo" and not
> regular file "foo" and make "foo/" in the ignore list match
> regular file "foo" happily.  This may hopefully does not matter
> in practice.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitignore.txt        |    3 +++
>  dir.c                              |   22 ++++++++++++++++++----
>  t/t3001-ls-files-others-exclude.sh |   26 ++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 08373f5..081a4df 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -57,6 +57,9 @@ Patterns have the following format:
>     included again.  If a negated pattern matches, this will
>     override lower precedence patterns sources.
>  
> + - If the pattern ends with a slash,

that slash

> is removed for the
> +   purpose of the following description.
> +
>   - If the pattern does not contain a slash '/', git treats it as
>     a shell glob pattern and checks for a match against the
>     pathname without leading directories.

Otherwise it sounds as if the entire pattern is removed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
