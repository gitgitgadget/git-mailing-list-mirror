From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 01:23:07 -0800
Message-ID: <7v622qhouc.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr> <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 10:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxDbK-00060C-87
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 10:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab3AUJXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 04:23:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab3AUJXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 04:23:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA9D9A11;
	Mon, 21 Jan 2013 04:23:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02vAG4bOMwMUEFT2QWGU3PX2rHM=; b=vFQHKF
	Uf+BV7bzIMVEXR+T6QHuUE+83RnGneSYIACRHiQy9rBdREAw2T7QF1xTU+Qf13GR
	WZM4zo4nDe4Kh26rrNdxKUsoBmTlQpjhDftKUq939nKyi84NtpzI0twKANhPbTPI
	KM/t7DwqFEdTnn0QaX4brf8yuesJdTZ9XKC4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BS1iwLxnsaeEakGVwdzAumpToBdy6+mv
	FB3wlBIqZti8T7iV9EBbDmpiCeVSlOz6bCqjyzKkkkYiuzwfe99O8NCbfzITyMKi
	WD9NtJTJ2Q1yO9itaIxk15bXoo9rYH0QS/IhGjzU+8afneQQ6mOyMAt16LskbU6S
	vPOCoy8ydzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD829A10;
	Mon, 21 Jan 2013 04:23:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB1909A06; Mon, 21 Jan 2013
 04:23:08 -0500 (EST)
In-Reply-To: <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com> (Piotr
 Krukowiecki's message of "Mon, 21 Jan 2013 09:09:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B69BA4E-63AC-11E2-9172-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214107>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Do you mean "git add" will be disallowed without "." or ":/" argument?
> Or will this change in future and "git add" without argument will me
> "whole tree", same as ":/" ?

No.  This is only about "git add -u<RETURN>", not any other forms of
"git add ...with or without other args...".

"git add -u<RETURN>" historically meant, and it still means, to
"update the index with every change in the working tree", even when
you are in a subdirectory.

Back when "git add -u" was invented, we didn't have the ":/", which
lets us tell commands that take pathspecs "I want everything from
the top of the working tree.".  If "git add -u<RETURN>" limited its
operation to the current directory, after working everywhere in the
working tree, cd'ing around and ending up to be in a subdirectory
somwhere deep, you had to "cd ../../.. && git add -u", which was
cumbersome.  If "git add -u" always meant the whole tree, limiting
it to the current directory with "git add -u .<RETURN>" was easy,
and that is why the default was chosen to the "whole tree".

Because we have ":/" these days, changing something that limits its
action to the current directory by default to instead work on the
whole tree no longer makes much sense.  That is, if we _were_ to
change "git add -u<RETURN>", it would be in the opposite direction,
i.e. to update the index only with the paths below the current
directory.

Such a change has to be done carefully.  Existing users do expect
the current behaviour, so we have to first _break_ their fingers and
habits and train them to say "add -u :/" when they mean the whole
tree operation.  Silently accepting "add -u" and changing its
meaning to update the index only with the paths below the current
directory will cause them trouble by leaving changes they _thought_
they added out of the index, and is an unacceptable change.

The first step of migration is "git add -u<RETURN>" that loudly
warns, so that uses of that form in scripts are updated before the
second step to avoid a flag-day breakage and start traing fingers
and habits of the users.

The second step is to make "add -u<RETURN>" fail, again with a
message that tells users to be explicit and add ":/" or "." at the
end if they mean "the whole tree" or "the current directory".

After keeping Git in that secnd step for sufficiently long time to
train users to type ":/" or "." explicitly, we can then finally
switch the default of "git add -u<RETURN>" to limit it to the
current directory, instead of failing the command.
