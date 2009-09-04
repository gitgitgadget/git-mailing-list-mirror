From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special
 case
Date: Fri, 04 Sep 2009 03:50:12 -0700
Message-ID: <7vk50fugpn.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
 <alpine.DEB.1.00.0909041232500.4605@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWNb-0002NQ-G0
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZIDKuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZIDKuW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:50:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbZIDKuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:50:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C25AE25E9C;
	Fri,  4 Sep 2009 06:50:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ta1+D5ix45a1cYaF3bA/qCwqh3Q=; b=aHEhPH
	QfgAXvKuuGkJUO18hYfKSQLG16nIQnqxjS6GO9r1RHSnTYQetWFmn6jvGQgZxfpD
	nUyRgYcFONFxa7T0S9lotbpfLUegN6Zrk8ZkAJqDkIwz7rD0lzVcYu86VRLIQ2dc
	whKh91uCfFvC1YDTMjGt8CT9GMAgvLCF/oVtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlkvRgzPa9LuzJ2XS3TLN41Smfy3MAns
	yn6+v0W94sx2VcK4/hQefnbc8qClwuJSdB2u7hrBGFdqpv4rvyPTErFCqtfr/oJw
	BEarygH4Jq4M3rjtinFr7/bq0XMarnXv1Qwy8PuGPBZ+Ce4jTXZcUkiP+Sp5LurN
	j+/RfX0XDSE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F01125E98;
	Fri,  4 Sep 2009 06:50:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B182325E96; Fri,  4 Sep
 2009 06:50:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0909041232500.4605@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri\, 4 Sep 2009 12\:34\:59 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC68242A-9940-11DE-9A4C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127710>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The special case is "http://" and "https://" which might indicate foreign 
> VCS repositories.
>
> In all other cases, I am afraid that you are complicating the glove.
>
> Remember: the whole purpose of the "foreign VCS" helpers is user 
> convenience.

Sorry, but you completely lost me here.

Here are two URLs that follows your "user convenience" principle.

	http://example.xz/repos/frotz.git/
	http://example.xz/repo/frotz/trunk/

How do you tell, without relying on .git and trunk, the former is a git
repository and wants the dumb walker transport to fetch from, while the
latter is probably a svn and you would either use "svn checkout", or use
"git clone" on it via the svn helper?

Well, you don't.

One possible "convenient user interface" would be to say

	svn+http://example.xz/repo/frotz/trunk/

(or use :: instead of + as the helper-name separator, as we agreed not to
decide on it)
        
This would give us

 (1) it is clear that it literally is what you would give to git and
     trigger the svn helper; and

 (2) to people who know how canonical git URLs with foreign helper are
     spelled, it also is clear that you can use "svn checkout" on
     everything after "svn+" in it.

     A corollary to this is that you can also use "git svn init" on it.

Compared to that, if you do not have any such prefix, how would that be
more convenient to the users?

Or perhaps you have an alternative in mind that is more convenient for the
users and that is not "use identically looking http://... for both", but
you are being unnecessarily cryptic by not spelling out what it is.
