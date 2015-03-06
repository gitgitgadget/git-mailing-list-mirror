From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store helper
Date: Sat, 7 Mar 2015 03:21:02 +0800
Message-ID: <CACRoPnQe67OFta276aQRiAoMcWdWO-3njHpnx8MHnkm5kieW=Q@mail.gmail.com>
References: <20150305215146.394caa71@gentp.lnet>
	<CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
	<20150306001534.06882282@gentp.lnet>
	<20150306004139.2dac2502@gentp.lnet>
	<CACRoPnR3i3pTyqcxm0iELP0uR9cL2kvm9fd7BQPVpbLB0UBNVw@mail.gmail.com>
	<vpqa8zq9grq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luis Ressel <aranea@aixah.de>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:21:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxo5-00041v-OG
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 20:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbbCFTVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 14:21:05 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:46928 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbbCFTVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 14:21:03 -0500
Received: by labgq15 with SMTP id gq15so5674785lab.13
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 11:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZT2My6+GH/txGt1dsC7LIDoj+KtwpM02CI3m8V/NhUQ=;
        b=g0CKt6Yi1pQjBDqhD6m2o/vGATks+ogmErIaXP/1glp1K4kTg2sKwlKydtQKivpD20
         P3CQdbo0KnjH/JkwfVrDCRHkdmF4mTPIB9E9zo1Ne7z45Ga7XYftaS87yqq3jwCaRE82
         DVff+W7BBztk92mXoRU2+GDRdNy5/yaTptLyFJUJyS/YgOi652sUIesDnQkhGgQKhl4W
         H4MJDjEjnRZHjHJBCNucAD8yXmrbg+oxfzpyCjD0GBwij25Tf0Onvpyj+8GXfxmRTbpG
         lke5BrkjdjQgBLBNB/NeBNjUP1HbQYxcZjwh1O6ZbR7Io2eoYzVa//GHNqUgYMHCBF3b
         Bmxg==
X-Received: by 10.112.140.74 with SMTP id re10mr14609120lbb.80.1425669662195;
 Fri, 06 Mar 2015 11:21:02 -0800 (PST)
Received: by 10.112.130.228 with HTTP; Fri, 6 Mar 2015 11:21:02 -0800 (PST)
In-Reply-To: <vpqa8zq9grq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264954>

Hi,

Reading my previous message again, I apologize if it sounded
conflicting. Truth to be told, I see merits in both proposed
behaviors, but it all depends on whether we want git-credentials-store
to support an arbitrary number of config files (now or in the future)
or just two. I'm not sitting on the fence though, personally I think
that we should go with supporting an arbitrary number of config files
(and the behavior it entails for xdg file vs home file), because it
will open up more possibilities in the future with regards to
supporting multiple config sources.

On Sat, Mar 7, 2015 at 1:28 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> The fact that I suggested doing it this way does not mean it _has_ to be
> done this way. Decisions are taken by trying to reach a consensus with
> discussion, so everyone is welcome to argue.

Well, I think we need to decide if git is going to implement support
for XDG_CONFIG_DIRS as well, as support for reading/writing an
arbitrary number of config files will affect my views on the behavior.
Personally, I think git-credentials-store should implement support for
XDG_CONFIG_DIRS because, as I mentioned in the previous message,
administrators may wish to provide users with default saved
credentials.

If machinery is being added to support reading/writing to an arbitrary
number of config files, it would lead to simpler behavior (and simpler
code) if the old ~/.git-credentials is just treated as just another
config file to load from. (So yes, I agree with implementing your
proposed behavior)

However, if we are just going to support 2 configuration files (the
xdg file and the home file), then I think Luis' proposed behavior has
some merit. See below.

(Just mentioning for completeness) The third option would be to
implement a hybrid of the above two approaches (support arbitrary
number of config files, but only choose 1 between the xdg file and
home file), but this behavior is unnecessarily complex.

> I don't remember all the discussions we had about the ~/.gitconfig, but
> one issue with considering only one file is if you create
> ~/.git/config/foo and initially make sure you don't have ~/.gitfoo, and
> then one tool creates ~/.gitfoo (either an old Git, or another tool
> trying to edit the config file), then you totally break your
> configuration.
> I argued for not taking backward compatibility too much into account in
> another thread, but that was about precedence of one file over the other
> which is far less important. Here, any tool creating even an empty home
> file would break your configuration.

Luis mentioned that if the user expects to use an old version of git,
the user would (or should) not create the xdg file in the first place.
I think that automated tools (and users) should call git-config to
edit the config files anyway and not roll their own. In fact, I think
that this issue will not occur at all if git prioritized
~/.config/git/foo over ~/.gitfoo instead of the other way around. When
the user creates the xdg file, the user is signaling that old versions
of git will not be used. Thus, if a tool creates/updates the old home
file (and it should not if it calls git-config), then configuration
changes won't take effect at all, and it _shouldn't_ because the tool
is _broken_.

But yes, the above strategy does not scale at all for multiple
configuration sources, which there will be if support for
XDG_CONFIG_DIRS is implemented.

(As an aside, I find it weird that git-config allows values in
~/.gitconfig to override ~/.config/git/config, given that the xdg file
is opt-in and introduced after ~/.gitconfig. Furthermore, it conflicts
with its writing behavior -- it writes to ~/.config/git/config and not
~/.gitconfig if it exists.)

> That also breaks the least surprise principle if you have a ~/.gitfoo
> file that you forgot about: edit ~/.config/git/foo, nothing is taken
> into account, at all (or the other way around, depending on the
> precedence you choose). I remember loosing some time with two vlc
> configuration files like this.

Hmm, I don't know the exact specifics of what happened with VLC, so I
can't judge. As mentioned above, if the user wants compatibility with
old tools, the user will not create the xdg file. If the user has an
updated toolset, the user will create the xdg file and delete the old
home file. The old home file will not be created at all because all
tools would have been updated to support the xdg file, and hence the
user will not be confused.

Of course, in the context of git-config, it has to read the files in
/etc/gitconfig, $GIT_DIR/config etc, and thus as mentioned above,
reading from the home file as well would lead to simpler behavior and
code.

Regards,
Paul
