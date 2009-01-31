From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Don't try to reclose in command_close_bidi_pipe
Date: Sat, 31 Jan 2009 08:03:21 +0800
Message-ID: <be6fef0d0901301603m452b1579q509bdc997ecad7c4@mail.gmail.com>
References: <1233291570-23295-1-git-send-email-nothingmuch@woobling.org>
	 <be6fef0d0901300635v4e6009f1n7da405ebc4c8dd68@mail.gmail.com>
	 <a891e1bd0901300706h4fdffe24m78c418f8c1ae7cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT3Ls-0004bi-Pl
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZAaADX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZAaADX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:03:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:9859 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZAaADW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:03:22 -0500
Received: by wa-out-1112.google.com with SMTP id v33so331679wah.21
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lEyYNuB5L9jMLZeW6qAvPBbvjqlvnUNepg2QNTI1Vgc=;
        b=yF9poSbxoYyQtqXQlqFORZYB/QzUuDh1baFf/8H0phuAC2KuwazWkGNuO6D+0gO1eY
         EhuU0V9yROA4zGfvJOkgpeGfy2KMpUHLAWzEDc6bRIggJcMoV0XWqd3bRezjcRjQSn8E
         4lERCRgzoSQm9CWY5D7KdaYiY75n+aueednZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ier7FL51fY2W/R3ypf/G1pVorT7DUFkRXhVJz6enAj+UdjdEIMw/+VLYrQPpXppi8e
         gRv/Opmw+W6j0IOpbA7loKJdaJGzQ5pUt9BPUrkgnpmD9oWwt94+cO7AcCPQXdoq2hbM
         NwBWS+ojCHX6W2uvdfDWYoufeH7/iLaFfr06c=
Received: by 10.115.49.11 with SMTP id b11mr1138829wak.114.1233360201148; Fri, 
	30 Jan 2009 16:03:21 -0800 (PST)
In-Reply-To: <a891e1bd0901300706h4fdffe24m78c418f8c1ae7cd8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107889>

Hi,

On Fri, Jan 30, 2009 at 11:06 PM, Yuval Kogman <nothingmuch@woobling.org> wrote:
> Here is an example:
> http://github.com/yanick/git-cpan-patch/blob/ed67d3f86f371764935fd0da3e7f08536c95b606/git-cpan-import#L190
>
> Since git-commit-tree requires the message to be written before it can
> write the sha1 of the new commit object, the handle has to be closed
> already, which makes command_close_bidi_pipe die with an error.
> The workaround in the linked code reopens a fake handle so that
> close() will not error.
> For what it's worth, I've been poking at t/t9700/test.pl but since
> it's pretty sparse I figured I should contribute this fix
> independently.

Your usage seems to a very special case. You're closing the handle,
and then invoking the method "command_close_bidi_pipe", whose job is
to close the pipe handles passed to it (among other things). So, it
doesn't seem very good to make "command_close_bidi_pipe" to take into
account that you closed your handle independently.

Maybe you could write a pair of new functions for the commit-tree
command in the Git package, something like the
"_open_hash_and_insert_object_if_needed" and "hash_and_insert_object"
pair.

-- 
Cheers,
Ray Chuan
