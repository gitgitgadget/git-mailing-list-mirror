From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Mon, 30 Jun 2014 11:13:22 -0700
Message-ID: <xmqqa98uz2nx.fsf@gitster.dls.corp.google.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
	<CACsJy8D8687QULRBZF_hvwASxOy5ekuPJ997xLSDX6HXDXgZnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 20:13:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1g59-0005dm-6r
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 20:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbaF3SNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 14:13:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50616 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735AbaF3SNa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 14:13:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B0D3235BA;
	Mon, 30 Jun 2014 14:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v2DYvd9lU+qwHlEwDqr+4XqKPE0=; b=v0br8x
	ZJDIJ1HaIflLFBvzGlWP63S2UmPLCkijl0D1sBgcyagRrAqjPoiAbQM/w1MnzhMo
	850VgSY+o03r8tc9lR/PF/qZHziY2E1YUE6WDbHZx04EIkDBo4yYo4faiS57Jxvl
	o9i1E7wHy8atKPsgs485EqSHju5e1iStZdtzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ojPC1HwAqwMwnhBE8QkE40Vzs1IsKsL0
	nMRtcllAwJqBduoZNcweIdmNpvzCf4XTg+WCUQqlTgndpAOgNYMzU/G1UrEb5qw6
	eZkt4CDTe32PQLmqNRZOS1m/JSpf2vTletFys0SpGzy55zsfs63cAnHn5a+lKWr5
	tReVv9O4CKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EF0B235B9;
	Mon, 30 Jun 2014 14:13:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 85D06235AB;
	Mon, 30 Jun 2014 14:13:16 -0400 (EDT)
In-Reply-To: <CACsJy8D8687QULRBZF_hvwASxOy5ekuPJ997xLSDX6HXDXgZnA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 29 Jun 2014 10:33:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35298E64-0082-11E4-8359-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252698>

Duy Nguyen <pclouds@gmail.com> writes:

> I wonder if we should do this in !opts->force code path only. In the
> opts->force code path we could use prime_cache_tree() (like
> read-tree), which is supposedly faster...

Nobody sane should be constantly running "checkout -f", so even if
priming from existing tree objects were faster, it would be adding
complexity to the code to optimize for a wrong case.
