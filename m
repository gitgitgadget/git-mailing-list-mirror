From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 13:09:24 -0700
Message-ID: <7viphx1zt7.fsf@alter.siamese.dyndns.org>
References: <20120321140429.GA28721@odin.tremily.us>
 <7vmx7921yz.fsf@alter.siamese.dyndns.org>
 <20120321195520.GB32535@odin.tremily.us>
 <201203212104.23192.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@drexel.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARqh-0008SL-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab2CUUJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:09:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab2CUUJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:09:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20F36AD3;
	Wed, 21 Mar 2012 16:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=td9dbVRcPSBveFRi8rQzMqec7Jw=; b=KDOn2U
	vj0SizP76DFjAwORuVuvoFDmllb9Fr2PBiXg9bjUCJ4BCp+PrRKTaPkvwUBCfje4
	vdwbZF4DPoMhCbNCdaQKzlDB73EwFkK6SRAVjS3rBN4ml7FyeNN8/7ObRtCIDoQA
	J71/iFNj+HFswzIAVi4u9fRKlw3Z0liICP2FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQdxYIEKxE63S6bxrmSmv2d+T5roMv6g
	z72v7eNQhF7Xb18jwUgD5VnZwJlYWK71OTr49yNIh261vlR4WC3bD/OWNfNI1nmt
	g6Jcmwj6QlnSdYvk6DGakOBy4/dwrQgqTNwGTCjKEQQlPDIKBB7gY8vJYehbBvMG
	sLO+yMqlByg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B0A6AD2;
	Wed, 21 Mar 2012 16:09:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30B0B6AD0; Wed, 21 Mar 2012
 16:09:26 -0400 (EDT)
In-Reply-To: <201203212104.23192.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 21 Mar 2012 21:04:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C21F4802-7391-11E1-A7CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193610>

Jakub Narebski <jnareb@gmail.com> writes:

>> 1: tests for i-m-s and git_feed
>> 2: refactor i-m-s handling
>
> Those two can be in single commit.  Tests added need only test i-m-s
> using git_feed ('atom' or 'rss' action), as it is the only user,
> and you touch only i-m-s handling.

Correct.

>> 3: tests for i-m-s and git_snapshot (which fail until 4)
>> 4: add i-m-s to git_snapshot
>
> We usually put tests together with feature.  Tests before feature means
> that you would need to mark them as test_expect_failure, as they would
> not pass before feature is added, isn't it?

Correct.

In a more elaborate series, you would first add a lot of tests to nail the
behaviour of the existing code down, then refactor or reimplement them in
a different way, add tests that expect failure until the next phase, and
then add features and turn expect_failure in tests to expect_success.

But I do not htink this single patch deserves that complexity.  Does it
even have to split into three?
