From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Tue, 15 Jan 2013 00:12:46 -0800
Message-ID: <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
References: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
 <1119893992.2134035.1358233781666.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1du-0007D9-HO
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab3AOIMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:12:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab3AOIMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 03:12:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E503F9B40;
	Tue, 15 Jan 2013 03:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pep0Fr2KUIcVT3ZE5A8OpH+DmyU=; b=TAJqvE
	5YJuNV+00s0ins+7xncA8ruN9rfro+XIfTSxUFGUEVntaP3ZO0uFmLlSXae8RKhK
	IqE17fmJNoxnx9Qe8wnGQ0njB06c9U7KM8bYKsAS0JZctAhzBoS97nu2jDfYXcSH
	Y9B6VYMY3YtrBEwPZG04DtGncedOxBi7I1PDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH/ahdv8QxSTugSorxtpyc7NcwuCoSKN
	LebPh3osP55j+6F9shyGltBX3/r+vNK8uReP+DEHw3gojVEgVT8a3NLWI4eEUWHK
	gGP/SjUDtKJFvWsK2MbKhJcTMbzmRbfIAM0JQG0znzBNIjPZAeI6MUyE3I4XdTcx
	QPNqoQW/lyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D75659B3F;
	Tue, 15 Jan 2013 03:12:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D9C9B3E; Tue, 15 Jan 2013
 03:12:48 -0500 (EST)
In-Reply-To: <1119893992.2134035.1358233781666.JavaMail.root@dewire.com>
 (Robin Rosenberg's message of "Tue, 15 Jan 2013 08:09:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 594A30B2-5EEB-11E2-B9E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213614>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> I'd say a simplistic "ignore if zero is stored" or even "ignore this
>> as one of the systems that shares this file writes crap in it" may
>> be sufficient, and if this is a jGit specific issue, it might even
>> make sense to introduce a single configuration variable with string
>> "jgit" somewhere in its name and bypass the stat field comparison
>> for known-problematic fields, instead of having the user know and
>> list what stat fields need special attention.
>
> My first patch was something like that, just not using the word jgit. As
> for what fields to ignore, it's something that can be configured by EGit
> and documented on the EGit/JGit wiki. 

That configurability is a slipperly slope to drag us into giving users
more complexity that does not help them very much, I suspect.

Earlier somebody mentioned "size and mtime is often enough", so I
think a single option core.looseStatInfo (substitute "loose" with
short, minimum or whatever adjective that is more appropriate---I am
not good at picking phrases, it sounds to me a way to more loosely
define stat info cleanliness than we usually do) that makes us
ignore all fields (regardless of their zero-ness) other than those
two fields might not be a bad way to go.

I do not offhand know if such a loose mode is too simple and make it
excessively risky, though.
