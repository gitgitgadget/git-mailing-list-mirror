From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 09:42:10 -0700
Message-ID: <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
	<xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
	<20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:42:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDNl-0007rf-GA
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbaC0QmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:42:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbaC0QmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 12:42:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E63B2754E6;
	Thu, 27 Mar 2014 12:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SdCgTODvBCvZdRysdCjoUSN4pv0=; b=wCKUr+
	MN3bt43nDeon6HfscnjwbQWqcSnzKidx3Jo+NXHOXDqDBEnqvyMnjOtSp8vOSGmi
	vTgyZ30Ws3dBmeRLiC9Ro3wJxjTjtIW3n2funETg3ozFzR5jfsR9gcVBRXtAx6V3
	6lGtZGO0LNCXfFc71KWRa89ynekLlKu5bOhQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HEF0yiyBWZa8mkMaqgX34TcZoYY+ws7S
	WvFjpq0DKJb8IJqlva3dcOGqp4FMQb8KM+Miylce/+vXR3NmfB57wCe6OiAOqbfL
	3i1U080dcoHhc3k4Hc7liPuN/xxYGqxtlkvXn5HZBHpYkcsQW63mMebqytnuLuO6
	R11k00BA1fs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC85754E5;
	Thu, 27 Mar 2014 12:42:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78584754D7;
	Thu, 27 Mar 2014 12:42:12 -0400 (EDT)
In-Reply-To: <20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
	(Christian Couder's message of "Thu, 27 Mar 2014 08:47:45 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF2139D6-B5CE-11E3-8AB2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245292>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, but it seems a bit wasteful to allocate memory for a new string,
> then downcase it, then compare it with strcmp() and then free it,
> instead of just using strcasecmp() on the original string.

I wasn't looking at the caller (and I haven't).  I agree that, if
you have to compare case-insensitive user input against known set of
tokens, using strcasecmp() would be saner than making a downcased
copy and the set of known tokens.  I do not know however you want to
compare in a case-insensitive way in your application, though.
