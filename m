From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] fetch-pack: save shallow file before fetching the
 pack
Date: Mon, 01 Apr 2013 07:53:57 -0700
Message-ID: <7v6206l2t6.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1364728148-7537-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 16:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMg7y-0008Rp-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 16:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537Ab3DAOyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 10:54:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758437Ab3DAOyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 10:54:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CB411DED;
	Mon,  1 Apr 2013 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=29dEM3Pwfsrh
	28UbqX6aKBLXy8E=; b=waJN6i6A1cV8YbZIi5hu9epaZaMvg5SDAZjxzH45B211
	ziB0pfjX9KcF/2Z38yJqLY+u7+61+x1LvkS60pFatf1L4iGX6hDvlCGDnB0kByDd
	mZXac+jSZlbRu/OWMTwdhJDngDFH6UfEud9nV0wCHjzd3qz5zdNXpgGmzpITmTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bfSps5
	adir5Ifz7I/wx+/qkcX3R5wt+LK06GA+7lXBL4mDq1lYT+0OD3Jg0bfPKpSsMaw0
	heeH0da6EboXoC/5gKgNG1ECFlbvJLk1dQjCN/0oh2UdVd4sQ1mTqPWIkqhLjWeC
	70R+iSKY07XQ/tw2DJxRS8XB10WquOruykN04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F211F11DEC;
	Mon,  1 Apr 2013 14:53:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D5511DEB; Mon,  1 Apr
 2013 14:53:59 +0000 (UTC)
In-Reply-To: <1364728148-7537-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 31 Mar
 2013 18:09:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC4DB0C8-9ADB-11E2-A5D4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219689>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> index-pack --strict looks up and follows parent commits. If shallow
> information is not ready by the time index-pack is run, index-pack ma=
y
> be lead to non-existent objects. Make fetch-pack save shallow file to
> disk before invoking index-pack.

I think the problem the patch is trying to solve _is_ real, but I
wonder if this is a correct approach to solve it.  What happens if
we die in the middle after writing the updated shallow file
prematurely?

Perhaps the index-pack (or any "Git" process in general) needs to
learn a way to use an alternate shallow file, instead of always
using a hard-coded git_path("shallow"), so that you can flush an
updated one to a to-be-the-next-shallow-file, run fetch-pack with
that alternate shallow file, and rename it to the final name at the
end after everything goes well, or something?
