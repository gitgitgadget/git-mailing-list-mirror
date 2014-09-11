From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] Make sure that index-pack --strict fails upon invalid tag objects
Date: Thu, 11 Sep 2014 09:50:31 -0700
Message-ID: <xmqqa966f6eg.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info>
	<xmqqoaunf8fv.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1409111620420.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:50:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7Zw-0000RH-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 18:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbaIKQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 12:50:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52976 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbaIKQug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 12:50:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F26839BDA;
	Thu, 11 Sep 2014 12:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMVCJfotEn0HkLKl38ixVn3nQnA=; b=Rvf3gN
	GWjNOnILcWLK1fa98+OGjnMidzPShf9l+3elj+GcYwgXPogDvfzHPFlPBNVdcgSi
	l9TtzVjAV7Atiq5kSTZESKpRqGlXGCaw/YI+uGajmWd1LQyw7mqQiibDH5sWOpmV
	ogrVfmhOAyEAWzssGGZCOYlLtCv87zBcECnLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uvK24xLXBfAfinUFCt6js3T5oLjU/E7O
	MxUfHdudrlOXLn1mtY6HwJFT1aVhZBib3Zfhud3HPcDeym2Xr3jFLnr69muTWa9t
	+DJUaq8YZKi4+UaS1Qaud306ec06gztr0PoquGP0MYLKYvybVecj81qYDzmLA+9o
	2a3zkcUyhYc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A72A339BD8;
	Thu, 11 Sep 2014 12:50:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A158139BD6;
	Thu, 11 Sep 2014 12:50:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409111620420.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 11 Sep 2014 16:22:10 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE9B472A-39D3-11E4-A5D2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256851>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 10 Sep 2014, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > +    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
>> > +    pack1=$(echo $tag | git pack-objects tag-test) &&
>> > +    echo remove tag object &&
>> > +    thirtyeight=${tag#??} &&
>> > +    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
>> > +    test_must_fail git index-pack --strict tag-test-${pack1}.pack 2> err &&
>> 
>> I had to drop "must fail" from this one (will amend the "SQUASH???"
>> again).
>
> Funny. It failed here, but for the wrong reason: index-pack --strict
> failed here because the object referenced by the tag object was not in the
> pack.

That is strange.  It failed with the version you sent to the list
for me for a different reason---it tried to verify the ident that
did not exist in the tested object (which we fixed in the squash).
