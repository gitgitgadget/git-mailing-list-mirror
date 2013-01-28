From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 10:07:07 -0800
Message-ID: <7v4ni1xjuc.fsf@alter.siamese.dyndns.org>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
 <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
 <51067353.2090006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzt7F-0001Zc-LM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684Ab3A1SHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:07:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab3A1SHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:07:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 872C6CFBD;
	Mon, 28 Jan 2013 13:07:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tEGWvVRS3vZvf8CA5E2eScX8VMo=; b=I9qYUX
	N4RaoVUCSP01oyC1K560fQhv5BX+BrY2eMSn6QHYgX3YX/iQSsqts4l08W2WoXMh
	1TdDH1CpvbjWz7riBmCIqkE+BUou0V9e0LMm1PxWQ0XRY4WXt7MMLXUiqBJKhlbk
	06aO/nx6wEz04pNy85/b13kbM3nwRLVU1bflo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KTkenYcWW1sGQDPS0WlFOt4Ae8JGwlGK
	xixaKKRiwo5zfzMZGnb7uicNVGhzGJC417VLdtLeX9MF1RLY2Rz2scEI2A9GnXdk
	Xffi1sE7USk8KCPT9hO8C2EHTj8kHcVeQyTXw6sDPlDzdfcX83NqHhoPQiBnJmO2
	wEWOhksll+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79550CFBC;
	Mon, 28 Jan 2013 13:07:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00294CFBA; Mon, 28 Jan 2013
 13:07:08 -0500 (EST)
In-Reply-To: <51067353.2090006@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 28 Jan 2013 13:47:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88201610-6975-11E2-BB34-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214846>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Matthieu Moy venit, vidit, dixit 28.01.2013 10:16:
>> Most git commands that can be used with our without a filepattern are
>> tree-wide by default, the filepattern being used to restrict their scope.
>> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>
> Since I didn't follow this thread, my first reaction was: "Huh? Aren't
> they treewide?" (for the relative tree)
>
> So, for someone reading just the commit message, it would be helpful to
> say what the others do, i.e. default to the relative tree at pwd (rather
> than defaulting to an empty tree, or all files whether tracked or not,
> or...).

I think "add -u && commit" vs "commit -a" you brought up is a good
thing to mention, so let's do this.  Another tweak is that I did
s/filepattern/pathspec/ here.  I know that both the documentation
and the help text for "git add" say filepattern, but we say pathspec
starting from glossary fairly consistently everywhere in the rest of
the system.

We should probably update the documentation/help for "git add", but
that is entirely a separate topic.

    add: warn when -u or -A is used without pathspec
    
    Most Git commands that can be used with or without pathspec operate
    tree-wide by default, the pathspec being used to restrict their
    scope.  A few exceptions are: 'git grep', 'git clean', 'git add -u'
    and 'git add -A'.  When run in a subdirectory without pathspec, they
    operate only on paths in the current directory.
    
    The inconsistency of 'git add -u' and 'git add -A' are particularly
    problematic since other 'git add' subcommands (namely 'git add -p'
    and 'git add -e') are tree-wide by default.  It also means that "git
    add -u && git commit" will record a state that is different from
    what is recorded with "git commit -a".
    
    Flipping the default now is unacceptable, so let's start training
    users to type 'git add -u|-A :/' or 'git add -u|-A .' explicitly, to
    prepare for the next steps:
    
    * forbid 'git add -u|-A' without pathspec (like 'git add' without
      option)
    
    * much later, maybe, re-allow 'git add -u|-A' without pathspec, that
      will add all tracked and modified files, or all files, tree-wide.
    
    A nice side effect of this patch is that it makes the :/ magic
    pathspec easier to discover for users.
    
    When the command is called from the root of the tree, there is no
    ambiguity and no need to change the behavior, hence no need to warn.
    
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
