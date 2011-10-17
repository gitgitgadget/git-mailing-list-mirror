From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove leading SP from $diff_class
Date: Tue, 18 Oct 2011 00:07:30 +0200
Message-ID: <201110180007.31008.jnareb@gmail.com>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com> <m38voj72xy.fsf@localhost.localdomain> <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvLU-0000qA-9C
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1JQWHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:07:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64910 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1JQWHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 18:07:38 -0400
Received: by eye27 with SMTP id 27so3424569eye.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jg5E/72p5XdM/IvtLTzLral3fht/XbyqgQ1oqzTbEm8=;
        b=I3VwTcn/oy7KEDhvYuCWmKbVu7prRqv2CqYbCH0k68jTERdihRggHRJ3ZR7eC1YsTb
         pTN1+4oYpTbA2lVu+Eww0Bl3XZhvJjl6IXL7AUKUYU7EYo/9bTflI9j32yzJF8NZKgy/
         iQnFtwP3NXOrVktWcXi7+X924+TiWKaUqmCxA=
Received: by 10.223.77.26 with SMTP id e26mr17560960fak.37.1318889257172;
        Mon, 17 Oct 2011 15:07:37 -0700 (PDT)
Received: from [192.168.1.13] (absh126.neoplus.adsl.tpnet.pl. [83.8.127.126])
        by mx.google.com with ESMTPS id a1sm25671151fab.4.2011.10.17.15.07.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 15:07:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183829>

On Mon, 17 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> By the way, it is common to either have following patches to be chain
>> reply to first patch, or better provide cover letter for patch series
>> and have all patches be reply to cover letter.
> 
> It may be a good discipline for 14 patch series, but it doesn't matter for
> something this small.

Well, cover letter for 2-patch series might be overkill, but having
patches in series connected e.g. chain-replied-to, or all replies to
first patch in series, is IMHO a good idea.

>>>  gitweb/gitweb.perl |   24 +++++++++++++-----------
>>>  1 files changed, 13 insertions(+), 11 deletions(-)
>>> 
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 85d64b2..095adda 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2235,28 +2235,30 @@ sub format_diff_line {
>>>  		# combined diff
>>>  		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
>>>  		if ($line =~ m/^\@{3}/) {
>>> -			$diff_class = " chunk_header";
>>> +			$diff_class = "chunk_header";
>>>  		} elsif ($line =~ m/^\\/) {
>>> -			$diff_class = " incomplete";
>>> +			$diff_class = "incomplete";
>>>  		} elsif ($prefix =~ tr/+/+/) {
>>> -			$diff_class = " add";
>>> +			$diff_class = "add";
>>>  		} elsif ($prefix =~ tr/-/-/) {
>>> -			$diff_class = " rem";
>>> +			$diff_class = "rem";
>>>  		}
>>
>> Hmmm... that reminds me: this if-elsif chain is a bit ugly, but would
>> be hard to replace without given ... when, I think.
> 
> I wasn't reading the existing context line, but now that you mention it,
> they are not just ugly but are borderline of being incorrect (e.g. it does
> not catch a broken hunk-header that begins with "@@@@" for a two-way
> merge).
> 
> Assuming that $from->{'href'} has all the parents (i.e. 2 for two-way
> merge), shouldn't the code be more like this?
> 
> 	# combined diff

Wouldn't that cover not only combined diff, but an "ordinary" diff as
well then (i.e. comment should change)?  I think that was the intent,
isn't it?

>       my $num_sign = @{$from->{'href'}} + 1;

$from->{'href'} is array reference only for combined diff (>= 2 parents).
For ordinary diff it is a scalar.

> 	my @cc_classifier = (
> 		  ["\@{$num_sign} ", "chunk_header"],

O.K.

Nb., it is "chunk_header", or "hunk_header"?

>                 ['\\', "incomplete"],

O.K.

>                 [" {$num_sign}", ""],

O.K.

>                 ["[+ ]{$num_sign}", "add"],
>                 ["[- ]{$num_sign}", "rem"],

It would be slightly different to what current code does.

Current code for combined diff uses "add" if there is at least one '+',
"rem" if there are no '+' and at least one '-', and context otherwise.


I wonder if with sufficiently evil merge we can have a line that is
added (changed) in some children, and removed in other, i.e. pluses
and minuses combined.

Nb. we can put regexp here, not only stringification of regexp.
i.e.

                  [qr/[+ ]{$num_sign}/, "add"],
                  [qr/[- ]{$num_sign}/, "rem"],


>         );
>         for my $cls (@cc_classifier) {
>                 if ($line =~ /^$cls->[0]$/) {
>                 	$diff_class = $cls->[1];
>                         last;
> 		}
> 	}

Nice trick.
 
> Also don't we want to use "context" or something for the css class for the
> context lines, instead of assuming that we won't want to paint it in any
> special color?

Right.  We use "diff" class without anything else for context, but probably
it would be better to state this explicitly.

-- 
Jakub Narebski
Poland
