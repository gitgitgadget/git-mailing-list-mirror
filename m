From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] git send-email suppress-cc=self fixes
Date: Tue, 04 Jun 2013 15:11:34 -0700
Message-ID: <7v4ndd5xwp.fsf@alter.siamese.dyndns.org>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
	<7v4ndd93ks.fsf@alter.siamese.dyndns.org>
	<20130604214921.GA30400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjzSA-0008H6-As
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab3FDWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 18:11:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab3FDWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 18:11:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E82225052;
	Tue,  4 Jun 2013 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8cZtxpdDDBHUNchoWlYbj5hsDQ=; b=VzcVdy
	ZxYcu3WHbI/ew/YPn4SatHPIhHU111udTfhYXQOXzjCHKPeOknRtC2fg1iOaTDWU
	AC4WT1drtXz647iMSovdzAEqPXCE7WnflvKVOyEL6BCBR2BbKUhaxRxJCcw6ngUU
	7l+6vn14MzSFcEVXNGLJW0OX4VI9S25nVp0L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cwMULwulIFczC3c/34oJKmf+x9texWia
	JywPXBTwbcee4reJ476PMqw9FAijwhV70fs1BTcXa2e9yl/nso+6MsqidrrXzhXK
	StOe+KoyNrKB2x7FoBGKwcxlcGtPtgzTVh/I6SAdxSZ5UL60Lo1ur8rje4HwT//O
	2AJLON9SZKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91DF12504F;
	Tue,  4 Jun 2013 22:11:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF3802504E;
	Tue,  4 Jun 2013 22:11:35 +0000 (UTC)
In-Reply-To: <20130604214921.GA30400@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 5 Jun 2013 00:49:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8C4B896-CD63-11E2-8451-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226418>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> All I see in 2/6 is this:
>
> 	diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> 	index e1a7f3e..f81e5f5 100755
> 	--- a/t/t9001-send-email.sh
> 	+++ b/t/t9001-send-email.sh
> 	@@ -204,13 +204,15 @@ test_suppress_self_unquoted () {

After noticing what is after "@@" here...

>
> 			unquoted-$3
>
> 	+               cccmd--$1 <$2>
> 	+
> 			Cc: $1 <$2>
> 			Signed-off-by: $1 <$2>
> 		EOF
> 	 }
>
> 	 test_expect_success $PREREQ 'self name is suppressed' "
> 	-       test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' \
> 	+       test_suppress_self_unquoted 'A U Thor' 'author@example.com' \
> 			'self_name_suppressed'
> 	 "
>
> where's test_suppress_self_quoted here?

... isn't addition of "cccmd--$1 <$2>" made to that function?

After applying [PATCH v3 1/6] to 'master', I do not see unquoted-$3
that we see in the context, either.

"git grep unquoted- pu t/t9001*" does show us a hit, but that is
coming from your previous round you are replacing with this series,
so....

Confused...
