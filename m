From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge-friendly text-based data storage
Date: Tue, 27 Mar 2012 08:21:33 -0700
Message-ID: <7vzkb2jchu.fsf@alter.siamese.dyndns.org>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
 <4F718496.4030808@ira.uka.de>
 <CAD77+gR=p+jhN5qNoRgjtQPHqgqrdtcSmqAy_4d0NUaqE6ZkVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:22:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCYDn-0003hd-1k
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 17:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab2C0PV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 11:21:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab2C0PVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 11:21:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC1B5C5D;
	Tue, 27 Mar 2012 11:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHWK5LlEgQP3+ovh2WgXhJqsHdY=; b=MqYhDI
	G5TH4HttWA5MvmqDSiZiRIdKcMsuyMljYI1SIRrJDIQUgmFfCbhIaMSoZHCmuGvt
	piMGmA1FaexDIpxjVmV0bdag5RGkOnwo0yBMxnclP08cPU/C5IR79Rtv0cQWdXzL
	9jNgAL5S0psBl76DCQH61Ic3OjRtKs/GgRSQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oj8buJ1OWC7P25DFrGJWc/Bg0A26QpRa
	Po0QaYPu0vuB5iazFtPfnapv/Cv2h84P7Spj+U4A+OZtGscH2Tw1eo5UehoZ7FSP
	mreIjK3lg18hvA9WvvyyDePTD85WPXrErdKmav2NUOpIe/su8iG90vhjATIQCpCZ
	IPlUSvhQ3Io=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3530B5C5C;
	Tue, 27 Mar 2012 11:21:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91A125C5B; Tue, 27 Mar 2012
 11:21:34 -0400 (EDT)
In-Reply-To: <CAD77+gR=p+jhN5qNoRgjtQPHqgqrdtcSmqAy_4d0NUaqE6ZkVg@mail.gmail.com> (Richard
 Hartmann's message of "Tue, 27 Mar 2012 15:01:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89EC4B72-7820-11E1-AC44-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194050>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> On Tue, Mar 27, 2012 at 11:12, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
>
>> I may be misunderstanding something, but lets assume you want to merge a
>> file that has "version: 0" with one that has "version: 1" and their last
>> common ancestor would have "version: 0" naturally. So the merge would not
>> fail even though the file layout changes.
>
> Ugh, I did not consider that. I can't come up with a way, other than a
> custom merge driver, to prevent this. Am I correct?

You are the only judge to that statement: "I can't come up with...".

I can't either, but I know a custom ll-merge driver would work.  It is
designed for this kind of thing.  It will know both version 0 and version
1 format, read from each and writes out the merged result in whatever
format it wants to use.

>> the only way
>> would be to store each data line in its own file. As you store file paths
>> that would even fit, but I doubt it is what you had in mind
>
> I considered this as well, but that's extremely expensive and wasteful.

And it does not solve anything.  The "version" file may cleanly merge to a
new version, and there is no way for the merge result of "version" file to
affect the outcome of merges in other files.
