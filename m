From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 07:47:25 +1000
Message-ID: <BANLkTi=H3oU5SxwJJZ9ZYJBWy+VS2CvJ7w@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<20110427212943.GA2646@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Motiejus_Jak=C5=A1tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCa5-0007kf-N3
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760060Ab1D0Vr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 17:47:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64523 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab1D0Vr1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 17:47:27 -0400
Received: by ewy4 with SMTP id 4so649828ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2i5JZ6POO/7sTVkayTqPtGqBJ0Ezj9zWpYwWbJFIDHk=;
        b=vsH1jRHkpJCTudYFqPkZ+bVvj5MQtPpb5J0w2qXOdIFQRyop7dDkdeWG+zXsFYGiTa
         PpQeYnscV3rSUW4BWbM34vO0bSD+i8gIwdSyGsDoABwa78gpYt+x/H4yACPJd+OpxWL8
         p9qCks6WbZfXSBzAVNgo7YeuXD8cB7alYrvJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z/wb8vQ45QhwPBxt2Cx8dJAGI3q8u440J2DynNlPJ0Vp702FGEwSVlPl3FSO1bkkyx
         z7Yi5fRK3R3QOnn13i/8vjIvpu/LHIA3ArlsbxeVfo1TMSgj9EnxtxesWuJKXGgOoz92
         yQPdbaax7/uepEb9d6R49KG27+7bgkVcpdZFg=
Received: by 10.14.123.9 with SMTP id u9mr1209120eeh.53.1303940846269; Wed, 27
 Apr 2011 14:47:26 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 14:47:25 -0700 (PDT)
In-Reply-To: <20110427212943.GA2646@jakstys.lt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172279>

2011/4/28 Motiejus Jak=C5=A1tys <desired.mta@gmail.com>:
- Hide quoted text -
> On Wed, Apr 27, 2011 at 01:36:44PM +1000, Jon Seymour wrote:
>> Has anyone ever given consideration to git supporting a plugin
>> architecture for git extensions?
>>
>
> How about this proposition? From the user perspective:
> $ cd /somewhere/might/be/home/or/project/.git/ext/
> $ git clone git://github.com/jonseymour/gitwork.git
>
> What user finds in gitwork/ is totally up to maintainer. git cares ab=
out
> two files:
>    .git/ext/git-work(.exe)
>    .git/ext/git-work.1.gz
>
> $ cd gitwork;
> $ (c)make|./waf|scons|what_the_hell_just_produce_git-work
> $ git config ext.work.enabled true
>
> What git does when git <command> is invoked:
> -------------------------------------------
> * config.ext.<command>.enabled is true. If not, do nothing new.
> * if above is true, search for git-work in:
>  ** project directory
>  ** user home directory
> * if found, execute it
> * if not found, fallback to default mechanism (check in
>    cmd_struct_commands, etc)
>
> Similar with man pages.
>
> Think about how Vim plugins are distributed. Vim developers assumed t=
hat
> users are educated enough to download the plugin and extract it to th=
e
> right place. Are git users less intelligent to download & install it,
> especially in a case when they need an *extension*?
>
> Are you trying to kill a bird with a rock?
>
> Motiejus
>

I think that is a little more invasive of git-core than it needs to be.

I was thinking more along the lines of, having solved the distribution
and build problem _some other way_, resulting in a foobar.gpm file
ending up in, say, /usr/local/lib/git-pm/foobar.gpm.

You would then run:

   git pm activate foobar

which would then link:

  ln -sf /usr/local/bin/git-foobar ~/.git-pm/activated/libexec/git-foob=
ar
  ln -sf /usr/local/share/man/man1 ~/.git-pm/activated/share/man/man1

One would have to have previously arranged for the sub directories of
~/git-pm/activated to be in the PATH and MANPATH paths.

Deactivating would involve removing the links.

Deciding which links to link during activation and de-activation would
be driven by a short descriptor file.

jon.
