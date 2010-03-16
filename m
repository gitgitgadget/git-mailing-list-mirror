From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 21:19:17 -0700
Message-ID: <7vbpeovqyi.fsf@alter.siamese.dyndns.org>
References: <20100315214003.GB11157@pixar.com>
 <20100316023306.GA14253@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Damerow <lars@pixar.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 16 05:19:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrOFg-0006YQ-FI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 05:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab0CPET1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 00:19:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab0CPET0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 00:19:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88F59A1F53;
	Tue, 16 Mar 2010 00:19:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gvkt4dHVliQm+9sxRU9lTfI95qQ=; b=I+6RgH
	7gAA/VMhrPgLWf8b5Rh99HeqxsVzJ8p3dpwAfQWv1SaVNZ3Rw1xQtuwDbFp9pz9t
	3VyyUgkr/BXVnqHu9PgU1S/LDB/iP/A6E1VzdZVHVKfmb6RxfBp1h7rQEca85T2T
	vGdN50sgZslmKa91XVA5MRjbHoq7UZdSQnjFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rr22rOY28/GKxeMBcjx/FxvtZVolLYCN
	VUFIeoRGH/0HcoFE18bunYyTsKS3DzLsRks0qBEC/WlrauQlucRQdzvgruIjVJrD
	5ZeMAjW4311xW5/Y+HA6YCmdoxZdE23m75Am5a4aUi2E9LkCtrv5JtEDddvwHOYX
	77V0GbYWhR4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54D69A1F51;
	Tue, 16 Mar 2010 00:19:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9698A1F4B; Tue, 16 Mar
 2010 00:19:18 -0400 (EDT)
In-Reply-To: <20100316023306.GA14253@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 15 Mar 2010 22\:33\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 191EEA50-30B3-11DF-9628-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142297>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 15, 2010 at 02:40:03PM -0700, Lars Damerow wrote:
>
>> +		if (getenv("GIT_ONE_FILESYSTEM") != NULL) {
>
> Should this really trigger for GIT_ONE_FILESYSTEM=0? We already have
> git_env_bool, which will handle 0/1, true/false, etc. Probably you
> should use it here.
>
> I am not a big fan of the environment variable name, either, but I don't
> have another good suggestion. It is closely related to
> GIT_CEILING_DIRECTORIES (in fact, you could probably solve the same
> problem with GIT_CEILING_DIRECTORIES, but I think your solution is much
> nicer in that it lets the user get away with being less verbose).

Yeah, that, or toplevel global option --one-file-system given to "git",
but I think that is probably too cumbersome.

How inefficient is it to repeatedly call getenv() in a loop, by the way?
I think the patch would become easier to read if env_bool() is called once
at the beginning to set a local variable, and not even do the initial stat()
for "." if this feature is not asked for.
