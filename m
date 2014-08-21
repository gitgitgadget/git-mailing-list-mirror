From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Handling unmerged files with merged entries
Date: Thu, 21 Aug 2014 15:18:46 -0700
Message-ID: <xmqqbnrdqyex.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
	<53F63D2F.9060704@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:19:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKahA-00059T-9V
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 00:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbaHUWS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 18:18:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60017 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbaHUWS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 18:18:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDE6634292;
	Thu, 21 Aug 2014 18:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/vtm6pVBTDFLLuo7me0qz63P7pw=; b=UBMqd8
	ZKJXUPYZWhHs2pC2HZZyW6fYZaDOI/9GSIz2Qu6hEXIAXiufX5tP/aIOVmWtQPNi
	qjBNoQzGWYvA1gUmQh/xgyrZYk449/JYdzKbpMKG4xz5wK3tk4rOEw7LB1OugtUS
	9ZksYg8st83XdulEeZVoIqp8j7Mz8WM7rWrjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rFtlzIB0TSOYc6ijmXG1g1QZoCA0hq01
	h3X3GTLLpnnq7ChQQEGOk+EM78VazpCgzb4euFiWjxzD2EMxx9dH3jGLrirk62Lj
	IRDf74gL9e038Av4MgUVhK9OCZZmMFhZoAetfxAs+A7foI73K5i1NzboH2KAt6Lb
	IKpuCqesxAw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2DC634291;
	Thu, 21 Aug 2014 18:18:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15F4034285;
	Thu, 21 Aug 2014 18:18:48 -0400 (EDT)
In-Reply-To: <53F63D2F.9060704@kdbg.org> (Johannes Sixt's message of "Thu, 21
	Aug 2014 20:40:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F536696-2981-11E4-99AD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255641>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.08.2014 00:19, schrieb Junio C Hamano:
>> For that, we need to catch an index whose entries are not sorted and
>> error out, perhaps when read_index_from() iterates over the mmapped
>> index entries.  We can even draw that "hopelessly corrupt" line
>> above the breakage you are addressing and add a check to make sure
>> no path has both merged and unmerged entries to the same check to
>> make it error out.
>
> Except that we can't declare an index with both merged and unmerged
> entries as "hopelessly corrupt, return to sender" when it's dead easy to
> generate with the git tool set:
>
>  >x
>  name=$(git hash-object -w x)
>  for i in 0 1 2 3; do printf '100644 %s %d\tx\n' $name $i; done |
>  git update-index --index-info

Because hash-object and update-index deliberately have these holes
to allow us (read: me ;-) to easily experiment new and/or unallowed
formats, I wouldn't take that as a serious objection.  It is dead
easy to corrupt your repository or lose your data by /bin/rm, too
;-)
