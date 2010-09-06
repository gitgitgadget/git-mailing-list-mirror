From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Mon, 6 Sep 2010 12:23:57 +0200
Message-ID: <201009061223.59090.jnareb@gmail.com>
References: <1283708940-2172-1-git-send-email-pascal@obry.net> <m3lj7fn9oy.fsf@localhost.localdomain> <7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 12:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsYra-0003jm-DO
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 12:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab0IFKXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 06:23:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46071 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0IFKXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 06:23:37 -0400
Received: by fxm13 with SMTP id 13so2375037fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lHEhER5g7XI/Ur8SohuwBR9nx9lTbrLuozhGd+A3BGM=;
        b=gEj3hMSIs9l2lOjTQJm9Rzinx7hz3I9dapA6hMDsiu7DzIWA56UnXk2OybbiM7DEg/
         roQQq7CFvJ3ptribU/5jjEH5SBy1ibyrMIT3IutqKQNTQZbfscwM3QcYq1NSj2appx1l
         7tG64t0Nk6B79j+hJAorINepBITLYQYmJkIBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=I05DWfEpR5Urq9upqdP7adl6BfUUETbA7UbYobKp3stBTlIDBWGblxMpJCtORd4pNi
         2pn0l1LW+WSUf1H7KRF0SMOJk8SLMpiTRRTL69LJXGz/EONaEBqNXP1IIEjuRYap4ZTt
         u7b4eaL81HKLdQNd0f1zFkId9X28xLCm3eZQo=
Received: by 10.223.118.11 with SMTP id t11mr2678571faq.51.1283768615943;
        Mon, 06 Sep 2010 03:23:35 -0700 (PDT)
Received: from [192.168.1.13] (abwo37.neoplus.adsl.tpnet.pl [83.8.238.37])
        by mx.google.com with ESMTPS id 19sm2283953fas.1.2010.09.06.03.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 03:23:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155549>

On Mon, 6 Sep 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Pascal Obry <pascal@obry.net> writes:

>>> ---
>>>  Documentation/git-send-email.txt |    8 ++++++++
>>>  git-send-email.perl              |    8 +++++++-
>>>  2 files changed, 15 insertions(+), 1 deletions(-)
>>
>> Needs update to Documentation/config.txt, adding line about
>> sendemail.smtpserveroption.
> 
> And test if it is easy to arrange (otherwise I'll take a look myself, so
> do not worry too much about it).

Actually because *all* options use the same mechanism (%config_settings
which is used in read_config, and GetOptions from Getopt::Long), it would
be better to just test the mechanism, I think.

But that is outside the scope of this patch... and probably require
moving (some of) functionality to Git.pm
 
>>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>>> index c283084..5af05bc 100644
>>> --- a/Documentation/git-send-email.txt
>>> +++ b/Documentation/git-send-email.txt
>>> @@ -157,6 +157,14 @@ user is prompted for a password while the input is masked for privacy.
>>>  	`/usr/lib/sendmail` if such program is available, or
>>>  	`localhost` otherwise.
>>>  
>>> +--smtp-server-option=<option>::
>>> +	If set, specifies the outgoing SMTP server option to use.
>>> +	Default value can be specified by the 'sendemail.smtpserveroption'
>>> +	configuration option.
>>> ++
>>> +The --smtp-server-option option must be repeated for each option you want
>>> +to pass to the server.
>>
>> Just a nitpick.
>>
>> How do multiple options are supported with sendemail.smtpserveroption?
>> This also needs to be described, I think.
> 
> That is a good and important point.
> 
> We could
> 
> 	[sendemail]
>         	smtpserveroption = opt1
>         	smtpserveroption = opt2
> 

We do it this way, the same as for 'sendemail.to'... though I admit
that it is much more natural for 'sendemail.to' than for 
'sendemail.smtpServerOption'.
                
> or if we choose to split at WS
> 
> 	[sendemail]
>         	smtpserveroption = "opt1 opt2"
> 
> but with the second form there always is this nagging "how would you
> specify an option with WS in it" issue, so the former might be easier.

Yes, there would be a problem with something like this:

  	[sendemail]
          	smtpserveroption = "opt1 'opt2_a opt2_b'"

We could use extract_delimited or extract_quotelike, or just a regexp
generated using gen_delimited_pat from Text::Balanced.  Or better use
shellwords from Text::ParseWords

Text::ParseWords is in Perl core since Perl 5... which is I think good
enough for Git.


If we go this route we should probably provide shellwords / shellsplit /
/ split_sq also for C.

> 
> 
> If we take the latter route, we should take a single command line option
> and split it, i.e. --smtp-server-option='opt1 opt2', using the same WS
> quoting mechanism, for consistency between command line and configuration.

Right.

> I dunno.  Have we solved a similar issue with other parts of the system,
> and how?
> 
>>> @@ -1015,6 +1019,8 @@ X-Mailer: git-send-email $gitversion
>>>  		}
>>>  	}
>>>  
>>> +	unshift (@sendmail_parameters, @smtp_server_options);
>>> +
>>
>> I guess that you are following strange style that other 'unshift'
>> invocation uses, but there should be no space between function and
>> opening parentheses beginning its arguments, e.g.
>>
>>   join("\n", @xh)
>>
>> not
>>
>>   join ("\n", @xh)
> 
> I tend to prefer shift/unshift/push/pop written without these
> parentheses.  Is it just me?

The Perl-ish way is to avoid parentheses for built-in functions with
prototypes, such as shift/unshift/join.  But consistency trumps this
rule, I think (till the cleanup :-))

-- 
Jakub Narebski
Poland
