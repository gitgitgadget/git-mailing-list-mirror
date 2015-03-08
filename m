From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Sun, 08 Mar 2015 00:09:54 -0800
Message-ID: <xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>
References: <54F89D90.6090505@gmail.com>
	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>
	<xmqq61af100p.fsf@gitster.dls.corp.google.com>
	<54F9E6B6.4070105@gmail.com>
	<xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
	<54FACD30.6080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:10:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUWHk-0003jO-2L
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbbCHIJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 04:09:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751389AbbCHIJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 04:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D04037A2B;
	Sun,  8 Mar 2015 04:09:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AWgVSyGRYq9R8HOo2VtF7K15qOg=; b=qqwvoS
	X0U0RAf1yW1bB2AmIf7j8yWVt6gIAAYG174Z78EG1VdkN8A/fqnt5Xh+dHBO9HKl
	/aTP8w856KXHaOFRECRTf2LN3Ad3gypiyUc2VfgW0I1XtpeHtNEvvxln5HImXrEJ
	KuRBmD+KBZqsFcBQ3nn8zFnhst/Puc98Lbwq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VNF25jS7wb0CXJGPkmx8g9aqZ3WYKh8s
	xA4I2peJohp8p3DHSlWQCFd0CN/Xbs5LJGxH97b//t9DYRo+u9T7jRdmYFDXbJ+i
	3G3IE/Orn7fib8SpMMID/vnueND6vY8bsBT5AjMm07sm46GZg4ZkCaXjiHLrL9dl
	Sr3HXQTOytk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5583037A2A;
	Sun,  8 Mar 2015 04:09:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C78CB37A28;
	Sun,  8 Mar 2015 04:09:55 -0400 (EDT)
In-Reply-To: <54FACD30.6080005@gmail.com> (karthik nayak's message of "Sat, 07
	Mar 2015 15:34:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8187A8E2-C56A-11E4-B21F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265045>

karthik nayak <karthik.188@gmail.com> writes:

> On 03/07/2015 12:58 AM, Junio C Hamano wrote:
>
> case 't':
> 	oi.typep = &type;
> 	oi.typename = &sb;
> 	sha1_object_info_extended(sha1, &oi, flags);
> 	if (sb.len) {
> 		printf("%s\n", sb.buf);
> 		strbuf_release(&sb);
> 		return 0;
> 	} else if (type) {
> 		printf("%s\n", typename(type));
> 		return 0;
> 	}
> 	break;
>
> This works but I need an else statement to check the type if not
> getting the type literally, which is because if not called literally
> the oi.typename is not set,...

Hmph, when I outlined that change to object-info-extended, I meant
to do it in such a way that when the optional oi->typename is set,
it is always filled whether "literally" is asked for andr whether
the object is a kosher one or a bogus one.

Without parsing the header, we wouldn't know how long the object
would be, so I do not know if not doing some variant of parse_header
is an option.

Thanks.
