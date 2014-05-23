From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] format-patch --signature-file <file>
Date: Fri, 23 May 2014 09:56:13 -0700
Message-ID: <xmqqbnuol9hu.fsf@gitster.dls.corp.google.com>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
	<1400723589-8975-3-git-send-email-jmmahler@gmail.com>
	<xmqqtx8hmt7m.fsf@gitster.dls.corp.google.com>
	<20140523055517.GA30019@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnsld-0001Bf-7f
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbaEWQ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:56:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61275 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaEWQ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:56:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B73D182F8;
	Fri, 23 May 2014 12:56:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BnwMiB1KSp2LydjuOKHXX6TfruM=; b=yaJqj2
	lUsUPObNhcdafdj0lq/GQSkOiVFo2A+l9Isp4d8h5sq/PGaGWDFMn4J7hkzDTL+z
	Q19v8dGvYib9l28sI6l1yQxm69YQdhb6jBJ/9TcijesaVALU2cXenNTMaJBjvyTY
	EkgbaiLRSQq/ifPq9ZYWAt11jnJo488/LISB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYOBAUQA/bKW9JYd0cKWtJITAicGsKim
	2goWvy1EPzCbRYEZDY7m3W8ySP+q9yI4dMw0uva4zSbF6GywLL9fz2BZEx4lQ8IJ
	Txd/5whEXJ8dfCQv42BlAPW2orAwCeWAqGMNOTe+H31Eju1mr01hiWQpVZMyr2b2
	S18jdW0tuQY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9247C182F5;
	Fri, 23 May 2014 12:56:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C1669182EF;
	Fri, 23 May 2014 12:56:15 -0400 (EDT)
In-Reply-To: <20140523055517.GA30019@hudson.localdomain> (Jeremiah Mahler's
	message of "Thu, 22 May 2014 22:55:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 274725F4-E29B-11E3-8250-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249997>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Your comments make it clear that I have not accounted for all the possible
> cases.  Below is a table of all the reasonable cases.  It should account
> for cases you mentioned as well as others.
>
>   Key:
>   ---
>   default: Git version number
>   sig1: .signature from column 1
>   file1: .signaturefile from column 1
>   sig2: --signature from column 2
>   file2: --signature-file in column 2
>
> A preceeding 'format.' is assumed for config.  .signature -> format.signature
> Command line arguments take precedence over config options.

;-)

I do not mind the full matrix if it is cleanly done.

It may be an overkill and a maintenance burden, especially if it can
be done only with a sequence of cut-and-paste repetition (i.e. not
as a loop in the test script that synthesises the permutations).

The suggestion for those three combinations were meant to be an
easy-to-implement-and-maintain compromise.

Thanks.

> |----------------------------+-------------------------------------+---------|
> | config  (1)                | argv  (2)                           |         |
> |----------------------------+-------------------------------------+---------|
> |                            |                                     | default |
> |                            | --signature                         | sig2    |
> |                            | --signature-file                    | file2   |
> |                            | --no-signature                      | none    |
> |                            | --no-signature-file                 | none    |
> |                            | --signature, --signature-file       | die     |
> |                            | --signature, --no-signature-file    | sig2    |
> |                            | --signature-file, --no-signature    | none    |
> |                            | --no-signature, --no-signature-file | none    |
> | .signature                 |                                     | sig1    |
> | .signature                 | --signature                         | sig2    |
> | .signature                 | --signature-file                    | file2   |
> | .signature                 | --no-signature                      | none    |
> | .signature                 | --no-signature-file                 | sig1    |
> | .signature                 | --signature, --signature-file       | die     |
> | .signature                 | --signature, --no-signature-file    | sig2    |
> | .signature                 | --signature-file, --no-signature    | none    |
> | .signature                 | --no-signature, --no-signature-file | none    |
> | .signaturefile             |                                     | file1   |
> | .signaturefile             | --signature                         | sig2    |
> | .signaturefile             | --signature-file                    | file2   |
> | .signaturefile             | --no-signature                      | none    |
> | .signaturefile             | --no-signature-file                 | default |
> | .signaturefile             | --signature, --signature-file       | die     |
> | .signaturefile             | --signature, --no-signature-file    | sig2    |
> | .signaturefile             | --signature-file, --no-signature    | none    |
> | .signaturefile             | --no-signature, --no-signature-file | none    |
> | .signature, .signaturefile |                                     | die     |
> | .signature, .signaturefile | --signature                         | sig2    |
> | .signature, .signaturefile | --signature-file                    | file2   |
> | .signature, .signaturefile | --no-signature                      | none    |
> | .signature, .signaturefile | --no-signature-file                 | sig1    |
> | .signature, .signaturefile | --signature, --signature-file       | die     |
> | .signature, .signaturefile | --signature, --no-signature-file    | sig2    |
> | .signature, .signaturefile | --signature-file, --no-signature    | none    |
> | .signature, .signaturefile | --no-signature, --no-signature-file | none    |
> |----------------------------+-------------------------------------+---------|
>
>
> Thanks,
