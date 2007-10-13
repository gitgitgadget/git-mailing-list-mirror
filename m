From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 20:31:18 +0200
Message-ID: <47110EF6.7090108@op5.se>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <4710F47D.2070306@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Sat Oct 13 20:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igllu-00030d-Jx
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759496AbXJMSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbXJMSbX
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 14:31:23 -0400
Received: from mail.op5.se ([193.201.96.20]:46217 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756096AbXJMSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 14:31:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 00DE31730666;
	Sat, 13 Oct 2007 20:31:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZeImVgYdyd5; Sat, 13 Oct 2007 20:31:20 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id DF73D173065F;
	Sat, 13 Oct 2007 20:31:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4710F47D.2070306@gmx.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60752>

Jean-Luc Herren wrote:
> Hi!
> 
> I really like the idea of colorizing git add -i, especially the
> prompt.  Here are my two cents.
> 
> Wincent Colaiuta wrote:
>> +sub print_ansi_color($$;$) {
>> +    my $color = shift;
>> +    my $string = shift;
>> +    my $trailer = shift;
> 
> None of the other subs in this file have a prototype, so for
> consistency I'd suggest to not add it on this function either.
> However maybe a patch that adds it to all subs would be welcome.
> (I wouldn't see the necessity though.)
> 
> And the common way of getting the arguments is reading @_ (see all
> other subs in the file).  So maybe instead write:
> 
> [...]
> sub print_ansi_color {
> 	my ($color, $string, $trailer) = @_;
> [...]
> 
>> +    if ($use_color) {
>> +        printf '%s%s%s', Term::ANSIColor::color($color), $string,
>> +            Term::ANSIColor::color('clear');
>> +    } else {
> 
> Why use printf when you could directly use print here?  It's only
> used for concatenating.
> 
>> +    if ($trailer) {
>> +        print $trailer;
>> +    }
> 
> This will fail to print $trailer when $trailer happens to be a
> string that evaluates to false in bool context, like '0'.  Write
> this as:
> 
> 	if (defined $trailer) {
> 	    print $trailer;
> 	}
> 
> IMHO, parsing the output of 'git diff-files --color' is a very bad
> idea and it makes all regexes uglier and more difficult to read.
> You're much better off recolorizing it yourself, which makes it a
> more localized change.  Especially, I don't think that you have
> any guarantee that escape sequences won't ever contain the
> characters '+', '-' or ' ' (space), which would break your code on
> lines like this:
> 
>> +        if ($line =~ /^[^-+ ]*\+/) { 
> 
> Finally -- and this might be just my eyes -- blue is a very nice
> color, but it looks a bit too dark on black background.  Maybe
> choose a default color that looks reasonable on black *and* white
> background.
> 

Red for removed and green for added seems to be the standard, although
I know it makes life terribly difficult for red-green colorblind people,
who usually prefer yellow/lightblue for black bg, or beige/blue for
white background.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
