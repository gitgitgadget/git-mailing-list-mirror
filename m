From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling
 improvements
Date: Tue, 22 Mar 2011 22:46:03 -0700
Message-ID: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 06:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Gtj-0005Wy-4Q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 06:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1CWFqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 01:46:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab1CWFqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 01:46:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06BFA239F;
	Wed, 23 Mar 2011 01:47:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MktP+2twsVdLlJl0v8ldVOqXJRc=; b=bwytAZLTeUmYyIRk0AI8
	VOQ20MPL8E/0i0P2zPVf6IZ2MPuhlaxRiqUiYSfP2NN6/93FxSfBD8blZcB0kjbx
	2IZw+tNdMqrdNhfk0fKK/HY72eoui+FhXZoGBbzKRnPkMBwxYj2NryF5u5r06z9o
	ssw7ow/q61R7kyhTIYOgRL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fywyhUFL9o9k5JBgtJHbdKjPmAx3QT4UMkJV6dLrf6WGxf
	H/VdC8GbHKtv1NSXKh96FHubYsGkEbUHSjuX/uO3x4F1kq/sSwUSvzjVFhMCtcHk
	32uMkvQbYURpy4g14oc5VURH8qmw1enP6ZmqKw1Hli23vf7QiFFQFLyFTn0NU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7109239E;
	Wed, 23 Mar 2011 01:47:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B11A239C; Wed, 23 Mar 2011
 01:47:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16D11664-5511-11E0-A7DB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169799>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Please pull
>
>   git://repo.or.cz/git/jrn.git svn-fe
>
> to get the following changes on top of master.

Done.

I only gave a cursory look at "git diff ORIG_HEAD" output immediately
after pulling, but I found that the majority of lines deleted were of
questionable style and the added ones looked more like normal C ;-)

Except for

	switch (keylen + 1) {
        case sizeof("constant string"):
        	...
                break;
        case sizeof("another constant string"):
        	...
	}

which looked a bit unusual. But mistakes in this construct can be easily
caught by the compiler that would notice duplicated case labels, so it
probably is not so brittle as it first looks.

By the way, I've been getting annoyed by these three "sleep 100" getting
stuck in t0081 and spending their sweet timeout while running my tests
(prove is on, "make test </dev/null" to forbid it from reading my stdin).
I see attempts to kill them early with "kill $!" but apparently they are
not working. Can you take a look at it?
