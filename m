From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 18:10:41 -0700
Message-ID: <7vmxeabm5q.fsf@alter.siamese.dyndns.org>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
 <7vty8iolnj.fsf@alter.siamese.dyndns.org>
 <348F09EE-5EE2-4F3E-B1B1-6FD34BDBD117@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 03:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2v4K-0005EA-QY
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 03:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab1ILBKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 21:10:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab1ILBKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 21:10:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84A334CCE;
	Sun, 11 Sep 2011 21:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fpnw7OdHk4vxVJWHfoda8k28b40=; b=C6Gx4r
	Y+ypwvvG74D9H3VL61tAtLF18bq3AGaRh6S6TH6wAS11Yipn6QTKhrDhadub6UAu
	ycPFGiGYJFo8CBdsTfyrM5QnHM8dLlwxIz5j/uWuf+9wvNZ/aWqAzvJZSq4x4euH
	hE+Fy21UHbbyb03fO0Oeims/B2e+Gzrp+sKz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9NXX9Z7U8jsyz1vZ+KHxYyq6G05y6XN
	yJGcGP7vk4RcB427k+ujh8Tvt5dcozkMdwyLIgGdCUIWDmlzmFwhNUjBcQhQ5YhN
	UtBTdQnwsR6JnZIgmRr609DWd0hjOnEks4HAe+9cUtjExp3vr0qFAjTyt7K6JU3G
	db9ioLWR1+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D09C4CCC;
	Sun, 11 Sep 2011 21:10:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED0744CCB; Sun, 11 Sep 2011
 21:10:42 -0400 (EDT)
In-Reply-To: <348F09EE-5EE2-4F3E-B1B1-6FD34BDBD117@bjhargrave.com> (BJ
 Hargrave's message of "Sun, 11 Sep 2011 17:43:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09678D48-DCDC-11E0-902F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181203>

BJ Hargrave <bj@bjhargrave.com> writes:

> On Sep 11, 2011, at 16:43 , Junio C Hamano wrote:
>
>> Funny.
>> 
>> I am sure we fixed a similar breakage elsewhere a few years ago, by
>> swapping the size and nmemb to the calls (i.e. instead of writing one
>> block of "size" bytes, you could write "size" blocks of 1-byte) and making
>> sure fwrite() reports the number of items. IOW
>> 
>> 	if (buf && fwrite(buf, 1, size, f) != size)
>> 		die_errno("Could not write '%s'", filename);
>> 
>
> Do you want me to resubmit the patch using this technique instead of the size > 0 check?

Not really.

I am not sure when/why we would try to write an empty blob out to begin
with...
