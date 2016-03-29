From: Elliott Cable <me@ell.io>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 06:53:35 -0500
Message-ID: <CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 13:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aksED-0003Ox-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 13:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136AbcC2LyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 07:54:05 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33963 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112AbcC2LyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 07:54:00 -0400
Received: by mail-vk0-f51.google.com with SMTP id e185so14816018vkb.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=36OgvZg/Xwg21ujDic/lSURWpxNB1abJhtVn2ONU45o=;
        b=hOdiZJz9/6P2KEwTZIMHJlbrzl94Un7+wUOR6+gfZHg+xF8nk5/Rj4P0OejgtO5CwD
         G+zyhL4Xedk6gL4EJBco/1/HUEoSsjxcB7sPWxrAay/zavobEXa/CETNgLV/xxzAo8W3
         M2dYGFW0LLjqdGX2JUSShQRrxWcSilR3EvOYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=36OgvZg/Xwg21ujDic/lSURWpxNB1abJhtVn2ONU45o=;
        b=Nh3T4XKCjeAGjDIcPwyeHUwJrNWoL1w2IjaMk2+VckM8WksXcewl70zP+PKrYksk6s
         BRvr+g8Es5pEsWS5YM3/IzsCx+LxcNDSuDpsVzDu20xGmTrz1vSfJS0QV5RJ2lByuOYn
         cMALpEMXKimGqrt5RzdhwTOoOwFopXRHzG0AGXkkTUYwLuv/rH69kI85oed3KZvfUw+8
         gPwb5hUW+VWv2MpC2i7vXOAE/KIhKcQh1CxOmS+mM31t5fX2fZWCEY6eFGti2IPB2saq
         oXVQcPy6ew0jlRCGX4wxj3CBd9eg3eDzpw2Jg/s7XniyIgvAEYWevAbBDBMSQJ+7CtY2
         Qcsg==
X-Gm-Message-State: AD7BkJJKgiq4Ow1Zi7H1y1Q02aQHyGpzgzIAh24rjstsfjoL2aJ9juPP12SVSTB8jSjhAkdBlMn+N0CFEZkkhA==
X-Received: by 10.31.151.11 with SMTP id z11mr873406vkd.131.1459252434549;
 Tue, 29 Mar 2016 04:53:54 -0700 (PDT)
Received: by 10.31.92.206 with HTTP; Tue, 29 Mar 2016 04:53:35 -0700 (PDT)
X-Originating-IP: [204.14.154.168]
In-Reply-To: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290121>

On Tue, Mar 29, 2016 at 6:42 AM, Elliott Cable <me@ell.io> wrote:
> So, I find this behaviour a little strange; I can't determine if it's
> a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 beha=
viour ...

Oh lord, it gets worse ...

$ cd a-repo
$ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-di=
r
true
false
$ cd .git
$ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-di=
r
false
true
$ export GIT_WORK_TREE=3D"$(git rev-parse --show-toplevel)"   # !!!
$ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-di=
r
true
false
$ # !!?!?

So, basically, if `$GIT_WORK_TREE` is set at all, it appears that the
`rev-parse --is-inside...` flags don't function reliably at all.


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
