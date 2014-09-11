From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitk: write only changed configuration variables
Date: Thu, 11 Sep 2014 13:26:05 -0700
Message-ID: <xmqq4mwdewf6.fsf@gitster.dls.corp.google.com>
References: <1410412888-10187-1-git-send-email-max@max630.net>
	<1410412888-10187-3-git-send-email-max@max630.net>
	<xmqqtx4edqgz.fsf@gitster.dls.corp.google.com>
	<20140911191726.GA5549@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:26:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSAwY-000860-FA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 22:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbaIKU0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 16:26:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55952 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbaIKU0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 16:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E16A3AF91;
	Thu, 11 Sep 2014 16:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tTithDfrmSGKfVZ5KFO7DXkE21s=; b=dJk/9Y
	Fb1VO5yZn8/bLl+YNfbpdrB1H0ma+guyMKQxyv3IyiRQHVze3G+PVEGhITxlGCnc
	/znHL+KooiaOG3QFzsaTSIOYZQ3raJBB2rSe+FpAM0xOtEqVLVdqIPklkjamM91Y
	fGveKQrHyDCu7R80rBAIyDXfGCL9Fbl10jqvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLVFcsr1TBL8ZWE0F4MB0PzNUU/f9qs5
	cKZDmiXf4W193avOAIvZLC/VZkde3h5YnnYsJTolGyY/RRDlaXvKCEhVHlqQvbES
	qY4arvSJlphHBny1wr44WP2ZgHrk6JtlJ76bYsLa87OSgCsps3PO1v8Hhxemfybw
	6ZJJ6AWqEqM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 157753AF90;
	Thu, 11 Sep 2014 16:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E0253AF8F;
	Thu, 11 Sep 2014 16:26:07 -0400 (EDT)
In-Reply-To: <20140911191726.GA5549@wheezy.local> (Max Kirillov's message of
	"Thu, 11 Sep 2014 22:17:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC6BEF3E-39F1-11E4-A3C8-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256873>

Max Kirillov <max@max630.net> writes:

> On Thu, Sep 11, 2014 at 10:19:56AM -0700, Junio C Hamano wrote:
>> Max Kirillov <max@max630.net> writes:
>> 
>>> If a variable is changed in a concurrent gitk or manually it is
>>> preserved unless it has changed in this instance
>> 
>> It would have been easier to understand why this is a desirable
>> change if you stated what problem you are trying to solve before
>> that sentence.  "If I do X, Y happens, which is bad for reason Z.
>> With this change, Y no longer happens as long as I do not do W."
>
> Something like:
>
> """
> When gitk contains some changed parameter, and there is
> existing instance of gitk where the parameter is still old,
> it is reverted to that old value when the instance exits.
>
> After the change, a parameter is stored in config only it is
> has been modified in the exiting instance. Otherwise, the
> value which currently is in file is preserved. This allows
> editing the configuration when several instances are
> running, and don't get rollback of the modification if some
> other instance where the cinfiguration was not edited is
> closed last.
> """
>
> Does it looks appropriate?

Yeah, except for the phrase "after the change" may give me a hiccup
or two while reading, because it is unclear if "the change" refers
to this patch (which is the intended interpretation) or the change
made in one of these two instances of gitk process.

Expressing the behaviour your patch modifies in the imperative mood,
as if you are ordering our codebase "to become like so", would avoid
such a hiccup, i.e./e.g.

	Re-read the current on-disk configuration variables and
	overwrite only the ones changed in this process when saving
	the file, to preserve the changes made by other instances.

or something like that, perhaps?

> Though storing the old value and comparing to it makes sanse
> to do anyway, because trace may produce bogus events, so it
> would be better to doublecheck has the value actually been
> changed.

Exactly.
