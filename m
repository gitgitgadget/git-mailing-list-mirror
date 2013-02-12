From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 10:00:26 -0800
Message-ID: <7vvc9xh0p1.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
 <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:01:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KA0-0001x9-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab3BLSA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:00:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300Ab3BLSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:00:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B0DC404;
	Tue, 12 Feb 2013 13:00:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqZ9HAljalXp7ZLq+PtgBc99Cl8=; b=ZATgtt
	gnxxyO4VnWNzptHOclU8dOYWfHZH3KUc948FR7B4Ihk7cgSstoLo+djXv4sxvy4/
	pQk+FDlddrIMoWz4n793Rcvg/r84lgOE1treu3IoFSAqnJXB/sbAniSduIz83B88
	M2HtutUydvzlz6eb38PQZvoaY0XNUfxH8v+68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rlFc80AIxJKM2dZnjtm4kNyqZWjnJTRs
	apkIJwY69Okh4Ad3EyLdH95bZoEd+hWXfT0Zzivp6oaLhLB4S7FY4/HozFgi9PME
	DnHdnKTt9H6e5K9QFym4B7Y5X+3cziQVtl5b8V48GSSHCUYcpDdz04GzscHTAY2j
	Bf4AWhwh2PE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27C74C402;
	Tue, 12 Feb 2013 13:00:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91719C3FC; Tue, 12 Feb 2013
 13:00:27 -0500 (EST)
In-Reply-To: <7v4nhhigp5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Feb 2013 09:29:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 150CC6B2-753E-11E2-86F1-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216167>

Junio C Hamano <gitster@pobox.com> writes:

>>  	cat >comment-lines.sh <<EOF &&
>>  #!$SHELL_PATH
>> -sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
>> +sed -e "2,\$ s/^/\\\\\\\\/" "\$1" >"\$1".tmp
>>  mv "\$1".tmp "\$1"
>>  EOF
>>  	chmod a+x comment-lines.sh &&
>
> Yeek.  If you used write_script with here-text that does not
> interpolate,
>
> 	write_script remove-all-but-the-first.sh <<\EOF
> 	sed -e '2,$s/^/\\/'  <"$1" >"$1.tmp" &&
>         mv "$1.tmp" "$1"
> 	EOF
>
> the above would be much more readable.

As this is already inside a pair of '', we cannot use single quote
around sed expression without doing the ugly '\''.

So it needs to be more like this, and I think it still is more
readable.

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index cbe36bf..8b3e2cd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -945,13 +945,11 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	git checkout E^0 &&
 	git config core.commentchar "\\" &&
 	test_when_finished "git config --unset core.commentchar" &&
-	cat >comment-lines.sh <<EOF &&
-#!$SHELL_PATH
-sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
-mv "\$1".tmp "\$1"
-EOF
-	chmod a+x comment-lines.sh &&
-	test_set_editor "$(pwd)/comment-lines.sh" &&
+	write_script remove-all-but-first.sh <<-\EOF &&
+	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
 	git rebase -i B &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
