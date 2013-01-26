From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/7] mergetool--lib: don't call "exit" in setup_tool
Date: Fri, 25 Jan 2013 16:24:03 -0800
Message-ID: <7vip6k23mk.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan> <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
 <7vbocd2auo.fsf@alter.siamese.dyndns.org>
 <20130125220222.GE7498@serenity.lan> <20130125220359.GF7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TytZN-0003CP-4u
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab3AZAYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:24:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab3AZAYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:24:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B529C43B;
	Fri, 25 Jan 2013 19:24:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hdOsEfSdbAYGwomek//XUAVCU+M=; b=rfN0Ar9li/fNuyBA6LDb
	BQ9bBmR+R4QZNtXks/zRHgwm5dAlfPRwI21slj4TbkgcYb/Pm5DwO5/XSgkPfOu7
	wu/i2/K8DUM6WnYkVyPYn8Sgw9jnf8LN+rFdjwjEaKXAty1PwPTCt2uL5/NDn9Jf
	h82DKLiEcHh1+vrdGxner0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OZCa1aYtz6JMKtfHqsfYmTb3eOv7DOxGl2ttLO68e9yWMY
	DthCXNi9ngN9NwssPUsyYGmWSmsMPzp5+q9/e+NGvC/1CuWn/nFqq0Ykjdun2aab
	ayuC+3s0UBSEX8UisZO8xeAMPtX6AwuNWOXnxKTaWJNjQ33qbTWjPTG9cbTMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F222C43A;
	Fri, 25 Jan 2013 19:24:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85B3EC438; Fri, 25 Jan 2013
 19:24:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0C82C20-674E-11E2-9E00-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214599>

Applying this one on top of 1/7 thru 5/7 and 7/7 seems to break
t7610 rather badly.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
...
ok 1 - setup

expecting success:
    git checkout -b test1 branch1 &&
    git submodule update -N &&
    test_must_fail git merge master >/dev/null 2>&1 &&
    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
    ( yes "" | git mergetool file1 file1 ) &&
    ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
    ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
    test "$(cat file1)" = "master updated" &&
    test "$(cat file2)" = "master new" &&
    test "$(cat subdir/file3)" = "master new sub" &&
    test "$(cat submod/bar)" = "branch1 submodule" &&
    git commit -m "branch1 resolved with mergetool"

M       submod
Switched to a new branch 'test1'
Submodule path 'submod': checked out '39c7f044ed2e6a9cebd5266529badd181c8762b5'
not ok - 2 custom mergetool
#
#           git checkout -b test1 branch1 &&
#           git submodule update -N &&
#           test_must_fail git merge master >/dev/null 2>&1 &&
#           ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
#           ( yes "" | git mergetool file1 file1 ) &&
#           ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
#           ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
#           ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
#           ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
#           ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
#           test "$(cat file1)" = "master updated" &&
#           test "$(cat file2)" = "master new" &&
#           test "$(cat subdir/file3)" = "master new sub" &&
#           test "$(cat submod/bar)" = "branch1 submodule" &&
#           git commit -m "branch1 resolved with mergetool"
#
--- 8< ------ 8< ------ 8< ------ 8< ------ 8< ------ 8< ---

Due to ">dev/null 2>&1", all of the error clues are hidden, and I
didn't dig further to see which one was failing (this is why tests
shouldn't do these in general).
