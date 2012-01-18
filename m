From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry
 run
Date: Wed, 18 Jan 2012 14:56:12 -0800
Message-ID: <7vobu0liwj.fsf@alter.siamese.dyndns.org>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dieter Plaetinck <dieter@plaetinck.be>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneQW-00010Z-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab2ARW4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:56:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab2ARW4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:56:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF9246CB7;
	Wed, 18 Jan 2012 17:56:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5AvmXEa8Vkn7jbt13YI3qwvF8kg=; b=AtAJec
	TZ4wikixyXNlyNVZ64+e7UayDrkDGBbiGMz/2NlS75Vn+42Kg0mKeqXi8A+osJLR
	kNcKGVbYGfGvjtAP4RPsPVEoRzF1yp7f6yOcoNmCc3BYmYeUvSyOmzUyOcgyyVxb
	LnNutEhLHrBlLS4Fkmk3naepgm+neXGyZYeEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rT35LwF+IfJ8UTfMNif55O61Osv22OLy
	JvomK/Otl5wc36TC20AHYBQ+n7ZYQjas2rpT/z8dKrAQv1d0MqQzWqJ1Hos79a6q
	HSL/TDxL8KwcSOhWOH7NVjQd9d2Hwi6wlZqOsZ571/b0g5XvgGt/m1ZPMZuRf8wV
	aKdg61kEf+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A73076CB6;
	Wed, 18 Jan 2012 17:56:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D2086CB5; Wed, 18 Jan 2012
 17:56:14 -0500 (EST)
In-Reply-To: <1326923544-8287-1-git-send-email-dieter@plaetinck.be> (Dieter
 Plaetinck's message of "Wed, 18 Jan 2012 22:52:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F5C4CA2-4227-11E1-9FDE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188775>

Dieter Plaetinck <dieter@plaetinck.be> writes:

> There is no need to restrict use of --ignore-missing to dry runs,
> it can be useful to ignore missing files during normal operation as
> well.
>
> Signed-off-by: Dieter Plaetinck <dieter@plaetinck.be>

Sorry, but for this kind of change, we would want to see a justification
that is much better than that. The default around here is not to change an
established behaviour without a good reason.

Have you dug into the list archive to see _why_ we decided not to allow
this option in the real run in the first place? You would need to find "By
letting the command ignore missing paths, the user can get into X and Y
situations and we would want to avoid it. We however need to give users a
way to see if there is something missing, hence we add it when we are
under dry-run option." and refute that previous justification, arguing why
X and Y is something we should _not_ be worrying about, to make a good
case for this change.

In this particular case, my gut feeling is that this might a change in the
good direction (but I strongly suspect that I am not recalling the real
reason why we didn't allow it when we introduced this option).

If somebody is writing a script using "git add" (which is not recommended
to begin with), it is tempting to say 'git add $list_of_possible_files' in
such a script when the script _knows_ that the list it is giving to "git
add" may contain a path that does not exist, and wants to ignore missing
ones.

But then the script could easily filter what does not exist before
compiling such a list, so that is not a very strong reason to advocate
it.
