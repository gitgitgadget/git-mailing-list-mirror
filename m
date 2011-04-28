From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 17:10:21 -0700
Message-ID: <7viptz5j82.fsf@alter.siamese.dyndns.org>
References: <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie>
 <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFEoa-0003KM-E5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab1D1AKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 20:10:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1D1AKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 20:10:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9359758AC;
	Wed, 27 Apr 2011 20:12:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r2t+y6aMC0XCahu6A3v/EHuH8KM=; b=uv14pJ
	jfLZ4SKMvKipSZoJQbGQpzKVW2DxXFniJKsPEJ9HZWXdq2pTuZf4Tv7JAulBCcU2
	cJ+lO7Z7lrzcwo9Atb1QXW3MP/oUYcqHFb1bF68m4jakDleig/yZxJr8jqX47MNJ
	Nkaw2rVTvBraxL9hoGB9EqtLlQ0pGn6As+EDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvueAlO9B2wk8iAw2N57DDPhfrUcyvhn
	vr+ex+Le7o7NfH9FPGxutNEWjeZug29OsdaaoRr4ZtwwNlBnYTYF7Q+5bm7weNKV
	oypLYDPIDSpv60olNjCr44aEhpobskeP5UdTHLAGrBgxx1uxR/zb8e4gSqBPSOBy
	1A7KK1xDT/M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 402E258AB;
	Wed, 27 Apr 2011 20:12:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 05A7158AA; Wed, 27 Apr 2011
 20:12:25 -0400 (EDT)
In-Reply-To: <20110427234224.GA26854@elie> (Jonathan Nieder's message of
 "Wed, 27 Apr 2011 18:42:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34F10DAC-712C-11E0-A558-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172295>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Right, my worry was based on the usual way programs find their way
> onto my $PATH.  That is:
>
>  - if they are installed via a package from the distro, they are in
>    /usr/bin.
>
>  - if they are installed with "make install" by the local sysadmin for
>    all users, they are in /usr/local/bin.
>
>  - if I am trying them out for myself, they are in $HOME/opt/foo/bin
>    and when it is time to remove it, "rm -fr $HOME/opt/foo".
>
>  - if I have adopted them, symlinks go in $HOME/bin.
>
> With a local gcc-4.6 in $HOME/bin, if the sysadmin upgrades gcc so
> gcc-4.6 is to appear in /usr/bin or /usr/local/bin, my setup still
> works without trouble.  So, barring bugs, each installation method
> does not interfere with the other ones.
>
> Call it overengineering, but I would want a way for installing new git
> commands to have the same attributes (installable by normal users in
> multiuser systems and name conflicts not being a terrible
> administrative burden).

Ok, I wasn't thinking about folks who use repackaged /usr/bin/git together
with their own choice of third-party enhancements.

Probably we would be better off if we define a new set of paths that is
independent from GIT_EXEC_PATH and friends.  The installed git and nothing
else will occupy GIT_EXEC_PATH etc., but at the runtime, git would look at
a user-writable location GIT_PLUGIN_PATH/{bin,man,...} to see if the user
has her own customization, and add them to its vocabulary.

Or something like that.  I am not all that interested, but it feels like a
good direction.
