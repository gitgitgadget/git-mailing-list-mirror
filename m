From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/19] reset --keep: only write index file once
Date: Wed, 09 Jan 2013 11:55:25 -0800
Message-ID: <7vd2xe5dxu.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-11-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1ka-0002A3-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab3AITz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:55:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439Ab3AITz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:55:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C3F0B8F3;
	Wed,  9 Jan 2013 14:55:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4anrLQNmAjxWviWteWh1tMObtkc=; b=co3udI
	00EpgvepqWbkfaKzwWD1fFtfdM40LzfCgzMklNmBqu77V+kO/Y+/CEn/wTSp6M88
	b4fpPlsifdjNsriKceFx8aHD+vvJOyE85pAoYiOvvr66qnsuk6fTb9De66cG29Ue
	2liFn8aDmRP1gypuxzUQDbA+Bd0msAMPaIO4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSAV5F5JlT13SzeoyaUFCkONNJKD+KZ2
	9UCFEXvIDBf9Ik9GzXeqmKDRHrbmwYtB/aq/xv5vtpEuBHj+3Y9HF9UE0tfoMjL/
	RBpqt4o5iFkzih/p/i2Z7gNMy+rL3+GHbfknAuLprBd5VMrheGuRHoJKQOlcJc09
	S+7XPZc5pdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA34B8F2;
	Wed,  9 Jan 2013 14:55:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 921CCB8F0; Wed,  9 Jan 2013
 14:55:26 -0500 (EST)
In-Reply-To: <1357719376-16406-11-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 832043D0-5A96-11E2-8A9E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213094>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> "git reset --keep" calls reset_index_file() twice, first doing a
> two-way merge to the target revision, updating the index and worktree,
> and then resetting the index. After each call, we write the index
> file.
>
> In the unlikely event that the second call to reset_index_file()
> fails, the index will have been merged to the target revision, but
> HEAD will not be updated, leaving the user with a dirty index.
>
> By moving the locking, writing and committing out of
> reset_index_file() and into the caller, we can avoid writing the index
> twice, thereby making the sure we don't end up in the half-way reset
> state.

Nice.
