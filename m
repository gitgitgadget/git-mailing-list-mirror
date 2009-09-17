From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] reset: add option "--merge-safe" to "git reset"
Date: Wed, 16 Sep 2009 22:23:12 -0700
Message-ID: <7veiq6kuv3.fsf@alter.siamese.dyndns.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org>
 <20090916041443.3737.63217.chriscool@tuxfamily.org>
 <7vfxamzqga.fsf@alter.siamese.dyndns.org>
 <200909170554.49416.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 07:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo9T2-0007af-O0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 07:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZIQFXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 01:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZIQFXb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 01:23:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZIQFXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 01:23:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBC4D54E50;
	Thu, 17 Sep 2009 01:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=HS/vBr9h/QEiLrei/XrNBDF1OQg=; b=EmPRWj
	6hQtfVesyA2HHPQiKCVV+Yera7PQ+jatRJoCqFZgCKkw5XxnPH3QVBhO5zb4tda8
	7IvLnpjbpc/qogXFB09lrpIQz30jI52FLlC2G91x2stoE76n91qQtorkmwaQ+O4w
	6v0nxNYqQMZpcurWGV0ojTJlV2xMhXM5zkt8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ttl7D5WxqAS82ZhrdhQYRykLvsb5NbBA
	QJuoFWoWo3F0kEX2UH/WheBlVJ3H/lu64rMwBh4Ss19COvRwovl1FOhnb3mzfSJ3
	b/besWt6wchmcCmRfVt9Il9ZSQ7ax4kj7U46SelnhKkxpfuuHkuFGefbpjE+zi/X
	pNkQY9ZoFT4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69EC654E4C;
	Thu, 17 Sep 2009 01:23:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0458254E44; Thu, 17 Sep 2009
 01:23:13 -0400 (EDT)
In-Reply-To: <200909170554.49416.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu\, 17 Sep 2009 05\:54\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39697D94-A34A-11DE-9BC2-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128712>

Christian Couder <chriscool@tuxfamily.org> writes:

> But I think that it can be usefull in case like:
>
> $ "hack something"
> $ git commit ...
> $ "hack something else"
> $ git add "some of the files"
> $ "find out previous commit was crap"
> $ git reset --merge-safe HEAD^
>
> Here using "--merge-safe" can be usefull because you don't want to lose 
> stuff in your current index and work tree.

That depends on the reason why you are resetting away the "crap commit"
and what your next move is.

If you are going to run "git commit", perhaps after some further edit, in
order to fix what the "crap commit" did not quite do right, what your new
option does is actively a wrong thing to do.  "Some of the files" you
added after that "crap commit" are about "hack something else", i.e. not
part of the work to fix the "crap commit", and their changes should not be
included in the amended commit, no?

In general, "reset" should be about matching the index entries to the
named commit, so that you can start from the clean, known slate to redo
the commit you wanted to make on top of it.  You would need a very good
use case to deviate from it and leave the index entry different from that
of the commit you are switching to; otherwise you would greatly confuse
the end users.
