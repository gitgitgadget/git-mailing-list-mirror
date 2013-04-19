From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/11] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 15:13:05 -0700
Message-ID: <7vy5cexj7y.fsf@alter.siamese.dyndns.org>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
	<1366399831-5964-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 00:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTJYQ-0003TU-RE
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934043Ab3DSWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 18:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933583Ab3DSWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 18:13:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A6518BD8;
	Fri, 19 Apr 2013 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqImeiF7EBngrQ1Ia1naCs2vJ9s=; b=n113rU
	vOllo2pari8S4NAhkdA61kRMjmJqRPrRMXKp09Z5Gkyla6pzV+n9pv7SoGhW94Pl
	iiDK0ph6xCfiwg4pRoojvxWZxvBZEfIEcXHQl8fKcIr8OBsfJB9qpuj0g76o8KsK
	XQkpo3nvx0CSjEOxT5t125kPTwOV8Rfzff4ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vVbgOeVhfpGWGUNFdSVRKfjM9HM2CkQm
	eE36nsN7K7WfsWaoU8+Ddkvm4QWOtc46i6FMK0THWLarowXc3YBmrE5xmdPjC7V3
	xnAw1pNZ416D2k2SQcavklVqjTqoViSoEo3R4P0QhrA+4uooBPIJoTLvNJGwTRhS
	3fEFACRydZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782AF18BD7;
	Fri, 19 Apr 2013 22:13:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C680B18BD6;
	Fri, 19 Apr 2013 22:13:06 +0000 (UTC)
In-Reply-To: <1366399831-5964-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 14:30:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FE88D6E-A93E-11E2-928A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221825>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This script find people that might be interesting in a patch, by going
> back through the history for each single hunk modified, and finding
> people that reviewed, acknowledge, signed, or authored the code the
> patch is modifying.
>
> It does this by running 'git blame' incrementally on each hunk, and then
> parsing the commit message. After gathering all the relevant people, it
> groups them to show what exactly was their role when the participated in
> the development of the relevant commit, and on how many relevant commits
> they participated. They are only displayed if they pass a minimum
> threshold of participation.
>
> For example:
>
>   % git cc-cmd 0001-remote-hg-trivial-cleanups.patch
>   Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
>   Jeff King <peff@peff.net> (signer: 83%)
>   Max Horn <max@quendi.de> (signer: 16%)
>   Junio C Hamano <gitster@pobox.com> (signer: 16%)

Should the contribution weight for each role add up to (close to)
100% if there were no minimum cut-off?

In general, it is not all that clear what these numbers mean.  Does
a sign/review on a single commit, no matter what kind of commit it
is or how big it is, count as contribution with the same weight?

I am not saying that the counting criteria needs to be configurable.
It just needs to be explainable to the end users.

> +commits = Commits.new
> +commits.from_patch(ARGV[0])
> +commits.import
> +
> +# hash of hashes
> +persons = Hash.new { |hash, key| hash[key] = {} }
> +
> +commits.items.values.each do |commit|
> +  commit.roles.each do |person, role|
> +    persons[person][role] ||= 0
> +    persons[person][role] += 1
> +  end
> +end
> +
> +persons.each do |person, roles|
> +  roles = roles.map do |role, count|
> +    percent = count.to_f * 100 / commits.size
> +    next if percent < $min_percent
> +    '%s: %u%%' % [role, percent]
> +  end.compact
> +  next if roles.empty?
> +
> +  name, email = person
> +  # must quote chars?
> +  name = '"%s"' % name if name =~ /[^\w \-]/i
> +  person = name ? '%s <%s>' % [name, email] : email
> +  puts '%s (%s)' % [person, roles.join(', ')]
> +end
