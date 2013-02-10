From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sat, 09 Feb 2013 19:45:48 -0800
Message-ID: <7vpq08u903.fsf@alter.siamese.dyndns.org>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
 <1360425499.3369.10.camel@t520> <7vehgpum7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 04:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Nrz-0002HM-5d
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 04:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761019Ab3BJDpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 22:45:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760983Ab3BJDpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 22:45:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5CDAC48E;
	Sat,  9 Feb 2013 22:45:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=un0e1MOJTrQxLlwm2jWD5R84cfU=; b=Z/mYTQ
	wLvSJPMYMS3A+usiiOTWdaDWEoNWuQgqKPU9ExtZ3PIWECd6yL91BVE9H6Ltx47G
	z4H4vLCM+F41ksYx1GOZ6I8xBSaX7F6Od5U7ZrzEqsfKzgDMSCHi/ewRveaQcE6e
	Dz4ys0p8S2Fs09bctWVLqlmumORgKzWOpLLpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pufvpO9Mc/P01aMgj+6ByQ1D6ThyRnz6
	lozMotkQZv4sxwNZrlKogAzkFg5IqnUv380SD7zKXq2HQFkJ+2qj4j+H7KTUmcUl
	kyTT4Iokf7cgje4qiePS3fV2aBhAiS7qtOj7LcPDRMcJHiVw5KogaDCFpTOKRf2a
	YoQhIgP1AxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61BAC48D;
	Sat,  9 Feb 2013 22:45:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32B26C48B; Sat,  9 Feb 2013
 22:45:51 -0500 (EST)
In-Reply-To: <7vehgpum7n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 09 Feb 2013 15:00:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D1C217A-7334-11E2-A8BD-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215892>

Junio C Hamano <gitster@pobox.com> writes:

> I am not Phil, but if you ask me, I think it is borderline between
> "meh" and "no way we would give a short-and-sweet -i to something
> like this".

I think one reason it was "meh" for me is that we never did an
equivalent of "cvs export" and "svn export", primarily because
we had "tar-tree" (aka "archive --format=tar") first, and it was
sufficient to pipe its outputto "tar xf -" if somebody wanted to do
the non-existent "git export".  Also "tar-tree" was more useful for
people who wanted to eventually want to have a tarball (you can
first "export" and then "tar cf" the resulting directory).

But I think it is fine to add "git export <revision> <directory>",
which may look like this, perhaps.

	#!/bin/sh
	# git export <rev> <directory>
	rev=${1?revision} dir=${2?directory}
	. $(git --exec-path)/git-sh-setup

        mkdir -p "$dir" || exit
        git archive --format=tar "$rev" |
        tar Cxf "$dir" -
