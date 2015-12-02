From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Wed, 02 Dec 2015 09:25:24 -0800
Message-ID: <xmqqd1uo69vf.fsf@gitster.mtv.corp.google.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
	<20151202005338.GD28197@sigill.intra.peff.net>
	<xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
	<20151202024403.GA29329@sigill.intra.peff.net>
	<xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
	<20151202164712.GA16636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4B9t-0002qV-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 18:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992AbbLBRZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 12:25:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758960AbbLBRZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 12:25:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 431922F556;
	Wed,  2 Dec 2015 12:25:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IdGsNN8J1mXcpcsS3Ua++ourOXU=; b=e3ezaW
	6RUV76B73HK4QFwZAJy1fqb6y31ts2TXTQYiRCNQn7mpOkTgcXrbx6EcmZvVtyGS
	Ggwgl3AoIsQYrdmtXJAS8ZJEhAUkzSs2/ENIgpykFzofDu5T8Dk9jdBcB1qC0IUu
	Sk4UGB9O5oI/A8d3Qd/X+5ojEsN/AP+4sqkWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b5DdZarGb+w1MXdTprWdCWq57hA0L/9G
	/JINi7WpOvja7BUqXle66ncIEJh+DdqSkzlKP8EX3PG4HJWUKYB7Vk8sI8O9em5X
	b3gZtCPj9zg+I6SzZpQrx4NSLWei/Y2leuuVaZIWKf6SaGPmcPjZrI1usfdlmE4z
	uY1FMmXlJB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FF322F555;
	Wed,  2 Dec 2015 12:25:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9EA3F2F554;
	Wed,  2 Dec 2015 12:25:25 -0500 (EST)
In-Reply-To: <20151202164712.GA16636@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Dec 2015 11:47:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACC6FD0E-9919-11E5-9CB6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281894>

Jeff King <peff@peff.net> writes:

> .... So maybe "clean" is really the only place where people care
> about such ad-hoc exclusion. Or maybe this an opportunity to add:
>
>   git --exclude='*.o' clean
>
> I dunno. I cannot think of a time when I would have used any of those
> options myself.

Me either and I do not think I ever wanted to use -e to "clean".

I do not think we should liberally add options that apply to
anything "git" in the first place [*1*].  Limit them to ones that
are really special and fundamental that changes the way Git
operates, i.e. "Where is our $GIT_DIR?" is a good thing for users to
be able to tell "git" itself.  Compared to that, the ignore patterns
is a fringe that is used only by commands that care about the
working tree (e.g. the global option in "git --exclude='*.o'
ls-tree" would be meaningless).


[Footnote]

*1* It would add unnecessary confusion to the end users; they have
    to decide if they need to pass an option before or after the
    subcommand name.  If the motivation behind the "git --option cmd"
    is to share code and semantics for common "--option", we should
    instead further refactor command line option handling, just like
    the code for config handling allows us to share config_default.
