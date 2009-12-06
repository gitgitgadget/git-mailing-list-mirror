From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Sat, 05 Dec 2009 23:54:42 -0800
Message-ID: <7vk4x0k059.fsf@alter.siamese.dyndns.org>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
 <7vocmdutph.fsf@alter.siamese.dyndns.org>
 <20091206041839.GB23983@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 08:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHBxK-0000Ek-4a
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 08:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZLFHyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 02:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbZLFHyq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 02:54:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZLFHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 02:54:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C94ACA4030;
	Sun,  6 Dec 2009 02:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jEm7Lji+fZ4QrWdT3a/dwsIRQ8A=; b=YSeIk7
	e1Jum+deZCM4W97w/cyQwa+tT/IkAUD3Re9RwvwZFytgM7DLzHjZi4BQqKsWwevr
	PYkWi18roHWhsOj0cv2EnZthBwoo9R9YOx13/3imjjgr6A31x86PDfA50iDY0WXC
	cog/pVM9ddKf6OAsmmUzPFXXC0CgpyLapggwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vzdPbI0aAHf8hB04LWwAY3Pt/eo7FtXK
	s08/zV0rjnwocs3lOF5W46kAa5bmED2YyHoL0JYWJJfFs1+H2fDg/vkKyEqYSgoW
	MJ6Ab84RotCV0OHC7lIaN4w4KK+rUKYyCNBzyDXJ/n2AFivkMiRimkF+cQT6E8mt
	bAR6fHrNehk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B704A402F;
	Sun,  6 Dec 2009 02:54:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EFF9A402C; Sun,  6 Dec 2009
 02:54:43 -0500 (EST)
In-Reply-To: <20091206041839.GB23983@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 5 Dec 2009 23\:18\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A079A32A-E23C-11DE-8064-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134648>

Jeff King <peff@peff.net> writes:

> I actually considered that, too, when writing the patch. But that would
> be inconsistent with all of the other commands that use SETUP_WORK_TREE.
> For example:
>
>   $ git init && cd .git && git clean
>   fatal: This operation must be run in a work tree
>
> So I think we are better to be consistent with the other commands. If
> somebody wants to make a separate patch to discover the work tree while
> in the $GIT_DIR and chdir to it, that should then be applied to all
> commands.  I'm not opposed to it, but I also don't see it as a
> particularly pressing need.

Yes, we would of course want to do this consistently.  I haven't followed
the codepath yet, but I suspect this will end up being connected with
running "rev-parse --show-cdup" inside .git/ of a non-bare repository.
