From: Junio C Hamano <gitster@pobox.com>
Subject: Delaying 2.0 final
Date: Fri, 16 May 2014 15:45:10 -0700
Message-ID: <xmqqd2fd8hs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 00:45:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQsW-0003fm-9j
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbaEPWpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:45:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63617 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbaEPWpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:45:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 799C315BFC;
	Fri, 16 May 2014 18:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	IY/f6UHsXcysHK4jk0LU3Vq/jg=; b=m5P1OmetvOtX8fpe7yYrx2b2M5Y2pweEM
	vgQ4Didk4+HJ8A2rrTqZhVG0WlS/sqsAw2iy+kQim78R9sjynzjh8wJkF6/hF7NX
	wF6dNnAoTjll0PskivS7uY8sHsV9HyeudegBQ4BmL0ZbnebFT2JKq2thOHtI8KVb
	98B818dpIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ydX
	rF2dKzAr2NyB94tmEBUAxyerIPAZ5acjelV4eldYGCGbK6wbAU9nlvQ4HlYhV8Zi
	5Dr4wdLTgJpZ6ff5GYOGk9+a82zCnH8nHjAx8kie6BAHs67KijLmmmdQf2xXzadh
	GmnqSZIlOzsbGoHwPAnIBTnjum3/PE5NKMyIwFTQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 709FB15BFA;
	Fri, 16 May 2014 18:45:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8B2C15BF8;
	Fri, 16 May 2014 18:45:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD3AFFB8-DD4B-11E3-B614-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249425>

As we seem to have a few regressions we may want to fix, I will not
be cutting the 2.0 final today (https://tinyurl.com/gitCal).

I queued the following near the bottom of 'pu' (these are also
merged to 'next' to keep pu^{/match.next} in sync with next), and
plan to cut 2.0.0-rc4 early next week.

 * git-gui has a show-stopper bug that wants to see if it is used
   with a version of git that "vsatisfies" 1.7.0; because 2.x is
   considered significantly different, it incorrectly decides to use
   the codepath for ancient versions that compares older than 1.7.0
   when working inside a submodule working tree.  A fix by Jens
   Lehmann is queued as an emergency patch to use vcompare instead.

 * There was a vague admission of having broken git-remote-hg/bzr by
   its author that hinted one topic branch is the culprit, without
   much detail.  As a precautionary measure, the merge of the topic
   has been reverted.

 * git-remote-hg/bzr are maintained outside our tree, our copy will
   become stale and will eventually go away.  A warning message to
   its standard error output has been added to each of them to tell
   the users where to find the latest of these tools.

 * git-request-pull has a minor regression and lost a useful DWIM
   that was designed to be friendly to users of Git older than
   1.7.10.  "git request-pull $base $URL for-linus" used to say
   "Please pull tags/for-linus" if that is what the user meant, but
   the version in 2.0.0-rc3 requires the command line to be "git
   request-pull $base $URL tags/for-linus".  It is simple enough to
   special case this use case, and a patch is included to fix it
   with a band-aid.

If you fetch tonight's 'pu' branch, you will find all of the above
at f608b83.  Hopefully 2.0.0-rc4 and 2.0.0-final will be the same
tree as that commit, with updated release notes.
