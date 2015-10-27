From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] submodule update: expose parallelism to the user
Date: Tue, 27 Oct 2015 13:59:49 -0700
Message-ID: <xmqqk2q8ni2i.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 21:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBLX-00013c-Tq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 21:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965798AbbJ0U7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 16:59:53 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965533AbbJ0U7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 16:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D89EE261F1;
	Tue, 27 Oct 2015 16:59:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6jPyqgw44Q3i5dJl6ac8tHfE0yg=; b=dZuKgl
	w+KhhRZBOR8tzU/kmX9UeZ9mVwo8Ah5a3WKYNCkBOW2ZV0xr47onfAYT5XvrkkWi
	oGqelsSnJCSa+JWiYWb2oyl8AVDS7zuzAvAWW78p2TLz/EUEYjJDA7u0rfu/9M8d
	JC9//ISrOU3hZbl81op8z5AIIrQXxIPo6ulb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tfakA+W7nwEtHIZwhHnquNr0/a5bkF4V
	wEFYerP3XVb8c4m0FR68yh6EQ94BCnDXZ2YkUFLWad4a9cQoXdXKZAs1hDE2k14B
	9oF8UQr7U5q+JgWTcaXZsZM7KwZQOs3PR8WqfjxngREw3x67pXaZwjm2yteqVTQx
	FkzSMYzbT8Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF169261F0;
	Tue, 27 Oct 2015 16:59:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D919261EE;
	Tue, 27 Oct 2015 16:59:50 -0400 (EDT)
In-Reply-To: <1445969753-418-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 27 Oct 2015 11:15:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9E31246-7CED-11E5-B182-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280296>

Stefan Beller <sbeller@google.com> writes:

> @@ -374,6 +374,10 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  	clone with a history truncated to the specified number of revisions.
>  	See linkgit:git-clone[1]
>  
> +-j::
> +--jobs::

This probably should be 

          -j <n>::
          --jobs <n>::

(see comments on [6/9]).  I know the option description in this file
is sloppy and does not say "--name <name>" etc., as it should (but
it does say "--reference <repository>"), and fixing them may not be
within the scope of this series, but we do not need to add more to
the existing problems.

> +	This option is only valid for the update command.
> +	Clone new submodules in parallel with as many jobs.

And when 0 starts to meaning something special, we would need to
describe that here (and/or submodule.jobs entry in config.txt).
As I already said, I do not think "0 means num_cpus" is a useful
default, and I would prefer if we reserved 0 to mean something more
useful we would figure out later.

Thanks.
