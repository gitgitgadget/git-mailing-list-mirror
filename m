From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fixing workdirs
Date: Fri, 09 Jul 2010 15:25:15 -0700
Message-ID: <7vy6dkl2d0.fsf@alter.siamese.dyndns.org>
References: <20100708110842.GC12789@madism.org>
 <7v7hl5pxt0.fsf@alter.siamese.dyndns.org> <20100709075617.GD2304@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Sat Jul 10 00:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXM0k-0004xc-Hp
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0GIWZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 18:25:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0GIWZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 18:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBCC8C3EA7;
	Fri,  9 Jul 2010 18:25:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7yatBiyzJ523DuKzpZHM7DD5GY0=; b=lvSFpJ
	GgajsM1WBIyXIOkYEw4GC8bBWFRXcCKRS7ucEGpwzPy/hbB0Lm8e4jNY0SBp+LoB
	+QqThgjVb96CZF7ypPJc8HohkoFqT4IpxvnguE2B3azR//iGua0A+S4DAgBZPGL1
	vNw9V1WbppzSPouMF5bvMQo2GT2mtQorU0Q5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i6tK0JyWtC78QHzQZE6sE5cYxlrrn/5B
	N8ERgVQlfpLsQd4OlXYEt7XKLjzvHqfRU1OBKtXHS8LXZJwLKnt1bwxOy4aTv5HB
	RPYLTB0a5or9L+WK6xNbGNqsUpBgYVpg5iV4DtzgCj+JqD4KlUdTeDbDt5uFCLf9
	XCk5Rlv4Xvc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 980E3C3EA6;
	Fri,  9 Jul 2010 18:25:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E47E4C3EA5; Fri,  9 Jul
 2010 18:25:16 -0400 (EDT)
In-Reply-To: <20100709075617.GD2304@madism.org> (Pierre Habouzit's message of
 "Fri\, 9 Jul 2010 09\:56\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB6418C4-8BA8-11DF-80B4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150693>

Pierre Habouzit <madcoder@madism.org> writes:

> On Thu, Jul 08, 2010 at 12:40:11PM -0700, Junio C Hamano wrote:
>> Pierre Habouzit <madcoder@madism.org> writes:
>> 
>> > for the first one, the fix is simple: workdirs have now a name, and
>> > their HEAD reflog lives in the "master" git repository reflog namespace
>> > under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog is then a
>> > symlink to the masters.
>> 
>> I think this is a sane thing to do, except for the "symlink" part but that
>> would be just a minor implementation detail.
>
> What would you suggest instead of the symlink then ? (knowing that all
> the workdir is just a full symlink farm at them moment).

I can imagine that we may want to have a general mechanism to help an
object store that belongs to one "primary" repository be aware of ref-like
things that live outside of the repoistory itself, and not just a special
purpose hack suitable only to handle the workdirs.  E.g., we have talked
about a "fork" created by "clone -s" wanting the forkee repository to be
aware of its refs, so that rewinding the refs in the forkee repository and
then running gc there won't remove the objects now unnecessary in the
forkee but still needed by the forker repository.

It shouldn't be hard to do something similar to "gitdir: " support for
this without using a symlink, no?
