From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] cvsimport.txt: document the mapping between config
 and options
Date: Tue, 30 Nov 2010 08:56:57 +0100
Message-ID: <4CF4AE49.7090406@drmicha.warpmail.net>
References: <4CF2ADC9.8020504@drmicha.warpmail.net> <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net> <7v7hfv3mli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 08:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNL7M-0001Wd-7u
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 08:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab0K3H7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 02:59:11 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42333 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754117Ab0K3H7K (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 02:59:10 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D0503644;
	Tue, 30 Nov 2010 02:59:09 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 30 Nov 2010 02:59:09 -0500
X-Sasl-enc: avOn8SMcxrVJ0oZ9fsqAWoXOLuKlMMx8cF3GoDvmW7GE 1291103949
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 515E9403CB2;
	Tue, 30 Nov 2010 02:59:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7v7hfv3mli.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162473>

Junio C Hamano venit, vidit, dixit 29.11.2010 21:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/git-cvsimport.txt |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
>> index 608cd63..b5d5b27 100644
>> --- a/Documentation/git-cvsimport.txt
>> +++ b/Documentation/git-cvsimport.txt
>> @@ -176,6 +176,13 @@ messages, bug-tracking systems, email archives, and the like.
>>  -h::
>>  	Print a short usage message and exit.
>>  
>> +CONFIG
>> +------
>> +For any option '-x' you can set the config variable 'cvsimport.x' to the value
>> +you would specify for '-x', or to 'true' for a boolean option. For an
>> +uppercase option '-X' use the config variable 'cvsimport.xx' (or
>> +'cvsimport.XX').
>> +
> 
> I still think this is not about fixing "parsing" as 2/3 states but about
> "working around the initial design flaw of how configuration variables are
> used in cvsimport" in that the initial design didn't take it into account
> that the last component of a configuration variable is case insensitive.

I don't care too much about the naming. But if I specify a correct
string value for "cvsimport.r" (correct as in correct for "-r", lower
case!) and "git cvsimport" gives me

fatal: bad config value for 'cvsimport.r' in .git/config

then I call this a bug, notwithstanding the fact that cvsimport does use
the value from cvsimport.r for "-r" and continues its operation.

This occurs really without even any attempt at specfiying values for
upper case options.

> While mapping -X to .xx may be a usable workaround, it looks really ugly.
> Worse, if we are going to give long command line options to the command
> someday, we will really regret it doing it the way your patch does.
> 
> Would it be a better alternative to give conflicting but rarely used
> uppercase options longer option name synonyms, and have them specified in
> the gitconfig file in their full names?  Then we can disambiguate with
> something like
> 
>     [cvsimport]
>     	generate-cvs-revisions = yes
>         remote = origin
> 
> which would be more readable, no?
> 

Well, cvsimport does not have any long options now, and given the fact
that most cvsimport related activity lately has been on documenting its
shortcomings and promoting cvs2git, I consider that scenario highly
unlikely. (I'm not hooked on cvsimport - it's simply the only
*incremental* cvs-to-git importer that I know of, and the only one not
requiring local access.)

How about using a naming scheme like:

[cvsimport]
	r = origin
	capital-r = yes

This would be safe against any possible future long-options, quickly
implementable, and we would not have to invent long names now for the
existing one-letter options (and thus hindering any future attempts
also). Whether this is more or less ugly lies in the eye of the
s/beholder/maintainer/ :)

Michael
