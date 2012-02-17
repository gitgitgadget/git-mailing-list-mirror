From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch
 in "heads" view
Date: Fri, 17 Feb 2012 06:28:18 -0800
Message-ID: <7vipj5v8jh.fsf@alter.siamese.dyndns.org>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
 <201202162341.09712.jnareb@gmail.com>
 <7vsjiawe74.fsf@alter.siamese.dyndns.org>
 <201202171441.35618.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rajesh boyapati <boyapatisrajesh@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 15:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyOnb-0000Ys-DO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 15:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab2BQO2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 09:28:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704Ab2BQO2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 09:28:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 532ED5095;
	Fri, 17 Feb 2012 09:28:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rsuh0hnHtgrXAa/j99lvqF+nbyg=; b=xAiwp0
	KwA1eB5zbCX1w3Z5N51qSBLfp6ZL0tJM88W78cmJvVSAaEo8YxcTWVRjiaLDflZZ
	7dx+6BDR2JaWzFsQrYIHHE06nBfE5OW+HSUTKFy0XwYckpaP4BLDQfmA0jV8hBc3
	kXwv4+LQs2ktrU4KiEWns79KcuzkYaA4NbBFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fC1J9aSJTE33fuWaC6muv7hY0l/0GPq2
	BqTaC/6vtghu+zMD74rjnhkMiSVrRtjvjAOaIhm7ccR5VTh1oq1bV61f3cGZelP2
	KEiq/HFvNDZhRd+hDRxcIM2TBLkowa4yEGSHirvBledWFAzxqfSJdn+GDoivXayi
	L9Cm/2oMr+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB4A5094;
	Fri, 17 Feb 2012 09:28:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA02F5093; Fri, 17 Feb 2012
 09:28:20 -0500 (EST)
In-Reply-To: <201202171441.35618.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 17 Feb 2012 14:41:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A43779B4-5973-11E1-A066-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190959>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 17 Feb 2012, Junio C Hamano wrote:
>  
>> But after trying to write a reroll myself, I have to wonder what would
>> happen if you have two branches pointing at the same commit as the one at
>> HEAD.  Why isn't the use of current_head class controlled by comparison
>> between the name of the ref and the output from "symbolic-ref HEAD"?
>
> If there is more than one branch that points to HEAD commit, they all
> will be highlighted.
>
> Using "git symbolic-ref HEAD", or just reading '.git/HEAD' file or symlink
> is on my todo list.  This will make gitweb highlight current branch
> correctly even if there is more than one branch that point to the same
> HEAD commit, and make it possible to support "detached HEAD" (which I think
> is not supported at all now).

You should be more honest and admit that showing unrelated branches that
happen to point at the same commit as the current HEAD does (this includes
the case where HEAD is detached) as if they are *ALL* current branch is
*NEITER* working *CORRECTLY* nor *SUPPORT*ing "detached HEAD" at all.  It
may not be giving a runtime error, but instead it is showing AN INCORRECT
RESULT.

I'd grant you that this is not a new problem this patch introduces, and it
may not even be a bug you introduced long time ago.  The patch gives the
same INCORRECT RESULT as it intended to do before the patch, and removes
one runtime error, so it is not worsening the situation, but that does not
change the fact that the code after the patch is still *WRONG*.
