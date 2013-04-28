From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git describe` in an export-subst format string?
Date: Sun, 28 Apr 2013 14:32:07 -0700
Message-ID: <7vobcypciw.fsf@alter.siamese.dyndns.org>
References: <CAFoDJR8RQExLwXcrViAJpWgvq+wBopY-Wq1keHxVqB3QwtAz4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Gallagher <johnkgallagher@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 23:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWZCq-0004fo-Bo
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 23:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab3D1VcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 17:32:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3D1VcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 17:32:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ACF41A3D8;
	Sun, 28 Apr 2013 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XuBUm85Es1U3YTWu7OKyBK+MBqU=; b=LnB/3v
	wb99R3wQVjdfXjEKbHzf3uxKh+uz86emQP1DdsE3KbhjnxaRC0m6+YqnUqw+janV
	3gM0jgRz9vysyaEgttfBJ0RQyOqaNFQbuSAVNEosJ5lq4YsdSrYHhIaixBnAEQX6
	B6c8xDNVgR79t0fsuGvnE99xeZZNpwThoFzfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OCgYx1/6C7nRKq9m1dN8Lm694jJQ42mI
	zVHf9oFu1ORp7iVWqZH2AKO2La+Z9hBF9ymnwmbMjWD3Lt6kTwHq9g+kkqvqHbkg
	LoSiGxUuR64mCAOMPYhvJ0igmj5azK4pg9cyCPl9cKYiADpBDa9qYmAIcmiPm1QW
	8aB2f1buNkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 418001A3D7;
	Sun, 28 Apr 2013 21:32:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD2521A3D6;
	Sun, 28 Apr 2013 21:32:08 +0000 (UTC)
In-Reply-To: <CAFoDJR8RQExLwXcrViAJpWgvq+wBopY-Wq1keHxVqB3QwtAz4A@mail.gmail.com>
	(John Gallagher's message of "Sun, 28 Apr 2013 14:02:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 147B41FE-B04B-11E2-A32E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222756>

John Gallagher <johnkgallagher@gmail.com> writes:

> The actual thing I want to do is
> something like this:
>
>   static const char *project_version = "$Format:...$";
>
> where "..." is something that `git archive` will replace with the
> output of `git describe`,...

You need to find an appropriate pair of placeholders that can
represent "git describe $it" and "git describe --contains $it".

I am tempted to suggest a more generalized way that is not limited
to describe at all, perhaps like this:

    $ git show --format='%x( git describe %H )'
    $ git show --format='%x( git describe --contains %H )'
