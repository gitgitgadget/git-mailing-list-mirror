From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Thu, 21 Feb 2013 10:51:24 -0800
Message-ID: <7vip5lv6tv.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
 <1360665222-3166-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 19:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8bFI-0003LZ-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 19:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3BUSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 13:51:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363Ab3BUSv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 13:51:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 982A3BA90;
	Thu, 21 Feb 2013 13:51:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ExEDIkhx5xyTR/cKF+I6LZTQ0uc=; b=d/eoP3
	O4oJ8ZU9+u0fHHNKvtGoyX6bBs9xleFi/tLoN7UoiImxbkJvMko+zRiBdQsJ5vLJ
	23H5lKE3PLYCLBwZnx13nVbNHkei6PV7b9nEpJ6av6lWFAWnD/T/QZ3uHgYaINAL
	Sew0pJG6tSVLGvc93Cy7RU9WZgfjwxth0NBpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpRcIlznB4E+WP9C9llbHVov1oWj64Ae
	jiLiBqR3ss3fizKriXlTyAXbkjQmvPG4lsvIS8hUks+rFzHlB0uIfcR88p1nkeR3
	nTjAtKVjmnWRTLZVOZec34o1dfWAYo0zTG6oiZTx6h3QLRJ60s88bK3rxyx7e1/v
	4goZlAHuqfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D886BA8F;
	Thu, 21 Feb 2013 13:51:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1845FBA8A; Thu, 21 Feb 2013
 13:51:26 -0500 (EST)
In-Reply-To: <1360665222-3166-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Tue, 12 Feb 2013 02:33:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1C9469A-7C57-11E2-AA1F-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216787>

Brandon Casey <drafnel@gmail.com> writes:

> Teach append_signoff to detect whether a blank line exists at the position
> that the signed-off-by line will be added, and refrain from adding an
> additional one if one already exists.  Or, add an additional line if one
> is needed to make sure the new footer is separated from the message body
> by a blank line.
>
> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
> ---
>
>
> A slight tweak.  And I promise, no more are coming.

When I do

	$ git commit -s

it should start my editor with this in the buffer:

	----------------------------------------------------------------

        Signed-off-by: Junio C Hamano <gitster@pobox.com>
	----------------------------------------------------------------

and the cursor blinking at the beginning of the file.  Annoyingly
this step breaks it by removing the leading blank line.
