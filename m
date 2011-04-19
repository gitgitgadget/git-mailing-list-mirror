From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is
 suitable.
Date: Tue, 19 Apr 2011 15:01:47 -0700
Message-ID: <7vfwpd529g.fsf@alter.siamese.dyndns.org>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
 <7vwriq3p0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCIzp-0003RI-QI
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 00:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab1DSWCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 18:02:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab1DSWCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 18:02:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C763467B;
	Tue, 19 Apr 2011 18:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=chmstuvHOVdIdoCQDuuVFDnHbFo=; b=P+jrZ9
	Ph+msTCoQTEkmeh8ltJSA5Moc4Dm86mRAbT074JhislGmAte4QWcRwNsDeij/9+a
	KiyZPtHO8fKKZjkgscgqVnHcEsjDFeRwrLU/qOzMUhbXAdLA4O3y+FUf+FqSoIEZ
	JIYsGVaf8OCwK0pxDp4Vzn+NCNJkAYPwbuSLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpfw2DDmPMpZRUngFSsNnh2yXI6B9Ehf
	bc4ozsYCmsW3NzNvzcfEi9evyxLPRePIsPw9KJkDZuASSEgsn6pKyuNLxpzx5VzQ
	lPvi8Wusat0HE67KJA2WtQlGmNKqJfovl5eROBEeblTh1HLc3pcTP0BJSoI6KfHh
	mYIXa5ZOCXc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0AC23467A;
	Tue, 19 Apr 2011 18:03:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E05E64677; Tue, 19 Apr 2011
 18:03:49 -0400 (EDT)
In-Reply-To: <7vwriq3p0t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Apr 2011 14:33:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA692C3A-6AD0-11E0-AC62-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171821>

Junio C Hamano <gitster@pobox.com> writes:

> Also, the command to use when you want to get an empty file is not "touch".
> It is not likely that you would have an existing file there, but the whole
> point of the updated codepath is to have an empty file, and not a file
> with recent timestamp, it would be far more sensible to say
>
> 	: >"$BASE"
>
> i.e. redirect into the path, with a no-op command.

By the way, you may want to study what git-merge-one-file.sh script does
when given a "both sides added, but differently" situation (look for a
string "--no-add" in the script).  It first tries to see if there are many
common material that are added in both sides, and if so tries to use that
common material as the "fake" base.  If there isn't enough common
material, it uses an empty file as the base.
