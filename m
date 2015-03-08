From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Sun, 08 Mar 2015 01:03:34 -0800
Message-ID: <xmqqegozsvx5.fsf@gitster.dls.corp.google.com>
References: <54F89D90.6090505@gmail.com>
	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>
	<xmqq61af100p.fsf@gitster.dls.corp.google.com>
	<54F9E6B6.4070105@gmail.com>
	<xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
	<54FACD30.6080005@gmail.com>
	<xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>
	<54FC0CCE.70009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 10:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUX7i-0000HQ-3G
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 10:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbbCHJDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 05:03:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751619AbbCHJDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 05:03:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5F13804F;
	Sun,  8 Mar 2015 05:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UVGq4ZD+UTPr7MDJiCUZ2ArU+Aw=; b=Q3+DWQ
	vs8ZNp6m7E9spPq+keeV5IgtQ8fc0TUAAgwmxVKjK07HJy1yMVHC/nFPoSoWViS2
	ZcwCKLwpDhH4et//m1GpwmfIHhPVlDWJWCcWKS2GrOdeUQLCkKYwT98ePajdGG7y
	aqYYJduvYNbWDjfpwjn5XTxRt1yDP42k2clYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avn6q2sEI0TRQJGTDZiQLXMPB8mzU+v6
	kLF+Z4tW8o33PtInbf3IqnC06k0iewBX/NUR2uEDwsMHtZ5k3dsnXZvik+CFePYR
	OkYgUF8cfYn+xyE+jb6fzpzl8uFCohNNqBxOIvIDK0srQqHV5OL67RvLzQfjAxDw
	51rVf+JhuTE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 772303804E;
	Sun,  8 Mar 2015 05:03:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F02F43804C;
	Sun,  8 Mar 2015 05:03:35 -0400 (EDT)
In-Reply-To: <54FC0CCE.70009@gmail.com> (karthik nayak's message of "Sun, 08
	Mar 2015 14:18:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00E5EEF8-C572-11E4-B96E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265049>

karthik nayak <karthik.188@gmail.com> writes:

> What parse_sha1_header() does to get the type is just find the first
> occurrence of a " " manually and store everything before it as the
> type. Then it finds the size of the object if needed. And finally
> returns the type by calling type_from_string(). This is where we get
> the undefined type error.

Yes, exactly.  The change illustrated in $gmane/264420 may be
incomplete and some calls from the sha1_object_info_extended() after
that change may still need to further be tweaked to pay attention to
LOOKUP_LITERALLY bit; for example, parse_sha1_header() may want to
learn not to barf when seeing an unexpected typename in the header
when the caller asks to look up "literally".

I thought I already said that; sorry if I forgot.
