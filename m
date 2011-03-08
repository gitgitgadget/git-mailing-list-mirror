From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] vcs-svn: use higher mark numbers for blobs
Date: Tue, 08 Mar 2011 11:08:20 -0800
Message-ID: <7vzkp5e8gr.fsf@alter.siamese.dyndns.org>
References: <20101210102007.GA26298@burratino> <20110306225419.GA24327@elie>
 <20110306230348.GC24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:08:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2H5-000488-BX
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab1CHTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:08:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1CHTIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:08:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 475AB4EF3;
	Tue,  8 Mar 2011 14:10:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tX8I3lUl5AIaP643OpPES8pqX70=; b=qDEuUa
	Ut6wlYBSLXaoV+a8LY3w1Op/cADXoHoqxNGUhB0ht4kfbkXJwriQ3Bs+gUa3Rj+J
	kJAT3NFu/nOPlEMR+NgmQvIrmn/FwXMU1/FzUbQGgSVOVMEOK+5U4n+waJ/EyHFi
	2BJc8Xa51mPp7MUzVNfMWqFakKf5E0resc3YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1bPsllTNO2GI9NQTDgGNT8QeuBOOzYP
	rmIT457Pd1/bQbQIDp/EQobBCT0E4J+cSK88IscWER7RyBIDngtQ94dvN3B1J4I1
	95L3p9RiTiX1UoJ3UzzX0RvIsIQLh6uXnmfq2fF7zpG7gRw3j4PWN7tTMAtCwVig
	zlgpwqmEd9s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B85E94EF1;
	Tue,  8 Mar 2011 14:10:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B319D4EEE; Tue,  8 Mar 2011
 14:09:48 -0500 (EST)
In-Reply-To: <20110306230348.GC24327@elie> (Jonathan Nieder's message of
 "Sun, 6 Mar 2011 17:03:48 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB875E7C-49B7-11E0-9D8E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168675>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Date: Fri, 10 Dec 2010 04:21:35 -0600
>
> Prepare to use mark :5 for the commit corresponding to r5 (and so on).
>
> 1 billion seems sufficiently high for blob marks to avoid conflicting
> with rev marks, while still leaving room for 3 billion blobs.  Such
> high mark numbers cause trouble with ancient fast-import versions, but
> this topic cannot support git fast-import versions before 1.7.4 (which
> introduces the cat-blob command) anyway.

Hmm, 1G+3G split?  Will we have HIGHMEM option someday? ;-)

How confident are you that you will never need more than two classes later
and you will never need to split the larger space again?

If you are not, and if the topic is to introduce incompatible output,
would it be wiser to be even more forward looking and introduce different
classes of marks with a backward incompatible syntax, perhaps like using
":\d+" for anything, and using ":[a-zA-Z0-9]+:\d+" for some application
specific "class" of objects that is specifed by the [a-zA-Z0-9]+ part?
