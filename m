From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please consider extending .gitignore to support setting of a file size limit
Date: Thu, 07 May 2015 14:31:12 -0700
Message-ID: <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Roger Mendes <sproger1@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 23:31:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqTO4-0002C1-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 23:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbEGVbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 17:31:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbbEGVbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 17:31:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F10050FA7;
	Thu,  7 May 2015 17:31:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aj4g89/sFKn11EmarhFyt+ZF338=; b=Py1Hjv
	wGqKLnn2yp07DKp9VvtRQ6WIbxjklCJHg0iYB0aKv8IFeV4vroqGuRD8XBBdAP7/
	u2g3W03eVZ1mkMmagtE/VRZtXYc7suG861PF/2H7O9W9xb5bzvPXia7/6ewAsrj+
	oYQ4XwMsI0yf1+NLM7QECDS9t3bYfvMP2so38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CurN05KmJ3ethFx5G9bQpzqRPKQgI9Vb
	tOHhYFaAbF0Jh6S45QHhU3K54gAc8rZ0oTG5QWRdNzfqOSScU2XGfpu3e0hqqU6J
	vslET/9Q2eHXS5XwSf6q/FUf7TGvuqL/AuANkd9B7NDVs2beZnYhSV2hpQ4VREXx
	9pxX4joTTd4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5875350FA6;
	Thu,  7 May 2015 17:31:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CECE450FA4;
	Thu,  7 May 2015 17:31:13 -0400 (EDT)
In-Reply-To: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
	(Roger Mendes's message of "Thu, 7 May 2015 17:14:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 630D6968-F500-11E4-A5FC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268591>

Roger Mendes <sproger1@gmail.com> writes:

> Allow .gitignore to support setting a file size limit so that all
> files over a certain size will by automatically ignored when
> performing git add, commit -a...;

No.

I would not say that it would not make sense to have a method to
tell your Git to reject an attempt to add certain files to the
index, but .gitignore is make that decision based on paths and
is a bad place to do any other decision, so take the above "No"
as "No, we do not consider butchering .gitignore for that", not
as "No, you shouldn't base your decision on file size".

Also, once the path is tracked, then "git add" will keep tracking it
unless and until you "git rm --cached" it.  So you may "git add" a
1kB file, grow the file to 500MB and then the next "git add" should
register the updated contents to the index.  Whatever you do when
designing that new feature, you should need to take that into
account.

Having said all that, why is it that you do not want to track
certain files that happen to be large?  Don't the existing large
file support facility work for you (or perhaps you are not using
them)?  It might be that your time is better spent on improving
that, instead of working around the issue, no?
