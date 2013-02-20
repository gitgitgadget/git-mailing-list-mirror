From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Tue, 19 Feb 2013 22:55:41 -0800
Message-ID: <7vmwuzzd76.fsf@alter.siamese.dyndns.org>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
 <508E0FAC.5050600@alum.mit.edu> <51246B31.6000605@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Feb 20 07:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83b8-0003hx-7T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 07:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab3BTGzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 01:55:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab3BTGzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 01:55:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 248758696;
	Wed, 20 Feb 2013 01:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUfWRLV9gSSMIPb8kkgWmqWb23U=; b=pNywjP
	WtOs/Bu9konCyzo/2ghd9jU10j4ERBb5ETX+J6EvRqNeaWLfZIOJck7+jXCu6wEq
	2cEz1cMDX4MEudzho8InS1kNHoGkgBUJOUQ/DaGnPapZA5McrzUNcq9ZAUPPY8M1
	ZyfIfvm7uZhXjEOe5PdclMhAeno9/allt8hEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Czde99uTTl23o+x5ppk0hxPlEzFPDtG1
	tXAyoauYw2uwpFhLUji4Hc8XBJHHtGR4daL20Ue7gRNTo7wQV9HipvHhjj+k90o/
	G9qIjPITTs8zqROX0pCrxmc1uS1Uz6wpPSzhKTQsMxH36L8vWRFTxSl4g7mpdsgl
	b6X09U0RLvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1730F8695;
	Wed, 20 Feb 2013 01:55:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 878208694; Wed, 20 Feb 2013
 01:55:43 -0500 (EST)
In-Reply-To: <51246B31.6000605@mit.edu> (Anders Kaseorg's message of "Wed, 20
 Feb 2013 01:20:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B9E7694-7B2A-11E2-9302-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216684>

Anders Kaseorg <andersk@MIT.EDU> writes:

> On 10/29/2012 01:10 AM, Michael Haggerty wrote:
>> How do you use GIT_CEILING_DIRECTORIES that the proposed changes cause a
>> slowdown?
>
> Sorry to bring up this old thread again, but I just realized why my
> computer has been acting so slow when I’m not connected to the
> network. I put various network filesystem paths in
> $GIT_CEILING_DIRECTORIES, such as /afs/athena.mit.edu/user/a/n/andersk
> (to avoid hitting its parents /afs/athena.mit.edu,
> /afs/athena.mit.edu/user/a, and /afs/athena.mit.edu/user/a/n which all
> live in different AFS volumes). Now when I’m not connected to the
> network, every invocation of Git, including the __git_ps1 in my shell
> prompt, waits for AFS to timeout.

Thanks for a report.

Assuming that this says "yes":

	D=/afs/athena.mit.edu/user/a/n/andersk/my/dir
        cd "$D"
        test "$(/bin/pwd)" = "$D" && echo yes

iow, AFS mounting does not have funny symbolic link issues that make
the logical and physical PWD to be different like some automounter
implementation used to have, perhaps we can introduce a way for the
user to say "The element of this CEILING list do not have any
alias due to funny symlinks" to solve this.  Perhaps existing of an
empty element in the list would do?  E.g.

	GIT_CEILING_DIRECTORIES=:/afs/athena.mit.edu/users/a/n/andesk

or something like that.  And in such a case, we do not run realpath
on the elements on the list before comparing them with what we get
from getcwd(3).

Of course, you could condionally unset the environment while
offline, but that feels like an ugly hack.
