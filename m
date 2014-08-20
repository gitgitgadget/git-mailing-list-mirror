From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v13 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Wed, 20 Aug 2014 18:05:12 -0400
Message-ID: <53F51B98.2060903@xiplink.com>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org> <20140816160622.18221.71416.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKE0N-0006vn-E9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 00:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbaHTWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 18:05:12 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:59312 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbaHTWFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 18:05:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 051958033B;
	Wed, 20 Aug 2014 18:05:09 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp16.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 93F2B80337;
	Wed, 20 Aug 2014 18:05:08 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Wed, 20 Aug 2014 22:05:09 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140816160622.18221.71416.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255591>

On 14-08-16 12:06 PM, Christian Couder wrote:
> While at it add git-interpret-trailers to "command-list.txt".
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-interpret-trailers.txt | 308 +++++++++++++++++++++++++++++++
>  command-list.txt                         |   1 +
>  2 files changed, 309 insertions(+)
>  create mode 100644 Documentation/git-interpret-trailers.txt
> 
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> new file mode 100644
> index 0000000..cf5b194
> --- /dev/null
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -0,0 +1,308 @@
> +git-interpret-trailers(1)
> +=========================
> +
> +NAME
> +----
> +git-interpret-trailers - help add stuctured information into commit messages
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git interpret-trailers' [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
> +
> +DESCRIPTION
> +-----------
> +Help adding 'trailers' lines, that look similar to RFC 822 e-mail
> +headers, at the end of the otherwise free-form part of a commit
> +message.
> +
> +This command reads some patches or commit messages from either the
> +<file> arguments or the standard input if no <file> is specified. Then
> +this command applies the arguments passed using the `--trailer`
> +option, if any, to the commit message part of each input file. The
> +result is emitted on the standard output.
> +
> +Some configuration variables control the way the `--trailer` arguments
> +are applied to each commit message and the way any existing trailer in
> +the commit message is changed. They also make it possible to
> +automatically add some trailers.
> +
> +By default, a '<token>=<value>' or '<token>:<value>' argument given
> +using `--trailer` will be appended after the existing trailers only if
> +the last trailer has a different (<token>, <value>) pair (or if there
> +is no existing trailer). The <token> and <value> parts will be trimmed
> +to remove starting and trailing whitespace, and the resulting trimmed
> +<token> and <value> will appear in the message like this:
> +
> +------------------------------------------------
> +token: value
> +------------------------------------------------
> +
> +This means that the trimmed <token> and <value> will be separated by
> +`': '` (one colon followed by one space).
> +
> +By default the new trailer will appear at the end of all the existing
> +trailers. If there is no existing trailer, the new trailer will appear
> +after the commit message part of the ouput, and, if there is no line
> +with only spaces at the end of the commit message part, one blank line
> +will be added before the new trailer.
> +
> +The trailers are recognized in the input message using the following
> +rules:
> +
> +* by default only lines that contains a ':' (colon) are considered

s/contains/contain/

> +  trailers,
> +
> +* the trailer lines must all be next to each other,
> +
> +* after them it's only possible to have some lines that contain only
> +  spaces, and then a patch; the patch part is recognized using the
> +  fact that its first line starts with '---' (three minus signs),

Is that "starts with" or "consists solely of"?

> +
> +* before them there must be at least one line with only spaces.

I had little bit of trouble parsing those three points, and it seems like a
lot of text to describe something simple.  How about a single paragraph:

Existing trailers are extracted from the input message by looking for a group
of one or more lines that contain a colon (by default), where the group is
preceded by one or more empty (or whitespace-only) lines.  The group must
either be at the end of the message or be the last non-whitespace lines
before a line that starts with '---' (three minus signs).


Also, will a trailer be recognized if there is whitespace before and/or after
the separator?  Can there be whitespace before the token?  In the token?  (I
don't feel strongly about the answers to these questions, they just came to
mind as I read the documentation.)

> +
> +Note that 'trailers' do not follow and are not intended to follow many
> +rules for RFC 822 headers. For example they do not follow the line
> +folding rules, the encoding rules and probably many other rules.
> +
> +OPTIONS
> +-------
> +--trim-empty::
> +	If the <value> part of any trailer contains only whitespace,
> +	the whole trailer will be removed from the resulting message.
> +	This apply to existing trailers as well as new trailers.
> +
> +--trailer <token>[(=|:)<value>]::
> +	Specify a (<token>, <value>) pair that should be applied as a
> +	trailer to the input messages. See the description of this
> +	command.
> +
> +CONFIGURATION VARIABLES
> +-----------------------
> +
> +trailer.separators::
> +	This option tells which characters are recognized as trailer
> +	separators. By default only ':' is recognized as a trailer
> +	separator, except that '=' is always accepted on the command
> +	line for compatibility with other git commands.
> ++
> +The first character given by this option will be the default character
> +used when another separator is not specified in the config for this
> +trailer.
> ++
> +For example, if the value for this option is "%=$", then only lines
> +using the format '<token><sep><value>' with <sep> containing '%', '='
> +or '$' and then spaces will be considered trailers. And '%' will be
> +the default separator used, so by default trailers will appear like:
> +'<token>% <value>' (one percent sign and one space will appear between
> +the token and the value).
> +
> +trailer.where::
> +	This option tells where a new trailer will be added.
> ++
> +This can be `end`, which is the default, `start`, `after` or `before`.
> ++
> +If it is `end`, then each new trailer will appear at the end of the
> +existing trailers.
> ++
> +If it is `start`, then each new trailer will appear at the start,
> +instead of the end, of the existing trailers.
> ++
> +If it is `after`, then each new trailer will appear just after the
> +last trailer with the same <token>.
> ++
> +If it is `before`, then each new trailer will appear just before the
> +last trailer with the same <token>.

It seems to me that it would be more sensible to make the new trailer appear
before the *first* trailer with the same token.  Otherwise you can end up
with a somewhat unintuitive order, e.g. if we add values A B C D E (in that
order) we get
	foo: B
	foo: C
	foo: D
	foo: E
	foo: A

		M.
