From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Thu, 24 Feb 2011 08:40:55 -0800
Message-ID: <7voc612xns.fsf@alter.siamese.dyndns.org>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
 <1298121481-7005-8-git-send-email-pw@padd.com>
 <7vbp25hsk6.fsf@alter.siamese.dyndns.org>
 <20110224121210.GA16475@arf.padd.com>
 <AANLkTik=KWwszN9ETOh11btPvcPXCcoA=evT4Fgxt-Fm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PseFg-0007le-7Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab1BXQlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:41:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab1BXQlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:41:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 310EC3424;
	Thu, 24 Feb 2011 11:42:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TNiveueKBDtK/O6wqXnzGdMVOOc=; b=ae90JZ
	krRiz+2jL9JtCJ5KEY9xNPBu0M6F0sHXK63hBgt9epMEICmk4FpYgJLOKhvmSINe
	XnAPlR/zzopsKDR9ne4ewXD/8tljYg7CTTeZIA8n/TAMhvz2NFlJJTrMwZw3t1uk
	cFUXxMSU8dudPaUs1iJCGOU1jcw586a9yXojM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gq1a8uRt61KFwUJ5/h6QvuvfnTrh7Imn
	qSuiaJRE9fygvDqivmyYKnUm/jy39H3RagxdwLWBj5clM+vN773PBxAbj2Txx820
	KR9u/XCGxdTVXTOHYqMXtG/6z9CMJnTZq3ObeZGpzribd+pbMysBI3KMQdEkyUKr
	/BZPQbOBInI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E31A83420;
	Thu, 24 Feb 2011 11:42:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 155F23413; Thu, 24 Feb 2011
 11:42:11 -0500 (EST)
In-Reply-To: <AANLkTik=KWwszN9ETOh11btPvcPXCcoA=evT4Fgxt-Fm@mail.gmail.com>
 (Tor Arvid Lund's message of "Thu\, 24 Feb 2011 14\:54\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0BDE1EDC-4035-11E0-92E1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167835>

Tor Arvid Lund <torarvid@gmail.com> writes:

> On Thu, Feb 24, 2011 at 1:12 PM, Pete Wyckoff <pw@padd.com> wrote:
> ...
> Yeah, I was thinking... what happens now if we do:
>
> 1) Create "my*file" in linux, and submit.
> 2) git-p4 sync from windows, and get my%2Afile on windows.
> 3) modify my%2Afile and do git commit.
> 4) git-p4 submit
>
> I haven't had time to test right now, but maybe p4 will not recognise
> my%2Afile (or try to check it in as my%252Afile (replacing the '%'
> character) or something like that? (Or maybe I just haven't had enough
> coffee today :-/ )

This shares the same issue as "checking files out on case insensitive
filesystems" topic in the other thread.  "my*file" may not be usable by
the project when renamed to "my%2Afile", so "git-p4 sync" may want to warn
the user about the path when this happens.

And you need to reverse this quoting upon "git-p4 submit".  Does that
happen already?
