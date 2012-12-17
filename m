From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 11:34:48 -0800
Message-ID: <7v4njkmq07.fsf@alter.siamese.dyndns.org>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
 <20121217121354.GB21858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"Srb\, Michal" <michal.srb11@imperial.ac.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:35:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkgT4-0005x3-1o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2LQTew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:34:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2LQTev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:34:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E521A8F7;
	Mon, 17 Dec 2012 14:34:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ilJ/G8HoidJWFDIQkIfKQoJx69c=; b=pOo6UN
	Y49+pmNrkydfRQW8Edxz0iLxWWPkClwrTuDL4biHp4T9U7vbetw4P+k3m5n6uAvq
	A8uaEBvaSSQ5GSN0jjWsvB7FGVd+1ooX2TSoBj949YURvTfARh7PvrJl47XsEHse
	UYdl0ASNwZm5F2v7zThcQNFszFR+rJsj0D5hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFOQkvyNkpdhiFZGorBVt87Hqov2JyGR
	fMs/W6F10InsFHQtLFyW2ho9q/mdTZH3ETHMDxUh+ySmIlIAotAP+hrXSJ4xSGa5
	RQhSXC1xb+m4QOqKEK96zTG8VUXntNb2rPRZf9fFM3HE7AMnnj5kWAPSBvtD3LjS
	3+ACZxCEPnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AAE0A8F6;
	Mon, 17 Dec 2012 14:34:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A57F4A8F3; Mon, 17 Dec 2012
 14:34:49 -0500 (EST)
In-Reply-To: <20121217121354.GB21858@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Dec 2012 07:13:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D25D11B2-4880-11E2-AD21-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211692>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 17, 2012 at 06:44:10PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> >                         if (!end)
>> >                                 return 0;
>> > -                       color_parse_mem(placeholder + 2,
>> > -                                       end - (placeholder + 2),
>> > +                       if (!memcmp(begin, "auto,", 5)) {
>> > +                               if (!want_color(-1))
>> > +                                       return end - placeholder + 1;
>> 
>> This want_color() checks color.ui and only when color.ui = auto, it
>> bothers to check if the output is tty. I think the document should say
>> that "auto," (or maybe another name because it's not really auto)
>> respects color.ui.
>
> Yeah, that should definitely be documented. I wonder if it should
> actually respect color.diff, which is what "log" usually uses (albeit
> mostly for the diff itself, we have always used it for the graph and for
> the "commit" header of each entry).

I actually do not like this patch very much.  The original motive
behind this "auto" thing was to relieve the script writers from
the burden of having to write:

	if tty -s
        then
        	warn='%C(red)'
                reset='%C(reset)'
	else
        	warn= reset=
	fi
        fmt="${warn}WARNING: boo${reset} %s"

and instead let them write:

	fmt="%C(auto,red)WARNING: boo%C(auto,reset) %s"

but between the two, there is no $cmd.color configuration involved
in the first place.  I am not sure what $cmd.color configuration
should take effect---perhaps for a "git frotz" script, we should
allow the script writer to honor frotz.color=(auto,never,always)
configuration, not just ui.color variable.

Also the patch as posted deliberately omits support to honor command
line override --color=(auto,never,always), but it may be more
natural to expect

    git show --format='%C(auto,red)%s%C(auto,reset)' --color=never

to defeat the "auto," part the script writer wrote.

Now, such a script would be run by its end users as

    $ git frotz --color=never

It has to do its own option parsing before running the underlying
"git show" to decide if it passes "--color=never" from the command
line for that to happen.

But at that point, we are back to the square one.  Such a script
would be doing something like:

	if cmdline_has_color_flag
        then
		use_color=... that flag ...
	elif git config --get-colorbool frotz.color
	then
		use_color=--color=always
	else
		use_color=--color=never
	fi

in its early part to decide $use_color, to be used in the call it
makes to "git show" later on:

	git show --format="$fmt" $use_color

Adding the logic to decide if %C(...) should be added to $fmt no
longer is an additional burden to the script writer, making the
whole %C(auto,red) machinery of little use.

So...
