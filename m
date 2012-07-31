From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-receive hooks based on push content
Date: Tue, 31 Jul 2012 12:07:34 -0700
Message-ID: <7vsjc7iwax.fsf@alter.siamese.dyndns.org>
References: <CAC=i8BzHi6UF=GEAiEdUzcjQM3NjibPw=p5S2uOeaE31nDkkjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jessica Lucci <jessicalucci14@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:08:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwHnd-0006Cm-MO
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab2GaTHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:07:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab2GaTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:07:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A9C86B3;
	Tue, 31 Jul 2012 15:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5WxUwFesvxJIYkgVLgLivAAoFgY=; b=u+r2+U
	rFi4vRqtfovGoQkqh5gsnNI9IlMLfc51cQJRZn3jqzWedTdARoi++8+a+sESR2A1
	K4TB2WGeMJR2DyijTXZLw8pHXg8QYQkgLJgs5wYj1t1OSsuZRln+kA8bQWo+21vD
	Mml8zFyEw+d3TbHqEu4Yk4HyOsRZY8SyLP9XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mpwr9vSzluqRcfO0+oBjCZtDdPzQ0/zk
	yMatChnSds+x7S1CWMArv3FB0vjlzlaUpu5nFAjTyv0GAo3EaPwsZ+lyWu9gueMH
	Epyv0xzcjqOdkqFy9I0YZTWieeujawJes8l19DVme/3Rw5yO+JbJp3itU9Iy/2Hz
	q0dx1iA76Pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D414E86B2;
	Tue, 31 Jul 2012 15:07:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 385F486B1; Tue, 31 Jul 2012
 15:07:36 -0400 (EDT)
In-Reply-To: <CAC=i8BzHi6UF=GEAiEdUzcjQM3NjibPw=p5S2uOeaE31nDkkjA@mail.gmail.com> (Jessica
 Lucci's message of "Tue, 31 Jul 2012 13:27:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD5570B8-DB42-11E1-B9A5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202671>

Jessica Lucci <jessicalucci14@gmail.com> writes:

> Hey guys,
>
> I'm trying to set up a post-receive hook that redirects code based on
> the content of the actual push. Specifically, I'm trying to set up
> automatic deployment of web apps with the option of sending the code
> to a build farm first. For example, if you push your code to a git
> repo, there should be a post-receive hook in there that looks to see
> if /www is empty or something. If /www is empty, the app has yet to be
> "built", so the hook should push the code to a build farm that can
> compile the code into a WAR file (or whatever is appropriate). If /www
> is already populated, we assume the code has already been compiled and
> will then push the code directly onto the node.
>
> So, first of all, is this even possible?

Should be.

> And if so, how would I go about writing this specific hook?

By writing the necessary pieces and then stringing them together?

 - How do you see /www is empty?  That is one piece.  It is outside
   of the scope of "git", but it perhaps involves looking at the
   output of "ls /www" or something.

 - How do you know if the app "has yet to be built"?  That is
   another piece and depends on how your build infrasture is set
   up.  It is outside of the scope of "git".

 - How do you push the code to a build farm?  You would be using
   "git push $there $what", and presumably you know where $there is
   (the repository your build farm reads from).  $what is given as
   the input for post-receive hook, or you can read the tip of the
   ref you care about yourself, as your hook will run in the
   receiving repository of the push.

 - How do you push the code to a node?  That would be left as an
   exercise to the reader ;-), but would be similar to how you push
   to your build farm, I would imagine.
