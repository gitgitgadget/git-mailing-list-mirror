From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Wed, 14 Oct 2009 11:47:47 -0700
Message-ID: <7vfx9lersc.fsf@alter.siamese.dyndns.org>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com>
 <loom.20091014T001602-378@post.gmane.org>
 <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8zJ-0007sb-OY
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760747AbZJNSsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757672AbZJNSsk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:48:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbZJNSsk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:48:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 403C377E37;
	Wed, 14 Oct 2009 14:47:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=phhfk/x3YRKbc/QS4p4H2wIC9cQ=; b=iafS5p
	1I+nml6nTqLXi1SsBF0W/1dVyskaPr+Sb63nBYSo2jHPJbtEpG2Ty/iSwUKsWGdT
	HruWo2PZV3ljNGI7s43xSIK9jybEQkxtqp7srmgohF2DXqJ31veuf/5J/O/iJb6g
	Pl7qKkwhPlhWaVglQ13g42kZL/p/o9Rv4bjIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lh+fAoLVRXU+fhlPsu4s+zJcnqwhT9n6
	A2JXT/hwejv9UjoCAW/38sAEkRPOO6K83soCtbKwEXbjdoONV0wWzZmTDZy7WTfY
	quYIjny6wq+CFCadtiiqwyVQGU9EvGFmI7QlAAmtmi+4FZc7MNW8ewN5WInyt2JL
	KfvHycKpugQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A2B477E36;
	Wed, 14 Oct 2009 14:47:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3BF177E35; Wed, 14 Oct 2009
 14:47:49 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 14 Oct 2009 16\:03\:43 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14F0A10A-B8F2-11DE-A9DE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130322>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I started some time ago to code a "git checkout --fix-crlf", but I 
> am not really happy with the user interface.  I think that Git should 
> realize itself that something went wrong with the line endings.  If I say 
> "git reset --hard", it is just a bug in Git when it insists afterwards 
> that the files are modified.

I tend to agree.  "git reset --hard-without-cached-stat-info" that ignores
the cached stat information while it does the equivalent of the usual
"reset --hard" may be a reasonably safe and usable alternative for
"checkout --fix-crlf".  When people see "reset --hard...", it will tell
them that this is about matching the index and the work tree with the
named commit, as opposed to "checkout", so enhancing "reset" would make
more sense, I think.

Obviously, I am not seriously suggesting "--hard-without-cached-stat-info"
as the name of this mode of operation, and you need to come up with a
better one.  But it is better than "--crlf", as it is not limited to the
crlf conversion that brings the inconsistency you will be resetting away.
It arises from any silent invalidation of the cached stat optimization
after you touch attributes and config.
