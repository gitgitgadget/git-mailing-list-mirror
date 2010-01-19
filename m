From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 14:36:49 -0800
Message-ID: <7vd41590xq.fsf@alter.siamese.dyndns.org>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v3a21amh7.fsf@alter.siamese.dyndns.org> <20100119214400.GA24911@Knoppix>
 <201001192246.53453.trast@student.ethz.ch> <20100119221258.GA25210@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:37:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXMhD-0003Jq-Ie
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 23:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811Ab0ASWhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804Ab0ASWhE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 17:37:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0ASWhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 17:37:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2E6292E56;
	Tue, 19 Jan 2010 17:36:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BK9rndPdJG+5+zxJfpoXYhRN3hQ=; b=q/ymf4
	uw3evUxz8LzlsOu4VNT1tg0D9UKdluiM6uK6W3dvgzYPk3OpREpkTDwvi46xs5K/
	+j5yx1Y1Ooz7KYaQA2q3KYDP1CPQtpD5me5xsYngVxRSx+I2uwBw3DRFvVQPdLb9
	YqlWHkZCfBpO1uNVdVVZer9tg3NLKMgQaPg54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n8+qtLXSib0nRnH9o8EoEJUcr5lysY3V
	75f0oHEedugt16bTjTx3y69eZOHLxZZ73mYL6WTbhnU8AXAzQmkryQw+Y6BTI1PT
	Qg6Km+1uQJkLf82/22q0nhNajmXClCyWygvxTiP3erQZssXZfIpOUMJi+s6AqVwJ
	2wAxjkDlYjw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90ECE92E55;
	Tue, 19 Jan 2010 17:36:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0BA092E4E; Tue, 19 Jan
 2010 17:36:50 -0500 (EST)
In-Reply-To: <20100119221258.GA25210@Knoppix> (Ilari Liusvaara's message of
 "Wed\, 20 Jan 2010 00\:12\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24FC8474-054B-11DF-91B2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137499>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Tue, Jan 19, 2010 at 10:46:51PM +0100, Thomas Rast wrote:
>> Ilari Liusvaara wrote:
>> > 
>> > Eh, remind me what commands take refs and shell-glob them? The only
>> > 'globbing' of refs I'm aware of is in refspecs, and that definitely isn't
>> > shell globbing...
>> 
>> fetchspecs?
>
> Ah, found one: 'ls-remote'. Documentation of that doesn't say what format
> patterns are in... 
>
> Any others? 

What I gave you was "Please don't use regexp, because matching refs with
fnmatch() is the design guideline we follow".  It was not "please follow
the precedence of existing commands".  IOW, even if there was no command
that matched refs with globs, it is not an excuse to use regexp.  You
didn't even have to find any single example.  But here are some others, if
you are interested.

$ git grep fnmatch builtin-{for-each-ref,reflog,name-rev,show-branch,tag}.c

You find the design guideline to make refs behave as paths in a lot more
fundamental places, such as "if you have 'master' branch, you don't have
master/foo branch", and "you cannot use '?' in ref name because it is a
special character in globbing".
