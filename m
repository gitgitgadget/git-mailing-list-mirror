From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] struct ref_update: move "have_old" into "flags"
Date: Thu, 12 Feb 2015 11:15:32 -0800
Message-ID: <xmqqsiebrlez.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYqx8s8Cz29Qn1aBtCnDOkR-Guk4RM-_KQeO+nHWv=r8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzEo-0003st-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbbBLTPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:15:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912AbbBLTPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:15:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 213E235CC8;
	Thu, 12 Feb 2015 14:15:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oM9lhlJPOMUSgGP4s/wl+UEuW80=; b=q3aDas
	+Nu/DBaxrCX8GD+PYVmoYIf7RpI3hn3UTC1KqWfeImSvWDE9yJ6MKchuEojQyILr
	ZhWwsCf7vBFSfx46nHhkKDo5ALXFEdDu+zpYDSbsLwtcaZJUygIsEOy+ElFZSLpL
	JpeTsXLQGmUo4xQJ+nHrrmKDNtpgv6FM2ayvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNwGAdA0ABL7tCSY4QCBYzMcGOo1MlU0
	PFw7szaQoRVeJ0zTYl8rwIZyNR4bvUl8RQevdl/en+tzVRmSSIhDf+SS6Ot1yx+t
	2KFLFb0hVE9vOOUulaDZ0/kZbLQai/VZ2pZQ82fi5LYfLWll7njZxwAhYN1iUplr
	3ygxE8USfU0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FF4C35CC7;
	Thu, 12 Feb 2015 14:15:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55BC635CC6;
	Thu, 12 Feb 2015 14:15:33 -0500 (EST)
In-Reply-To: <CAGZ79kYqx8s8Cz29Qn1aBtCnDOkR-Guk4RM-_KQeO+nHWv=r8w@mail.gmail.com>
	(Stefan Beller's message of "Thu, 12 Feb 2015 10:08:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8447A60E-B2EB-11E4-8D43-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263751>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> -       int flags; /* REF_NODEREF? */
>> -       int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>> +       /*
>> +        * One or more of REF_HAVE_OLD, REF_NODEREF,
>> +        * REF_DELETING, and REF_IS_PRUNING:
>> +        */
>> +       int flags;
>
> Nit:
> I'd find it more readable if it would be:
>     /*
>      * One or more of
>      * REF_HAVE_OLD,
>      * REF_NODEREF,
>      * REF_DELETING,
>      * REF_IS_PRUNING:
>      * whose definition is found at the top of this file.
>      */

I wouldn't do either, though, as you would have to keep repeating
yourself here and over there.  Wouldn't it be sufficient to:

 - Have a header that says "these are bits meant to go to struct
   ref_update.flags" at the beginning of series of #define's;

 - Say "ref_update.flags bits are defined above" here.  The phrasing
   can be "One or more of REF_HAVE_OLD, etc. defined above." as long
   as it is clear that this is not meant to be an exhausitive list.

Also, unless we are taking advantage of the fact that MSB is special
in signed integral types [*1*], I would prefer to see us use an
unsigned type to store these bits in a variable of an integral type.
That would let the readers assume that they have fewer tricky things
possibly going on in the code.


[Footnote]

*1* For example, you can give the MSB to the REF_ERROR bit, and say

	if (structure->flags < 0)
        	there is an error;
	else
        	other things;

only if flags is a signed type.  Also if you are relying on the fact
that MSB is special in this kind of thing:

	structure->flags >>= 3;

then you obviously cannot use unsigned type for collection of bits.
