From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/FR] Should "git checkout (-B|-b) branch master...branch" work?
Date: Fri, 21 Dec 2012 07:58:27 -0800
Message-ID: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 16:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm50N-0000PI-76
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 16:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab2LUP6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 10:58:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab2LUP6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 10:58:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802C68C57;
	Fri, 21 Dec 2012 10:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	IzzQZH2EARMxs6bbELdcTx/HYU=; b=qDrU1VyMV3j3HP5wn9Xu9UzDdEPbmyEk9
	FLq6G9AANvakaqo+wED7k/vBVen35G/X+egJacbnU0cwxlu7gPr6vFD2QBqZF0e9
	V5Bqqt73R3fYTvA+6aJWw7r/ochKNgIihyas7gP8w/pDd/MdBHrhmJVzzs6D+InO
	pXNm75mQQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=cLP
	MSkFveEFfiwLJ4PJTRchbtTiHYMVvSHYFNSlkn7kI/doZoCDm/sJgBgyzxosBbZg
	HG9WdZ4hqaczK0D+AD28zNQW60tOFU8RyehK2XQWgiAbrJieY6hy8NWl93z4Ifj9
	fs2baQrSTHSkXNjCxhx887eordHxnSkZxJSw+kBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CFC38C56;
	Fri, 21 Dec 2012 10:58:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66F598C48; Fri, 21 Dec 2012
 10:58:30 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 445F1234-4B87-11E2-A89C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211978>

When you want to redo a branch forked from another branch (say
'master'), a handy way to work is to first detach HEAD at the
previous fork point:

    $ git checkout master...branch

and build an updated history on top of this state.  Once you are
done, you can verify your results with commands like:

    $ git show-branch branch HEAD
    $ git diff branch HEAD

and then finish it off with:

    $ git checkout -B branch

This way, you can keep the history of the previous round on 'branch'
until you are done with the new history you build on the detached
HEAD state, and if you do not like updated history, you can reset
back to branch@{1} easily.

But you may not even need to have such an easy access to the old
history and just want to restart, with:

    $ git checkout -B branch <old fork point>

Unfortunately, master...branch syntax does not seem to work for
specifying the "old fork point" for this purpose, even though we
have special case to support the syntax in the "detach at that
commit" case (the first command line example in this message).

Perhaps we should teach the <start-point> parser this syntax as
well?
