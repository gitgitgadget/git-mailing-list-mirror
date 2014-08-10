From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update hard-coded header dependencies
Date: Sun, 10 Aug 2014 16:31:06 -0700
Message-ID: <xmqq38d39b2d.fsf@gitster.dls.corp.google.com>
References: <20140808215825.GH12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGcaA-0005ZK-KE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 01:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbaHJXbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 19:31:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52203 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbaHJXbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 19:31:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1B5231C45;
	Sun, 10 Aug 2014 19:31:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ysjGqWDPgJNg+4I0AAqRWiBC80Q=; b=wsM/YE
	3HB3Fwg4KIs/4AFII56A73jxotqm+s+kMdhJdDqFXob+pZ2NGsV+0QuRgj0IYHm1
	2mM+/1fu6NT+NF0tCv4woJzf7QquWB85qS06GNc0Mtu3TI5iwkNkXwgzPtXg3U3o
	FqEwxeF9Ze7wm1uq8Xg0/m2IfBwp7ABujWquI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7F0s2p45uy5l/OXqZxGyBt0wWOerX01
	8+Xrc+wPgGzLZNv8G0OApPBV1rjY/YY7PnMG50t5py8UbjOVFGtly+2ur0d31h9J
	xSIZWftOjaM9L4dSLTt9vUNi8nJ9+PnezO5wF7VTb9GLcTvShKNaI57tEjuWZ5ns
	ZDo97B0B1aQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A986531C44;
	Sun, 10 Aug 2014 19:31:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAE8331C37;
	Sun, 10 Aug 2014 19:31:07 -0400 (EDT)
In-Reply-To: <20140808215825.GH12427@google.com> (Jonathan Nieder's message of
	"Fri, 8 Aug 2014 14:58:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67637DB6-20E6-11E4-9903-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255113>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The fall-back rules used when compilers don't support the -MMD switch
> to generate makefile rules based on #includes have been out of date
> since v1.7.12.1~22^2~8 (move git_version_string into version.c,
> 2012-06-02).
>
> Checked with 'make CHECK_HEADER_DEPENDENCIES=yes'.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Maybe it's worth switching to plain
>
> 	LIB_H += $(wildcard *.h)
>
> ?  People using ancient compilers that never change headers wouldn't
> be hurt, people using modern compilers that do change headers also
> wouldn't be hurt, and we could stop pretending to maintain an
> up-to-date list.

I agree that it is very tempting to declare that we do not manually
"maintain" the dependency list and force people without -MMD to
recompile whenever any unrelated header changes.  Especially that
this patch only works on the 'master' branch and upwards, and does
not even work on 'maint', let alone 1.9 or 1.8.5 maintenance tracks.

Let's consider the merit of that approach after 2.1 is out.  Thanks.
