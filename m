From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Approxidate with YYYY.MM
Date: Tue, 10 May 2011 09:40:08 +0200
Organization: terreActive AG
Message-ID: <4DC8EBD8.50707@terreactive.ch>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com> <4DC8DCC2.8050208@drmicha.warpmail.net> <964517.31047.1305010481774.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 10 09:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJhYT-0001DQ-PT
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 09:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab1EJHkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 03:40:24 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:55503 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab1EJHkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 03:40:23 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <964517.31047.1305010481774.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173319>

On 05/10/2011 08:54 AM, Andreas Ericsson wrote:
> On 05/10/2011 08:35 AM, Michael J Gruber wrote:
>> Brian Gernhardt venit, vidit, dixit 09.05.2011 21:02:
>>> (This is in response to a discussion on #parrot.)
>>>
>>> Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form
>>> YYYY.MM for their monthly releases.  When we were attempting to find
>>> the cause of a slowdown, somewhat was trying to find what commits
>>> occurred after the 2011.01 release with "git log --after=2011.01".
>>> His mistake was pointed out but this led to the confusion of why this
>>> was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't
>>> date.c:match_multi_number() parse something with only two numbers as
>>> a beginning of month instead of allowing it to pass through to the
>>> generic parsing?
>>
>> I just don't think there is a format like that. There is dd.mm.[yy]yy
>> and apparently also yyyy.mm.dd, but without leading zeros in mm for the
>> latter. Our date parser also takes "." for a space so that you don't
>> need to quote a space ("1.day.ago"). I can see the logic behind parsing
>> 2011.01 as January 2011, but it's a stretch from the existing formats:
>>
> 
> It would be far more logical to parse "2011-01" as "January 2011" as
> that's the preferred way to write month-precision dates in most
> countries that use both the metric system and the gregorian calender.
> 
> I've never seen that date-type with dot as a separator, but with the
> dash it's very, very common.

Seconded. ISO dates are getting pretty common, and in the extended
format hyphens are the default separator between year, month, and date
<https://secure.wikimedia.org/wikipedia/en/wiki/ISO_8601#Calendar_dates>.

A few notes on support:

GNU `date` 8.5 parses some ISO date strings correctly:
$ date --date='2001-02-03' +%Y-%m-%d\ %H:%M:%S
2001-02-03 00:00:00
$ date --date='2001-02-03 04:05:06' +%Y-%m-%d\ %H:%M:%S
2001-02-03 04:05:06

Unfortunately, it doesn't handle partial dates:
$ date --date='2001-02' +%Y-%m-%d\ %H:%M:%S
date: invalid date `2001-02'

But it does handle HH:MM:
$ date --date='04:05' +%Y-%m-%d\ %H:%M:%S
2011-05-10 04:05:00

Basic format dates are sometimes parsed correctly:
$ date --date='20010203' +%Y-%m-%d\ %H:%M:%S
2001-02-03 00:00:00

But not with seconds:
$ date --date='20010203040506' +%Y-%m-%d\ %H:%M:%S
2001020304-05-06 00:00:00

The W3C recommends the use of ISO dates:
<http://www.w3.org/QA/Tips/iso-date>, and their standards, like XML,
typically support only ISO dates (or a subset thereof).

Cheers,
Victor Engmark
