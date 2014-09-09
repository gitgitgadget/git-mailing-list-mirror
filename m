From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 8/8] log --remerge-diff: show what the conflict resolution changed
Date: Tue, 09 Sep 2014 12:08:18 -0700
Message-ID: <xmqqr3zkk3x9.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRQmQ-0005Rg-77
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaIITIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 15:08:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60728 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbaIITIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:08:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D86137AF9;
	Tue,  9 Sep 2014 15:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzTobkMFguIfE5lAllSPOxefr74=; b=KveMJY
	hVxVIFvVK54PMI7FduhvagOeVEfyxIcaPW1kZzEgSi+6DkScm6Zw3ikhfBX7PU4/
	VxdFzLE783Q5hX3nVaSgpyx41Zv/xP9yMi9IO51RvYHpb14CdJKUbYoPJaBjp1uk
	ieA1u8kVBcxowzgRd7pplC4U/2C9f6SSUe+is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSh0U9M3xQV63mvz85kz937pLN5R2t+Y
	9tcA1CpfEvVYKIMtmFniWEMxH0umvLN5Rix4jqsyu4+wPlIeko2WrwuNOMipy+h9
	Kmgo5KEsyWQ8Ve8NE//x61EahSfRs31S5uplHW0PfeenDO82KihKRzIhi3CkJdqF
	zLWxW0zoU7I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43C8437AF8;
	Tue,  9 Sep 2014 15:08:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AEAE837AF7;
	Tue,  9 Sep 2014 15:08:19 -0400 (EDT)
In-Reply-To: <29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A954D0AA-3854-11E4-8B4A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256703>

Thomas Rast <tr@thomasrast.ch> writes:

> +			assemble_conflict_entry(&content,
> +						branch1, branch2,
> +						stage2, stage3);
> +			if (write_sha1_file(content.buf, content.len,
> +					    typename(OBJ_BLOB), sha1))
> +				die("write_sha1_file failed");
> +...
> +	if (cache_tree_update(&the_index, WRITE_TREE_SILENT) < 0) {
> +		printf("BUG: merge conflicts not fully folded, cannot diff.\n");
> +		return !opt->loginfo;
> +	}

Another worry I have on this change is that it breaks the
expectation that "log [-p]" is a read-only operation.  I do not know
how big a breakage this will be viewed as by those uninitiated who
do not know how --remerge-diff (or Git in general) works internally.
