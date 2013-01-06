From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-fast-import(1): reorganise options
Date: Sun, 6 Jan 2013 05:51:09 -0800
Message-ID: <20130106135109.GF22081@elie.Belkin>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
 <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
 <20130106132915.GG6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 06 14:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrqdY-0005C9-JQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 14:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab3AFNvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 08:51:16 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61166 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab3AFNvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 08:51:15 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so10207526pad.23
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Be/ob+iz7hBPeItbzpeJwpOFTAWa8jGsUGkind4wkXQ=;
        b=G9jDZzhoYkpup4cPlAimgUxAgyA/T17ZpRT4HvMTOzUE+/5/lGa0fSpdGxcZxs/iH1
         9rCcGSYHfWhgmpVOGOWAd7trwb8NJ4QraDaJthbIbhGsxhYTjJxvrL9LZUktsJGkGQ6b
         qoTDutQM+7LpUMHc1+Dv4bSaZnb36OulFgqBZtobGeuiphTFpxe48goIdHBa9KldMNp5
         jl10L1MqZrQgSmE2hIABXS2TxZHYq0jEaVn9VMVc4gzuBb4a2FF89famyLgX03GUWBEN
         pKeQPgUXvonXNcQr/wOqDRTO7F3abyrzwiu7alP5arX9SG28GLrBGvPJGFzKWAE48dIK
         xKpA==
X-Received: by 10.66.73.138 with SMTP id l10mr169815342pav.44.1357480275077;
        Sun, 06 Jan 2013 05:51:15 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sk1sm35838034pbc.0.2013.01.06.05.51.12
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 05:51:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130106132915.GG6440@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212802>

John Keeping wrote:

> How about this?

Ah, our patches crossed.

> I left the "Semantics of execution" options with the general options
> since I couldn't think of a sensible heading

Neat trick. :)

[...]
> -- <8 --
> The options in git-fast-import(1) are not currently arranged in a
> logical order, which has caused the '--done' options to be documented
> twice (commit 3266de10).
>
> Rearrange them into logical groups under subheadings.

Nice description.

> While doing this, fix the duplicate '--done' documentation by taking the
> best bits of each.  Also combine the descriptions of '--relative-marks'
> and '--no-relative-marks' since they make more sense together.

I'd prefer to keep those as separate patches, if that's manageable.

The organization you propose is:

	OPTIONS
	-------
	--quiet
	--stats
	--force
	--cat-blob-fd
	--export-pack-edges

	Options related to the input stream
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	--date-format
	--done

	Options related to marks
	~~~~~~~~~~~~~~~~~~~~~~~~
	--export-marks
	--import-marks
	--import-marks-if-exists
	--relative-marks
	--no-relative-marks

	Options for tuning
	~~~~~~~~~~~~~~~~~~
	--active-branches
	--big-file-threshold
	--depth
	--max-pack-size

These headings are less cryptic than the ones I proposed, which is a
nice thing.

My only nitpicks:

I'd worry that the catch-all toplevel category would grow larger
and larger with time, since it's the obvious place to put any new
option.

Part of what I tried to do with the proposed categorization was to
separate options that change the semantics of the import (which one
uses with "feature" when they are specified in the fast-import stream
since ignoring them results in a broken import) from options that only
change superficial aspects of the interface or the details of how the
resulting packfiles representing the same objects get written.

The phrasing of the name of the category "Options related to the input
stream" is too broad.  All options relate to the input stream, since
consuming an input stream and acting on it is all fast-import does.
Something more specific than "related to" and a mention of "syntax"
could make it clearer --- how about something like "Input Syntax
Features"?

Likewise, lots of functionality is _related_ to marks, but the marks
options are the options that specify marks files.  I don't know a good
way to say that --- maybe "Location of Marks Files"?

"Options for Tuning" could also be made more specific --- e.g.,
"Performance and Compression Tuning".

I like how you put important options like --force on top.  Perhaps
the less important --quiet and --stats could be split off from that
into a subsection like "Verbosity" to make them stand out even more.

Generally I think this is a better starting point for future work than
the patch I sent.  Thanks for writing it.

Jonathan
