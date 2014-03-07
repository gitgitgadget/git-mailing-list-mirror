From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Fri, 07 Mar 2014 10:27:21 -0800
Message-ID: <xmqq8uslvp86.fsf@gitster.dls.corp.google.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
	<1394095783-24402-1-git-send-email-pclouds@gmail.com>
	<xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
	<CACsJy8B8=N6R6nVa12jjhxdqxMA2eGXOV6jR-XqRRbb-6Xppdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:27:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLzUY-0004Sn-7F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 19:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaCGS10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 13:27:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbaCGS1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 13:27:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D6070EE1;
	Fri,  7 Mar 2014 13:27:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w2I6poCNKG2PW73lvBjzbGlqDNc=; b=VWUbCp
	d+4IBNFxxnAIaB21tOYpp46hv8FthwyumsvFrySI2WkZww7V8h5OkyNFKu1nBD3S
	2/xlywxzMFBlWw1kjt0JuJPH+RM05L+kDlsIdfGGVwz9iVghVIa1uu+1FC7I7bLz
	Mg+wJAI5trUOywstUo2tqzAJfzw9xoeK2thr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RS8bnTlvyypKOQCmv7Y7GB8rCSoJGkeF
	UR3MmcJA3ocwgN5igHY+eppVhS989Ub/QOlYNCmxSOMv6Nvk9D8e03O4qQgi2qlL
	rEnOD7MIRbd+AMDsFHkxv7rgPUVbsGkULpu1DcrlSG7pTtTkk1S78rplVwFvWv/M
	pbEU4fA6vMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0310B70EDE;
	Fri,  7 Mar 2014 13:27:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E3370EDA;
	Fri,  7 Mar 2014 13:27:24 -0500 (EST)
In-Reply-To: <CACsJy8B8=N6R6nVa12jjhxdqxMA2eGXOV6jR-XqRRbb-6Xppdg@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 7 Mar 2014 06:13:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20EF77B2-A626-11E3-8709-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243621>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 7, 2014 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I like what I see in this patch, but I wonder if we can essentially
>> revert that "temporary shallow file" patch and replace it with the
>> same (or a similar) mechanism uniformly?
>
> Using --shallow-file is uniform.  The only downside is temporary file.
> Without it you'll need to think of a way (probably different way for
> each command) to feed shallow info to.

Yes, that is what I meant to say by the "we need a way to tell hooks
in some cases" below; we are in agreement.

>> On the receive-pack side, the comment at the bottom of
>> preprare_shallow_update() makes it clear that, if we wanted to use
>> hooks, we cannot avoid having the proposed new shallow-file in a
>> temporary file, which is unfortunate.  Do we have a similar issue on
>> hooks on the upload-pack side?
>
> No. I don't think we have hooks on upload-pack.

The question was not only about "do we happen to work OK with the
current code?" but about "are we closing the door for the future?"

If we ever need to add hooks to upload-pack, with the updated
approach, its operation will not be affected by the temporary
shallow file tailored for this specific customer.  Which I think is
a good thing in general.

But at the same time, it means that its operation cannot be
customized for the specific customer, taking into account what they
lack (which can be gleaned by looking at the temporary shallow
information).  I do think that it is not a big downside, but that is
merely my knee-jerk reaction.

>> Nothing for Documentation/ anywhere?
>
> Heh git-pack-objects.txt never described stdin format. At least I
> searched for --not in it and found none. So I gladly accepted the
> situation and skipped doc update :D

To pile new technical debt on top of existing ones is to make things
worse, which we would rather not to see.
