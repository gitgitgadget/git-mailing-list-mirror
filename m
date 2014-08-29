From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck exit code?
Date: Fri, 29 Aug 2014 12:21:12 -0700
Message-ID: <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRjk-0002oa-WC
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 21:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaH2TVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 15:21:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55474 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbaH2TVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 15:21:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9419D35098;
	Fri, 29 Aug 2014 15:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnoRQyxYSbFxMXBACLe8laEwZKI=; b=iXqNhP
	8LZGlGeRn5Qn6rAinMgs47I3q2vg1r4mXMIk3KxLKYMXwKWiVyR53K/U7lVzpeon
	C9SIl8WXwqXoS+JgK/vjbup24na+HKvfmOKBk7nlU2Rcw2OkV4pqVhust+Rjelkq
	/+PIlTl/yjWS2OFhqk3lL2GQudLm01btxc8DA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eVgaPqT0jVuCPiE9y3WpZhIFSLsSTzx+
	+NtrfE47kBMjLiAZfHAyPQllnhqSv/VqAx+ThP6i6rFXTl1vcuhrFqO13b83r1ob
	kMKwd8B7yyTuKAJ7LAW7wbFP0zmVymnz583/vb1ggee9mXmEhvdCgKSJzwAm3YoH
	fpiNQ8wQAJI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BF3735097;
	Fri, 29 Aug 2014 15:21:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 37FD03508F;
	Fri, 29 Aug 2014 15:21:14 -0400 (EDT)
In-Reply-To: <20140829185325.GC29456@peff.net> (Jeff King's message of "Fri,
	29 Aug 2014 14:53:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A46EE590-2FB1-11E4-8C9D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256183>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 27, 2014 at 06:10:12PM -0400, David Turner wrote:
>
>> It looks like git fsck exits with 0 status even if there are some
>> errors. The only case where there's a non-zero exit code is if
>> verify_pack reports errors -- but not e.g. fsck_object_dir.
>
> It will also bail non-zero with _certain_ tree errors that cause git to
> die() rather than fscking more completely.

Even if git does not die, whenever it says broken link, missing
object, or object corrupt, we set errors_found and that variable
affects the exit status of fsck.  What does "some errors" exactly
mean in the original report?  Dangling objects are *not* errors and
should not cause fsck to report an error with its exit status.
