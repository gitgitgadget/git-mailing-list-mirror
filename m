From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Mon, 04 Nov 2013 11:12:04 -0800
Message-ID: <xmqqfvrcyoaj.fsf@gitster.dls.corp.google.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 04 20:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdPZa-00040G-U1
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 20:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab3KDTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 14:12:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab3KDTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 14:12:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E86514ECA8;
	Mon,  4 Nov 2013 14:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nCFGUMmzMLvzR+KjKG4Y5F2W6lI=; b=rDBQMq
	2Z7Wu7FcxNpmJE/lq04M43yvxGMTx9GUlLPwS1vpMIp6p03LtYeyVPxUCF3diZcQ
	P/KyH9bp8PtOItEw1rh/Ki3MegcnsxoOrWL5L7hvz7Ul1k+c7vRYxulJ03XkChsz
	cBzm+SSrQPl9QRE3BpJlhKuUIZLzGM67RpH80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnAOtFtjEEQcgP8ohShfWByKMuU+HycJ
	EtW4REZ5kdXJd30obxqpo3FhopcdIToqtgWU5ipVhm2izRKfmy7VqHoDAUJgF3j7
	tmjR38xhHfnKSai9ps0UFPzysp/FJCg1BHEDZp0ow+AO4bseNCsXyuqPhAPDOtzY
	cAG/WFEBaPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9D294ECA6;
	Mon,  4 Nov 2013 14:12:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F00934EC99;
	Mon,  4 Nov 2013 14:12:18 -0500 (EST)
In-Reply-To: <CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
	(Johan Herland's message of "Mon, 4 Nov 2013 02:01:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0657C4BA-4585-11E3-8611-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237297>

Johan Herland <johan@herland.net> writes:

Thanks for looking this over.  I am mostly in agreement and will
elide the parts I do not have much to add.

>> This command should help with RFC 822 style headers, called
>> "trailers", that are found at the end of commit messages.
>
> As has been asked earlier in this discussion, we should probably
> specify explicitly what we _mean_ with "RFC822-style"
> headers/footers/trailers, and exactly how closely we follow the actual
> RFC... E.g. do we make use of the linebreaking rules? encoding
> handling? etc... We may want to take a more relaxed approach (after
> all, we're not including a complete RFC822/RFC2822 implementation),
> but we should at least state so, and possibly how/why we do so.

Indeed; especially I do not think we would want to do the 2822
contination lines, or 2047 MIME quoting, ever.

>> For a long time, these trailers have become a de facto standard
>> way to add helpful information into commit messages.

"helpful" is not the key aspect of these footers. They are added at
the end to introduce some structure into a free-form part of the
commit objects.

>> The following features are implemented:
>>         - the result is printed on stdout
>>         - the [<token[=value]>...] arguments are interpreted
>>         - a commit message passed using the "--infile=file" option is interpreted
>
> If the output is written to stdout, then why is not the input taken
> from stdin? Or vice versa: why not --outfile?

I'd say just make it a filter without --in/outfile ;-)

>> +{
>> +       char *end = strchr(arg, '=');
>> +       if (!end)
>> +               end = strchr(arg, ':');
>
> So both '=' (preferred) and ':' are accepted as field/value
> separators. That's ok for the command-line, I believe.

Why?

Sometimes you have to be loose from the beginning _if_ some existing
uses and established conventions make it easier for the users, but
if you do not have to start from being loose, it is almost always a
mistake to do so.  The above code just closed the door to use ":"
for some other useful purposes we may later discover, and will make
us regret for doing so.

> From the enum values, I assume that these declare the desired behavior
> when there are two (or more?) or the same footer (i.e. same "field
> name"). However, it's not (yet) obvious to me in which order they are
> processed. There are several opportunities for multiple instances of
> the same "field name":
>
>  - Two (or more) occurences in the infile
>  - Two (or more) occurences on the command line
>  - One occurence in the infile, and one of the command line

Also, there is a distinction between fields with the same field name
appearing twice and fields with the same field name and the same
field value appearing twice. Some headers do want to have them, some
do not. 
