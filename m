From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit path vs rebase path
Date: Tue, 08 May 2012 10:02:48 -0700
Message-ID: <7vhavqwqpz.fsf@alter.siamese.dyndns.org>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
 <7vaa1j7vg1.fsf@alter.siamese.dyndns.org> <4FA8BBB0.1080406@viscovery.net>
 <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
 <4FA8C5DB.5060002@viscovery.net>
 <CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 19:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnoO-0007f5-U5
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431Ab2EHRCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:02:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393Ab2EHRCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:02:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2936E67;
	Tue,  8 May 2012 13:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B2N5b7cUJ5/2amjRLPDKVtxfZo0=; b=QShShn
	OR8VBDnOlfz+eYAu6051KhhHyEwzonLetxgjAp0EyHf2dshq3ZbJifkRrqyw0QQD
	+b6W5ahAepPscO0RE3m1gJ2KNbXdtl+OwX75QP+p4OY99WZNSGOh/dt5eHPOnJSV
	WC1H9RyzA3LFNjuJ9QMzPgcqs2/SaTFahdB6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVdtQc0cF7G6VfUHGygKOy/aQqsG/+nl
	odGS78MocmLtnOS4X5GiBOy56cYWV/hpM4mz14xfd1JGnNwqPTIo7YEG7+ItNSy7
	IllLlBtdcGHXlQZi/F8qKwtaPS9bv6ThLhpLSA6Jy1U1zwIA3j6IixVUfSbV15gT
	e2QHEprM4tY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2473C6E66;
	Tue,  8 May 2012 13:02:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B5766E65; Tue,  8 May 2012
 13:02:50 -0400 (EDT)
In-Reply-To: <CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com> (Steven
 Penny's message of "Tue, 8 May 2012 02:11:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4CBD310-992F-11E1-A5F9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197394>

Steven Penny <svnpenn@gmail.com> writes:

> Johannes Sixt wrote:
>> Are you saying that the new pwd function will also be used on Cygwin? That
>> would be a bug.
>
> The linked patch should fix the problem for _MinGW_ users.
>
> The problem will persist with _Cygwin_ users.

What does a full pathname, fed as a parameter when invoking Windows native
binaries like notepad, look like in a Cygwin environment?  That is, if you
are writing a bash script that is meant to run in a Cygwin environment,
and if the script takes the name of a file in the current directory, but
it needs to chdir around for its own reasons before spawning notepad on
the file, i.e.

	#!/bin/bash
	file="$(pwd)/$1"
        ...
        cd ..some..where..else..you..have..no..control..over
        notepad "$file"

what is the right incantation to replace `pwd` in 'file="$(pwd)/$1"'
above?

Whatever that is, using that instead of `pwd` in git-sh-setup.sh here:

	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {

would be the solution.
