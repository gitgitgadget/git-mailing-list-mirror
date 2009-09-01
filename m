From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unmerged files listed in the beginning of git-status
Date: Tue, 01 Sep 2009 09:42:25 -0700
Message-ID: <7vljkypqfi.fsf@alter.siamese.dyndns.org>
References: <20090901145213.GB4194@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiWRS-0004vN-W7
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 18:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbZIAQme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZIAQmd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 12:42:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbZIAQmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 12:42:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5647B21BE8;
	Tue,  1 Sep 2009 12:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfoEkbafAbqGPTomH/d56eafR4A=; b=kQwXhf
	oCcD0bixT88hVPKCnU8JrHbqpo3Z/9DZcqDuSbID5G2gEa78EnQQc5JdEP8tuP2m
	8SDqHrPuqT/3wEVSIYqOQsJ2CmM9lsq5HLioz49WhyI1TOmM0x5lzAa/kcga4oTu
	c0UIBKhAS9Hba8T7z9YPsOgohco0QXXcdPpCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vq1whvue7Ar5stGVhwjMEktBgImY3xZs
	sTmg4KlQV1y/JRqRb9M13ZifKvl5fGVJKfuWYuPB/WewIh0KZNPNmyFDc+Y3Wppx
	x7l+HvZxkeOp0NFp/eZzdFl8h2ry1xwPKdLGjbEKV7eDBja3K6WOO7mM5H9rMKcy
	3X+8AMw324s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D2521BE7;
	Tue,  1 Sep 2009 12:42:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D53121BE5; Tue,  1 Sep
 2009 12:42:27 -0400 (EDT)
In-Reply-To: <20090901145213.GB4194@debian.b2j> (bill lam's message of "Tue\,
 1 Sep 2009 22\:52\:13 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7130AB48-9716-11DE-9E67-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127542>

bill lam <cbill.lam@gmail.com> writes:

> I noticed in the new git 1.6.4.2 .

I hope you didn't.  This is only in 'master' and will appear first in the
upcoming 1.6.5; it is never meant for 1.6.4.X maintenance series and
1.6.4.2 does not have this change.

> git-status show unmerged files
> with a clause of explanation.  This is very helpful. However these
> unmerged files are listed in the beginning and followed by modified
> files,

"git status" is preview of what git commit does.  The "Changes to be
committed" section is given at the beginning of the output because it is
the most important one.  But while reviewing the conflicts, you would want
to notice conflicted paths more than what are already resolved and staged.

It used to be that unmerged paths were mixed together with locally
modified paths in the "Changed but not updated" list, after the "Changes
to be committed" list.  This made the unmerged paths harder to spot than
necessary.

To remedy this, unmerged ones are now:

 (1) placed in a new, separate section that appears only when there are
     unmerged paths, to make the fact that there is something unusual
     going on (i.e. conflicts) stand out; and

 (2) the new section is given at the top of the status output to give
     these unmerged paths more prominence.

Having said all that, the relative importance of the pieces of information
given in "git status" output is fairly subjective.

If you are a confident, know-what-I-am-doing type, you would see the
"Changes to be committed" list the most important, because that is where
you make sure you have added all the changes you want to include in the
commit.  If you are a forgetful type, on the other hand, you would see
"Changed but not updated" and "Untracked files" more important, because
that is where you make sure there isn't any files you modified and new
files you created that you want to include in the commit but may have
forgotten.  If you are into flipping many branches and often commit your
changes on a wrong branch, you may value the "On branch foo" information
at the top the most.  So in that sense, there cannot be a single right
order of these sections.

But unmerged entries are something you need to deal with _first_ before
being able to go further, so in that sense it is more important than
anything else in the traditional output.

In the output, "the most important part first" rule is unlikely to change,
if only because this is what you are shown when committing in the editor,
and even in 1.7.0 when "git status" stops being "git commit --dry-run"
because we would still keep consistency of the two outputs,

By the way, please do not deflect responses to your message away from
yourself using Mail-Followup-To.
