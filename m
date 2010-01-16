From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Fri, 15 Jan 2010 17:05:26 -0800
Message-ID: <7v4ommoo4p.fsf@alter.siamese.dyndns.org>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
 <4B5027B8.2090507@viscovery.net> <7vljfzz0yd.fsf@alter.siamese.dyndns.org>
 <201001152017.00121.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVx7K-0000C7-0r
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758549Ab0APBFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386Ab0APBFk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:05:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758511Ab0APBFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:05:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC939126A;
	Fri, 15 Jan 2010 20:05:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=eLO0qfntGNK72iJrv1/7kyUZK5A=; b=TLipaRe+Nslb3L1w2AdsegD
	IeBAMqegJ4KZbdJXzj/6o93/v8IEk7L1EH4UdB4cPEI3ncaRoORf4xR5h0dX9AUR
	/KA8MWvJN9N5tFd+aBUCiGAgmtZY+wZxdBYLnoTJccHTUuAfX4uG7ktpDqYEz+3Q
	gEKabhdJb4TzoJzE5hGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=f2kNXdPrhYTpDoL/h6wElkwRa3m25yg4uwZIrHhxqZg6kpY92
	ZJ3KUxBm1lQYLBfVhuOPU8ye/2rPCW+RF3k0dNtcz8yQd+1S3t+pv8N2beaax3kt
	PLZ9jDlZQlSSzhlF8YVd92FRDlRLepRbwVVtvKNCKWck73yhmP97CRgXkQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 651AB91266;
	Fri, 15 Jan 2010 20:05:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6936591265; Fri, 15 Jan
 2010 20:05:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F5CF6A4-023B-11DF-85A4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137183>

Johannes Sixt <j6t@kdbg.org> writes:

>> Yesterday, I saw rebase--interactive has a few codepaths where "output"
>> shell function was used with the single-shot export; perhaps they need to
>> also be fixed.
>
> I knew these spots, and they were discussed when that code was introduced. 
> Before I sent out the mail you were responding to, I tried various ways to 
> show the failure in rebase--interactive, but it didn't fail...

It may be the case that the single-shot-ness of these GIT_AUTHOR_NAME
exports do not matter at all in that program, even though the original
versions may have been written carefully not to leak the value suitable
for the current commit to later rounds.

I think the recent updates from Michael actually depends on the
distinction not to matter.  For example, do_with_author() in 7756ecf
(rebase -i: Extract function do_with_author, 2010-01-14) invokes "$@"
that could be a shell function.
