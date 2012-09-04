From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 04 Sep 2012 11:28:01 -0700
Message-ID: <7vwr09abim.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
 <7vpq64f935.fsf@alter.siamese.dyndns.org>
 <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
 <7v1uijexor.fsf@alter.siamese.dyndns.org>
 <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de>
 <7vzk55bu8s.fsf@alter.siamese.dyndns.org>
 <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8xrB-0006IV-9o
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab2IDS2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:28:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757461Ab2IDS2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:28:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA03A9256;
	Tue,  4 Sep 2012 14:28:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3lWJ/bjdvt8WSloBjXTlqu79B8=; b=KUjKmn
	lnJudZb8+xXP7p2FSpSCWzerXePtFU2WjYUL6/HikA+1Jf3Hdy/UiXp19Tkf+f8g
	XZ52rv15aUXu44l2FVvMzVe9Z+eLRSYIx6QPmxDInZZTxqXMh05oy9VxSzUx1DYh
	E7myvv19OmpND1beaNrWrY7UGznaFJvin1Anw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOAktezothXIQA2o1nv/g10gdV7/pqaO
	px+ESGAzIr18Dj/kStWfbqrvFZN6klBthF1mZlG17Jrgm31lOSNVCdY4agNlCbVe
	Johfq/MOD5QvC0ZF25KygUFuw0E1sjinKC5DqdMvn8y3B6FonTdk/W7fq5F+KvFo
	F9pyA7IMPIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A67439255;
	Tue,  4 Sep 2012 14:28:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 010439252; Tue,  4 Sep 2012
 14:28:02 -0400 (EDT)
In-Reply-To: <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 4 Sep 2012 19:23:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 433CFB82-F6BE-11E1-9946-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204761>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> Only with the observation of "clone", I cannot tell if your timer is
>> working.  You can try repacking the test repository you created by
>> your earlier "git clone" with "git repack -a -d -f" and see what
>> happens.
>
> It does update the counter too.

Yeah, that was not a very good way to diagnose it.

You see the progress from pack-objects (which is the underlying
machinery "git repack" uses) only because it knows how many objects
it is going to pack, and it updates the progress meter for every
per-cent progress it makes, without any help from the timer
interrupt.
