From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Fri, 05 Aug 2011 08:02:32 -0700
Message-ID: <7vaabn52bb.fsf@alter.siamese.dyndns.org>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
 <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu>
 <7v4o1zg20r.fsf@alter.siamese.dyndns.org> <4E3A12B9.1010800@alum.mit.edu>
 <7vliv95cpb.fsf@alter.siamese.dyndns.org> <4E3B8CAA.4030002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 05 17:02:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpLv6-0007JI-SR
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 17:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab1HEPCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 11:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab1HEPCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 11:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C701633BC;
	Fri,  5 Aug 2011 11:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+4vIDaXkoDGhpsQPXCEErvZMOCo=; b=b2V+J2
	lwtpihOzvZiTxtN5tzIjJ+rPvl3JLnBZaIJKTeGzr0jglq+21KnWCSqHCatwroIO
	M6i11JDIzGobjhNrsVxJshrsZNolpbrjtKTnLWxXEkbK5c8LVb+n0ZglVChipQSM
	Xa95cCd9GJUe1idnoBMLSFQG5n5VxogT8sPdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J0DdYJU+gljXPiN331Bf3hMizUR3GgaV
	PnxBAFakSWywtFuNcgWHKSzliiNqnZtM7DoDloaiDF7FfU6f39uxX4Yptay+/FOE
	2dNbmsgqKDuQba5ic3+M5IdogZ3T+CbhnJwOtHjUEkCVD0M1YF8J/JYfzCRwKSDD
	X4LW7MeDu0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5E9333BB;
	Fri,  5 Aug 2011 11:02:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B0C733B9; Fri,  5 Aug 2011
 11:02:34 -0400 (EDT)
In-Reply-To: <4E3B8CAA.4030002@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 05 Aug 2011 08:24:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F310B270-BF73-11E0-8637-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178797>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If I understand you correctly, the use of some API routines requires a
> chdir by the caller (i.e., the surrounding application) *before* calling
> into the routine.  This is certainly a bit cleaner than the library
> chdiring itself, but it is still unusable in a multithreaded context.

Why?

Presumably you know what your threads are doing, so if you take input from
the end user after you started the environment, you will be doing the
prefix discovery and pathspec prefixing on the entry and prefix stripping
upon output but do not have to (and should not be doing) chdir at all.
