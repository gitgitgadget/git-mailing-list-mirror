From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Tue, 24 Mar 2015 10:00:43 -0700
Message-ID: <xmqqtwxa72kk.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
	<xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
	<20150317140704.GA7248@lanh>
	<xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
	<CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
	<xmqqtwxikpz6.fsf@gitster.dls.corp.google.com>
	<xmqqlhitle5w.fsf@gitster.dls.corp.google.com>
	<CACsJy8BczCNxm3WHK1gtkXiZCbDkFD-67oOMR+eK8uwOBfQXuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:51:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSzJ-0007ZO-LL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbbCXRBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:01:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755564AbbCXRA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:00:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7675F3FB98;
	Tue, 24 Mar 2015 13:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ADJ+tMSOHGjLar+e6HWeV5Ympig=; b=dzsx7q
	h8fimcvM8eWOeaVJaNN5GzeGnaHgSKN0l+PK9Ui0NkMbzW3uvZMlwixmIH8vVGO2
	6yM1M+2m9+/r+zgUN6Q8PDO/ppso6HOJpMrua5deKg/pOhTCOkYgDcPjV5K+AP5T
	UBPsx8Dcr7gdLTRysFxZQYKIkx/+33dvN/t/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnZaA5dWpM3VQHnhgyuHQ0WQABThaXsG
	e4fVTy4gJn3qGiwSt2YB1QzcN0j9qfO3jk3dkaABCLRlhqo0S+LXE3/YsrQcXW8o
	61eQ9fXlpUu8TuWNnQEgDqc3n+QGUZ3UubbSivVmXTEWFP3EmHGPPI8p/BbYflE0
	2EueiCutQ1c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FCFB3FB95;
	Tue, 24 Mar 2015 13:00:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C2DB3FB75;
	Tue, 24 Mar 2015 13:00:44 -0400 (EDT)
In-Reply-To: <CACsJy8BczCNxm3WHK1gtkXiZCbDkFD-67oOMR+eK8uwOBfQXuw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 24 Mar 2015 08:15:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FC2C0DC-D247-11E4-AB0F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266213>

Duy Nguyen <pclouds@gmail.com> writes:

> "read-tree -m" does not invoke diff, does it? If I went with my
> previous approach (modifying unpack-trees to ignore i-t-a entries)
> then this could be a problem, but because unpack-trees is untouched,
> merge operations should not be impacted by this patch.

Theoretically yes, but not quite.

I wouldn't be surprised if an enterprising soul saw an optimization
opportunity in the "read-tree -m A B" codepath.  When it finds that
a tree in A and a valid cache-tree entry that corresponds to the
tree matches, it could blow away all index entries covered by the
cache-tree entry and replace them with B, either

 (1) unconditionally when "-u" is not given; or

 (2) as long as the working tree matches the index inside that
     directory when running with "-u".

And such an optimization used to be a valid thing to do in the old
world; but (1) will break in the new world, if we drop that
invalidation---the i-t-a entries will be discarded from the index.

As i-t-a is not a norm but an abberration, I'd rather keep the
pessimizing invalidation to keep the door open for such an
optimization for a more common case, and there may be other cases
in which our correctness around i-t-a depends on.
