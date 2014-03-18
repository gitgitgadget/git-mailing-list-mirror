From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: add --nonlinear-barrier to help see non-linear history
Date: Tue, 18 Mar 2014 12:08:04 -0700
Message-ID: <xmqqmwgn8gvf.fsf@gitster.dls.corp.google.com>
References: <1391867417-979-1-git-send-email-pclouds@gmail.com>
	<1395060676-23144-1-git-send-email-pclouds@gmail.com>
	<xmqqob14d0qv.fsf@gitster.dls.corp.google.com>
	<CACsJy8BsEsyrcis=+2HyocYWi9WM2oHKtSFPXzSt5ji6zVgeXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzNA-0004N3-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466AbaCRTIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:08:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756412AbaCRTIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:08:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E105773647;
	Tue, 18 Mar 2014 15:08:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jsygPxfUhPXNrDJZUmxBrEhutkA=; b=j+ebSo
	9iONN5Fq3AFpN+bp4i3XPzHMyqBHCksFipkioubpZ9Znbch01o32+nUlu3Yv6xaG
	RHdJrjOJL5KPQp+zWVifYifn8umHNRgKgAW4N0bcLZmwD2PcplSBSiRNw+U7kwwZ
	3zQEdibDi3amKjVD3FYkCHlUbRkEZCO8WLel0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FHaYmod//Ewn6aa1KiOUaxk8VF3ngj0M
	xR8EEOu6o0sZVv3dwD1BVgpw0doGhY8nW6cM9x4L5wGEZz5vk2zXd1GMreUiKBrj
	duOlYafcWuDeRRJmqeFoL5QGKww+4lTEgwhCbz2NS5vbAfrSvx6PhOOPINByZ0YK
	J+jWArDBG/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1CC73646;
	Tue, 18 Mar 2014 15:08:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0BFE73644;
	Tue, 18 Mar 2014 15:08:07 -0400 (EDT)
In-Reply-To: <CACsJy8BsEsyrcis=+2HyocYWi9WM2oHKtSFPXzSt5ji6zVgeXA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 18 Mar 2014 18:46:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A40275AC-AED0-11E3-B9A0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244369>

Duy Nguyen <pclouds@gmail.com> writes:

>> I do not quite understand the "if we do not have previous parents"
>> bit, though.  Is it meant to trigger only at the very beginning?
>
> Only at the beginning.

Then I am not sure !revs->previous_parents match that condition.

What happens in a history with more than one root commits and the
first one the revision traversal finds is one of the roots?  When
showing the second commit, after processing the root and storing its
parent list, which is NULL, to revs->previous_parents, wouldn't it
mistakenly think that it is the first round and fail to show the
break line?
