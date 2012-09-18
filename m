From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched
 branch
Date: Mon, 17 Sep 2012 20:56:33 -0700
Message-ID: <7vwqzsoufi.fsf@alter.siamese.dyndns.org>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
 <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
 <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
 <7vd31kv2ba.fsf@alter.siamese.dyndns.org>
 <CACsJy8CUuPPvTMNmtX9P5ZHkvUHCVZkKmPj7Ghubxt_daPaKZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 05:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDovV-0005JS-JW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 05:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755Ab2IRD4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 23:56:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932728Ab2IRD4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 23:56:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EF498734;
	Mon, 17 Sep 2012 23:56:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hLwFA3FhaZatgbFkAmkHHybRJJI=; b=aqvdiv
	Rx4Hwa2PC4Djh5ebQ8VO1rWF5TPw/lluojPD7ZCTM3sVCM7TYJrb9NZOR3v1Uhfi
	tNGaQ35l9R/U9vqnXkoftE4M7dqz0Qd2ejnghMQNKJb+K57CL1SZQQd0chgKi69D
	wjAvMjeN0CViTb/yOOWJnmYbypIRROAPzaqXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2h7/rCmcgO67vjq+m/xKuQIMQ9DJOxh
	kUvRqdA6uZ7x1KvMQw17X0h/lXD6AemeWzaVFbDuGTGYlKu9me47TkfMS1iBGFhb
	ioLdaobLgJr68DyM4JWrWtb5x4f5BONGVPzbmiL0uAYT7O1JuRRSfdTWbnBDyBB5
	c+r3tqI/NCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 580198733;
	Mon, 17 Sep 2012 23:56:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7556D8732; Mon, 17 Sep 2012
 23:56:34 -0400 (EDT)
In-Reply-To: <CACsJy8CUuPPvTMNmtX9P5ZHkvUHCVZkKmPj7Ghubxt_daPaKZg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 18 Sep 2012 08:04:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6A206DE-0144-11E2-9B10-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205786>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Sep 18, 2012 at 3:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Mon, Sep 17, 2012 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>>> --mirror --single-branch combination does not look right. The "heads/"
>>>> part is missing..
>>>
>>> It also does not look right for cloning a tag:
>>>
>>> $ LANG=C ./git clone --single-branch --branch=v1.7.0 .git abc
>>
>> What does it even _mean_ to clone a single branch and give a tag,
>> not a branch, to the --branch option?  Again, shouldn't it be
>> diagnosed as an error in the first place?
>
> That could be misleading. The original purpose is to clone just one
> ref, be it a branch or a tag. You might want to work on top of a
> specific version and may not want to clone everything.

Yeah, see my other comments.
