From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 11:49:35 -0700
Message-ID: <xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcba-0003Au-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbaCQStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:49:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbaCQStl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:49:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE8676FC6;
	Mon, 17 Mar 2014 14:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FYricVbCiGec3jun98k2ElUe+dI=; b=VS9W3r
	y7oIujGsn8hou2HbZQ1ILIi9yQEBuvBQR8KF70ig4L2Ol5Q84MheIZYqDdt0bpEP
	h5V4sn/cBrlf2k7z3VQxv+4cEeBOJzms9eOYxCUhkMMvKLocIcdjRcmwXBb02Am7
	WjkysDII1dzERCKr/nqwO2BNShiPbG/qdxpk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uRW8JxJsesMKCI47T/lp7LTAuGwQnKb0
	UsRWsxp9n74CaVLJOayVSmkGN4oKOukLfjmBXB81ptojI0ofiveRK7tIs42RWcsm
	g/UuLCrgLp7H7LkDDLCHFRG+vkihs983Rp6JuSCQMVNK5py9yfSg8/kwerQHIQIp
	51PEujDhqZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF3576FC5;
	Mon, 17 Mar 2014 14:49:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB07676FC2;
	Mon, 17 Mar 2014 14:49:39 -0400 (EDT)
In-Reply-To: <1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Sat, 15 Mar 2014 22:42:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E529A22A-AE04-11E3-8710-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244264>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> Add (failing) tests: with commit changing the environment to let hooks
> know that no editor will be used (by setting GIT_EDITOR to ":"), the
> "edit hunk" functionality does not work (no editor is launched and the
> whole hunk is committed).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7513-commit-patch.sh | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100755 t/t7513-commit-patch.sh
>
> diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh

Again, as I said, I'll rename this to t7514-commit.patch.sh while I
queue this.

Thanks.

> new file mode 100755
> index 0000000..9311b0c
> --- /dev/null
> +++ b/t/t7513-commit-patch.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='hunk edit with "commit -p -m"'
> +. ./test-lib.sh
> +
> +if ! test_have_prereq PERL
> +then
> +	skip_all="skipping '$test_description' tests, perl not available"
> +	test_done
> +fi
> +
> +test_expect_success 'setup (initial)' '
> +	echo line1 >file &&
> +	git add file &&
> +	git commit -m commit1
> +'
> +
> +test_expect_failure 'edit hunk "commit -p -m message"' '
> +	test_when_finished "rm -f editor_was_started" &&
> +	echo more >>file &&
> +	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit2 file &&
> +	test -r editor_was_started
> +'
> +
> +test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
> +	test_when_finished "rm -f editor_was_started" &&
> +	echo more >>file &&
> +	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit3 file &&
> +	test -r editor_was_started
> +'
> +
> +test_done
