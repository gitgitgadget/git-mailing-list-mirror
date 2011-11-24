From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect working only from toplevel dir
Date: Thu, 24 Nov 2011 03:50:22 -0800
Message-ID: <7vd3chage9.fsf@alter.siamese.dyndns.org>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
 <7vzkfma7q9.fsf@alter.siamese.dyndns.org>
 <20111124070659.GC6291@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adam Borowski <kilobyte@angband.pl>,
	git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 24 12:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTXp1-0007Cp-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab1KXLu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:50:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab1KXLuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:50:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E7B301E;
	Thu, 24 Nov 2011 06:50:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QBNvtw/hEbUTHj8a87X0hlWL0Ho=; b=JNukHD
	1LaJNkzvXbW5HdHBf9m4Tv5Ewy7oZpCzt7T3EpN+WqsPp0K1tRMHOS0Id3OSO79T
	igXlUfF0gvDGazFfOcFQgT0RItQodU4kK8lRbPaBFsIpOVFdYrXuq1h6c+XH+SO3
	EFeRAIOjRlMdZzhL4GqJBmebzckJh1FbRMlqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bhEHrAy6WpYZe61rz/q5sLZChg04gja0
	X65cE35ZqENLbjaRj3uzattPNDe3cFtkX7Z5VuYHxEMFQDesBFPRO+3qGVgzOgu1
	zK22L80GzjVCeHfG86iGeHzy7l45pkU+eZD3is7cuEAPhUBvwdfcYiqkubpzUGEt
	r8uQUb/fseM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC46C301D;
	Thu, 24 Nov 2011 06:50:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 685CA301C; Thu, 24 Nov 2011
 06:50:24 -0500 (EST)
In-Reply-To: <20111124070659.GC6291@m62s10.vlinux.de> (Peter Baumann's
 message of "Thu, 24 Nov 2011 08:06:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EB0F982-1692-11E1-9CED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185910>

Peter Baumann <waste.manager@gmx.de> writes:

> On Wed, Nov 23, 2011 at 12:45:18PM -0800, Junio C Hamano wrote:
> ...
>> Also didn't we make bisect workable in a bare repository recently? So the
>> start-up sequence has to be something more elaborate like...
>> ...
>> and then inside bisect_next() you would check if $prefix exists, and go
>> there to run bisect--helper (or fail to go there and say "cannot test").
>
> But is the "cannot test" aka exit(127) the best we can do in this case?

Yeah, thinking about it a bit more, it may probably be better to make it a
failure. The user explicitly asked "be in _this_ directory and run make;
it should succeed for the bisection test to pass". If the bisection test
criterion the user was interested in was a successful build of the whole
project (not the subpart of the current directory), the user would have
gone up to the top-level and "bisect run make" there.
