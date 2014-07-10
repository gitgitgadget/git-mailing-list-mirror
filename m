From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 15:46:04 -0700
Message-ID: <xmqq38e87ryr.fsf@gitster.dls.corp.google.com>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
	<20140710040731.GD28401@sigill.intra.peff.net>
	<xmqqa98h8587.fsf@gitster.dls.corp.google.com>
	<20140710193404.GA15615@sigill.intra.peff.net>
	<1405029028.4925.32.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "peff\@peff.net" <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5N6W-0002Au-No
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbaGJWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:46:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62426 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbaGJWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46ED1277D3;
	Thu, 10 Jul 2014 18:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aCpPJ8APvYpcsWN94wVR/3G+9Mk=; b=mImD9v
	A5goEV4cHTKzUfEGZepTfhmOyh0zpZsw1Z25f40JSDssDxbQZbsMysjH6yPHDr8A
	X4WvJ2ahSgjaiY35GYOgWaZIiUYVZ92z5GzlhQGPTyi25nlCvcPjEtkRqh8Xpo10
	CGD410hRqRyVZyyx7fxDbAlcI96FxkPNfQ5B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9NEC9kXaiaS8NKHearVzqJ/gzwzBsBU
	gS0HBqVXbKPIYT/J+ePLj6m7Hm5biHb/0pDIlh2djj6yxteJy9yI2cWvwrOd5ZKg
	2gL+rkbx0wJQb1X6GMkXPfTXH5tj82Ygmj9aF9g3Ei+K9nSKuqJuBPQJpWvKSho5
	N2o0ZzuK93Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D401277D2;
	Thu, 10 Jul 2014 18:45:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED6E2277CC;
	Thu, 10 Jul 2014 18:45:50 -0400 (EDT)
In-Reply-To: <1405029028.4925.32.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Thu, 10 Jul 2014 21:50:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F149E752-0883-11E4-BCC0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253226>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> On Thu, 2014-07-10 at 15:34 -0400, Jeff King wrote:
>> On Thu, Jul 10, 2014 at 10:59:36AM -0700, Junio C Hamano wrote:
>> 
>> > Jeff King <peff@peff.net> writes:
>> > 
>> > > I know this is existing code you are moving, but I noticed it looks ripe
>> > > for using skip_prefix. Perhaps while we are in the area we should do the
>> > > following on top of your patch (I'd also be happy for it be squashed
>> > > in, but that may be too much in one patch).
>> > 
>> > I am tempted to suggest going the other way around, i.e. queue (an
>> > equivalent of) this on jk/skip-prefix and merge it to 'next' and
>> > then 'master' quickly.
>> > 
>> > I can go either way, but I tend to prefer building new things on top
>> > of obviously correct clean-up, not the other way around.
>> 
>> Me too. I just didn't want to make more work for Jacob (in having to
>> rebase on top of mine) or for you (in having to do a non-obvious merge a
>> few days from now).
>> 
>> -Peff
>
> I'm perfectly fine rebasing. :)

Alright, thanks.

I am still not ready to push out today's integration result, but
when it happens, Peff's "tag: use skip_prefix" should appear at
ce85604, as a direct follow-up to the tip of already merged
jk/skip-prefix topic which was 67a31f61 (http-push: refactor parsing
of remote object names, 2014-06-19).
