From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] rebase [-m]: calculate patches in upstream correctly
Date: Tue, 26 Jun 2012 14:13:07 -0700
Message-ID: <7v8vf9bwv0.fsf@alter.siamese.dyndns.org>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1340722318-24392-6-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjd4c-0000pq-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2FZVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:13:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab2FZVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0933B91DA;
	Tue, 26 Jun 2012 17:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1EKiMD7ykFLG1GSgYcJeatlfHU=; b=ceHD2+
	liXV4129KkW4u17Umo0ORUqopyOqbxhoEvkGBPrvl+yTi0nPxj8dHLA978ykwRTr
	uxD9w8KqcFsb//Pvav8uH/Yelc7eou/lplumY9OFKrWxUFGMh4BOMhoQn3BNBdfS
	iuESq5/e/UZwxTSBY7hZ1wSwg7rIgoT2LfIgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eKyT8MhTR4GHBWrJ0PARZbOUwV1h/3U7
	CVZJPr1T6TZQSliW4Bip3YFKKvfbNq6NruSY2o96igh5S/UntjnY7fnZz+H3ag2i
	YEAjgs3LnSpIkJJ1WpsEGwhJVjZeP+dvBjTMSuHS4X7l1LjkTKU1OoyIJUR/ymmf
	d3hdNrbDta8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F388691D9;
	Tue, 26 Jun 2012 17:13:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8666091D8; Tue, 26 Jun 2012
 17:13:14 -0400 (EDT)
In-Reply-To: <1340722318-24392-6-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Tue, 26 Jun 2012 07:51:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE10D292-BFD3-11E1-B274-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200682>

Hrm, why does this break 9140.6?  Has the test been expecting a
wrong result?

-- >8 --

expecting success: 
        ( cd g &&
          git svn fetch &&
          git svn rebase &&
          fgrep "mod hidden" hid/hid.txt
        )

Index mismatch: a4b5c203f79112e92d530cb82366ca4d706fa4a8 != 6b5a1244749c8cdb5442eefd0abc3689d666322d
rereading 6f980d1f3188db5082d5bfd2f28b317b6e7b8893
        A       hid/hid.txt
r2 = 9c02870abb807d33b84cc36ab2f2384bf01448f8 (refs/remotes/git-svn)
        M       vis/vis.txt
r3 = 26a2abacc1ca26dde5a0b18a73f0b2d306dc95d1 (refs/remotes/git-svn)
        M       hid/hid.txt
r4 = 9299b4c6227b8efcc64ec5e867f0eeae4d1c96ec (refs/remotes/git-svn)
First, rewinding head to replay your work on top of it...
Applying: create initially hidden files
fatal: unrecognized input
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 create initially hidden files

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase
--skip".
To check out the original branch and stop rebasing run "git rebase
--abort".

rebase refs/remotes/git-svn: command returned error: 1

not ok - 6 refetch succeeds not ignoring any files
