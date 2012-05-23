From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] sha1_loose_object_info: do not complain out loud
 on non-existent objects
Date: Wed, 23 May 2012 09:01:24 -0700
Message-ID: <7vvcjm28ff.fsf@alter.siamese.dyndns.org>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-6-git-send-email-pclouds@gmail.com>
 <CACsJy8A5Xv8_KY2z4eQvm2e=3e=KjDJyVM+-d0dmXntHJ-6efg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:02:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXE0n-0004vJ-Ob
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175Ab2EWQBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 12:01:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965104Ab2EWQBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 12:01:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 817698C88;
	Wed, 23 May 2012 12:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=liXBfaOlJGvx
	uL8aRqpmN7xxaeE=; b=Ob5bu1C3gzqi7qpa4t2qFqxN8ugZajXwdqHsTo0VZ5uw
	wnpNBdysm4igQ2i+mAXeIaQIwcQHIA2quw3vH3ZFOMgOFUZ2R3uR67Aj3yKg9jZ6
	Vk4rWOULjf61KqVGET1mkrs5Z2qI4bvGhvtJJQAFkQ9RvfpEDz48uRNpP8u4hG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H97KUu
	14S8PTzTSiFWIW9kiTx8uKmCzZtN0YBXCTCwD370nFSoeS22mwuWcv23jgoxvNh2
	DmISv+5dF/tLBEs18XYdE/fXQPcrYDJoGQfUjPlUaPCwHieVPae8W5dy7EsxxMaj
	TOl4YW00k997xyhxA8KxxTPRlF8d6ZD+d+ssE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77CA78C87;
	Wed, 23 May 2012 12:01:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C98CD8C84; Wed, 23 May 2012
 12:01:51 -0400 (EDT)
In-Reply-To: <CACsJy8A5Xv8_KY2z4eQvm2e=3e=KjDJyVM+-d0dmXntHJ-6efg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 23 May 2012 21:24:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C3FDEC2-A4F0-11E1-8574-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198302>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, May 23, 2012 at 9:09 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> makes sense to me, but I might have overlooked something
>
> while it's still making sense for me, i think it's more logical  to
> move the check to the caller, where "entry in pack?" check is also
> done.

I think most of the callers of sha1_object_info_extended() are using th=
is
function, saying "We expect this object to exist somewhere, perhaps in
pack or perhaps in a loose form, and trying to see what it is", and the=
y
rely on the first error message "unable to find" to be issued.

So in that sense, I do not see how this patch makes any sense at all.
Care to point out a codepath where we throw a random 20 bytes at it in
order to see if an object with the given object name exists?  That woul=
d
be the only case where "unable to find" might be an unwanted error
message.
