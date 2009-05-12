From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 12:54:20 +0200
Message-ID: <81b0412b0905120354p6e1bf517y154601132f0901a3@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <81b0412b0905112351l126a7c5bh902a7c7748d9a77a@mail.gmail.com>
	 <200905121103.00432.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Tue May 12 12:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3pd1-0000oD-7G
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 12:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbZELKyX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756564AbZELKyW
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 06:54:22 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42520 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352AbZELKyV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 06:54:21 -0400
Received: by fxm2 with SMTP id 2so3239540fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4H1c8RUnk8eMasPxddMHIAzIVZ66j7nlKq8j3P+EdCY=;
        b=fRQ3Yy4qwm1hBpD8b6kJh2lXaIjANs7FpDaHqYLi7HHzXIBFJ8WI/3qdHrOFIPeBhe
         oPUkUyXsQkB3H0kcbrrxK29oM3dM5kxpdSIBezmArFNQ6UCJdtII2H6n/ceS1dux7bAw
         Ip7vtn80wkzOaphmDZalyGgkUK21Z8B9SwZbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HscK4fffP6Ta+mqJP+wdYFsvpaC7JdnpCLQzvpPHlGTF/eBLq/V8ZR2Rl0vLj8tjIJ
         LUJsWsXu2CNgiUFSQSoxrIfy4Zb0WWjC9nuxl5xRL+G7qq7afXYG1o9aSeQYFFdAtUHV
         fAIb6ysOS4v6PsKxeyLzpDj8sWJhzTbSqfm7A=
Received: by 10.204.119.71 with SMTP id y7mr7964877bkq.16.1242125660971; Tue, 
	12 May 2009 03:54:20 -0700 (PDT)
In-Reply-To: <200905121103.00432.Hugo.Mildenberger@namir.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118887>

2009/5/12 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
>> 2009/5/11 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
>> > While this was almost entirely my fault, git could possibly apply =
a
>> > filter, reject such a name or at least issue a warning.
>>
>> Maybe. Or maybe it can just work (well, assuming the user meant to
>> use an url with character you considered "control").
>
> I said it actually did not work well, independent from how anyone pre=
fers to
> classify characters. My platform is Gentoo-hardened with unicode supp=
ort and
> an ext3 disk format . =C2=A0With "trunk directory" =C2=A0I meant the =
top level
> directory which is created when you run git clone on a remote url -- =
sorry
> for still not being a native git speaker. I don't have the original s=
etup
> anymore. My _working_ ".git/config" is now:

Ok, let's assume you picked up '\r\n' from that web page

> The remote url did contain something like "^J\n" at the end, as did t=
he top
> level (the much derided "trunk") directory name on disk. I probably g=
ot there
> by puting the copied url within quotes on the command line, but today=
 I'm
> unsure exactly how I arrived there. However, old fashioned as I am, I=
 still
> consider e.g. a linefeed to be a "control character", and inspite of =
your
> flashing git punditry I still consider this to be an issue.

Git tries not to enforce any specific rules where the program itself do=
es
not need them. One can easily imagine an automatic system which
generates names of repositories from something like binary data
(something like BigTable comes to mind) and the less rules the
underlying levels impose on it, the simplier the upper levels will be.

OTOH, a warning about commonly used delimiters not fitting a name
context, maybe a good idea. Like "\r\n\t", backslash (came up recently
on this list). Such a check and associated warning may be useful for
repository names and branches.

Still, it's more of a policy issue and I would make it optional, even
if enabled by default. Maybe even by defining a regexp which the
repo name or branch name must (for hard error) or should (for a warning=
)
match.

=46or your specific case, you can take a look at builtin-clone.c,
just after the line containing "guess_dir_name(repo_name"...
