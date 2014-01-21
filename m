From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Verifiable git archives?
Date: Tue, 21 Jan 2014 11:38:35 -0800
Message-ID: <xmqqiotdunus.fsf@gitster.dls.corp.google.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
	<xmqqsiswapav.fsf@gitster.dls.corp.google.com>
	<52DB1DB4.7080806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Lutomirski <luto@amacapital.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:38:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5h9p-0003qw-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbaAUTil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:38:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbaAUTik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:38:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B760364B83;
	Tue, 21 Jan 2014 14:38:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O5JMZ5M1scD5yuisZBz8GxD3NdY=; b=kXOXPC
	n9fhN+jZwPkLtdN8yxSj64v2ugzQbI5rH6R5mtG6ByPT8/TUVO/zBP/VTsZ8sqku
	+l4Chr3XbUpxN9RppSQlfwzRwh/c/drgj4Tk9J8fBJ1w9pX15TQShr4SJjsHIqD2
	hLs+PeP6YwLvMOWdW1+FzbhTdV20sKt7Fs5Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qoE5dh9BYIKAoa7Vl7hKyPIIpVobiBtz
	71kVkQZvDsy5hduF7x+KKJWHKuU5kGql6cONkxCG0YwoVm+yHYIe0ezYYai7tez2
	y2lCUptv5ZnRjHUQtZgpIrh3rDAF39QmEBCXu4B/hFyPjmYECL9K+xVtT6sxdfA8
	ML0mpxUa1r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C7564B7E;
	Tue, 21 Jan 2014 14:38:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5695864B7D;
	Tue, 21 Jan 2014 14:38:38 -0500 (EST)
In-Reply-To: <52DB1DB4.7080806@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 19 Jan 2014 01:35:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FE64B20-82D3-11E3-A02F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240767>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/09/2014 09:11 PM, Junio C Hamano wrote:
>> Andy Lutomirski <luto@amacapital.net> writes:
>> 
>>> It's possible, in principle, to shove enough metadata into the output
>>> of 'git archive' to allow anyone to verify (without cloning the repo)
>>> to verify that the archive is a correct copy of a given commit.  Would
>>> this be considered a useful feature?
>>>
>>> Presumably there would be a 'git untar' command that would report
>>> failure if it fails to verify the archive contents.
>>>
>>> This could be as simple as including copies of the commit object and
>>> all relevant tree objects and checking all of the hashes when
>>> untarring.
>> 
>> You only need the object name of the top-level tree.  After "untar"
>> the archive into an empty directory, make it a new repository and
>> "git add . && git write-tree"---the result should match the
>> top-level tree the archive was supposed to contain.
>> [...]
>
> This wouldn't work if any files were excluded from the archive using
> gitattribute "export-ignore" (or "export-subst", which you already
> mentioned in a follow-up email).

Correct.  By "and such" below, I meant any and all futzing that
makes the resulting working tree different from the tree object
being archived ;-)  That includes the line-ending configuration
and other things as well.

    Also, if you used keyword substitution and such when creating an
    archive, then the filesystem entities resulting from expanding
    it would not match the original.
