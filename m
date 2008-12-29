From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-add --verbose should say when something is already indexed
Date: Mon, 29 Dec 2008 01:02:32 -0800
Message-ID: <7v63l3e4lz.fsf@gitster.siamese.dyndns.org>
References: <87eizr32db.fsf@jidanni.org>
 <20081229175258.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHE2b-0002j4-8t
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYL2JCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 04:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYL2JCl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:02:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYL2JCk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 04:02:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6948A1B47C;
	Mon, 29 Dec 2008 04:02:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D22451B463; Mon,
 29 Dec 2008 04:02:33 -0500 (EST)
In-Reply-To: <20081229175258.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 29 Dec 2008 17:52:58 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71013706-D587-11DD-92DE-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104086>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting jidanni@jidanni.org:
>
>> git-add or at least git-add --verbose should say upon
>> $ git-add bla.txt
>> $ git-add bla.txt
>> bla.txt is already in the index.
>
> I do not think it should.
>
> I suspect that you misunderstand what "git add" is. It is not about adding a new path to be tracked. Rather, it is to add the current contents of the file (unless --interactive is used).
>
> You told git to add the contents of "bla.txt" to the index as path "bla.txt". I do not think there is anything more to report after it did exactly what it was told to do.

That is almost (say, 98%) true, but it is not absolutely outlandishly
unreasonable if somebody wants:

    $ git add bla.txt
    $ edit bla.txt
    $ git add bla.txt

and

    $ git add bla.txt
    $ git add bla.txt

to behave differently.  The latter is a pure no-op.

Having said that, I do not think it is worth it.  For one thing, if you
did:

    $ git add .

after making changes to a few files and created one new file in a project
with 20,000 files, command would say "Yo, bozo, you told me to add the
same contents for path X" for 19,998  times.

If the report were not negative as Jidanni suggests, but instead were
positive, i.e.

    $ git add -v frotz.txt nitfol.txt
    added new contents for frotz.txt
    added new contents for nitfol.txt
    $ edit frotz.txt
    $ git add -v frotz.txt nitfol.txt
    added new contents for frotz.txt

it might be slightly more useful, but I doubt it is that useful in
practice.

I won't reject a patch if it is cleanly done, though.
