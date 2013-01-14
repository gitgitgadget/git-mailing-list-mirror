From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 11:06:47 -0800
Message-ID: <7v622zbn3s.fsf@alter.siamese.dyndns.org>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
 <50F3F852.8060800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Karpenkov <george@metaworld.ru>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupNH-0008Ez-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab3ANTGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:06:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757565Ab3ANTGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:06:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4632CBC90;
	Mon, 14 Jan 2013 14:06:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bwndUT8x/05HtGKU/3c/CHIOigY=; b=SrCe6x
	2UrW6Zi6pMdOYFn/4NtMWFtAYes8JvhEa8hiJeo9dciH8XQf9UCYM/XoUpbOdSN8
	0AEZ2/sZgqLEYr4RZsYNEC9onGPh72G9CagYj+bM9zvhYGGE7PVkUWWCrI/rizqT
	tDtEJzu8GrHwpwU2xvVo0T9kDpWDfdR6l2MbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obIfs/QZu6vFaQoL7HA74rDGPAZezMea
	bkijLkNNHqa7K0B+CU8QHqrw/NwLKJMyM2DR/pxQRXYqfz8lFKHevfukPc73+Aiq
	jIEahS3JRcRJMZiBfz0JOy2vklLevnxVaWcdUfZJJJqP7TrfincX1mbWfrVRy563
	64SMTCG3fXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A1D2BC8F;
	Mon, 14 Jan 2013 14:06:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 966B4BC88; Mon, 14 Jan 2013
 14:06:48 -0500 (EST)
In-Reply-To: <50F3F852.8060800@viscovery.net> (Johannes Sixt's message of
 "Mon, 14 Jan 2013 13:21:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BF05A8C-5E7D-11E2-9E17-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213516>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 1/14/2013 12:40, schrieb George Karpenkov:
>> I've managed to corrupt my very valuable repository with a recursive
>> sed which went wrong.
>> I wanted to convert all tabs to spaces with the following command:
>> 
>> find ./ -name '*.*' -exec sed -i 's/\t/    /g' {} \;
>> 
>> I think that has changed not only the files in the repo, but the data
>> files in .git directory itself. As a result, my index became
>> corrupted, and almost every single command dies:
>> 
>>> git log
>> error: non-monotonic index
>> ..git/objects/pack/pack-314b1944adebea645526b6724b2044c1313241f5.idx
>> error: non-monotonic index
>> ..git/objects/pack/pack-75c95b0defe1968b61e4f4e1ab7040d35110bfdc.idx
>> ....
> ...
> Try the reverse edit:
>
>  find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;
>
> Remove .git/index; it can be reconstructed (of course, assuming you
> started all this with a clean index; if not, you lose the staged changes).

Everybody seems to be getting an impression that .idx is the only
thing that got corrupt.  Where does that come from?

I do not see anything that prevents the original command line from
touching *.pack files.  Loose objects may have been left unmolested
as their names do not match '*.*', though.
