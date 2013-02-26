From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc does not clean up after itself when not enough disk space
Date: Tue, 26 Feb 2013 08:07:32 -0800
Message-ID: <7v1uc3njnf.fsf@alter.siamese.dyndns.org>
References: <512CD689.4050705@gmail.com> <512CD703.4080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "jones.noamle" <lenoam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAN4T-0000iM-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849Ab3BZQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:07:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759841Ab3BZQHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:07:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9EFAD3B;
	Tue, 26 Feb 2013 11:07:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lbul6DzUmrlt60oZl7L2d65TL5U=; b=XUu0Ss
	FWYCbdBDb804MWJOtDGblaVGpaoScqbMNHWnAMLWVAY5mS/GB+p5++7HDyAK0hTQ
	NQ8BlUtWre5dxoIFKBe1DOf+MeDM5ZhFfnGmLorojxNZOAEjhg5y2L+4Kvrj4YUU
	J+EEPzjxX09SbFzh2g9s4i3JnI7AYTObMnD70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxYWqy00DXAZJzg1t0z+UTzEie0tZGWP
	P4oNznlYIg94rpAUrt0za5Ocra4a3zCR8grqEqzlxRyqmsxFqnvn9nRGQdwgayiK
	z6kYZcfbQQ1GRKemnMp5UYHEf7OmnITuoYdPMjH9mgWpCe/mJ1GS9TvDdip2h7rM
	80rTo88A2BQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92140AD27;
	Tue, 26 Feb 2013 11:07:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 142D4AD0F; Tue, 26 Feb 2013
 11:07:33 -0500 (EST)
In-Reply-To: <512CD703.4080302@gmail.com> (jones noamle's message of "Tue, 26
 Feb 2013 10:38:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A18154E6-802E-11E2-B0AB-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217140>

"jones.noamle" <lenoam@gmail.com> writes:

> # git gc
> Counting objects: 44626, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (7756/7756), done.
> fatal: sha1 file '.git/objects/pack/tmp_pack_uJ0E5b' write error: No
> space left on device

In general when we encounter an unexpected error, we tend to try
leaving things as they are so that we can help diagnosing the
failure. But when you ran out of disk space I would agree that it
may be sensible to remove a temporary file we didn't manage to write
out in full.
