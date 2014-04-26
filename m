From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sat, 26 Apr 2014 10:27:07 -0700
Message-ID: <7vtx9ghuhg.fsf@alter.siamese.dyndns.org>
References: <20140421204622.GA9532@logfs.org>
	<20140425182928.GA29904@logfs.org> <vpqoazpdz1r.fsf@anie.imag.fr>
	<20140425201048.GB29904@logfs.org>
	<20140426071358.GA7558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:25:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6M1-0008WM-IR
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbaDZRZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 13:25:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbaDZRZZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 13:25:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1201C79C71;
	Sat, 26 Apr 2014 13:25:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f9HyaVDaQ7us
	KiaPeQnXv9K4uXc=; b=K5r9gLY8GP9KRLqp01tvQ3jCKWoQjiKRSkreRpbmBR4z
	dMpMFsiaNbKzJcGk7g9va8I+W6DQFP0/8MYCuh4pXaBjr8Q+ANDhCx3o0ZT9iApj
	zX7DsW6u2LRVtv0GgxunaMGIuCUjNDFNT9KUth9zlywMYdPxbQQcwUrxtEN4yIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F7t7r5
	oFBMf4iHoMiDU5xTU3BxDamHMDqvwGjLGaFK1auS4ads+xFRg+oCenHrwrNAJ5KD
	BGf2z2eZ8+EW6lnqm6hzTbBywI/G0TLrmq9w0aCMUudFc0M7cfHD2ZGMvRGPH2C7
	v52Qv0tEIgGRYJMQS8XFE0h4jxX4z462xm0Ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E69E279C6F;
	Sat, 26 Apr 2014 13:25:24 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8A9E79C6D;
	Sat, 26 Apr 2014 13:25:22 -0400 (EDT)
In-Reply-To: <20140426071358.GA7558@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 26 Apr 2014 03:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: BF8501FE-CD67-11E3-9F4B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247164>

Jeff King <peff@peff.net> writes:

> [+cc Duy, whose patch this is]
>
> On Fri, Apr 25, 2014 at 04:10:49PM -0400, J=C3=B6rn Engel wrote:
>
>> A second option is to add a --pager (or rather --no-pager) option to
>> the command line and allow the user to specify
>>     GIT_PAGER=3D"git --no-pager -p column --mode=3D'dense color'" gi=
t -p branch
>
> I think we have "--no-pager" already. But the "-p" is turning _on_ th=
e
> pager, so you could also just omit it. IOW, I really don't understand
> why the original command was not simply:
>
>   GIT_PAGER=3D"git column --mode=3D'dense color'" git -p branch
>
> The whole infinite loop that the original commit solved is caused by
> specifying the "-p". So it sounds like the right solution is "don't d=
o
> that". Am I missing something useful that the "-p" does?

My reading of this is that Duy wanted to let "-p" kick in to pass
the columnized output, which could be more than a page long, thru
the usual "less" or whatever pager.
