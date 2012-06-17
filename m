From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sun, 17 Jun 2012 15:00:00 -0700
Message-ID: <7v62ap7g67.fsf@alter.siamese.dyndns.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
 <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
 <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net>
 <7vd34z96lv.fsf@alter.siamese.dyndns.org>
 <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net>
 <7vmx427aj0.fsf@alter.siamese.dyndns.org>
 <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Jun 18 00:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgNW4-0001er-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 00:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab2FQWAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 18:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab2FQWAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 18:00:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC0E195F8;
	Sun, 17 Jun 2012 18:00:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PDvQU6Nvkv1Qh+m02QkAJ3uhpSQ=; b=amSrwn
	L96yWNSedjRp12qRHnzxGoKOzoaeoDu97TE/bn+z+P+YuzLCqsMigrO8vQCHhB3+
	xi6mCrs4NSIx7X14cEDedFvn72vwNyYzRkgkSOyrn1s2DYYJ95MOV6Vdi7/M2EdG
	aM7A+QkE4KmnTfrD1ahMk3BAtZ6O256mRJoNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pq/VSb7NG5D4uw1UoZUHLeEArwJx5GPS
	6FWZoC5miYb45t8zBoh0u40pJeWmtuwArjJyzevsH+f5MHOHKGVSP3PLoFKfW3rp
	PKDomo8KOO9qcfcIHQZC/1SNdcoO/EuOUTyQmiK9H/st7TMEa0fkCyStqg8tGi3y
	WT9CKHkPHVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8547095F7;
	Sun, 17 Jun 2012 18:00:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A7A395F1; Sun, 17 Jun 2012
 18:00:04 -0400 (EDT)
In-Reply-To: <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net> (David
 Kilzer's message of "Sun, 17 Jun 2012 06:46:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB22C458-B8C7-11E1-A1B3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200132>

David Kilzer <ddkilzer@kilzer.net> writes:

> + Johannes Schindelin  [sorry, should have added you at the beginning of the thread]

Side note: Dscho, I do not mind hearing from you from time to time,
but if the only reason David summoned you is because I mentioned
t4200 and your name appears at the beginning of that file, and
unless you are interested in rerere.autoupdate yourself, I am fine
if you to treat this thread as low priority.  Your code in t4200
does not have much to do with rerere.autoupdate which this
discussion thread is about.

I vaguely recall doing the 5-patch series that ends with 121c813
(rerere.autoupdate, 2008-06-22) after somebody asked if there is a
way to tell paths that have been resolved by rerere already and
paths that still need to be sorted out manually (back then I think
we had "rerere status" but not "rerere remaining"), so that "git
ls-files -u" can be a more useful command to find out which paths
need further work, but I do not seem to be able to find the thread.
I also think that somebody was a regular in the kernel mailing list,
but I do not remember the details.  Hopefully somebody with better
research skills (or better memory) than I have can help digging the
context up for us ;-).
