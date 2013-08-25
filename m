From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 22:25:56 -0700
Message-ID: <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSq0-0007yO-La
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab3HYF0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:26:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3HYFZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:25:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355032E514;
	Sun, 25 Aug 2013 05:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s6n4E71WremQkEPLnbX89EV1qsc=; b=TAetKi
	RkrbfAusYCpmFnaQBfOETKWSdMxpd9OYBjoLcfUudzJZmWgu3jZq2BN27tuVOHZg
	j3P2yy5qytR7bdoI8MJfcmvKl9WG6voxBP07f63CS0zJZoYJRokMrMb39/lAzQdU
	Ffc4czPe39xdVHOcfZZCION0BVUuz2hBjwcFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MRu84uGIPcx4/B34dcwAeGv32eGRPWU3
	ylNQO9eUob85cKBbwU3x8Edg24VKJaRB/3/aGFayZ6qXEbxVxGNKMSsimqROWFVD
	ZylfM10xwsKBId1GIPBnrDEpXhqWc3/h6qj8TlvHCcqsGV6G0uZaP1k672XtTeul
	3XF/25s+x5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DA72E512;
	Sun, 25 Aug 2013 05:25:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 892172E511;
	Sun, 25 Aug 2013 05:25:58 +0000 (UTC)
In-Reply-To: <20130825042314.GE2882@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 24 Aug 2013 21:23:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2BCD3FA-0D46-11E3-A211-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232921>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think Phil meant that when "git grep" is asked to search within
> "HEAD:some/path", filenames tacked on at the end should be appended
> with a '/' separator instead of the usual ':' (e.g.,
> "HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").

Ah, OK.

I am not sure if we have a proper hint in the revision parser
machinery, but it may not be too hard to teach rev-cmdline interface
to keep that kind of information (i.e. "This tree object name is a
result of parsing '<tree-ish>:path' syntax").
