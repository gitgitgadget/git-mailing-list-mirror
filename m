From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GPG public keys
Date: Tue, 08 Dec 2015 17:49:42 -0800
Message-ID: <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jamie Evans <jamie@pixelrebel.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 02:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Tt9-0007YC-CM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 02:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbbLIBtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 20:49:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbbLIBtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 20:49:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 804BE32716;
	Tue,  8 Dec 2015 20:49:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Hv6KcATAZLoKp3JXiUcR9i3HtF0=; b=c1GQfCQBZHBYrOXpbx6D
	Ra/ew6cNlFVIETlx95dacyY+HRri9r+zDaU2eZhJCVIpLCAHMlOU3lDbtF0I5BhK
	ojk4/aiT5GWfZ2qgFD+w/PpYyK12mYXqpxkUehP5c+Qk/8+fc9f8WBSDSnEAdCRN
	s5oP+10ehvfhtcvr+00fr9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OAzVjId1yWQOFeQHCQJVz1srSoIR7lWT6/bITAs73arg0E
	9xpaTlTdCt05qHwyIfsbMDc/LdpkGst8ExIiYtDb+MShTWx0bF12rFRftz7jvTyd
	+vA04kYLeqDZ1TRsbm1MEQyVcufOVM9GkG4h1TwVsNdfDdYXa448T6EE96j2U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 785E732715;
	Tue,  8 Dec 2015 20:49:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F338132714;
	Tue,  8 Dec 2015 20:49:43 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EA2C104-9E17-11E5-BB4E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282183>

Jamie Evans <jamie@pixelrebel.com> writes:

> Can you please point me to the public GPG keys used for source code signing?

I suspect that you are asking about our project, but instead of
throwing you a fish, I'll show you how to catch one yourself.

In a copy of linux kernel repository I have lying around from a
random past, I did this:

    $ git log --show-signature

and saw something like this:

    commit c6fa8e6de3dc420cba092bf155b2ed25bcd537f7
    merged tag 'arm64-fixes'
    gpg: Signature made Wed 07 Oct 2015 03:10:34 AM PDT using RSA key ID 84C16334
    gpg: Can't check signature: public key not found
    Merge: e82fa92 62c6c61
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Wed Oct 7 18:17:46 2015 +0100

        Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/li...

I do not have the public key with key ID 84C16334, but I can ask
public keyservers.  Put 0x84C16334 in "Search String" in pgp.mit.edu
and click "Do the search!"--it would result in the key that was used
to sign the merge request that resulted in this merge.

I also can do this:

    $ git tag -v v3.0

and I would see something like:

    object 02f8c6aee8df3cdc935e9bdd4f2d020306035dbe
    type commit
    tag v3.0
    tagger Linus Torvalds <torvalds@linux-foundation.org> 1311301049 -0700

    Linux 3.0

    w00t!
    gpg: Signature made Thu 21 Jul 2011 07:17:44 PM PDT using DSA key ID 76E21CBB
    gpg: Good signature from "Linus Torvalds (tag signing key) <torvalds@osdl.org>"
    ...

to find that Linus's tag signing key has ID 0x76E21CBB (I do have
his key in my keyring, so this does not say "Can't check").

Perhaps you can do the same to whatever project you are interested
in.  For example, here is a starting point to do the same for our
recent v2.6.4 tag:

    $ git tag -v v2.6.4
    gpg: Signature made Tue 08 Dec 2015 02:12:50 PM PST using RSA key ID 96AFE6CB
    gpg: Can't check signature: public key not found
    error: could not verify the tag 'v2.6.4'
