From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git
 interpret-trailers'
Date: Fri, 25 Apr 2014 21:56:19 +0200 (CEST)
Message-ID: <20140425.215619.2296838250398594645.chriscool@tuxfamily.org>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
	<xmqqmwfv3433.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 25 21:56:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdmEW-0007hv-M5
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaDYT4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:56:24 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:60930 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaDYT4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:56:22 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 680213A;
	Fri, 25 Apr 2014 21:56:20 +0200 (CEST)
In-Reply-To: <xmqqmwfv3433.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247110>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> +Help add RFC 822-like headers, called 'trailers', at the end of the
>> +otherwise free-form part of a commit message.
> 
> I think it is somewhat misleading to use the word "headers" like
> that.  'trailers' look similar to RFC-822-headers but they come at
> the end.  The sentence however reads as if they are "headers" that
> look like RFC 822.  Perhaps shuffling words like so:
> 
> 	Help adding 'trailers' lines, that look similar to RFC 822
> 	e-mail headers, at the end of the ...
> 
> would make it less confusing.

Ok, I made this change in v11.

>> +Some configuration variables control the way the `token` arguments are
>> +applied to the message and the way any existing trailer in the message
>> +is changed. They also make it possible to automatically add some
>> +trailers.
>> +
>> +By default, a 'token=value' or 'token:value' argument will be added
>> +only if no trailer with the same (token, value) pair is already in the
>> +message. The 'token' and 'value' parts will be trimmed to remove
>> +starting and trailing whitespace, and the resulting trimmed 'token'
>> +and 'value' will appear in the message like this:
>> +
>> +------------------------------------------------
>> +token: value
>> +------------------------------------------------
> 
> Mental note: this does assume that the final output for the 'token'
> is to have a line <label> that is followed by a colon ":", SP and
> the value.
> 
> And the natural way to express that on the command line would be to
> say "token: value", I would think, but let's just read on.
> 
>> +Note that 'trailers' do not follow and are not intended to follow many
>> +rules that are in RFC 822. For example they do not follow the line
>> +breaking rules, the encoding rules and probably many other rules.
> 
> s/that are in RFC 822/for RFC 822 headers/.
> s/line breaking/line folding/. (see RFC 822, 3.1.1)

Ok, it's in v11 too.

>> +OPTIONS
>> +-------
>> +--trim-empty::
>> +	If the 'value' part of any trailer contains only whitespace,
>> +	the whole trailer will be removed from the resulting message.
>> +
>> +CONFIGURATION VARIABLES
>> +-----------------------
>> +
>> +trailer.<token>.key::
>> +	This 'key' will be used instead of 'token' in the
> 
> As `key` is something that is typed literally, it should be typeset
> as `key` in the descriptive text.

Ok, I used `key` in v11.

> I think other manpages spell the
> placeholder as `<token>` (or '<token>', I am not sure which...).

I found mostly <token>, so I used that in v11.

>> +	trailer. After some alphanumeric characters, it can contain
>> +	some non alphanumeric characters like ':', '=' or '#' that will
>> +	be used instead of ':' to separate the token from the value in
>> +	the trailer, though the default ':' is more standard.
> 
> I assume that this is for things like
> 
> 	bug #538
> 
> and the configuration would say something like:
> 
> 	[trailer "bug"]
>         	key = "bug #"
> 
> For completeness (of this example), the bog-standard s-o-b would
> look like
> 
> 	Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> 
> and the configuration for it that spell the redundant "key" would
> be:
> 
> 	[trailer "Signed-off-by"]
>         	key = "Signed-off-by: "

Yeah, but you can use the following instead:

 	[trailer "s-o-b"]
         	key = "Signed-off-by: "

The <token> and the key can be different.

> Am I reading the intention correctly?

Yeah, I think so.

> That is, when trailer.<token>.key is not defined, the value defaults
> to "<token>: " (with one SP after the label and colon),

Yes.

> and when it
> is defined, the value can come directly after it.

The value can come directly after the key, only if the key ends with '#'.

If it ends with something else, except spaces, one SP will be added
between the key and the value.

Yeah, I made '#' special in the hope that it would be more compatible
with GitHub and other services that might also use '#'.

Thanks,
Christian.
