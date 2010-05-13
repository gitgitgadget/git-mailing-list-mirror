From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Wed, 12 May 2010 17:06:52 -0700
Message-ID: <AANLkTilfXLdYCIZAu_I5vGTrbI08fbqUpIsjx5yP1q47@mail.gmail.com>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 02:07:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCLx9-0005Ai-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 02:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab0EMAGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 20:06:55 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:41405 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0EMAGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 20:06:54 -0400
Received: by qyk13 with SMTP id 13so782911qyk.1
        for <git@vger.kernel.org>; Wed, 12 May 2010 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iJHlxvWmT253TdeU+rZj9UI23+NT4t3HYZYrxcAXtgk=;
        b=YKsGvQiO+qe9lB0COkHHs4WUwSqvg/Z736SxRWXLejYI5lvF0u/KsH7VtSYN5701A3
         EcuOoA4vKbfIbDvKjfLUJSpzFRVWHRbCCkvfAnMWDu8amVuX2qxr0DfjmzK0jHqlEzS3
         M+h4IykS5MLkaVQXzm1PnByZMpFPqqLmhyGPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ldYyaEagNqtEAEGAfiWTAJUXSyLAxXME0ZPyPd7lE8dWCC6N58UXhe2z7c8KieRdcp
         lyIShNuVQPcY/8vWz0rqHUh7tfdAEqgYgOzUL4ObxuW23ZZpHfdVaj82csbrTlBybbdT
         59X3xbr57ErSD8tfeHZzou6k/huuVcG7Hpydo=
Received: by 10.229.235.204 with SMTP id kh12mr858980qcb.191.1273709212415; 
	Wed, 12 May 2010 17:06:52 -0700 (PDT)
Received: by 10.229.2.26 with HTTP; Wed, 12 May 2010 17:06:52 -0700 (PDT)
In-Reply-To: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146969>

On Wed, May 12, 2010 at 12:45 PM, Robert Buck <buck.robert.j@gmail.com>=
 wrote:
> Today, just after someone else committed to my public repository I
> started getting errors. Until then Git worked great.
>
> Does anyone know what is going on here? Are there particular versions
> of Git with known issues around this?
>
>
> uname@hostname:~/dev/workspaces/scm-evaluations/welcome.git/install/g=
it-config$
> git push
> Counting objects: 7, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (4/4), done.
> Writing objects: 100% (4/4), 922 bytes, done.
> Total 4 (delta 0), reused 4 (delta 0)
> error: unable to create temporary sha1 filename ./objects/e6: File
> exists
>
> fatal: failed to write object
> error: unpack failed: unpacker exited with error code
> To ssh://git.projectbedrock.com/var/cache/git/welcome.git
> =C2=A0! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to
> 'ssh://git.projectbedrock.com/var/cache/git/welcome.git'

This is probably a permissions problem on the server. We use git over
ssh at $dayjob and we need to make sure everyone who pushes to a
repository on the server is a member of the same group and that the
repositories are created with "git init --shared" otherwise we run
into problems like this. Its not too much of an issue for us because
we have a maintainer model and the maintainers generally have the
right permissions and don't change frequently.

I think the "shared" part is probably the problem in this case because
you can both obviously create files on the server. Rhe problem appears
to be when one of you needs to update a file (or directory) the other
created.

To fix your current problem you'll just need to ssh into that server
and find the  welcome.git/objects directory and check the permissions
on the "e6" directory and its contents. You will keep running into
this problem until the permissions/sharing is sorted. Theres probably
a config variable which dictates the permissions to use when creating
objects on the server which is changed when you pass the "--shared"
option to "git init", but I'm not sure what its is (I see some man
pages in your future).

> As an aside, where the heck is the git bug tracker? I've searched, an=
d
> searched, and ... All I found is a Debian tracking system, which
> appears to have no full text search capabilities.

You're looking at it bugs, patches, questions all go to this mailing
list. The archive on gmane[1] is conveniently search-able.

[1] http://news.gmane.org/gmane.comp.version-control.git
