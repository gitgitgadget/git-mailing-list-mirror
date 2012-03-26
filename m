From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] Teach revision walking machinery to walk multiple
 times sequencially
Date: Mon, 26 Mar 2012 14:28:49 -0700
Message-ID: <7v1uofnjam.fsf@alter.siamese.dyndns.org>
References: <20120213092541.GA15585@t1405.greatnet.de>
 <20120213092730.GB15585@t1405.greatnet.de>
 <7vfwee9p1t.fsf@alter.siamese.dyndns.org>
 <20120326193241.GA41087@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:28:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHTG-0001q7-II
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985Ab2CZV2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 17:28:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755541Ab2CZV2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:28:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDCD7D85;
	Mon, 26 Mar 2012 17:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q+PHpT3mcgGfYvPJpPeTgMo5RbY=; b=Hz834m
	IHFpCWBlu2C9MeiOi4VXjEiKIt4NFCrxiijLLE94WQVJfnhTAVVi682bpccT8qON
	Nv63Qt/g+VU+5UWUvaPXtmY6EuVVzKkG4KM1pvCVtbGL8efHOgDPX6dB9yYLTLmv
	MbjXmxyHLkKWjbbTtUKOb4C8SklED911hOsww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sc2oydwkTOph+j6a3mEItXFv7aE9ayvm
	09EtwYx4B7QOJOo2gFBvajv9arjvebgDwjv5u7HaT9UyhxOd6jDaezQtU3QMTHPG
	+LPPG9yaBDy1kGljQwsqqFvrgLLzE68jzuAopM2nEsXhGWQ81esuQPJenz+KFA+4
	ohPcmlHhZBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76DDC7D84;
	Mon, 26 Mar 2012 17:28:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6067D82; Mon, 26 Mar 2012
 17:28:50 -0400 (EDT)
In-Reply-To: <20120326193241.GA41087@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 26 Mar 2012 21:32:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE41ED60-778A-11E1-9751-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193980>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> > +{
>> > +	clear_object_flags(SEEN | ADDED | SHOWN);
>> > +}
>> 
>> But is this really the right API?  After a particular program finishes
>> using the revision walker, wouldn't it want to clear both the set of these
>> standard flag bits used by the traversal machinery, as well as whatever
>> program specific bits it used to mark the objects with?
>
> Well if a program uses extra flags on objects it should clear the flags
> it set by using the clear_objects_flags() function itself. For example if
> the program wants to reuse those extra flags in a second revision walk
> it would not be possible if reset_revision_walk() would clear all flags.

OK.

>> These two hunk look like a *BUGFIX* to me (certainly it does not look like
>> this is an addition of any new feature).
>> 
>> What bug does this fix, and how is the current submodule code broken
>> without this patch?  Can you describe the problem in the log message, and
>> add a test to demonstrate the existing breakage?
>
> There is no breakage I know of. Its rather a cleanup which allows to
> call these functions multiple times. I did this to avoid surprises.

OK.

Thanks.
