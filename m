From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Use "last one wins" convention for --recurse-submodules
Date: Thu, 10 Dec 2015 15:38:24 -0800
Message-ID: <xmqq8u51ho27.fsf@gitster.mtv.corp.google.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<1449148235-29569-2-git-send-email-mac@mcrowe.com>
	<CAGZ79kbxvrMHnJx9iACus44+rmFf6ZNFPArrpVhNr6ZTDj+XOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Crowe <mac@mcrowe.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:38:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7An9-0006i7-JO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbbLJXi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:38:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752659AbbLJXi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:38:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D7E33390D;
	Thu, 10 Dec 2015 18:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hqvnau2nlGXdi0oarOmJ8FipCrE=; b=pcaDtD
	lV5gFM+kmqck27VtxVaFHZ8yrF1wGJTkC9GgMWPDymW/dpePq/lvA6C1SPC5BeeK
	l5kNi1JR6/gIBq3MB4ACTq2Xff5UWVNyCiv1ueg65wni8sGKlpCgJIiki86/BUE1
	epgVDvgRjW/P2R5XkGgtj9T1MRm7LTazXTSgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xTEzOkreEZRD1mopx3uzYOlwZJVwpI5w
	ZSS4eBTeSw3RgsyMqFoWpMkgTk2mdRUuXXdg3f87z648NUTRodMaBrARXRjrjy1z
	+DcH85zV0EyYjYBJrEhekhK7YOZpyMb/MOY3ejacKScjaCTT8Lt6dppxXwiIwmH6
	BHA+XUpjAAw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 043033390C;
	Thu, 10 Dec 2015 18:38:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79F4D3390B;
	Thu, 10 Dec 2015 18:38:25 -0500 (EST)
In-Reply-To: <CAGZ79kbxvrMHnJx9iACus44+rmFf6ZNFPArrpVhNr6ZTDj+XOg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 10 Dec 2015 15:31:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B83000C-9F97-11E5-968A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282242>

Stefan Beller <sbeller@google.com> writes:

>> +               git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
>> +               # Check that the submodule commit did not get there
>
> Do we want to check here that the supermodule commit did get there,
> instead of only checking the submodule?

Hmm, your point is that when the push succeeds, (1) the command
should return with 0 status, (2) the branch in the superproject
should update to the right commit, and (3) none of the submodule
should be affected, and the current test does not check the second
one?

I think that makes sense, in somewhat a paranoid way ;-).
