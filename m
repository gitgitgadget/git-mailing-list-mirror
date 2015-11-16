From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Mon, 16 Nov 2015 11:41:13 -0800
Message-ID: <CA+P7+xqGwb6yejh+HZMt8cwx=4arR6+YKCNVdftuQe5SBY_X9w@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
 <CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com> <CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 20:42:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyPen-0007tq-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 20:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbKPTlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 14:41:36 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36775 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbKPTld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 14:41:33 -0500
Received: by iofh3 with SMTP id h3so171412239iof.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gvt9xk2oVSUcHCyzClPIkWAG4jRShjh+RavPMPGehIY=;
        b=nHopkhdVm5CeZBWFpASy+BFyQ/9fHnImHbyEjREmVmpNpo4BZzeq74AjO2+zp1MsHS
         +19fFkc5Dony60Yvj7hU1p0qPZ59e7ygldWPfPy86lOuk+7LJXFHIpyPK6ED1DQ1FHD5
         a8p70dXyQVSVX9KAOaNRyhp3m8A4oSIhRU4vFrsueTjJGQh/L/ZqvHKbAZqF+1kCkYvb
         fMtPe3Lv7BTRvOjX2r3zkdWbmP2LnSNsDbQ5GN4k2y+UTjQHvmUHx1GaUzTmRGk2/NYH
         J+wIebgOb8F0uoNl8IxjKOSAVw/bkycZz2fJCXMH17NgaZOgctuBZCn16aQrcxIenljK
         gLiw==
X-Received: by 10.107.136.39 with SMTP id k39mr41919677iod.0.1447702892605;
 Mon, 16 Nov 2015 11:41:32 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Mon, 16 Nov 2015 11:41:13 -0800 (PST)
In-Reply-To: <CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281355>

On Sun, Nov 15, 2015 at 11:55 PM, Johan Herland <johan@herland.net> wrote:
> Additionally, if we suspect that passing non-notes trees to read-only
> operations will be a common error, we could add a simple heuristic to
> the notes code, to warn (or even abort) if we strongly suspect that we
> are reading in a non-notes tree. For example, if the ratio of
> non-notes to notes entries goes above, say, 1:1 (or even 10:1), then
> what we're reading is probably not a proper notes tree...
>

I agree here for this part, a possible heuristic check would maybe be
valuable.. but not sure it's super worth the effort. I doubt it would
be a common error, and I don't think the issues above would actually
cause too many problems.

The main other issue is how to get notes DWIM things to work for all
cases where we want to use notes refs, since right now the DWIM is
basically done at the top level and only handles notes like things.
The problem with it is that if you specify a full ref that *isn't*
refs/notes, you will always prefix it with refs/notes, like so:

refs/remote-notes/origin => refs/notes/refs/remote-notes/origin,

This makes it really difficult to expand a ref. However, Julio seemed
to think this was a possibly valuable expansion under normal
circumstances. The current solution is to try to do a normal lookup
first and only use the notes DWIM after we fail a lookup, which I
think is what the above patch attempts to do. This seems ok enough to
me.

Regards,
Jake

>
> ...Johan
>
