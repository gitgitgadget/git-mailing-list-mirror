From: Chris Packham <judge.packham@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 09:29:54 -0700
Message-ID: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl Stenerud <kstenerud@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 18:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHDc-0004Qk-U9
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031Ab0F1Q34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 12:29:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59675 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0F1Q3z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 12:29:55 -0400
Received: by gxk23 with SMTP id 23so172525gxk.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xeCoXHMBtptuBj7L6KnxTjizK4mD0iYmL4xu3ZTykkY=;
        b=nk+KZbMpjB36lW4q1bU9ZRgr7OM5VGzlWOIZ0PWbBXqZAbbAbeBjG8MtrfFi3oqf2O
         EWYESeclI1XZVvmQ1cvdnDNEa6ZLxoE+w5SUmbxNydhpOZP3uKx7j/5VOEiC2VsEPPLx
         BcaeloLqwcwRuDCd7HaSeehyue4NcHlW7aBX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KBoKSHKu8MW73caVw7eZ2fRqjvho8USxESKFASoBHIgwqmF01EylIdauRKHkGBhnPB
         hUyfzMFyTqVWj9gZNjISoY0raBzfOWTfNVeL5flhCULk8i7VBmwmYj+Ws/9KIVbiVERk
         kEiJdiStq0rfWOcZclXxkrJhAFHsWjfmhRtXY=
Received: by 10.229.238.72 with SMTP id kr8mr2877522qcb.76.1277742594520; Mon, 
	28 Jun 2010 09:29:54 -0700 (PDT)
Received: by 10.229.224.194 with HTTP; Mon, 28 Jun 2010 09:29:54 -0700 (PDT)
In-Reply-To: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149837>

On Mon, Jun 28, 2010 at 9:10 AM, Karl Stenerud <kstenerud@gmail.com> wr=
ote:
> Hi,
>
> As I did a git pull on my project today, git went into some kind of a=
uto gc mode:
>
> Auto packing the repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 4531, done.
>
> This is, of course, quite an annoying feature since it could hit at a=
ny (inconvenient) time.
>
> The git help tells me I can disable it by setting gc.auto to 0, while=
 the mailing list archive tells me I also have to set gc.autopacklimit =
to 0. =C2=A0This is fine, but if I do that, I won't know when the repo =
is in need of cleanup. =C2=A0Is there any option I can set to instruct =
it to simply TELL me when it's in need of gc?
>

I don't think there is an existing configuration for this but I think
you can achieve what you want with the "pre-auto-gc" hook. From the
githooks(5) man page

  pre-auto-gc
     This hook is invoked by git gc --auto. It takes no parameter, and
     exiting with non-zero status from this script causes the git gc --=
auto
     to abort.

So a hook like

  #! /bin/sh
  echo "repository needs git gc"
  exit 1

Should cause the auto gc to be skipped.
