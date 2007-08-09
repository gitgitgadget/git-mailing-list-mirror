From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 09 Aug 2007 00:34:48 -0700
Message-ID: <87bqdhnotj.fsf@hubert.paunchy.net>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	<1185851481271-git-send-email-eclesh@ucla.edu>
	<20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:35:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2Xv-0006jp-N8
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763858AbXHIHfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 03:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763987AbXHIHfA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:35:00 -0400
Received: from smtp-2.smtp.ucla.edu ([169.232.47.136]:35699 "EHLO
	smtp-2.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760029AbXHIHe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:34:59 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-2.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l797YpBV027009;
	Thu, 9 Aug 2007 00:34:51 -0700
Received: from localhost (adsl-75-26-181-145.dsl.scrm01.sbcglobal.net [75.26.181.145])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l797Yobq021143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Aug 2007 00:34:51 -0700
Received: by localhost (Postfix, from userid 1000)
	id A28CB1E80B6; Thu,  9 Aug 2007 00:34:48 -0700 (PDT)
In-Reply-To: <20070731040510.GD12918@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Tue\, 31 Jul 2007 00\:05\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.47.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55422>

[ I'm finally back to this.  Thanks for your comments. ]

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

[...]

>> +}
>> +
>> +# usage: set_guards <patch> <guards...>
>> +set_guards()
>> +{
>> +	p="$1"
>
> Again, be careful about namespace polution.
>

Can I use "local", or is it a bashism?  If not, use parentheses around
the function body?

>> +	shift
>> +	for x in "$@"; do
>> +		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then
>
> Out of curiosity, why printf and not echo?
>

For guards named '-e' or other funky things echo doesn't like and can't
process with echo --.

>> +			echo "'$x' is not a valid guard name"
>> +		else
>> +			sed -i -e "s,^\($p[[:space:]]*.*\)$,\1 #$x," "$series"
>
> The regexp is in double quotes, so you should escape the $ (EOL), as well as
> all the \. Yep, this is shell scripting at its worst.
>

Yikes.

[...]

I'm trying to clean the rest and get it ready again. This whole series
will definitely need to incubate for a while once there's a
reasonable-looking version, to make sure nothing goes crazy.  Hopefully
it ends up being useful somewhere!

	Eric
