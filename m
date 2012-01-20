From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] mergetool: Provide an empty file when needed
Date: Fri, 20 Jan 2012 10:28:25 -0800
Message-ID: <7vbopyfcty.fsf@alter.siamese.dyndns.org>
References: <7vy5t2g6za.fsf@alter.siamese.dyndns.org>
 <1327045655-3368-1-git-send-email-davvid@gmail.com>
 <CAJDDKr71Q9ihLZdP1Pu=ebpvX0EPvW-9bN6kZz9MeuhYKZzh+Q@mail.gmail.com>
 <CAM6z=4-HfRAjJjnYqfoiYsYjiZJSsbkCaW-VtLWvoeFM0xsB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jason Wenger <jcwenger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoJCV-0003TX-9X
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 19:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab2ATS22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 13:28:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2ATS21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 13:28:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3F76D60;
	Fri, 20 Jan 2012 13:28:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SRhqAMhEQ62i
	IvuBocfB6PLGRJU=; b=PgFGZOe5YMB2Vdp1eiLFJex4H93Lqjv8FEdgyS8a4WgZ
	VTEePcFfXCmPQj56SGK/qCtDyUo07NK/oRQL3U9mUucsfNCoQwGtF7Z8ZaR0aBmq
	YsJcmG8BCb39GrKedhtyYQ/dwA8ITDe8TT1ooSQ2dCyBQ5zcBGNui9m+SoP2QN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j/XB09
	PSfHWhqB6EvurAsRiObsMcx842wrgl5uH5q70YOMLou+krlK0jvnUOMDvEO4JG6w
	jYQH3I7gw7OXyXcXhVhdtoIPt4eqD/sCRQm7DNejhJfpDTUT9CDrn3SuhNnaVs0e
	WBO1qFohifIiW8dSoU9dPN/pAxcDWtysZU9ZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339936D5F;
	Fri, 20 Jan 2012 13:28:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87E726D5C; Fri, 20 Jan 2012
 13:28:26 -0500 (EST)
In-Reply-To: <CAM6z=4-HfRAjJjnYqfoiYsYjiZJSsbkCaW-VtLWvoeFM0xsB9g@mail.gmail.com> (Jason
 Wenger's message of "Fri, 20 Jan 2012 08:03:01 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B187770-4394-11E1-A254-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188892>

Jason Wenger <jcwenger@gmail.com> writes:

> On Fri, Jan 20, 2012 at 01:53, David Aguilar <davvid@gmail.com> wrote=
:
>> On Thu, Jan 19, 2012 at 11:47 PM, David Aguilar <davvid@gmail.com> w=
rote:
>>> Some merge tools cannot cope when $LOCAL, $BASE, or $REMOTE
>>> are missing. =C2=A0$BASE can be missing when two branches
>>> independently add the same filename. =C2=A0$LOCAL and $REMOTE
>>> can be missing when a delete/modify conflict occurs.
>>>
>>> Provide an empty file to make these tools happy.
>
> This is cleaner, yes -- but is this extra processing on $LOCAL and
> $REMOTE necessary?  Git mergetool doesn't actually call an external
> mergetool during del/mod conflicts -- instead it goes into an
> alternate processing and prompts the user interactively whether to
> take the deleted or modified file.  Can these changes be reached?
> (command line option I'm not aware of?)

Thanks for a careful reading. I did not read outside the context of the
patch so I didn't know if we had special cases for del/mod.

A bigger question is if the del/mod codepaths are negatively affected b=
y
the presense of these superfluous empty $LOCAL/$REMOTE files. If they a=
re,
this change will _break_ things. If they are not, I think the change wo=
uld
be OK.

Another small worry is that this could potentially negatively affect so=
me
merge tools that are sufficiently clueful, if it can give different and
better results for a true two-way-merge than a simulated two-way-merge
this patch feeds them by using a three-way-merge with an empty file as =
a
base.
