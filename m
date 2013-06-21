From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Cleanup {branches,remotes}-file cruft
Date: Fri, 21 Jun 2013 07:32:16 -0700
Message-ID: <7vsj0bo7pr.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, akpm@linux-foundation.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 16:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq2O0-00016t-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 16:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423059Ab3FUOcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 10:32:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422890Ab3FUOcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 10:32:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE48829835;
	Fri, 21 Jun 2013 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RdTx/d2O2Otpoffg3EbCtjhlF4M=; b=ukDc+o
	56hDVh+NXqdWriys3p6YiQUd6TYH6b71orLry+TzGzJQXyVw3ldnZbR6k4za+tMS
	xV4+Yrgjg+QWlVSeXlLXXHjv1AxSXiMKMChiYOS19SzEDJMwAnjMveDj1wLpQPB3
	BCzGgAz/tAF+RW5a4zKLQLn0YXkKwqDsgnmgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2y+r9PZ2RkJiI/EPEi7KC5aYLIzae4M
	7XcTU8lq+B49cx6TsoqpNFRRLz2NHcqg73oK1MK2LtzkyUF7BHnpHFOHdwn7vukh
	U0brSUaMGH1PPAWSBq1Tu+yJJWpl5OvElBHyQxa3DsVcRo16BWebLcxsTGSwCVoN
	xGgR7IjjKOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A256129834;
	Fri, 21 Jun 2013 14:32:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24F4329832;
	Fri, 21 Jun 2013 14:32:18 +0000 (UTC)
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 600B56DC-DA7F-11E2-9008-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228619>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is a cleanup operation to get rid of the historical
> $GIT_DIR/{branches,remotes} cruft.  Mostly no-brainers that don't
> deserve a second look.

Only reacting to "no-brainer".

The last time I hinted removal of .git/branches/, Andrew Morton
reminded me that there are those who use Git primarily to fetch from
many dozens of other people's branches, to maintain his own quilt
patch series on top of, and never push anything back.  To them,
being able to say

    $ echo the-repository-url#the-branch >.git/branches/the-subsys
    $ rm .git/branches/the-subsys

has been a much easier and simpler way than "git config".  The only
thing they do with them is essentially:

    $ git fetch the-subsys
    ... use FETCH_HEAD to integrate it to a larger whole
    ... against which his remaining quilt queue is rebuilt

I myself thought that replacing the established work process of
these people to the one that instead uses "git config" should be
simple enough even back then, and in the longer term, these old
mechanisms will become disused so that we can remove them, but
deciding _when_ is the good time is not a no-brainer at all.
