From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu, 08 Mar 2012 11:08:39 -0800
Message-ID: <7vaa3qewqw.fsf@alter.siamese.dyndns.org>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com>
 <87399jnyxh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominique Quatravaux <domq@google.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ihj-0003my-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab2CHTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:08:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382Ab2CHTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:08:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DB06C9D;
	Thu,  8 Mar 2012 14:08:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=idjXSVz0RBF2eYjnoTZEjVNKd00=; b=UVjdCI
	NVga6y02krGK8Ss/U/r6ByfXFinNxk728xvtC2dUydDUrWtTCi9XpplefKONCX7r
	fTAGBQz2jeIt8xSvB74Ra8QGXVskIZ4M/RCLVX2aGrYzXGh6lM+qoRUpgHIIBWL9
	6+IjSNZr9F+1soCy9Nly4YzREG7y4zn1R4+Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jabXu2yKaqsW8TCcmOrYOXC18oLK8fA5
	eDgB/XnH7qrcl9ykogJa6tVkRPtl+PkHRpm7ptzEEwz2kCCQXTwBZilDCJukfouo
	CQHHQNe5RKE+nJhPWWHv4hlOpKiXrckbGb4NaoxD/aU5EmSshQUVcPEJiNPUWb6B
	zVujkUYAhEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF7876C9C;
	Thu,  8 Mar 2012 14:08:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 501526C9B; Thu,  8 Mar 2012
 14:08:41 -0500 (EST)
In-Reply-To: <87399jnyxh.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 8 Mar 2012 11:56:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E3E1E1E-6952-11E1-BD58-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192631>

Thomas Rast <trast@inf.ethz.ch> writes:

> Dominique Quatravaux <domq@google.com> writes:
>
>> If set, the second column of the rebase todo contains named revisions (obtained
>> with git name-rev) instead of short SHA1s.
>
> Hum.  I'm not sure yet if I find that very useful, since frequently the
> names will just be 'topic', 'topic~1', ...., 'topic~N' if you are
> rebasing a topic with N+1 commits not in master.  But you might, so who
> am I to judge.

I think the only use case where this might be useful is when you
have totally undescriptive one-line description to your commits that
they alone do not help distinguishing the commits being picked, e.g.

  pick 47a02ff add frotz
  pick d41489a fix frotz
  pick 00c8fd4 fix frotz more
  pick 090ea12 again fix frotz
  pick 74775a0 fix frotz one more time
  pick 6f7f3be at least now frotz compiles

As we treat the one-line subject merely as a human aid, I would
probably do not mind if a workaround for such an issue were done to
produce something like this instead:

  pick 47a02ff (1) add frotz
  pick d41489a (2) fix frotz
  pick 00c8fd4 (3) fix frotz more
  pick 090ea12 (4) again fix frotz
  pick 74775a0 (5) fix frotz one more time
  pick 6f7f3be (6) at least now frotz compiles

It is not a problem with the current rebase-i that detaches HEAD
while working, but using object names like "topic~7" that is
relative to something inherently fluid (i.e. a branch) makes me feel
nervous as an end user from aesthetics point of view.
