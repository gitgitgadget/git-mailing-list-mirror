From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Diff filename has trailing tab if filename contains space
Date: Fri, 04 Mar 2016 16:32:00 -0800
Message-ID: <xmqqa8mdydbz.fsf@gitster.mtv.corp.google.com>
References: <CAHtLG6TLAOA0hg897EntOjG1kJsZEmjDshc-yyO9zP27540AAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 01:32:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac08g-0008Q6-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 01:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759066AbcCEAcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 19:32:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755567AbcCEAcD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 19:32:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 851FD49582;
	Fri,  4 Mar 2016 19:32:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ETBeTdYFfe5M
	cnSvRj44depALew=; b=oF3OqWgL/ZlHd0ZpnVNGQ41lM4lpy5Lit5wzX+E5LN0E
	N9LgiVk195vuTmv/TtX3ohlNg1UvAYtCeLQtB6j40fspjfb2yBeCqd569FLWGvl3
	K3x56oXI7v9fozMZaCNi37LaqBIXVcS5vsniiybmQl3oLUU5fSpzEik7onWneAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=StuIim
	yyJrScKS6I7VV5eoHlspzNaJHaTOofzrgripdw3yiLLucR4lrBxOnUuX6S3Q92t/
	H2WAx7ResMrjJ/7Pcwr3/MjepsExwOAfWXkzuPe+E53ThqzQdGzIpyKZue8yvQKc
	P2W9Ew6A+Hsv9SmyoCvEQFEZ3TjJiHdlfqkQU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7750A49581;
	Fri,  4 Mar 2016 19:32:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDF124957F;
	Fri,  4 Mar 2016 19:32:01 -0500 (EST)
In-Reply-To: <CAHtLG6TLAOA0hg897EntOjG1kJsZEmjDshc-yyO9zP27540AAg@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sat, 5 Mar 2016 07:50:32
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADAE3900-E269-11E5-BFA2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288283>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> Hi,
>
> Using git 2.7.1
>
> Diff filename has trailing tab if filename contains space

Thanks; that is very much deliberate and has been with us forever.

commit 1a9eb3b9d50367bee8fe85022684d812816fe531
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri Sep 22 16:17:58 2006 -0700

    git-diff/git-apply: make diff output a bit friendlier to GNU patch =
(part 2)
   =20
    Somebody was wondering on #git channel why a git generated diff
    does not apply with GNU patch when the filename contains a SP.
    It is because GNU patch expects to find TAB (and trailing timestamp=
)
    on ---/+++ (old_name and new_name) lines after the filenames.
   =20
    The "diff --git" output format was carefully designed to be
    compatible with GNU patch where it can, but whitespace
    characters were always a pain.
   =20
    This adds an extra TAB (but not trailing timestamp) to old_name
    and new_name lines of git-diff output when the filename has a SP
    in it.  An earlier patch updated git-apply to prepare for this.
   =20
    Signed-off-by: Junio C Hamano <junkio@cox.net>
