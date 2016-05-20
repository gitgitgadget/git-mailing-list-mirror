From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Fri, 20 May 2016 11:19:07 -0700
Message-ID: <xmqq8tz4ego4.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
	<xmqqshxdhi76.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
	<xmqq1t4wfyv4.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaBjHXGNxR_6WNWMtmBm0H_QCpHGciM7B1yY1yJ3S23wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:19:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3p12-0007Bq-6F
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcETSTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:19:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751032AbcETSTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:19:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FADD1D7C4;
	Fri, 20 May 2016 14:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VkDWhIxoGpb3kmeV/Wi7gZDnj6A=; b=N2xN9x
	NmvnkvAGGoKmKhYh2+5ODfDcoSl9tSngBVgG8S2p1ZBzL9CmcsxD3cW+6zFI+Sye
	7i1V7+NYsNXThcXT/WlCz1FWvyK6IDPwpJEcGMzAMcmbZWEJZ/arjcwqtVN2/bKF
	dBYWjDSavkb44hCCLKT7bZcJB7PMp5zMZiZVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SsSyZ2BajRJj+DWQBnv0NIdzQMZi1cp1
	+WluaX0WL/NTsotspU7z7CKDfP5/kufnOamRDQrTbdMt7TUY6Jnt4SLKsNlx+xQu
	1U7r9WaWj6AIXFTyzHCu3qDoOCL9/L1VPqRTHToq9OuzIADTpFWvtlcO8Huj86Tv
	ndZ4HT8L+Us=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 479AC1D7C3;
	Fri, 20 May 2016 14:19:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B445F1D7C2;
	Fri, 20 May 2016 14:19:09 -0400 (EDT)
In-Reply-To: <CAGZ79kaBjHXGNxR_6WNWMtmBm0H_QCpHGciM7B1yY1yJ3S23wA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 May 2016 11:12:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58B5CF5A-1EB7-11E6-BADC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295198>

Stefan Beller <sbeller@google.com> writes:

> As a user I'd prefer to be exposed to as few concepts as possible,
> and adding yet another concept of sparseness is not a good thing
> IMHO, so I'll try to keep it simple there.

Yes, and as a user, I'd prefer if I (and all the users) do not have
to even worry about the "sparse" hack.

If you are using submodules, it was in its design from day one that
it is not unsual for many of your submodules to be uninitialized
(but still present).  And that is a pretty normal state.  I do not
think we want to expose users to the "sparse" hack only to use
submodules effectively.
