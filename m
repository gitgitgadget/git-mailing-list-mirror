From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Sun, 1 Feb 2009 23:48:30 +0100
Message-ID: <4ac8254d0902011448t242e7fcek3ae7fda609648ef0@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
	 <20090119172939.GA14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTl8Z-0001cT-M8
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZBAWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZBAWse
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:48:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:21085 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbZBAWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:48:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so185397nfc.21
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ypiPaY4cy9r8e21PqD2MWbO2cSB+YrDlT3s1evPzeJo=;
        b=wfmR8h9PZ1IuTIXmCLnVzpJRpHk5ilrhA5qsQxz7FV+6fMSSGcIvk8Btc2ImTM53Ma
         UikW83Xw8z9GjC8jIcYxqvYzTb6JAKDohhhg+bMcJz+Sek5hyofgI37BC0MFjMOXHKcO
         ldAPYsZlOi9B2dbmym4JHWVxUZUOLpGJvIAp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C3pHkWzZTzFehVt86nKDPFHVEsCYWHA6m38aTJ8rEozWwMyQUMwJCgAV1XI+RLa8M0
         y/KmWbZY0yTZ4POtvUmdJyxWnjshNuZLerXL4D+/TSMsosXLtckXIERAi3K3aPTFFNQX
         DQ2hQgIbLBf7AqxDeOg2I7cF2r2/YQ6uzkVzw=
Received: by 10.210.35.5 with SMTP id i5mr4037526ebi.174.1233528510228; Sun, 
	01 Feb 2009 14:48:30 -0800 (PST)
In-Reply-To: <20090119172939.GA14053@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108020>

On Mon, Jan 19, 2009 at 6:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>> > +           if test ! -z "$GIT_PS1_EXPENSIVE"; then
>> > +                   git update-index --refresh >/dev/null 2>&1 || w="*"
>>
>> This makes the feature unavailable for people who care about the stat
>> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?
>
> Yup, and I'm one of those people who sets autorefresindex to false
> in my ~/.gitconfig, usually before I even have user.{name,email} set.
>
> I do like the idea of what Thomas is trying to do here, but its
> so bloody expensive to compute dirty state on every prompt in
> some repositories that I'd shoot myself.  E.g. WebKit is huge,

I've been thinking about this and wondered
whether implementing "status --mini" or
"status --short" which prints "+?*" in wt-status.c
could be made fast enough.

Should we try to implement and profile this
or do we know it will be slow beforehand?

I am actually using this feature on the bash
prompt via calls to git commands and parsing
for added=+, unknown=? and changed=* as
others have done in combination with __git_ps1.

> computing the dirty state inside of the WebKit repository on each
> prompt would absolutely kill CLI performance to a point of it not
> being usuable.  But git.git is small enough its OK on pretty much
> everything except Cygwin.
>
> So as much as I'd like to use this without the update-index --refresh
> bit, I'm not sure its viable in every project out there.  If we had
> an inotify sort of daemon to keep the data current so the prompt
> doesn't have to stat every source file on every display it would
> be reasonable, but we don't have such a thing yet for Git.
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
