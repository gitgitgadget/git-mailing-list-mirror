From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Applying for conversion scripts to builtins
Date: Tue, 17 Mar 2015 11:38:39 -0700
Message-ID: <xmqqpp87o4eo.fsf@gitster.dls.corp.google.com>
References: <CAHLaBNJkL1CUJEk=cH=CLcDvZtoAr+PiCo2KHjfMLUKsugtRPA@mail.gmail.com>
	<CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
	<4355599932558291b22313f244eda9bd@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Yurii Shevtsov <ungetch@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXwOF-00053q-It
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbbCQSip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:38:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932237AbbCQSim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:38:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9524C3EA2F;
	Tue, 17 Mar 2015 14:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVmlJhYpbfQjA+5lyh6h46tC/L0=; b=d3vhOw
	Ifcg86xchtFelKH9ldeC6fInBJ1WiS6x2h6yVDSLqtN0TLZ8WbhV2Oz/rrfdoZ1l
	cGyYYDjHzAYD6UpCHcKH5PEN1ZMbN2djTAuGtgxGntLbmTtXZtMxG82dd0+MaiSf
	1cNm2gm4q2a9v44CghVBZfZfdc29s6hsTwAa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=US38cl0ZMSD9eZpPEt1/Ac8cWc0ZJ7U+
	kFbWZwv36r515DzMDtsRS3ZFK+DbWBPs+JaMOFsDFS1+E50qTb2DB9FSvAIn7KPN
	nv6ezzT3ONR8p7V8FgJ20U8jyBMT8t9aMx652ofTdb+efyy6emWtjnRIQCXnOrR3
	4HSu9HxE/6k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DE583EA2C;
	Tue, 17 Mar 2015 14:38:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7BB73EA29;
	Tue, 17 Mar 2015 14:38:40 -0400 (EDT)
In-Reply-To: <4355599932558291b22313f244eda9bd@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 17 Mar 2015 12:56:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D51A4192-CCD4-11E4-BC21-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265652>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Therefore, I would wager a bet that just the mere conversion of a
> shell script into even a primitive `run_command()`-based builtin would
> help performance on Windows in a noticeable manner.

As you correctly allege, if a patch rewrote a shell-scripted
porcelain by using series of run_command() and doing nothing else, I
would have asked "is that an improvement?", without knowing that.

> Of course, it would be *even nicer* to avoid the spawning altogether.

Yeah, that, too ;-)

> The biggest benefit of avoiding needless parsing, however, is not
> performance. It is avoiding quoting issues. This is particularly so on
> Windows, where Git is sometimes called from outside a shell
> environment, where we have to deal with inconsistent quoting because
> it is every Windows program's own job to parse the command-line,
> including the quoting.
>
> Concrete example: on Windows, we have file locking issues because
> files that are in use cannot be deleted. For that reason, we have
> Windows-specific code that is "nice" by trying harder to delete files,
> giving programs a little time to let their locks go. This locking
> issue happens also when a virus scanner "uses"...

These are definitely good advices from the area expert.

Thanks for a bunch of good input.
