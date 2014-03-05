From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 08/11] trailer: add tests for "git interpret-trailers"
Date: Wed, 05 Mar 2014 14:59:30 -0800
Message-ID: <xmqqob1kz1yl.fsf@gitster.dls.corp.google.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.44333.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:59:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKmo-0004Mv-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbaCEW7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:59:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbaCEW7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:59:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1DD70127;
	Wed,  5 Mar 2014 17:59:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Zy1QggW3wp8MRywQ6HKKVynC944=; b=BpOV47IDM3hys9tkom/R
	a/0UEujHwMZVvBAwZTADDJPESCbckvoaC/eFbzvR+8yLmNts5NdlZvaLIx6XdU++
	OrSzgJzdzCirqyx7ZWUcn4F3ct4sArIVNSBthcnicTOM3y7cE3BCO/65T/SdUfeK
	DEsXeyYzpJHjro3VA6vvYIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lVCfCig/WH4/S/ZaYlsV/NcfQkExjw7bw/JjBEaKNnQJU7
	mhpO4J+GBtwNqXl7N9sXZWdQ6onDtmRzeaEApP4pUF8nm+cf74muAgc23TlnUNS2
	nddRUsKVE1GLWSrVLgfxsOC0SPunjVAn6t6s2AKw0mLAiAUupbn4wf3ChaUTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4671D70126;
	Wed,  5 Mar 2014 17:59:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30FE070125;
	Wed,  5 Mar 2014 17:59:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D05CC98E-A4B9-11E3-A00A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243493>

Christian Couder <chriscool@tuxfamily.org> writes:

> +# We want one trailing space at the end of each line.
> +# Let's use sed to make sure that these spaces are not removed
> +# by any automatic tool.
> +test_expect_success 'setup 3' '
> +	sed -e "s/ Z\$/ /" >complex_message_trailers <<-\EOF
> +Fixes: Z
> +Acked-by: Z
> +Reviewed-by: Z
> +Signed-off-by: Z
> +EOF
> +'

It is a bit disappointing to see that these are flushed to the left,
when the here-doc redirection uses "<<-\EOF" (not "<<\EOF") to allow
you to indent, i.e.

	sed ... <<-\EOF
        foo
        bar
        EOF

or even more readable:

	sed ... <<-\EOF
	        foo
	        bar
        EOF

no?
