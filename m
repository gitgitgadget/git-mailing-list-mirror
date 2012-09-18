From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/14] Change fetch_pack() and friends to take
 string_list arguments
Date: Tue, 18 Sep 2012 13:49:52 -0700
Message-ID: <7vehlzkqdr.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
 <7vipblmwaq.fsf@alter.siamese.dyndns.org> <5057167A.6040403@alum.mit.edu>
 <7vd31ks3ls.fsf@alter.siamese.dyndns.org>
 <20120917221710.GA555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:50:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4k9-0008Ii-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab2IRUt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:49:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083Ab2IRUtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:49:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D0D90AA;
	Tue, 18 Sep 2012 16:49:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GvoKThrbug6smexfpOO9Xc/WDkQ=; b=vHQWbX
	AVKgUwUMgUjVEPzmHrGjwd2aJm9SZfAPmK8+X7/MNrKRHXDLIQRkJ7BgwODYzGMh
	mrSMe5NtSJZcP9+4OSAznpePOfOqqnZTkNVDLK/TFcMo3Q3tt8L+2UtAxiJoyB30
	v6Lmh8Dd2vf1FCrcjZAdrwViWSXb0mQ1jjcns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FQQhIgL+pq07Ud+wv3mF4DiB4w06oAQA
	debFU2ecyWnadrvyhZrATdq5vU6ezE1HAKUr1H8i7k3VFWs8yJQtg+ko6mpJZhmP
	8S1qIajCmyFoXfwJCUC2TtpVMGNrXM2EGhwOaIpz8Krn5tt2NAfI9gSJs2QTYVZa
	JE+3Q/0u3ME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEE5F90A9;
	Tue, 18 Sep 2012 16:49:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DCC690A8; Tue, 18 Sep 2012
 16:49:54 -0400 (EDT)
In-Reply-To: <20120917221710.GA555@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Sep 2012 18:17:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66292C00-01D2-11E2-A188-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205872>

Jeff King <peff@peff.net> writes:

> What I think would be much more productive is breaking apart gigantic
> includes like cache.h into more reasonable modules, which would mean
> less frequent recompilation when an uninteresting part of the header
> changes.

Ideally cache.h should cover what read-cache.c, sha1_file.c and
sha1_name.c do and need.  The parts related to sha1_name.c may
deserve to have its own header file, as its scope is fairly wide and
spans from low-level object name get_sha1_hex() to high level
parsing like dwim_ref().  Right now, the header also has pieces that
are needed only by connect.c and config.c (not even commented as
such), pager, base85, alloc, trace, add, piece of diff, etc.

Also we may want to move helper functions that are generally useful
and do not depend on specific command to more appropriate files.
