From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Mon, 15 Sep 2014 10:55:21 -0700
Message-ID: <xmqqioko93au.fsf@gitster.dls.corp.google.com>
References: <20140913093746.GD6600@mwanda> <20140913154556.GA12361@kroah.com>
	<20140913203645.GB24854@peff.net>
	<20140913204745.GA12291@msilap.einon.net>
	<20140913205751.GA17875@mwanda> <20140913210908.GG6549@mwanda>
	<20140913212504.GA25190@peff.net>
	<20140913225713.GB189120@vauxhall.crustytoothpaste.net>
	<20140914004725.GA28010@peff.net>
	<CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
	<20140914010120.GA28498@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 19:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTaUr-0005bs-CU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 19:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbaIORzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 13:55:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53165 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817AbaIORzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 13:55:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 140F03AA11;
	Mon, 15 Sep 2014 13:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dtCflO+aFJ4f+XG+INVSPjNBl34=; b=TpklF5
	Xtxq3n1H2BiZD9y0n/OdzSirMCOyd1nta3bf9XgZBoJCclLKaJQkqBfOKQ3CzAZt
	VnlonuBUpKFYFwLFOFJSrinAIWT5e3xSW/gNSC0PvoSuA3/cMKOoPZfz53E3YsNf
	cp0Qgq5GEo+qeXLEbw4SJ2WxLYDkfrxz8ljFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpLkU+Qam1nneFVgvZB7rBSoNUhORVhb
	VhFJzXFMn6UK+ufN2CJFDAiC0JsShM/fM4bPQVXHXte4gLyrEvIBvUsQTYmaGpXx
	ZGjllwzZhSnr13Vx4rTrW8boEY6/9zA/o3ynJhfFBLAkklX69LilOO/XxonH2lO6
	azetaNzyBRo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A3833AA10;
	Mon, 15 Sep 2014 13:55:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 75A3F3AA0D;
	Mon, 15 Sep 2014 13:55:23 -0400 (EDT)
In-Reply-To: <20140914010120.GA28498@peff.net> (Jeff King's message of "Sat,
	13 Sep 2014 21:01:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 775F2BB6-3D01-11E4-A481-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257058>

Jeff King <peff@peff.net> writes:

> On Sat, Sep 13, 2014 at 05:55:49PM -0700, Junio C Hamano wrote:
>
>> On Sat, Sep 13, 2014 at 5:47 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > On Sat, Sep 13, 2014 at 10:57:14PM +0000, brian m. carlson wrote:
>> >
>> > > I wonder if git send-email should do what mutt does in this case, which
>> > > is use quoted-printable encoding and encode the first F as =46 (as well
>> > > as any equals signs as =3D).  It looks like mailinfo.c already is
>> > > capable of handling that, and that would avoid the entire issue.
>> >
>> > That's not an unreasonable tactic. However, I think we'd still want to
>> > do something with mailinfo on the receiving end, similar to the patch I
>> > sent. We don't know that the sending side is necessarily send-email.
>> 
>> Hmm, isn't the ">" stuffing in front of a beginning-of-line "From " purely
>> a local matter of MUA that stores messages in (old-style) mbox format
>> where a line that begins with "From " is what defines the end of the
>> previous message?
>
> Yes, it is[1].
>
>> Why should send-email do anything when it sends individual messages
>> separately out?
>
> It does not need to, but the QP-transformation helps protect against
> other, stupider software downstream.  And unlike From-quoting it is
> actually well-specified and reversible.

Oh, I was only reacting to a phantom suggestion nobody made to add
">" on the sending side (which would not help anybody), but now I
re-read the thread with a larger screen I realize nobody made such a
suggestion.  Sorry for a noise.
