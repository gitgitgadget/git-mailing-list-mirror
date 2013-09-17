From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 11:06:07 -0700
Message-ID: <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
References: <20130831194425.GA14706@redhat.com>
	<xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
	<20130903210815.GB24480@redhat.com>
	<20130915074900.GA30438@redhat.com>
	<20130915080830.GA30465@redhat.com>
	<xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
	<20130917164226.GB20672@redhat.com>
	<xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
	<20130917172829.GA21121@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 20:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzfN-0003PB-L7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 20:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab3IQSGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 14:06:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab3IQSGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 14:06:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662E342F69;
	Tue, 17 Sep 2013 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qiP3/GudM4YxDQUPEGrHL5JzuUQ=; b=GXeKJA
	rJkgZkm68VMsD6Q4mfLuixeLyfcOe78YWO/ZeuBVAxb76hoYFnfZ3NhmMfat6xOc
	jyltedN33++2tdgH/zGZfOgeb8LL9tw1v82VeW0hrQ/a3qq1WqREVVmu4erhqx6r
	v3FYw8JsbT14oWC6k1lMYBatl42AjJKtnC6Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lIftvFTwm+HOK5UzXuUhJsdHsRVKMAaH
	wANC2taVaqsmZbzI8A8wtH9la0JfT9y7h013+XkqO5Hf5jzrOrM9+HN6laciNMSr
	pztaDVdOuDsREhtj+vnLcj7w5WsXJ0dXZVN/hfeEZLyB7ZrDH2CbVisuVSzhptDY
	5OuArRDah1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93EE42F64;
	Tue, 17 Sep 2013 18:06:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2168442F4D;
	Tue, 17 Sep 2013 18:06:19 +0000 (UTC)
In-Reply-To: <20130917172829.GA21121@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 17 Sep 2013 20:28:30 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA387E88-1FC3-11E3-9B6D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234898>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Sep 17, 2013 at 10:24:19AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > So might it not be useful to tweak patch id to
>> > sort the diff, making it a bit more stable?
>> 
>> That is one thing that needs to be done, I think.  But it would be
>> unfortunate if we have to do that unconditionally, though, as we may
>> be "buffering" many hundred kilobytes of patch text in core.  If we
>> can do so without regressing the streaming performance for the most
>> common case of not using the orderfile on the generating side (hence
>> not having to sort on the receiving end), it would be ideal.  I am
>> not sure offhand how much code damage we are talking about, though.
>
> So make it conditional on the presence of the orderefile option?

That would mean that those who set orderfile from configuration in
the future will have to always suffer, I would think.  Is that
acceptable?  I dunno.

Also, if the sender used a non-standard order, the recipient does
not know what order the patch was generated, and the recipient does
not use a custom orderfile, what should happen?  I thought your idea
was to normalize by using some canonical order that is not affected
by the orderfile to make sure patch-id stays stable, so I would
imagine that such a recipient who does not have orderfile specified
still needs to sort before hashing, no?
