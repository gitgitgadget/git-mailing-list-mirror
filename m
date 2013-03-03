From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 03 Mar 2013 14:49:12 -0800
Message-ID: <7vppzg9k0n.fsf@alter.siamese.dyndns.org>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch> <20130303102946.GH7738@serenity.lan>
 <7vk3pob38d.fsf@alter.siamese.dyndns.org>
 <20130303214206.GL7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 03 23:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCHiv-0007lN-Mk
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 23:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab3CCWtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 17:49:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab3CCWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 17:49:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5E0BABD;
	Sun,  3 Mar 2013 17:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMZRaQO+NtG12hNn3cD7Chqlb2s=; b=YxXyZ2
	b50xLLg5W+1QVcjK3EUt7qyo6wZGilwsPQVLdTffNdYIe94whmTexF0AB4bim3Xg
	h8bnYAuLpNfl3HRDEZOSof5zgNjFMWilZnA8H6miqV3sXgdylGW7OdorYa061SHq
	ucs2Ee/xvUWVpl52SWGQC3cZxQNRhkYKKfNPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVhHaMefFK4+0PHuDeYIAIMCtAJzb/4f
	Tu+TIh9rwrk87xEQJaLnPQPFbk2I7Q7OYcfD6j4D5M7hqY2iwQTVIPvBSFoFo5Kd
	cNwuttRy/56s6g8Zo7W0OANgWuZtOIQrHfFhY7v3BceQ5MpGr7Ifpw9qYOweTP9L
	CdokxEbAUSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90AF2BABC;
	Sun,  3 Mar 2013 17:49:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E110DBABB; Sun,  3 Mar 2013
 17:49:13 -0500 (EST)
In-Reply-To: <20130303214206.GL7738@serenity.lan> (John Keeping's message of
 "Sun, 3 Mar 2013 21:42:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 923086E0-8454-11E2-9E3B-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217365>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Mar 03, 2013 at 01:08:50PM -0800, Junio C Hamano wrote:
>> >> > Additionally, it seems that Johan added graph_set_column_colors
>> >> > specifically so that CGit should use it - there's no value to having
>> >> > that as a method just for its use in graph.c and he was the author of
>> >> > CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).
>> >> 
>> >> Perhaps you could add a comment in the source to prevent this from
>> >> happening again?
>> > ...
>> > I would hope that having this message in the history should be enough to
>> > prevent this changing in the future....
>> 
>> Given how it happened in the first place, I do not think anything
>> short of in-code comment would have helped.  There wouldn't be any
>> hint to look into the history without one.
>
> So you'd accept a patch doing that?

The answer obviously depends on the specifics of "that" ;-) I was
merely agreeing with what Thomas said.  A straight-revert would be
insufficient to prevent this from recurring again.

> Something like this perhaps:
>
>     NOTE: Although these functions aren't used in Git outside graph.c,
>     they are used by CGit.

It would be a good place to start, although I prefer to see it
completed with s/used by CGit/& in order to do such and such/ by
somebody working on CGit.

Also it probably is worth adding contact information for folks who
work on CGit (http://hjemli.net/git/cgit/ might be sufficient), as
changing these functions (e.g. changing the function signature) will
affect them; making them "static" is not the only way to hurt them.

Thanks.
