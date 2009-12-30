From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Wed, 30 Dec 2009 00:05:20 -0800
Message-ID: <7vr5qc51kv.fsf@alter.siamese.dyndns.org>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091230121325.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtYm-0006bX-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbZL3IFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbZL3IFc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:05:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbZL3IFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:05:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA5D5ABC5C;
	Wed, 30 Dec 2009 03:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5EJ5yApGv809qom5Bvn0i6PEsUQ=; b=PxAhy/
	VMLeDsxhOckX1PiTegllykbVG3/Ym2sPMEhrAJCKPz+ADBmLyOKa1fNg09TCErTi
	pqpDAL6xqk+YVD1woobSUfI2RXNF+tNegnPNMVgQb+ZrX5bDv8DI0c81bF457xQA
	a7Q2R+5h/Y7pn3zdzlvwHZG6DVnsIP+dpst3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BA7fVTmcze8n3gMYaem26ilNzaEwleCi
	t36HY2qHAhiJFnESmuWnBhlfe//l5FiOztj/I1opV+GBG5HF8zX3LOhhyza5FWQX
	ilRYRmjVsxjBWdSaq1qOM8pv9u+/opx5XnIjmVPVtU81SSPTts4xrgCi/0UJ8S39
	j/PBaCrOBkI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AEFDABC5B;
	Wed, 30 Dec 2009 03:05:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 764D4ABC5A; Wed, 30 Dec 2009
 03:05:22 -0500 (EST)
In-Reply-To: <20091230121325.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:13\:25 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16A0EA00-F51A-11DE-A661-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135868>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> I use this patch myself, and it works really well.

I stopped promoting the patch after Peff mentioned he was planning a
rework of textconv, but now I re-read it, I think his rework would be
orthogonal to the patch.

Also Peff gives a good hint about borrowing how launch_editor() calls out
to the shell.  I think the codepath we fork&exec user-defined commands
(not hooks, but filters like smudge/clean/textconv and EDITOR/PAGER that
take a command line) need to be first enumerated, then we need to see if
we can refactor what launch_editor() does into a common helper function.
I felt it was unclear what we would want to do with GIT_EXTERNAL_DIFF,
diff.external, and diff.<driver>.command trio, but I tend to agree that we
should run things the same way, honoring $IFS and shell everywhere.

http://thread.gmane.org/gmane.comp.version-control.git/135250/focus=135312
