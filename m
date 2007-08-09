From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 09 Aug 2007 02:01:08 -0700
Message-ID: <873aytnktn.fsf@hubert.paunchy.net>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	<1185851481271-git-send-email-eclesh@ucla.edu>
	<20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
	<87bqdhnotj.fsf@hubert.paunchy.net> <86r6mdp1e1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3tO-0006OD-VW
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764682AbXHIJBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764863AbXHIJBQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:01:16 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:46266 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763916AbXHIJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:01:15 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l79919vn026695;
	Thu, 9 Aug 2007 02:01:09 -0700
Received: from localhost (adsl-75-26-181-145.dsl.scrm01.sbcglobal.net [75.26.181.145])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l79919v3008882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Aug 2007 02:01:09 -0700
Received: by localhost (Postfix, from userid 1000)
	id 095011E80B6; Thu,  9 Aug 2007 02:01:08 -0700 (PDT)
In-Reply-To: <86r6mdp1e1.fsf@lola.quinscape.zz> (David Kastrup's message of "Thu\, 09 Aug 2007 10\:17\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55434>

David Kastrup <dak@gnu.org> writes:

>>>> +	shift
>>>> +	for x in "$@"; do
>>>> +		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then
>>>> +			echo "'$x' is not a valid guard name"
>>>> +		else
>>>> +			sed -i -e "s,^\($p[[:space:]]*.*\)$,\1 #$x," "$series"
>>>
>>> Out of curiosity, why printf and not echo?
>>>
>>
>> For guards named '-e' or other funky things echo doesn't like and
>> can't process with echo --.
>
> The problem with the above is that it reacts strangely to multiline
> options.
>

There shouldn't be multiline options passed to this function, so it
might not be a problem.

> Should be much better (and faster on shells without builtin printf) to
> use
>
> case "$x" in
>    [+-]*)
>      sed -i -e ...  ;;
>        *)
>      echo "'$x' is not ...
> esac
>
> and this runs portably without forking on shells that are 30 years
> old.  Shell script programmers _really_ should know "case" inside out.
>

Heh, as you may have noticed, I'm no shell programmer :-)  Thanks for
the advice though.

> Also, instead of 'for x in "$@"' one can just write "for x'
>

Nice.

>>> The regexp is in double quotes, so you should escape the $ (EOL),
>>> as well as all the \. Yep, this is shell scripting at its worst.
>
> \ does not need to be escaped in double quotes except before \, $ and `.
> You can write
>
>     sed -i -e "s,^\($p[[:space:]]*.*\)\$,\1 #$x," "$series"
>
> and that's fine.

Yeah.  That one made itself clear.  The sed -i needs to go too, as
Thomas observed.  The regexp itself also needs cleansing.

Lots of work to do...

	Eric
