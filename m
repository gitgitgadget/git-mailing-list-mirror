From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 03 Mar 2014 10:49:27 -0800
Message-ID: <xmqq61nvqfrc.fsf@gitster.dls.corp.google.com>
References: <1393775755-15359-1-git-send-email-mzguanglin@gmail.com>
	<CAPig+cRy2Jt_3DAS=ARzN-8HT3rdMCSGP5QfU8sJZGwqsJTG3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guanglin Xu <mzguanglin@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXvj-0007Xp-N3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbaCCStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:49:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbaCCStb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:49:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CBCE6F956;
	Mon,  3 Mar 2014 13:49:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BV7PfasWKYdma//pb0HIujfNA38=; b=iV8Mf+
	6BydD7ezt/porZJxzAuN13xiTkk69MnkZwzC8f0uEgI0VruL54gIQ2+3kRwXwfrW
	ToLF7+/cBspPEacY9xk1B/sVDBq7D0mYSmPar03ZkUMtsQgncwLOFZqYYTk7e/RX
	VJ7wbSJl4g7onSXHuxi7AzZID726RJdTIBRRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVHiiy95XcDG+txIhiDPjGQ8So2C5SZk
	qKOECJh9mN3HFyrmWB9PUxgZmjcauO3PJ/SRnTqVVIydyYrn/ACYCdZwsoLRf2M4
	SrR7YL0HsoIKcDoHP84YH5wstcmmBYPm0JoAUkiZozKeylwNgA2WH7CX5sgPc0ee
	AEos8sDLH7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80ABB6F951;
	Mon,  3 Mar 2014 13:49:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E236F94C;
	Mon,  3 Mar 2014 13:49:29 -0500 (EST)
In-Reply-To: <CAPig+cRy2Jt_3DAS=ARzN-8HT3rdMCSGP5QfU8sJZGwqsJTG3g@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 2 Mar 2014 17:56:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D480AA2-A304-11E3-8E08-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243253>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/branch.c b/branch.c
>> index 723a36b..ca4e824 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>>         const char *shortname = remote + 11;
>> -       int remote_is_branch = starts_with(remote, "refs/heads/");
>> +       int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
>
> This actually makes the code more difficult to read and understand.
> There's a more fundamental reason to use skip_prefix() here. See if
> you can figure it out. (Hint: shortname)

I've already queued 0630aa49 (branch: use skip_prefix() in
install_branch_config(), 2014-02-28) on this topic, by the way.
