From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 06/13] Read index-v5
Date: Wed, 08 Aug 2012 10:05:28 -0700
Message-ID: <7vipcttiuf.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-7-git-send-email-t.gummerer@gmail.com>
 <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9hQ-0001F7-NC
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 19:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929Ab2HHRFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 13:05:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758903Ab2HHRFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 13:05:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E4818841;
	Wed,  8 Aug 2012 13:05:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDxoIUYyVwepvDEojVWgmmP6bC0=; b=tvZ/7N
	0G/aWf0w6Se2ADt6l4bpGyP2HJCv5ZPx3cu9zZCKFux28eV/sha3UZiyHLFo0wwK
	epx5mQEBeWXadOUp74sBZUQwUvVmxVlwVQ9Qb7aCt3716WlwlcyuGskir4AKuFFJ
	SW4IWiooGtX1XbYruageVxjQrZSD/j0Y5VPaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IkgffjbQFVJwNaSaCKFolrod+Mc3bmEm
	SoufrZ72csz/3Yh888hFv83d8vW7Q+ZwtuqQaEV3IZILoBAx9hKzWQaoJ6fE+VKb
	6exZKK6rch3rpd6ti89skH3++dJ30RVhFT0pHWCASD0wKSxP55SYwDiMtL5Xq/N4
	qMQ8978l2FU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A8288840;
	Wed,  8 Aug 2012 13:05:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE356883C; Wed,  8 Aug 2012
 13:05:29 -0400 (EDT)
In-Reply-To: <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 8 Aug 2012 19:05:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41C5F360-E17B-11E1-BE6B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203101>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> +struct index_ops v5_ops = {
>> +       match_stat_basic,
>> +       verify_hdr,
>> +       read_index_v5,
>> +       NULL
>> +};
>
> If you do it right, putting write_index_v2 here should work because
> in-core structure is not changed (except that write_index_v2 is static
> function, well..). Maybe putting write_index to this struct is a wrong
> decision. We should be able to read_index_v5+write_index_v2 and
> read_index_v2+write_index_v5.

The "right way" is to have a global API function

    write_index_in_format(int version, int fd);

which calls "the_index->index_ops.write_index[version](the_index, fd)",
no?
