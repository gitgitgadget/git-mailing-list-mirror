From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] patch-id: make it stable against hunk reordering
Date: Thu, 24 Apr 2014 12:12:49 -0700
Message-ID: <xmqqd2g6v8we.fsf@gitster.dls.corp.google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
	<1398331809-11309-4-git-send-email-mst@redhat.com>
	<20140424173043.GJ15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdP4t-0008MP-1R
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaDXTMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:12:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbaDXTMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:12:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7C27F08C;
	Thu, 24 Apr 2014 15:12:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EpldGmmzI2r4rKu12t5rKXoqa6I=; b=H+4pNT
	S6jbp08zJyKMZJo8Jb99JYtvymUCGO9b0ThX5+kkpsvGz1dBiqKyxcrzXGgOd6VL
	0ms3dJuOY3Tuk7Q8gB2VCXyTZex2IuGoiLrkpSxQ4BaqC9RKxpVzwaNqlqOKV+Ul
	AxQN/yKD+/VxDMEMFYgKrGclxBGY1TIRPPVlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LUfzJrrgGrEYwmiUSNsYtZowQPmPQfdc
	Y3q+2Q+Ce9OCDkhfZPkSLco70syVsrrRnCb9RD4BCpM/f82ME/i1N51jwz8hToKm
	3CQAYMD20IKXdpstWPZp/EI3hsBpqY/iZpeLx+BdwXHHaZNa2OAwOjPyawDjiLud
	cr49LJTkzPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8167F08B;
	Thu, 24 Apr 2014 15:12:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EE777F087;
	Thu, 24 Apr 2014 15:12:51 -0400 (EDT)
In-Reply-To: <20140424173043.GJ15516@google.com> (Jonathan Nieder's message of
	"Thu, 24 Apr 2014 10:30:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E440314-CBE4-11E3-B556-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246998>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Should the internal patch-id computation used by commands like 'git
> cherry' (see diff.c::diff_get_patch_id) get the same change?  (Not a
> rhetorical question --- I don't know what the right choice would be
> there.)

I thought about it but I did not think of a reason why.  If we do
not store the patch-id (it would be a misnomer especially after this
series, it is mor like patch signature), and we generate the patch
to be hashed internally without getting affected by any user input
given per-invocation, then nothing is externally observable even if
we used two completely different definition of patch id computation,
and I think these preconditions do hold.
